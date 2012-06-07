#!/usr/bin/env ruby

##
##  exi/qname.rb
##  created 2012-06-05 by Larry Gilbert <larry@L2G.to>
##  part of Ruby EXI
##
##  To the extent possible under law, Lawrence Leonard Gilbert has
##  waived all copyright and related or neighboring rights to Ruby EXI.
##  For more information: http://creativecommons.org/publicdomain/zero/1.0/
##  This work is published from: United States.
##

module EXI
    QName = Struct.new(:uri, :name, :prefix)

    class QName
        #
        # Match a QName with another by comparing their component parts for
        # equality, ignoring a component if the equivalent on either side is
        # nil.
        #
        # QName.new(XSD_NS, 'fnord', 'xsd').match(QName.new(XSD_NS)) => true
        #
        def match(other)
            (!self.uri || !other.uri || (self.uri == other.uri)) &&
            (!self.name || !other.name || (self.name == other.name)) &&
            (!self.prefix || !other.prefix || (self.prefix == other.prefix))
        end
    end
end
