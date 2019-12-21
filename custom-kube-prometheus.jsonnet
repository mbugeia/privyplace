local kp =
  (import 'kube-prometheus/kube-prometheus.libsonnet') +
  // Uncomment the following imports to enable its patches
  // (import 'kube-prometheus/kube-prometheus-anti-affinity.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-managed-cluster.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-node-ports.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-static-etcd.libsonnet') +
  // (import 'kube-prometheus/kube-prometheus-thanos-sidecar.libsonnet') +
  {
    _config+:: {
      namespace: 'monitoring',
      versions+:: {
        alertmanager: "v0.20.0",
        nodeExporter: "v0.18.1",
        kubeStateMetrics: "v1.9.0",
        kubeRbacProxy: "v0.4.1",
        prometheusOperator: "v0.34.0",
        prometheus: "v2.14.0",
        grafana: '6.5.2',
      },

      imageRepos+:: {
        prometheus: "quay.io/prometheus/prometheus",
        alertmanager: "quay.io/prometheus/alertmanager",
        kubeStateMetrics: "quay.io/coreos/kube-state-metrics",
        kubeRbacProxy: "quay.io/coreos/kube-rbac-proxy",
        nodeExporter: "quay.io/prometheus/node-exporter",
        prometheusOperator: "quay.io/coreos/prometheus-operator",
        grafana: 'grafana/grafana',
      },

      prometheus+:: {
        name: 'k3s',
        replicas: 1,
      },

      alertmanager+:: {
        name: 'main',
        config: |||
          global:
            resolve_timeout: 5m
          route:
            group_by: ['job']
            group_wait: 30s
            group_interval: 5m
            repeat_interval: 12h
            receiver: 'null'
            routes:
            - match:
                alertname: Watchdog
              receiver: 'null'
          receivers:
          - name: 'null'
        |||,
        replicas: 1,
      },
      grafana+:: {
        config: {
          sections: {
            "auth": {disable_login_form: true,
                     disable_signout_menu: true},
            "auth.anonymous": {enabled: false},
            "auth.basic": {enabled: true},
            "auth.proxy": {enabled: true,
                           header_name: "x-organizr-user",
                           header_property: "username",
                           auto_sign_up: true,
                           sync_ttl: 60,
                           whitelist: "0.0.0.0/0",
                           headers: "Email:X-User-Email, Name:X-User-Name"},
            "users": {allow_sign_up: false,
                      auto_assign_org: true,
                      auto_assign_org_role: "Admin"},
            "security": {disable_initial_admin_creation: true},
          },
        },
      },
    },
  };

{ ['00-kube-prometheus/0namespace-' + name + '.json']: kp.kubePrometheus[name] for name in std.objectFields(kp.kubePrometheus) } +
{
  ['00-kube-prometheus/prometheus-operator-' + name + '.json']: kp.prometheusOperator[name]
  for name in std.filter((function(name) name != 'serviceMonitor'), std.objectFields(kp.prometheusOperator))
} +
// serviceMonitor is separated so that it can be created after the CRDs are ready
{ '01-kube-prometheus/prometheus-operator-serviceMonitor.json': kp.prometheusOperator.serviceMonitor } +
{ ['01-kube-prometheus/node-exporter-' + name + '.json']: kp.nodeExporter[name] for name in std.objectFields(kp.nodeExporter) } +
{ ['01-kube-prometheus/kube-state-metrics-' + name + '.json']: kp.kubeStateMetrics[name] for name in std.objectFields(kp.kubeStateMetrics) } +
{ ['01-kube-prometheus/alertmanager-' + name + '.json']: kp.alertmanager[name] for name in std.objectFields(kp.alertmanager) } +
{ ['01-kube-prometheus/prometheus-' + name + '.json']: kp.prometheus[name] for name in std.objectFields(kp.prometheus) } +
{ ['01-kube-prometheus/prometheus-adapter-' + name + '.json']: kp.prometheusAdapter[name] for name in std.objectFields(kp.prometheusAdapter) } +
{ ['01-kube-prometheus/grafana-' + name + '.json']: kp.grafana[name] for name in std.objectFields(kp.grafana) }