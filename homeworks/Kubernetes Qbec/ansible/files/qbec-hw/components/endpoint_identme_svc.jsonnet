local objects = import '../functions/objects.libsonnet';
local p = import '../params.libsonnet';
local params = p.components.endpoint_identme_svc;

objects.service(params.name, params.type, params.port, params.nodePort, params.isNotEndpoint)
