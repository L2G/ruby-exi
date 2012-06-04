#!/usr/bin/env ruby

##
##  exi/bit_vector.rb
##  created 2012-06-03 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

# "What's your vector, Victor?"
#     --Capt. Oveur, "Airplane!"

#
# EXI::BitVector Holds an unsigned integer value and a size in bits.
#
module EXI
    class BitVector

        attr_reader :size, :value
        alias_method :length, :size

        def initialize(value, size)
            if (value.integer? and value >= 0)
                @value = value
            else
                raise ArgumentError, "Value must be non-negative but was #{value}"
            end
            if (size.integer? and size >= 0)
                @size = size
            else
                raise ArgumentError, "Size must be non-negative but was #{value}"
            end
        end

        #
        # An inspect-style string for IRB and the like.
        #
        def inspect
            "#<#{self.class} 0b#{self.to_s}>"
        end

        #
        # The maximum value that can be held by a bit vector of this size.
        #
        def max_value
            2**@size - 1
        end

        #
        # Return the integer value of the bit vector.
        #
        def to_i
            @value.to_i
        end

        # 
        # Return the bit vector as a string of '0' and '1' characters, most
        # significant bit first.
        #
        def to_s
            return '' if @size == 0

            bit_string = ''
            value = @value

            @size.times do
                bit_string += ((value & 1).zero? ? '0' : '1')
                value >>= 1
            end

            bit_string.reverse
        end
    end
end
