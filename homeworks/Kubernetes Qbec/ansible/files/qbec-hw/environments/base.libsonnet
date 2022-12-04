
// this file has the baseline default parameters
{
  components: {
    backend: {
      name: 'backend',
      replicas: 1,
      image_name: 'backend_hw',
      image_tag: '0.1',
      env: [
        {name: 'DATABASE_URL', value: 'postgres://postgres:postgres@database:5432/postgres'}
      ],
    },
    frontend: {
      name: 'frontend',
      replicas: 1,
      image_name: 'frontend_hw',
      image_tag: '0.1',
      env: []
    },
    database: {
      name: 'database',
      replicas: 1,
      image_name: 'postgres',
      image_tag: '13-alpine',
      env: [
        {name: 'POSTGRES_DB', value: 'postgres'},
        {name: 'POSTGRES_USER', value: 'postgres'},
        {name: 'POSTGRES_PASSWORD', value: 'postgres'}
      ]
    },
    backend_svc: {
      name: 'backend',
      type: 'NodePort',
      port: 9000,
      nodePort: 30001
    },
    frontend_svc: {
      name: 'frontend',
      type: 'NodePort',
      port: 80,
      nodePort: 30000
    },
    database_svc: {
      name: 'database',
      type: 'ClusterIP',
      port: 5432,
    },
  },
}
