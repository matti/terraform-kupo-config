require 'json'
require 'yaml'

params = JSON.parse(STDIN.read)

addresses = JSON.parse(params["addresses"])
private_addresses = JSON.parse(params["private_addresses"])

fields = JSON.parse(params["fields"])

fields_yaml_lines = fields.to_yaml.split("\n")
fields_yaml_lines.shift
fields_yaml_lines.map! { |line| "    #{line}" }
partial_fields_yaml = fields_yaml_lines.join("\n")

hosts = []
addresses.each_with_index do |address, i|
  host = {}
  host["address"] = address
  host["private_address"] = private_addresses[i] if private_addresses.at(i)

  host["fields"] = "INSERT"
  hosts << host
end

yaml_lines = hosts.to_yaml.split("\n")
yaml_lines.shift

better_yaml_lines = []
for yaml_line in yaml_lines do
  better_yaml_lines << if yaml_line == "  fields: INSERT"
    "#{partial_fields_yaml}"
  else
    "  #{yaml_line}"
  end
end
result = {
  rendered: better_yaml_lines.join("\n")
}

puts result.to_json
