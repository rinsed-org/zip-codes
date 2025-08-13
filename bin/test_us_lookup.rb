#!/usr/bin/env ruby

require_relative '../lib/zip-codes'

result = ZipCodes.lookup("US", "55122")
puts result.inspect
