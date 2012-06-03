#!/usr/bin/env ruby

##
##  exi/options.rb
##  created 2012-06-01 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

require 'ostruct'

# This models the EXI options defined in the EXI Format 1.0 specs, section 5.4,
# "EXI Options" <http://www.w3.org/TR/2011/REC-exi-20110310/#options>. The
# object will also accept ad-hoc, user-defined options. Only the predefined
# options will have a direct effect on the EXI coding.

module EXI
    class Options

        # Class constants
        ALIGNMENTS    = [:bit_packed, :byte_alignment, :pre_compression]
        TRUE_OR_FALSE = [true, false]

        attr_reader :alignment, :block_size, :compression,
                    :datatype_representation_map, :fragment, :preserve,
                    :schema_id, :self_contained, :strict, :value_max_length,
                    :value_partition_capacity

        attr_writer :schema_id

        def initialize
            # These are the defaults used when any options at all are provided.
            # The EXI 1.0 spec does not define specific behavior for when **NO**
            # options are provided.
            @alignment      = ALIGNMENTS[0]  #-- :bit_packed
            @compression    = false
            @strict         = false
            @fragment       = false
            @preserve       = nil # TODO: multiple parameters--check the spec
            @self_contained = false
            @block_size     = 1_000_000
        end

        def alignment=(what)
            if ALIGNMENTS.include?(what)
                @alignment = what
            else
                raise(ArgumentError,
                      "Alignment given was #{what.inspect} but must " +
                      "be one of: " + ALIGNMENTS.inspect)
            end
        end

        def block_size=(integer)
            valid_integer(integer) &&
                @block_size = integer
        end

        def compression=(bool)
            valid_boolean(bool) &&
                @compression = bool
        end

        def datatype_representation_map=(wtf)
            # todo
        end

        def fragment=(bool)
            valid_boolean(bool) &&
                @fragment = bool
        end

        def preserve=(wtf)
            # TODO
        end

        def self_contained=(bool)
            valid_boolean(bool) &&
                @self_contained = bool
        end

        def strict=(bool)
            valid_boolean(bool) &&
                @strict = bool
        end

        def value_max_length=(integer)
            valid_integer(integer) &&
                @value_max_length = integer
        end

        def value_partition_capacity=(integer)
            valid_integer(integer) &&
                @value_partition_capacity = integer
        end

        # This should handle any user-defined options.
        def method_missing(method_name, value = nil)
            var_name = "@#{method_name}"
            is_assignment = var_name.gsub!(/=$/,'')
            if is_assignment
                instance_variable_set(var_name, value)
            else
                instance_variable_get(var_name)
            end
        end

        #-------#
         private
        #-------#

        def valid_boolean(value)
            TRUE_OR_FALSE.include?(value) or
                raise(ArgumentError,
                      "Value must be true or false but was #{value.inspect}",
                      caller)
        end

        def valid_integer(value)
            value.is_integer? or
                raise(ArgumentError,
                      "Value must be an integer but was #{value.inspect}",
                      caller)
        end

    end
end
