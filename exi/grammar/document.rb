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

module EXI
    class Grammar
        class Document < Grammar

            def initialize
                super
                @lhs[:Document] = [
                    [:SD, nil, :DocContent, [0]]
                ]
                @lhs[:DocContent] = [
                    [:SE, nil, :DocEnd,     [0]    ],
                    [:DT, nil, :DocContent, [1,0]  ],
                    [:CM, nil, :DocContent, [1,1,0]],
                    [:PI, nil, :DocContent, [1,1,1]]
                ]
                @lhs[:DocEnd] = [
                    [:ED, nil, nil,     [0]  ],
                    [:CM, nil, :DocEnd, [1,0]],
                    [:PI, nil, :DocEnd, [1,1]]
                ]
            end
        end
    end
end
