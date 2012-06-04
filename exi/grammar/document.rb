#!/usr/bin/env ruby

##
##  exi/grammar/document.rb
##  created 2012-06-02 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

#
# Implements the Build-In Document Grammar, EXI 1.0 spec, section 8.4.1
# <http://www.w3.org/TR/2011/REC-exi-20110310/#builtinDocGrammars>.
#
module EXI
    class Grammar
        class Document < Grammar

            def initialize(*args)
                super(*args)

                @lhs[:Document]   = [ [:SD, nil, :DocContent, [0]] ]
                @lhs[:DocContent] = [ [:SE, nil, :DocEnd,     [0]] ]
                @lhs[:DocEnd]     = [ [:ED, nil, nil,         [0]] ]

                # Extend to support preservation/fidelity options
                n = 0
                m = 0
                if @exi_options.preserve.include?(:dtd)
                    @lhs[:DocContent].push(
                        [:DT, nil, :DocContent, [1,n]]
                    )
                    n += 1
                end
                if @exi_options.preserve.include?(:comments)
                    @lhs[:DocContent].push(
                        [:CM, nil, :DocContent, [1,n,m]]
                    )
                    @lhs[:DocEnd].push(
                        [:CM, nil, :DocEnd, [1,m]]
                    )
                    m += 1
                end
                if @exi_options.preserve.include?(:pis)
                    @lhs[:DocContent].push(
                        [:PI, nil, :DocContent, [1,n,m]]
                    )
                    @lhs[:DocEnd].push(
                        [:PI, nil, :DocEnd, [1,m]]
                    )
                    m += 1
                end
            end
        end
    end
end
