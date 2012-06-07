#!/usr/bin/env ruby

##
##  exi/session.rb
##  created 2012-06-06 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    class Session
        attr_reader :options

        def initialize
            @options = EXI::Options.new
            @options.preserve = :prefixes
        end

        def sax_handler
            @sax_handler ||= EXI::SaxHandler.new(self)
            @sax_handler
        end
    end
end
