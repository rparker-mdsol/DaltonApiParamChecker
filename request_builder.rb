#!/usr/bin/env ruby

require "csv"

def usage
  puts "Request Builder reads a CSV dump from a Sumo CSV file of parent_span_ids and span_ids and compiles them into a Sumo search to feed param_checker.rb."
  puts "USAGE  : request_builder <file_name>"
  puts "EXAMPLE: ./request_builder search-results-2018-08-09T06_32_33.686-0700.csv\n"
end

if ARGV.length != 1
  usage
  exit 0
end

lines = CSV.parse(File.read(ARGV[0]), { :headers => true, :return_headers => false })

search_filters = []

lines.each do |line|
  search_filters << %Q[("parent_span_id":"#{line[0]}" AND "trace_id":"#{line[1]}")]
end

puts %Q[_sourceHost=*dalton_sandbox* AND "Parameters: " AND (#{search_filters.join(" OR ")})]
