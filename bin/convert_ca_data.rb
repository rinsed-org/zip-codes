#!/usr/bin/env ruby

# Converts tab-delimited CA.txt to CA.csv format.
# CA.txt is downloaded from https://download.geonames.org/export/zip/CA.zip
# Only the first 3 characters of the Canadian postal code are needed in order for us to
# correctly match postal codes to city and province (state below). That is why we can
# use the much smaller CA.zip file instead of the larger full zip database found
# at https://download.geonames.org/export/zip/CA_full.csv.zip.
# 
# To update CA.csv, download a new CA.zip from the location above, unzip it, and place
# it in the lib/data/source directory. To run the script and regenerate CA.csv while sitting
# in the root directory of the zip-codes repository, execute:
# 
# ruby bin/convert_ca_data.rb
# 
# Using zero-based column references, the script:
# - Takes the first 3 characters from column 1 for zip_code
# - Uses column 4 for state_code (AB)
# - Uses column 3 for state_name (Alberta)
# - Uses column 5 for city, falling back to column 2 with parentheses removed when column 5 is empty
# - Leaves time_zone empty since that data is not available
# - Strips whitespace from the beginning and end of all fields

input_file = 'lib/data/source/CA.txt'
output_file = 'lib/data/CA.csv'

File.open(output_file, 'w') do |file|
  file.puts "zip_code,state_code,state_name,city,time_zone"
  
  File.foreach(input_file) do |line|
    fields = line.strip.split("\t")
    
    next if fields.length < 6
    
    zip_code = fields[1][0, 3].strip
    state_code = fields[4].strip
    state_name = fields[3].strip
    
    city = fields[5].strip
    if city.empty?
      city = fields[2].strip.gsub(/\s*\([^)]*\)/, '')
    end
    
    file.puts "#{zip_code},#{state_code},#{state_name},#{city},"
  end
end

puts "Successfully converted CA.txt to CA.csv"
