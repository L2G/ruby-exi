About Ruby EXI
==============

This is an experiment in coding an [Efficient XML Interchange
(EXI)](http://www.w3.org/TR/exi/) processor with Ruby.

Design notes
------------

Some rambling thoughts on where to go with this.

The aim is not to reinvent the XML-parsing wheel, but rather to layer on top
of existing XML parsers. Ruby has several flavors of them, and everyone has a
favorite (I think).  There should be a driver interface generic and flexible
enough to handle all of them.

Right now, [Nokogiri](http://nokogiri.org/) is my favorite library, but that
may change soon. Its SAX parser doesn't do absolutely everything I'd like it
to do. [Ox](https://github.com/ohler55/ox) looks promising, if for no other
reason than it sells itself as a superior alternative to Ox. :-)

In-memory XML handling is more flexible and feels more natural to work with OO
style. SAX, of course, does not consume (as much) memory and is potentially
faster. The driver interface should be able to handle either.

EXI revolves around events much like SAX does, but there is not always a
one-to-one mapping between EXI and SAX events. The driver will need to be able
to generate extra EXI events when necessary. For example, Nokogiri's SAX
parser may send a start-element event that also contains the element's
attributes and namespace info; in EXI, this would not be just one event, it
would be one SE event followed by one or more AT and NS events.

What would be _really_ nice is to map EXI events to foreign objects/events in
such a way that the mapping is implicitly two-way. Only the code at the most
abstract level would be handling the specifics of going in one direction or
another. So we could just say "SAX start-element event <=> EXI SE event (AT
event)\* (NS event)\*" for a mapping and the code would take care of it.

----

<p align="center" xmlns:dct="http://purl.org/dc/terms/" xmlns:vcard="http://www.w3.org/2001/vcard-rdf/3.0#">
  <a rel="license"
     href="http://creativecommons.org/publicdomain/zero/1.0/">
    <img src="http://i.creativecommons.org/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law,
  <a rel="dct:publisher"
     href="https://github.com/L2G">
    <span property="dct:title">Lawrence Leonard Gilbert</span></a>
  has waived all copyright and related or neighboring rights to
  <span property="dct:title">Ruby EXI</span>.
This work is published from:
<span property="vcard:Country" datatype="dct:ISO3166"
      content="US" about="https://github.com/L2G">
  United States</span>.
</p>
