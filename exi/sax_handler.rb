#!/usr/bin/env ruby

##
##  exi/sax_handler.rb
##  created 2012-06-01 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

require 'nokogiri'

module EXI
    class SaxHandler < ::Nokogiri::XML::SAX::Document

        def initialize(session)
            @options = session.options
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
            use_namespaces_and_all_that = @options.preserve.include?(:prefixes)
            qname = QName.new(nil, name, nil)
            if use_namespaces_and_all_that
                qname.uri = uri
                qname.prefix = prefix
            end
            puts Event::SE.new(qname).inspect
        end
    end
end
