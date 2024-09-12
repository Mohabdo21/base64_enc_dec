#!/usr/bin/env ruby
# A professional Ruby script to encode and decode strings to and from base64 using a Singleton pattern.

require 'base64'
require 'singleton'

class Base64Singleton
  include Singleton

  def encode(input_string)
    Base64.encode64(input_string).strip
  end

  def decode(input_string)
    begin
      Base64.decode64(input_string)
    rescue ArgumentError
      nil
    end
  end
end

def parse_arguments
  if ARGV.length != 2
    puts "Usage: #{$0} <encode|decode> <string>"
    exit 1
  end
  ARGV
end

def main
  operation, input_string = parse_arguments

  base64_instance = Base64Singleton.instance

  case operation
  when "encode"
    puts base64_instance.encode(input_string)
  when "decode"
    decoded = base64_instance.decode(input_string)
    if decoded.nil?
      puts "Decoding failed"
      exit 1
    end
    puts decoded
  else
    puts "Usage: #{$0} <encode|decode> <string>"
    exit 1
  end
end

main if __FILE__ == $0
