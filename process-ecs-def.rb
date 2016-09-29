#!/usr/bin/ruby
require 'json'

family_name = ARGV[0]
file_name = ARGV[1]

file = File.read(file_name)
task_defs = JSON.parse(file)
new_json = { "taskDefinition" => task_defs, "family" => family_name }

File.open('ecs-complete.json', 'w') {|f| f.write new_json.to_json }
