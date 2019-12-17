# PrivyPlace

*Disclaimer: still in development, use at your own risk*

PrivyPlace is a opiniated personal cloud distribution based on a selection of open source software and deployed on a single node Kubernetes cluster.

It makes use of several open-source software, mainly:

- [k3s](https://k3s.io/): A lightweight distribtution of Kubernetes
- [Ansible](https://www.ansible.com/): to orchestrate cluster installation, generate and deploy the k8s ressources
- [kube-prometheus](https://github.com/coreos/kube-prometheus) for the monitoring stack, based on Prometheus and grafana
- [Organizr](https://github.com/causefx/Organizr) as main dashboard and to provide sso 
- [Ingress-nginx](https://kubernetes.github.io/ingress-nginx/) to serve cluster ingress in https
- [Cert-Manager](https://cert-manager.io/) to generate Let's Encrypt certificate
- [Postgresql](https://www.postgresql.org/) as main database for apps

Additionnaly to the infrastucture, several apps are available to install on the cluster, for now:

- [FreshRSS](https://freshrss.org/) a great RSS aggregator
- [Searx](https://asciimoo.github.io/searx/) an internet metasearch engine 
- [srt2hls](https://github.com/mbugeia/srt2hls) an audio HLS streaming server

## SSO and ingress protection

PrivyPlace use the [external auth ingress functionality](https://kubernetes.github.io/ingress-nginx/examples/auth/external-auth/) 
coupled to Organizr to provide authentification on all ingress by default.

All apps that support reverse proxy header authentification can make use of it to manage user.
This is the case for Grafana where the x-organizr-user header is used to pass the Organizr user to Grafana.

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
- A domain with DNS configured to point to your server, for example
```
YOURDOMAIN.TLD. 300 IN A yourserveripv4
*.YOURDOMAIN.TLD. 300 IN A yourserveripv4
```

### Configure

#### Configure ansible inventory

`cp inventory.yml.example inventory.yml`

Then edit `inventory.yml` and replace YOURDOMAIN by your real domain name.


#### Customize your installation
Edit the file `group_vars/all` to configure secret.

```
letsencrypt_email: "youremail@example.com"
letsencrypt_env: # staging or prod
main_domain: YOURDOMAIN.TLD

postgres_password: postgresmasterpassword

freshrss_db_password: freshrsspassword

authorized_keys: |
  ssh-rsa your ssh public key

```
You can also override default value here like `freshrss_domain: "myrssdomain.tld"`.

Edit the file `setup-apps.yml`, here you can comment or remove all the applications you dont want.

### Deploy
```
ansible-playbook -i inventory.yml privyplace.yml --diff
```

### First run configuration

As for now, Organizr need to be configured manually. Once the deploy is finished, go to https://YOURDOMAIN.TLD.

You can then follow Organizr first time setup instructions https://docs.organizr.app/books/installation/page/first-time-setup

Here is the values you need to set to makes it work:
- Install type: `Personal`
- Admin infos: Whatever you want
- Security: Whatever you want
- Database: Name: `organizr` Location: `/data`

### Enjoy you self-hosted applications

By default you will have access to theses urls. All of theses can be overriden in `group_vars/all`.

#### Monitoring stack
https://monitoring.YOURDOMAIN.TLD
https://prometheus.YOURDOMAIN.TLD
https://alertmanager.YOURDOMAIN.TLD

**Searx**

https://search.YOURDOMAIN.TLD

**FreshRSS**

https://rss.YOURDOMAIN.TLD

**Stream**

ffplay https://stream.YOURDOMAIN.TLD/live.m3u8

## Advanced Usage

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