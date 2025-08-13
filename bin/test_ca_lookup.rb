#!/usr/bin/env ruby

require_relative '../lib/zip-codes'

result = ZipCodes.lookup("CA", "V3B")
puts result.inspect