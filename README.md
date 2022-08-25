# Introduction

Terraform and Ansible for deploying and provisioning infrastructure for a 4 node k3s cluster using Oracle Cloud Free Tier resources.

Dependencies:  
- Terraform => 1.x.x
- Python => 3.6.x
- Ansible Core => 2.x.x

## Running the Terraform code.

Make sure to sign up for an oracle cloud account.

Create a tfvars file and put in all your configuration. Then run a plan and apply

## Configuring the K3s cluster

Create a file all.yaml in bootstrap_cluster/inventory/group_vars and populate with all your variables
Create a hosts.ini file in bootstrap_cluster/inventory and populate with your controller and worker ips.  
Then run the below

```shell

ansible-playbook bootstrap.yaml -i inventory/hosts.ini

```

### Get external access to the cluster

scp ubuntu@<controller_ip>:~/.kube/config ~/.kube/config  

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
Inspiration taken from https://github.com/k3s-io/k3s-ansible and https://github.com/techno-tim/k3s-ansible