#!/usr/bin/env ruby

##
##  exi.rb
##  created 2012-06-01 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    require "exi/bit_stream"
    require "exi/bit_vector"
    require "exi/event"
    require "exi/grammar"
    require "exi/nokogiri_reader_handler"
    require "exi/options"
    require "exi/qname"
    require "exi/sax_handler"
    require "exi/session"
    require "exi/type/unsigned_integer"
    require "exi/xml_driver/nokogiri"
end
