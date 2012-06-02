#!/usr/bin/env ruby

##
##  exi/xml_handler/nokogiri.rb
##  created 2012-06-01 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    module XmlDriver
        class Nokogiri

            def initialize
                require "nokogiri" unless defined?(::Nokogiri)
            end

        end
    end
end
