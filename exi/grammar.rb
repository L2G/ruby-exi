#!/usr/bin/env ruby

##
##  exi/grammar.rb
##  created 2012-06-01 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

require "exi/grammar/document"

# EXI::Grammar is an abstract (base) class for other EXI::Grammar::* classes.
# See section 8, "EXI Grammars", in W3C's EXI Format 1.0 spec
# <http://www.w3.org/TR/2011/REC-exi-20110310/#grammars>.

#-- TODO: Block #new since this is abstract?

module EXI
    class Grammar

        def initialize
            @lhs   = Hash.new     #-- Keyed by "left-hand side"
            @state = nil          #-- Symbol representing the current state:
                                  #--   "Document", "ElementContent", etc.
        end

        # Decode an event code and return an EXI event.

        def decode_event(exi_event_code)
        end

        # Return the appropriate event codes (bit fields) for the given event.
        #
        # exi_event :: (EXI::Event)

        def encode_event(exi_event)
        end

    end
end
