# PrivyPlace

*Disclaimer: still in development, use at your own risk*

PrivyPlace is a opiniated personal cloud distribution based on a selection of open source software and deployed on a single node Kubernetes cluster.

It makes use of several open-source software, mainly:

- [k3s](https://k3s.io/): A lightweight distribtution of Kubernetes
- [Ansible](https://www.ansible.com/): to orchestrate cluster installation, generate and deploy the k8s ressources
- [kube-prometheus](https://github.com/coreos/kube-prometheus) for the monitoring stack, based on Prometheus and grafana
- [Organizr](https://github.com/causefx/Organizr) to protect applications and provide Single Sign-On 
- [Ingress-nginx](https://kubernetes.github.io/ingress-nginx/) to serve cluster ingress in https
- [Cert-Manager](https://cert-manager.io/) to generate [Let's Encrypt](https://letsencrypt.org/) certificate
- [Postgresql](https://www.postgresql.org/) as main database for apps

Additionnaly to the infrastucture, several apps are available to install on the cluster, for now:

- An application portal, based on [Homer](https://github.com/bastienwirtz/homer)
- [FreshRSS](https://freshrss.org/) a great RSS aggregator
- [Searx](https://asciimoo.github.io/searx/) an internet metasearch engine 
- [srt2hls](https://github.com/mbugeia/srt2hls) an audio HLS streaming server
- [Droppy](https://github.com/silverwind/droppy) a file storage server with a web interface

![Alt text](doc/img/portal.png?raw=true "Privy Place Portal")

## Security considerations

PrivyPlace assumes, for now, a single tenant cluster where everyone connected is an administrator.

### SSO and ingress protection

By default, once the first run setup done (see below), all applications will be secured by proper default values and a Single Sign-On solution.
For now, it use the [external auth ingress functionality](https://kubernetes.github.io/ingress-nginx/examples/auth/external-auth/) 
coupled to Organizr.

All apps that support reverse proxy header authentification can make use of it to manage user.
This is the case for Grafana where the `x-organizr-user` header is used to pass the Organizr user to Grafana.

The authentification can be disabled on specific ingress like in the stream app by using the annotation `nginx.ingress.kubernetes.io/enable-global-auth: "false"`.

## Usage

### Requirements

#### local machine
```
pip3 install ansible PyYAML openshift
git clone https://github.com/mbugeia/privyplace
cd privyplace
```

#### remote server
- Debian 10 (untested on other)
- root ssh access
- Firewall rules to allow ports 80 and 443 from internet
- A domain with DNS configured to point to your server, for example
```
yourdomain.tld. 300 IN A yourserveripv4
*.yourdomain.tld. 300 IN A yourserveripv4
```

### Configure

#### Configure ansible inventory

`cp inventory.yml.example inventory.yml`

Then edit `inventory.yml` and replace `yourdomain.tld` by your real domain name.


#### Customize your installation
Common default value are in `group_vars/all.yml`, you can overide them in `group_vars/privyplace.yml`, some options need to be set:

```
# mains options
letsencrypt_email: "youremail@example.com"
letsencrypt_env: # staging or prod
main_domain: yourdomain.tld

# passwords
postgres_password: postgresmasterpassword
freshrss_db_password: freshrsspassword

# shh public key to connect to ansible-executor
authorized_keys: |
  ssh-rsa your ssh public key
```

You can override default value here like `freshrss_domain: "myrssdomain.tld"` or disable app by setting `app_freshrss_enabled: false`.

### Deploy
```
ansible-playbook -i inventory.yml privyplace.yml --diff
```

### First run configuration

As for now, Organizr need to be configured manually. Once the deploy is finished, go to https://auth.yourdomain.tld.

You can then follow Organizr first time setup instructions https://docs.organizr.app/books/installation/page/first-time-setup

Here is the values you need to set to makes it work:
- Install type: `Personal`
- Admin infos: Whatever you want
- Security: Whatever you want
- Database: Name: `organizr` Location: `/data`

### Enjoy you self-hosted applications

Go to https://yourdomain.tld

## Advanced Usage

### Access the cluster from you local machine

- [Install Kubectl](https://kubernetes.io/fr/docs/tasks/tools/install-kubectl/)
- mkdir ~/.kube
- scp root@youserverip:.kube/config ~/.kube/config
- Edit ~/.kube/config and replace https://127.0.0.1:6443 with your server ip

### Partial deploy

```
# Check before deploy
ansible-playbook -i inventory.yml privyplace.yml --diff --check
# Deploy only ingress
ansible-playbook -i inventory.yml privyplace.yml --diff --tags ingress
# Deploy only roles setup-cluster
ansible-playbook -i inventory.yml privyplace.yml --diff --tags setup-cluster
# Deploy only organizr
ansible-playbook -i inventory.yml privyplace.yml --diff --tags organizr
```

### Build monitoring ressources

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

### Build docker image

```
export DOCKER_ID_USER="privyplace"
# build and push latest php/* images
./docker-build.sh docker/debian/php
# make a clean release and push all debian images
./docker-build.sh docker/debian v0.0.1
```

## Knows issues

Some monitoring dashboard are broken because of https://github.com/rancher/k3s/issues/473