#!/usr/bin/env ruby

# Converts YAML US data to CSV format. YAML file is taken from
# https://github.com/monterail/zip-codes/tree/master/lib/data
# 
# To update lib/data/US.csv, download a new US.yml from the location above and place
# it in the lib/data/source directory. To run the script and regenerate US.csv while sitting
# in the root directory of the zip-codes repository, execute:
# 
# ruby bin/convert_us_data.rb
# 
require 'yaml'

input_file = 'lib/data/source/US.yml'
output_file = 'lib/data/US.csv'

File.open(output_file, 'w') do |file|
  file.puts "zip_code,state_code,state_name,city,time_zone"
  
  zips = YAML.safe_load_file(input_file, permitted_classes: [Symbol]).to_h
  zips.each do |zip, z|
    file.puts "#{zip},#{z[:state_code]},#{z[:state_name]},#{z[:city]},#{z[:time_zone]}"
  end
end

puts "Successfully converted US.yml to US.csv"