#!/usr/bin/env ruby

def usage
  puts "Dalton Api Param Checker reads a CSV dump from a Sumo CSV file of JSON messages and compiles all params passed."
  puts "USAGE  : dalton_api_param_checker <file_name>"
  puts "EXAMPLE: ./dalton_api_param_checker grants_endpoint.csv\n"
end

if ARGV.length != 1
  usage
  exit 0
end

lines = File.readlines(ARGV[0])
params = []

lines.each do |line|
  line.scan(/\\\"\"[a-zA-Z_]*\\\"\"=>/).each do |dirty_param|
    params << dirty_param.gsub(/\\""/, "").gsub("=>", "")
  end
end

params.uniq!.sort!

puts params.join(", ")
