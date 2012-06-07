#!/usr/bin/env ruby

##
##  exi/grammar/fragment.rb
##  created 2012-06-05 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

#
# Implements the Build-In Fragment Grammar, EXI 1.0 spec, section 8.4.2
# <http://www.w3.org/TR/2011/REC-exi-20110310/#builtinFragGrammars>.
#
module EXI
    class Grammar
        class Fragment < Grammar

            def initialize(*args)
                super(*args)

                @lhs[:Fragment]        = [ [:SD, nil, :FragmentContent, [0]] ]
                @lhs[:FragmentContent] = [ [:SE, nil, :FragmentContent, [0]],
                                           [:ED, nil, nil,              [1]] ]

                # Extend to support preservation/fidelity options
                n = 0
                if @exi_options.preserve.include?(:comments)
                    @lhs[:FragmentContent].push(
                        [:CM, nil, :FragmentContent, [2,n]]
                    )
                    n += 1
                end
                if @exi_options.preserve.include?(:pis)
                    @lhs[:FragmentContent].push(
                        [:PI, nil, :FragmentContent, [2,n]]
                    )
                    n += 1
                end
            end

            def insert_production_start_element(lhs, se_qname, rhs)
                @lhs[lhs].each do |production|
                    production[GP_CODE][0] += 1
                end
                @lhs[lhs].unshift( [:SE, se_qname, rhs, [0]] )
            end

        end
    end
end
