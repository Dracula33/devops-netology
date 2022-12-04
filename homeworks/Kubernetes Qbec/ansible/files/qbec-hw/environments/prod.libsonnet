
// this file has the param overrides for the default environment
local base = import './base.libsonnet';

base {
  components +: {
    frontend +: {
      replicas: 3
    },
    backend +: {
      replicas: 3
    },
    database +: {
      replicas: 3
    },
    endpoint_identme_svc: {
      name: 'endpoint-identme',
      type: 'NodePort',
      port: 8080,
      nodePort: 31234,
      isNotEndpoint: false
    },
    endpoint_identme: {
      name: 'endpoint-identme',
      ip: '49.12.234.183',
      port: 80
    }
  }
}
