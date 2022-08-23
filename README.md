# Introduction

Terraform deploying infrastructure for a 4 node k3s cluster using Oracle Cloud Free Tier resources.

## Running the Terraform code.

Make sure to sign up for an oracle cloud account.

Create a tfvars file and put in all your configuration. Then run a plan and apply

## Configuring the K3s cluster

```shell

ansible-playbook bootstrap.yaml -i inventory/hosts.ini

```

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

```shell
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl apply -f cert_manager/issuer.yaml
kubectl apply -f cert_manager/prod_issuer.yaml
kubectl apply -f nginx_k3s_config/nginx_cert_manager_config_map.yaml
```

You should now be able to go to your public load balancers public IP and see a 404 page not found.

#### Notes

This repo was originally forked from https://github.com/garutilorenzo/k3s-oci-cluster.
Inspiration taken from https://github.com/k3s-io/k3s-ansible