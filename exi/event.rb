#!/usr/bin/env ruby

##
##  exi/event.rb
##  created 2012-06-06 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    class Event

        class Base
            def inspect
                instance_vars = instance_variables.collect do |var|
                    "#{var}=#{instance_variable_get(var).inspect}"
                end
                var_string = instance_vars.join(', ')
                var_string = " #{var_string}" unless var_string == ''
                "#<exi:event:#{self.symbol}#{var_string}>"
            end

            def symbol
                self.class.const_get(:SYMBOL)
            end
        end

        class StartDocument < Base
            SYMBOL = :SD
        end
        SD = StartDocument

        class EndDocument < Base
            SYMBOL = :ED
        end
        ED = EndDocument

        class StartElement < Base
            SYMBOL = :SE
            attr_accessor :qname
            def initialize(qname = nil)
                @qname = qname
            end
        end
        SE = StartElement

        class EndElement < Base
            SYMBOL = :EE
        end
        EE = EndElement

        class Attribute < Base
            SYMBOL = :AT
            attr_accessor :qname, :value
            def initialize(qname, value)
                @qname = qname
                @value = value
            end
        end
        AT = Attribute

        class Characters < Base
            SYMBOL = :CH
            attr_accessor :value
            def initialize(value)
                @value = value
            end
        end
        CH = Characters

        class NamespaceDeclaration < Base
            SYMBOL = :NS
            attr_accessor :uri, :prefix, :local_element_ns
        end
        NS = NamespaceDeclaration

        class Comment < Base
            SYMBOL = :CM
            attr_accessor :text
        end
        CM = Comment

        class ProcessingInstruction < Base
            SYMBOL = :PI
            attr_accessor :name, :text
        end
        PI = ProcessingInstruction

        class DOCTYPE < Base
            SYMBOL = :DT
            attr_accessor :name, :public, :system, :text
        end
        DT = DOCTYPE

        class EntityReference < Base
            SYMBOL = :ER
            attr_accessor :name
        end
        ER = EntityReference

        class SelfContained < Base
            SYMBOL = :SC
        end
        SC = SelfContained

    end
end
