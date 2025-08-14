# ZipCodes

Retrieve city, state, and time zone for a given ZIP code for those times when API's just aren’t doable 🎉

Note that time zones are only supported for US zip codes. Canadian zip codes do not support time zones.

Also only the first three characters of the Canadian postal code are used to look up the city and province.
The remaining three characters should not be submitted in a call to ZipCodes.lookup.
Documentation on why we only need to use the first three letters to determine the city and province
is available at https://www.canadapost-postescanada.ca/cpc/en/support/articles/addressing-guidelines/postal-codes.page

# Updating US ZipCodes DB

1. Download the latest `US.yml` from https://github.com/monterail/zip-codes/tree/master/lib/data
   and place it in the `lib/data/source` directory.
2. Run `ruby bin/convert_us_data.rb` to convert the data and produce a new lib/data/US.csv file.
3. Run some manual tests using the bin/test_us_lookup.rb script.
4. Commit the new `lib/data/US.csv` and `lib/data/source/US.yml` files.

# Updating CA ZipCodes DB

1. Download the latest `CA.zip` from https://download.geonames.org/export/zip/CA.zip
2. Unzip it and place the resulting CA.txt file in the `lib/data/source` directory.
3. Delete the CA.zip file.
4. Run `ruby bin/convert_ca_data.rb` to convert the data and produce a new lib/data/CA.csv file.
5. Run some manual tests using the bin/test_ca_lookup.rb script.
6. Commit the new `lib/data/CA.csv` and `lib/data/source/CA.txt` files.

## Installation

Using bundler, add to the `Gemfile`:

```ruby
gem 'zip-codes'
```

Or standalone:

```
$ gem install zip-codes
```

## Standard Usage

```ruby
ZipCodes.lookup('US', '30301')
# => {:state_code=>"GA", :state_name=>"Georgia", :city=>"Atlanta", :time_zone=>"America/New_York"}

ZipCodes.lookup('CA', 'V3B')
# => {:city=>"Port Coquitlam", :state_code=>"BC", :state_name=>"British Columbia", :time_zone=>nil}

# Case insensitive
ZipCodes.lookup('uS', '30301')
# => {:state_code=>"GA", :state_name=>"Georgia", :city=>"Atlanta", :time_zone=>"America/New_York"}

ZipCodes.lookup('cA', 'V3B')
# => {:city=>"Port Coquitlam", :state_code=>"BC", :state_name=>"British Columbia", :time_zone=>nil}

ZipCodes.lookup('CA', 'V3b')
# => {:city=>"Port Coquitlam", :state_code=>"BC", :state_name=>"British Columbia", :time_zone=>nil}

# Symbols work too
ZipCodes.lookup(:US, '30301')
# => {:state_code=>"GA", :state_name=>"Georgia", :city=>"Atlanta", :time_zone=>"America/New_York"}

ZipCodes.lookup(:CA, 'V3B')
# => {:city=>"Port Coquitlam", :state_code=>"BC", :state_name=>"British Columbia", :time_zone=>nil}
```
