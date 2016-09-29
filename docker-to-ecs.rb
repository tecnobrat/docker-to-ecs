#!/bin/env ruby
require 'yaml'

image_name = ARGV[0]
build_name = ARGV[1]

compose = YAML.load_file('docker-compose.yml')
compose["services"].each do |service_name, service|
  service.delete("labels")
  if service.delete("build")
    service["image"] = image_name
  end
  service["environment"] << "SERVICE_9393_CHECK_INTERVAL=15s"
  service["environment"] << "SERVICE_9393_CHECK_TCP=true"
  service["environment"] << "SERVICE_9393_NAME=#{build_name}"
  service["environment"] << "SERVICE_9393_TAGS=urlprefix-#{build_name}.peer.articulate.zone/"
  compose["services"][service_name] = service
end

File.open('docker-compose-ecs.yml', 'w') {|f| f.write d.to_yaml }
