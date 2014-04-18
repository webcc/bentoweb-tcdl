<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns="http://bentoweb.org/refs/TCDL1.1" 
 xmlns:btw="http://bentoweb.org/refs/TCDL1" 
 xmlns:tcdl="http://bentoweb.org/refs/TCDL1.1" 
 xmlns:xlink="http://www.w3.org/1999/xlink" 
 xmlns:html="http://www.w3.org/1999/xhtml" 
 xmlns:dc="http://purl.org/dc/elements/1.1/" 
 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
 exclude-result-prefixes="xsi tcdl btw"
 >
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no" />
    <xsl:namespace-alias stylesheet-prefix="tcdl" result-prefix="btw" />
  
  <xsl:template match="/">
    <!--xsl:processing-instruction name="xml-stylesheet">href=&quot;../../TCDL/css/TCDL1.1_oldns.css&quot; title=&quot;Basic stylesheet&quot; type=&quot;text/css&quot;</xsl:processing-instruction-->
    <testCaseDescription id="{/*[local-name()='testCaseDescription']/@id}">
      <xsl:attribute name="xml:lang"><xsl:value-of select="/*[local-name()='testCaseDescription']/@xml:lang" /></xsl:attribute>
      <xsl:attribute name="xsi:schemaLocation"><xsl:text disable-output-escaping="yes">http://bentoweb.org/refs/TCDL1 http://bentoweb.org/refs/schemas/tcdl1.xsd http://bentoweb.org/refs/TCDL1.1 http://bentoweb.org/refs/schemas/tcdl1.1.xsd http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/simpledc20021212.xsd http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd</xsl:text></xsl:attribute>
      <xsl:apply-templates />
    </testCaseDescription>
  </xsl:template>


  <xsl:template match="*[local-name()='testCase']">
    <testCase complexity="{@complexity}">
      <purpose><p>@TODO</p></purpose>
      <requiredTests>
        <testModes>
          <testMode>
            <xsl:choose>
              <xsl:when test="/*[local-name()='testCaseDescription']/*[local-name()='testCase']/*[local-name()='requirements']/*[local-name()='requiredTests']/@testMode = 'manual'">enduser</xsl:when>
              <xsl:when test="/*[local-name()='testCaseDescription']/*[local-name()='testCase']/*[local-name()='requirements']/*[local-name()='requiredTests']/@testMode = 'automatic'">automatic</xsl:when>
              <xsl:when test="/*[local-name()='testCaseDescription']/*[local-name()='testCase']/*[local-name()='requirements']/*[local-name()='requiredTests']/@testMode = 'both'">endUser</xsl:when>
            </xsl:choose>
          </testMode>
        </testModes>
        <xsl:for-each select="*[local-name()='requirements']/*[local-name()='requiredTests']/*[local-name()='scenario']">
          <scenario>
            <xsl:if test="../../*[local-name()='userGuidance']">
             <xsl:for-each select="../../*[local-name()='userGuidance']">
                 <userGuidance>
                  <!--xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute--><!-- xml:lang is already copied by @* below -->
                  <xsl:copy-of select="node() | @*" />
                </userGuidance>
              </xsl:for-each>
            </xsl:if>
            <questions>
              <xsl:if test="../../*[local-name()='instructions']">
                 <yesNoQuestion>
                  <xsl:for-each select="../../*[local-name()='instructions']">
                       <questionText>
                         <!--xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute--><!-- xml:lang is already copied by another rule -->
                          <xsl:copy-of select="node() | @*" />
                       </questionText>
                  </xsl:for-each>
                     <optionYes value="yes" />
                     <optionNo value="no" />
                     <optionOther xml:lang="en"><p>@placeholder</p></optionOther>
                </yesNoQuestion>
              </xsl:if>
            </questions>
            <experience>
              <xsl:choose>
                <xsl:when test="*[local-name()='experience'][@type='speech']">
                  <xsl:for-each select="*[local-name()='experience'][@type='speech']">
                    <AssistiveTechnology type="screenreader" minimumLevel="{@minimumLevel}" />
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <AssistiveTechnology type="screenreader" minimumLevel="1" />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="*[local-name()='experience'][@type='braille']">
                  <xsl:for-each select="*[local-name()='experience'][@type='braille']">
                  <xsl:comment>@TODO: The value below is a dummy!! There was no experience indication in the TCDL 1.0 version of this test case description.</xsl:comment>
                    <AssistiveTechnology type="Braille display" minimumLevel="{@minimumLevel}" />
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:comment>@TODO: The value below is dummies!!! There was no experience indication in the TCDL 1.0 version of this test case description.</xsl:comment>
                  <AssistiveTechnology type="Braille display" minimumLevel="1" />
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="*[local-name()='experience'][@type='HTML']">
                  <xsl:for-each select="*[local-name()='experience'][@type='HTML']">
                    <UserAgent type="browser" minimumLevel="1" />
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:comment>@TODO: The value below is dummies!!! There was no experience indication in the TCDL 1.0 version of this test case description.</xsl:comment>
                  <UserAgent type="browser" minimumLevel="1" />
                </xsl:otherwise>
              </xsl:choose>
            </experience>
          </scenario>
        </xsl:for-each>
      </requiredTests>
      <xsl:apply-templates /><!-- This adds <files>. -->
    </testCase>
  </xsl:template>

  <xsl:template match="@btw:hrefLang">
    <!-- Do nothing: the attribute is linked to the old TCDL 1.0 namespace and causes validation problems. -->
  </xsl:template>
  

  <xsl:template match="*[local-name()='instructions'] | *[local-name()='userGuidance']">
    <!-- Do nothing! These elements are already handled by the template for <testCase>. -->
  </xsl:template>

  
  <!-- M. Kay: XSLT Programmer's Reference, 2nd ed. p. 187 -->
  <xsl:template match="*[local-name()='formalMetadata']">
    <formalMetadata>
      <xsl:copy-of select="node() | @*" />
    </formalMetadata>
  </xsl:template>


  <xsl:template match="*[local-name()='technology']">
    <technology>
      <xsl:copy-of select="node() | @*" />
    </technology>
  </xsl:template>


  <!--xsl:template match="*[local-name()='files']">
    <files>
      <xsl:copy-of select="node() | @*" />
    </files>
  </xsl:template-->
  <xsl:template match="*[local-name()='files']">
    <files sequential="{@sequential}">
      <xsl:apply-templates />
    </files>
  </xsl:template>
  <xsl:template match="*[local-name()='file']">
    <file>
      <!--xsl:attribute name="btw:hrefLang" namespace="http://bentoweb.org/refs/TCDL1.1"><xsl:value-of select="@btw:hrefLang" /></xsl:attribute-->
      <!--xsl:attribute name="btw:hrefLang"><xsl:value-of select="@btw:hrefLang" /></xsl:attribute-->
      <!--xsl:copy-of select="node() | @xlink:href | @hrefLang" /--><!-- @hrefLang and @btw:hrefLang don't work -->
      <xsl:copy-of select="node() | @xlink:href | @*" />
    </file>
  </xsl:template>


  <xsl:template match="*[local-name()='rules']">
    <rules>
      <xsl:copy-of select="node() | @*" />
    </rules>
  </xsl:template>


  <!-- adding below template does not make any difference for comments containing markup, regardless of the value of disable-output-escaping -->
  <xsl:template match="comment()" xml:space="preserve">
    <xsl:comment xml:space="preserve">
      <xsl:value-of select="." disable-output-escaping="yes" />
    </xsl:comment>
  </xsl:template>

</xsl:stylesheet>
