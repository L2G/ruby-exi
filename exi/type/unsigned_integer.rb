#!/usr/bin/env ruby

##
##  exi/type/unsigned_integer.rb
##  created 2012-06-03 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    module Type
        class UnsignedInteger

            attr_reader :value
 
            def initialize(value = 0)
                self.value = value
            end

            #
            # Encode according to EXI 1.0 spec, section 7.1.6.
            #
            def encode
                scratch_value = @value
                code = []

                begin
                    octet = scratch_value & 0b1111111
                    scratch_value >>= 7
                    octet = (octet | 0b10000000) if scratch_value > 0
                    code.push(BitVector.new(octet,8))
                end while scratch_value > 0

                return code
            end

            def value=(value)
                if (value.kind_of?(Integer) and value >= 0)
                    @value = value
                else
                    raise ArgumentError,
                          "Value must be unsigned integer but was " +
                          value.inspect
                end
            end

        end
    end
end
