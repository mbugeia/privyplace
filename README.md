# PrivyPlace

## Prereq

```
apt install rsync
pip3 install ansible
```

## Usage
```
ansible-playbook -D -i inventory privyplace.yml
```

## Dev

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