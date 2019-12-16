# PrivyPlace

*Disclaimer: do not use this, it's still in development*

PrivyPlace is a opiniated personal cloud distribution based on a selection of open source software and deployed on a single node Kubernetes cluster.

It makes use of several open-source software, mainly:

- k3s: A lightweight distribtution of Kubernetes
- Ansible: to generate most of the k8s ressources
- Prometheus and grafana for the monitoring stack
- Organizr as main dashboard and to provide sso

## Prereq


```
# local machine
apt install rsync
pip3 install ansible PyYAML openshift
# remote machine
Debian 10 (untested on other)
root ssh access
```

## SSO and security considerations

## Usage

### Configure

$EDITOR group_vars/all

```
letsencrypt_email: "youremail@example.com"
letsencrypt_env: # staging or prod
main_domain: example.com 

authorized_keys: |
  ssh-rsa your ssh public key

```

### Deploy
```
ansible-playbook -D -i inventory.yml privyplace.yml
```

## Advanced Usage

```
# Check before deploy
ansible-playbook -D -i inventory.yml privyplace.yml --check
# Deploy only ingress
ansible-playbook -D -i inventory.yml privyplace.yml --tags ingress
# Deploy only roles setup-cluster
ansible-playbook -D -i inventory.yml privyplace.yml --tags setup-cluster
```

Build monitoring ressources

```
apt install jsonnet
GO111MODULE="on" go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
mkdir kube-prometheus
cd kube-prometheus
jb init
jb install github.com/coreos/kube-prometheus/jsonnet/kube-prometheus
# customize custom-kube-prometheus.jsonnet
./build-monitoring.sh
```