local objects = import '../functions/objects.libsonnet';
local p = import '../params.libsonnet';
local params = p.components.endpoint_identme;

objects.endpoint(params.name, params.ip, params.port)
