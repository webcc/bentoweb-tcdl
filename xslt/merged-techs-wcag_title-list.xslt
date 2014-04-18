<?xml version="1.0" encoding="UTF-8" ?>
<!-- Stylesheet to transform WCAG 2.0's Techniques and Failures source XML 
  into a list of techniques with their IDs and titles. 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
 <xsl:output method="xml" encoding="UTF-8" indent="no" omit-xml-declaration="no" />

 <xsl:template match="/"><techniquesList><xsl:apply-templates /></techniquesList> </xsl:template>

 <xsl:template match="div1/technique"><technique class="{../@id}" id="{@id}"><short-name><xsl:value-of select="short-name" /><!-- @@todo check handling of child elements --></short-name></technique></xsl:template>

 <xsl:template match="/spec/header"></xsl:template>
 <xsl:template match="/spec/front"></xsl:template>
 <xsl:template match="/spec/back"></xsl:template>
 <xsl:template match="/spec/body//div1/head"></xsl:template>
 <xsl:template match="/spec/body//div1/technique/short-name/issue"></xsl:template>
</xsl:stylesheet>