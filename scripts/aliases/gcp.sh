alias gcp_ip="terraform show -json | jq '.values.root_module.resources' | jq '.[].values' | jq '.network_interface[].access_config[].nat_ip'"

