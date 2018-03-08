require "json"
require "yaml"

params = JSON.parse(STDIN.read)

template = {
  "hosts" => JSON.parse(params["hosts"]),
  "network" => JSON.parse(params["network"]),
  "addons" => JSON.parse(params["addons"])
}

result = {
  rendered: template.to_yaml
}

puts result.to_json
