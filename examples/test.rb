#!/usr/bin/env ruby
$:.unshift('.')

require 'exi'

handler = EXI::NokogiriReaderHandler.new(EXI::Session.new)
handler.read_file(ARGV[0])
