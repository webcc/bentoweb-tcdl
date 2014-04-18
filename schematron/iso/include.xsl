<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:err="uri-for-xslt-implementation"
  xmlns:xdt="http://www.w3.org/2005/02/xpath-datatypes"
  xmlns:iso="http://purl.oclc.org/dsdl/schematron" 
                version="2.0">

<d:doc xmlns:d="rnib.org.uk/ns#">
 <revhistory>
   <purpose><para>Process Schematron include statements</para></purpose>
   <revision>
    <revnumber>1.0</revnumber>
    <date></date>
    <authorinitials>DaveP</authorinitials>
    <revdescription>
     <para></para>
    </revdescription>
    <revremark>Initial release</revremark>
   </revision>
  </revhistory>
  </d:doc>
  <xsl:output method="xml" encoding='utf-8'/>

  <xsl:template match="/">
        <xsl:apply-templates/>
  </xsl:template>




<!-- Include all includes -->
 <xsl:template match="iso:include">
     <xsl:if test='not(string(@href))'>
       <xsl:sequence select="
           error(xs:QName('err:ERR0003'),
                 'include element without href attribute!')"/>
     </xsl:if>
     <xsl:apply-templates select="document(@href)" xml:base="{document-uri(/)}"/>
   </xsl:template>



   <!-- Identity template  -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>


</xsl:stylesheet>
