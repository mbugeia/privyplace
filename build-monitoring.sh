#!/usr/bin/env bash

set -e
set -x
set -o pipefail

# Make sure to start with a clean 'manifests' dir
rm -rf roles/monitoring/files/00-kube-prometheus
rm -rf roles/monitoring/files/01-kube-prometheus
mkdir -p roles/monitoring/files/00-kube-prometheus
mkdir -p roles/monitoring/files/01-kube-prometheus

jsonnet -J kube-prometheus/vendor -m roles/monitoring/files/ custom-kube-prometheus.jsonnet