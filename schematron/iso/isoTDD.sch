<?xml version="1.0" encoding="iso-8859-1"?>
<iso:schema    xmlns="http://purl.oclc.org/dsdl/schematron" 
	       xmlns:iso="http://purl.oclc.org/dsdl/schematron" 
	       xmlns:sch="http://www.ascc.net/xml/schematron"
	       queryBinding='xslt2'
	       schemaVersion="ISO19757-3"
	       defaultPhase="docs"

>




  <iso:title>Test ISO schematron file. Introduction mode </iso:title>
  <!-- Not used in first run -->
  <iso:ns prefix="dp" uri="http://www.dpawson.co.uk/ns#" />
  <iso:ns prefix="html" uri="http://www.w3.org/1999/xhtml"/>



<!-- The input phase element produces no svrl output! 
     The phase being used is only available in the document element-->
<phase id="docs" 
       xml:lang="en-GB" 
       icon="http://www.dpawson.co.uk/graphics/pig.jpg" 
       see="http://www.dpawson.co.uk/schematron" 
       xml:space="preserve">
  <active pattern="doc.checks"/>
</phase>


<iso:pattern id="doc.checks"
	     icon=""
	     fpi="fpiValue"
	     see=""
	     xml:lang="en-GB"
	     xml:space="default">
  <iso:title>ISO19757-3 test suite.</iso:title>
  <iso:p>Revision 1.0</iso:p>
  <iso:p>Date: 2007-02-02T10:33:00Z</iso:p>
  <iso:p>Author: Dave Pawson. </iso:p>
  <iso:p>Copyright: &#xA9; Dave Pawson 2007, GPL licence. </iso:p>
  <iso:p>This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of the
  License, or (at your option) any later version.</iso:p>
  <iso:p>This program is distributed in the hope that it will be
  useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.
  </iso:p>
  <iso:p>You should have received a copy of the GNU General Public
  License along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  02110-1301, USA.</iso:p>
 



 <iso:rule context="doc" 
	   flag="rule1.flagName" 
	   icon="http://www.dpawson.co.uk/graphics/pig.gif" 
	   see="http://www.dpawson.co.uk/schematron"
	   subject="/doc"
	   xml:lang="en-GB"
	   xml:space="default"
	   role="rule.1.role"
	   fpi="rule.1.fpiValue"
          >
   <iso:report test="chapter" fpi="report.1.Fpi"
   icon="http://www.dpawson.co.uk/graphics/pig.gif"
   see="http://www.dpawson.co.uk/schematron" id="report.1.id"
   role="report.1.role" subject="report.1.subject" xml:lang="en-GB"
   xml:space="preserve" flag="report.1.flag">Report date.<value-of
   select="current-dateTime()"/>. Context is <iso:value-of
   select='name(.)'/>. Inlines test, <iso:emph>emphasis</iso:emph>,
   <iso:span class='italics'>span.italics</iso:span> and <iso:dir
   value="ltr">dir.ltr</iso:dir> and &lt;iso:name @path, <iso:name
   />
   
</iso:report>
 </iso:rule>

 <iso:rule context="chapter" flag="Chapter">
   <iso:assert test="title"
	       fpi="assert.1.Fpi"
	       icon="http://www.dpawson.co.uk/graphics/pig.gif" 
	       see="http://www.dpawson.co.uk/schematron"
	       id="assert.1.id"
	       role="assert.1.role"
	       subject="assert.1.subject"
	       xml:lang="en-GB"
	       xml:space="preserve"
	       flag="assert.1.flag">Chapter should have  a title</iso:assert>
   <iso:assert test="desc" diagnostics="desc.diag" flag="Descriptor">Descriptor checks. </iso:assert>
 </iso:rule>
</iso:pattern>




<iso:diagnostics> 
  <iso:diagnostic id="desc.diag">Descriptor missing from   chapter <iso:value-of 
  select="count(../preceding-sibling::chapter) +1" /> (<iso:value-of select="@id"/>)</iso:diagnostic>

</iso:diagnostics> 

</iso:schema>
