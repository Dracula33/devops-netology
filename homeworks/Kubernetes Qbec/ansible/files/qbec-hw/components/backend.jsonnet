local objects = import '../functions/objects.libsonnet';
local p = import '../params.libsonnet';
local params = p.components.backend;

objects.deployment(params.name, params.replicas, params.image_name, params.image_tag, params.env)
