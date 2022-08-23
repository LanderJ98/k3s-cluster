# Introduction

Terraform deploying infrastructure for a 4 node k3s cluster using Oracle Cloud Free Tier resources.

## Running the Terraform code.

Make sure to sign up for an oracle cloud account.

Create a tfvars file and put in all your configuration. Then run a plan and apply

## Configuring the K3s cluster

Currently the K3's cluster is configured by SSH'ing onto each of the nodes and following all the steps below.

### Installation and Configuration for the Controllers

#### Disable firewall and install required packages on controllers

```shell

Disable Firewall on all Nodes

/usr/sbin/netfilter-persistent stop
/usr/sbin/netfilter-persistent flush

systemctl stop netfilter-persistent.service
systemctl disable netfilter-persistent.service

#Update and Install required packages on control Nodes

apt-get update
apt-get install -y software-properties-common jq
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y  python3 python3-pip
pip3 install oci-cli

```

#### Install k3s on controller 1

```shell

local_ip=$(curl -s -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/vnics/ | jq -r '.[0].privateIp')
flannel_iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')
Server 1 - curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=<k3s_version> sh -s - --cluster-init --write-kubeconfig-mode 644 --disable traefik --node-ip $local_ip --advertise-address $local_ip --flannel-iface $flannel_iface --tls-san <kube_api_lb_ip> --tls-san <controller1_public_ip>

#The token is in /var/lib/rancher/k3s/server/token - needed to join additional servers to the cluster

```

#### Install k3s on controller 2

```shell

local_ip=$(curl -s -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/vnics/ | jq -r '.[0].privateIp')
flannel_iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')
Server 2 - curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=<k3s_version> K3S_TOKEN=<k3s_token> sh -s - --server https://<kube_api_lb_ip>:6443 --disable traefik --node-ip $local_ip --advertise-address $local_ip --flannel-iface $flannel_iface --tls-san <kube_api_lb_ip> --tls-san <controller1_public_ip>

```

#### Disable firewall and install required packages on workers

```shell

Disable Firewall on all Nodes

/usr/sbin/netfilter-persistent stop
/usr/sbin/netfilter-persistent flush

systemctl stop netfilter-persistent.service
systemctl disable netfilter-persistent.service

#Update and Install required packages on control Nodes

apt-get update
apt-get install -y software-properties-common jq nginx
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y  python3 python3-pip
systemctl enable nginx

```


#### Install k3s on both worker nodes

```shell

local_ip=$(curl -s -H "Authorization: Bearer Oracle" -L http://169.254.169.254/opc/v2/vnics/ | jq -r '.[0].privateIp')
flannel_iface=$(ip -4 route ls | grep default | grep -Po '(?<=dev )(\S+)')
Workers - curl -sfL https://get.k3s.io |INSTALL_K3S_VERSION=<k3s_version> K3S_TOKEN=<k3s_token K3S_URL=https:/<kube_api_lb_ip>:6443 sh -s - --node-ip $local_ip --flannel-iface $flannel_iface

```

#### Configure NGINX on both worker nodes

Find the private ips of the worker nodes via the TF output

```shell

terraform output
```

SSH onto each node and create a file /tmp/private_ips. Paste the 4 private ips into the file, save and close.  

Replace nginx_ingress_controller_http_nodeport, nginx_ingress_controller_https_nodeport, http_lb_port, https_lb_port with the same values as you have in TF (in my case 30080, 30443, 80, 443 respectively). Then run the following bash to generate your nginx config. 

```shell

cat << 'EOF' > /root/nginx.tpl
load_module /usr/lib/nginx/modules/ngx_stream_module.so;
user www-data;
worker_processes auto;
pid /run/nginx.pid;
events {
  worker_connections 768;
  # multi_accept on;
}
stream {
  upstream k3s-http {
    {% for private_ip in private_ips -%}
    server {{ private_ip }}:${nginx_ingress_controller_http_nodeport} max_fails=3 fail_timeout=10s;
    {% endfor -%}
  }
  upstream k3s-https {
    {% for private_ip in private_ips -%}
    server {{ private_ip }}:${nginx_ingress_controller_https_nodeport} max_fails=3 fail_timeout=10s;
    {% endfor -%}
  }
  log_format basic '$remote_addr [$time_local] '
    '$protocol $status $bytes_sent $bytes_received '
    '$session_time "$upstream_addr" '
    '"$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';
  access_log /var/log/nginx/k3s_access.log basic;
  error_log  /var/log/nginx/k3s_error.log;
  proxy_protocol on;
  server {
    listen ${https_lb_port};
    proxy_pass k3s-https;
    proxy_next_upstream on;
  }
  server {
    listen ${http_lb_port};
    proxy_pass k3s-http;
    proxy_next_upstream on;
  }
}
EOF

cat << 'EOF' > /root/render_nginx_config.py
from jinja2 import Template
import os
RAW_IP = open('/tmp/private_ips', 'r').readlines()
IPS = [i.replace('\n','') for i in RAW_IP]
nginx_config_template_path = '/root/nginx.tpl'
nginx_config_path = '/etc/nginx/nginx.conf'
with open(nginx_config_template_path, 'r') as handle:
    nginx_config_template = handle.read()
new_nginx_config = Template(nginx_config_template).render(
    private_ips = IPS
)
with open(nginx_config_path, 'w') as handle:
    handle.write(new_nginx_config)
EOF

chmod +x /root/find_ips.sh
/root/find_ips.sh

python3 /root/render_nginx_config.py

nginx -t

systemctl restart nginx
```

In the Oracle Cloud GUI make sure both load balancers have a green tick for overall health checks. 

### Get external access to the cluster

SCP /etc/rancher/k3s/k3s.yaml to your local machine to ~/.kube/config from controller server 1. Then open ~/.kube/config and change the ip from 127.0.0.1 to controller server 1's public ip.  
You should then be able to access your cluster by doing:

```shell
kubectl get nodes
```
If nodes are returned then you now have access to your cluster.

### Deploying Services to the cluster

Make sure to change config files ports, dns names etc before deploying.

#### Deploy nginx ingress config

Deploy these files:

```shell
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.2.1/deploy/static/provider/baremetal/deploy.yaml
kubectl apply -f nginx_k3s_config/ingress_controller_config_map.yaml
kubectl apply -f nginx_k3s_config/ingress_controller_service.yaml
```

#### Deploy cert manager

Deploy these files:

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl apply -f cert_manager/issuer.yaml
kubectl apply -f cert_manager/prod_issuer.yaml
kubectl apply -f nginx_k3s_config/nginx_cert_manager_config_map.yaml

You should now be able to go to your public load balancers public IP and see a 404 page not found.

#### Notes

This repo has been forked from https://github.com/garutilorenzo/k3s-oci-cluster.