#!/usr/bin/env ruby

##
##  exi/nokogiri_reader_handler.rb
##  created 2012-06-06 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

require 'nokogiri'

module EXI
    class NokogiriReaderHandler

        Reader = ::Nokogiri::XML::Reader

        def initialize(session)
            @options = session.options
        end

        def read_file(filename)
            reader = ::Nokogiri::XML::Reader(File.read(filename))
            reader.each do |node|
                case node.node_type
                when Reader::TYPE_ATTRIBUTE
                    attribute(node.name, node.value)
                when Reader::TYPE_COMMENT
                    comment(node.value)
                when Reader::TYPE_DOCUMENT
                    start_document
                when Reader::TYPE_ELEMENT
                    start_element_namespace(node.local_name, nil, node.prefix,
                                            node.namespace_uri, nil)
                    node.attribute_nodes.each do |attr|
                        attribute(attr.name, nil, nil, attr.value)
                    end
                when Reader::TYPE_END_ELEMENT
                    end_element(node.name)
                when Reader::TYPE_SIGNIFICANT_WHITESPACE, Reader::TYPE_TEXT
                    characters(node.value)
                when Reader::TYPE_NONE
                else
                    puts node.node_type
                end
            end
        end

        def attribute(name, prefix, uri, value)
            qname = QName.new(nil, name, nil)
            if @options.preserve.include?(:prefixes)
                qname.uri = uri
                qname.prefix = prefix
            end
            puts Event::AT.new(qname, value).inspect
        end

        def characters(string)
            puts Event::CH.new(string).inspect
        end

        alias_method :cdata_block, :characters

        def comment(string)
            puts Event::CM.new(string).inspect
        end

        def end_document
            puts Event::ED.new.inspect
        end

        def end_element(dont_care)
            puts Event::EE.new.inspect
        end

        def start_document
            puts Event::SD.new.inspect
        end

        def start_element_namespace(name, attrs, prefix, uri, ns)
            qname = QName.new(nil, name, nil)
            if @options.preserve.include?(:prefixes)
                qname.uri = uri
                qname.prefix = prefix
            end
            puts Event::SE.new(qname).inspect
        end
    end
end
