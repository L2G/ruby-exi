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

#
# This models the EXI options defined in the EXI Format 1.0 specs, section 5.4,
# "EXI Options" <http://www.w3.org/TR/2011/REC-exi-20110310/#options>. The
# object will also accept ad-hoc, user-defined options. Only the predefined
# options will have a direct effect on the EXI coding.
#

require 'set'

module EXI
    class Options

        # Class constants
        ALIGNMENTS    = [:bit_packed, :byte_alignment, :pre_compression]
        PRESERVES     = [:dtd, :prefixes, :lexical_values, :comments, :pis]
        TRUE_OR_FALSE = [true, false]

        attr_reader :datatype_representation_map, :preserve,
                    :schema_id, :value_max_length,
                    :value_partition_capacity

        attr_writer :schema_id

        def alignment
            @alignment || ALIGNMENTS[0]  #-- default = :bit_packed
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

        def block_size
            defined?(@block_size) ? @block_size : 1_000_000
        end

        def block_size=(integer)
            valid_integer(integer) &&
                @block_size = integer
        end

        def compression
            defined?(@compression) ? @compression : false
        end

        def compression=(bool)
            valid_boolean(bool) &&
                @compression = bool
        end

        def datatype_representation_map=(wtf)
            # TODO
        end

        def fragment
            defined?(@fragment) ? @fragment : false
        end

        def fragment=(bool)
            valid_boolean(bool) &&
                @fragment = bool
        end

        #
        # A set of zero or more of the following symbols used as flags:
        # :dtd, :prefixes, :lexical_values, :comments, :pis. Presence of a
        # flag indicates true; absence indicates false.
        #
        def preserve
            defined?(@preserve) ? @preserve : Set.new
        end

        def preserve=(*flags)
            if flags[0].kind_of?(Enumerable)
                flags = flags[0]
            end

            @preserve ||= Set.new
            @preserve.clear
            flags.each do |flag|
                if PRESERVES.include?(flag)
                    @preserve.add(flag)
                else
                    raise(ArgumentError,
                          "Preservation flag given was #{flag.inspect} but " +
                          "must be one of: " + PRESERVES.inspect)
                end
            end
        end

        def self_contained
            defined?(@self_contained) ? @self_contained : false
        end

        def self_contained=(bool)
            valid_boolean(bool) &&
                @self_contained = bool
        end

        def strict
            defined?(@strict) ? @strict : false
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

        #
        # This handles user-defined options, both getting and setting.
        #
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

        #
        # Returns the XML Schema for EXI options. This is defined in appendix C
        # of the EXI 1.0 spec
        # <http://www.w3.org/TR/2011/REC-exi-20110310/#optionsSchema> and is
        # used for schema-informed encoding of the options document itself.
        #
        def xsd
            return <<-END_XSD
<xsd:schema targetNamespace="http://www.w3.org/2009/exi"
            xmlns:xsd="http://www.w3.org/2001/XMLSchema"
            elementFormDefault="qualified">

  <xsd:element name="header">
    <xsd:complexType>
      <xsd:sequence>
        <xsd:element name="lesscommon" minOccurs="0">
          <xsd:complexType>
            <xsd:sequence>
              <xsd:element name="uncommon" minOccurs="0">
                <xsd:complexType>
                  <xsd:sequence>
                    <xsd:any namespace="##other" minOccurs="0" maxOccurs="unbounded" 
                             processContents="skip" />
                    <xsd:element name="alignment" minOccurs="0">
                      <xsd:complexType>
                        <xsd:choice>
                          <xsd:element name="byte">
                            <xsd:complexType />
                          </xsd:element>
                          <xsd:element name="pre-compress">
                            <xsd:complexType />
                          </xsd:element>
                        </xsd:choice>
                      </xsd:complexType>
                    </xsd:element>
                    <xsd:element name="selfContained" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                    <xsd:element name="valueMaxLength" minOccurs="0">
                      <xsd:simpleType>
                        <xsd:restriction base="xsd:unsignedInt" /> 
                      </xsd:simpleType>
                    </xsd:element>
                    <xsd:element name="valuePartitionCapacity" minOccurs="0">
                      <xsd:simpleType>
                        <xsd:restriction base="xsd:unsignedInt" /> 
                      </xsd:simpleType>
                    </xsd:element>
                    <xsd:element name="datatypeRepresentationMap" 
                                 minOccurs="0" maxOccurs="unbounded">
                      <xsd:complexType>
                        <xsd:sequence>
                          <!-- schema datatype -->
                          <xsd:any namespace="##other" processContents="skip" /> 
                          <!-- datatype representation -->
                          <xsd:any processContents="skip" /> 
                        </xsd:sequence>
                      </xsd:complexType>
                    </xsd:element>
                  </xsd:sequence>
                </xsd:complexType>
              </xsd:element>
              <xsd:element name="preserve" minOccurs="0">
                <xsd:complexType>
                  <xsd:sequence>
                    <xsd:element name="dtd" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                    <xsd:element name="prefixes" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                    <xsd:element name="lexicalValues" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                    <xsd:element name="comments" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                    <xsd:element name="pis" minOccurs="0">
                      <xsd:complexType />
                    </xsd:element>
                  </xsd:sequence>
                </xsd:complexType>
              </xsd:element>
              <xsd:element name="blockSize" minOccurs="0">
                <xsd:simpleType>
                  <xsd:restriction base="xsd:unsignedInt">
                    <xsd:minInclusive value="1" />
                  </xsd:restriction> 
                </xsd:simpleType>
              </xsd:element>                 
            </xsd:sequence>
          </xsd:complexType>
        </xsd:element>
        <xsd:element name="common" minOccurs="0">
          <xsd:complexType>
            <xsd:sequence>
              <xsd:element name="compression" minOccurs="0">
                <xsd:complexType />
              </xsd:element>
              <xsd:element name="fragment" minOccurs="0">
                <xsd:complexType />
              </xsd:element>
              <xsd:element name="schemaId" minOccurs="0" nillable="true">
                <xsd:simpleType>
                  <xsd:restriction base="xsd:string" />
                </xsd:simpleType>
              </xsd:element>
            </xsd:sequence>
          </xsd:complexType>
        </xsd:element>
        <xsd:element name="strict" minOccurs="0">
          <xsd:complexType />
        </xsd:element>
      </xsd:sequence>
    </xsd:complexType>
  </xsd:element>

  <!-- Built-in EXI Datatype IDs for use in datatype representation maps -->
  <xsd:simpleType name="base64Binary">
     <xsd:restriction base="xsd:base64Binary"/>
  </xsd:simpleType>
  <xsd:simpleType name="hexBinary" >
     <xsd:restriction base="xsd:hexBinary"/>
  </xsd:simpleType>
  <xsd:simpleType name="boolean" >
     <xsd:restriction base="xsd:boolean"/>
  </xsd:simpleType>
  <xsd:simpleType name="decimal" >
     <xsd:restriction base="xsd:decimal"/>
  </xsd:simpleType>
  <xsd:simpleType name="double" >
     <xsd:restriction base="xsd:double"/>
  </xsd:simpleType>
  <xsd:simpleType name="integer" >
     <xsd:restriction base="xsd:integer"/>
  </xsd:simpleType>
  <xsd:simpleType name="string" >
     <xsd:restriction base="xsd:string"/>
  </xsd:simpleType>
  <xsd:simpleType name="dateTime" >
     <xsd:restriction base="xsd:dateTime"/>
  </xsd:simpleType>
  <xsd:simpleType name="date" >
     <xsd:restriction base="xsd:date"/>
  </xsd:simpleType>
  <xsd:simpleType name="time" >
     <xsd:restriction base="xsd:time"/>
  </xsd:simpleType>
  <xsd:simpleType name="gYearMonth" >
     <xsd:restriction base="xsd:gYearMonth"/>
  </xsd:simpleType>
  <xsd:simpleType name="gMonthDay" >
     <xsd:restriction base="xsd:gMonthDay"/>
  </xsd:simpleType>
  <xsd:simpleType name="gYear" >
     <xsd:restriction base="xsd:gYear"/>
  </xsd:simpleType>
  <xsd:simpleType name="gMonth" >
     <xsd:restriction base="xsd:gMonth"/>
  </xsd:simpleType>
  <xsd:simpleType name="gDay" >
     <xsd:restriction base="xsd:gDay"/>
  </xsd:simpleType>

  <!-- Qnames reserved for future use in datatype representation maps -->
  <xsd:simpleType name="ieeeBinary32" >
     <xsd:restriction base="xsd:float"/>
  </xsd:simpleType>
  <xsd:simpleType name="ieeeBinary64" >
     <xsd:restriction base="xsd:double"/>
  </xsd:simpleType>
</xsd:schema>
            END_XSD
        end
    end
end
