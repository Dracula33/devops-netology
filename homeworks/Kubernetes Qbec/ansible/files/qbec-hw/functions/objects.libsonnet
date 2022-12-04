{
  deployment(name, replicas, image, tag, env)::
  {
    apiVersion: 'apps/v1',
    kind: 'Deployment',
    metadata: {
      name: name,
      labels: {
        app: name
      }
    },
    spec: {
      replicas: replicas,
      selector: {
        matchLabels: {
          app: name
        }
      },
      template: {
        metadata: {
          labels: {
            app: name
          }
        },
        spec: {
          containers: [
            {
              local image_tag = if tag != '' then tag else 'latest',
              image: image + ':' + image_tag,
              name: name,
              [ if env != null then 'env']: env,
              imagePullPolicy: 'IfNotPresent'
            }
          ]
        }
      }
    }
  },
  statefulset(name, replicas, image, tag, env)::
  {
    apiVersion: 'apps/v1',
    kind: 'StatefulSet',
    metadata: {
      name: name,
      labels: {
        app: name
      }
    },
    spec: {
      replicas: replicas,
      selector: {
        matchLabels: {
          app: name
        }
      },
      minReadySeconds: 0,
      serviceName: name,
      template: {
        metadata: {
          labels: {
            app: name
          }
        },
        spec: {
          terminationGracePeriodSeconds: 15,
          containers: [
            {
              local image_tag = if tag != '' then tag else 'latest',
              image: image + ':' + image_tag,
              name: name,
              env: env,
              imagePullPolicy: 'IfNotPresent'
            }
          ]
        }
      }
    }
  },
  service(name, type, port, nodePort, isNotEndpoint=true)::
  {
    apiVersion: 'v1',
    kind: 'Service',
    metadata: {
      name: name,
    },
    spec: {
      type: type,
      ports: [
        {
          name: name,
          port: port,
          [if type == 'NodePort' then 'nodePort'] : nodePort,
        }
      ],
      [ if isNotEndpoint then 'selector' ]: {
        app: name
      }
    }
  },
  endpoint(name, ip, port)::
  {
    apiVersion: 'v1',
    kind: 'Endpoints',
    metadata: {
      name: name,
    },
    subsets: [
      {
        "addresses": [
          {
            "ip": ip
          }
        ],
        "ports": [
          {
            "name": name,
            "port": port
          }
        ]
      }
    ]
  }
}
