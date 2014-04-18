<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://bentoweb.org/refs/TCDL2.0/"
    xmlns:btw="http://bentoweb.org/refs/TCDL2.0/"
    xmlns:tcd="http://bentoweb.org/refs/TCDL2.0/"
    xmlns:btw1="http://bentoweb.org/refs/TCDL1.1"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:earlwd="http://www.w3.org/WAI/ER/EARL/nmg-strawman#"
    xmlns:http="http://www.w3.org/2006/http#"
    xmlns:uri="http://www.w3.org/2006/uri#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xsi:schemaLocation="
      http://bentoweb.org/refs/TCDL1.1 http://bentoweb.org/refs/schemas/tcdl1.1.xsd
      http://bentoweb.org/refs/TCDL2.0/ http://bentoweb.org/refs/schemas/tcdl2.0.xsd
      http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd
      http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd
      http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd
      http://www.w3.org/2006/http# http://bentoweb.org/refs/schemas/http.xsd
      http://www.w3.org/2006/uri# http://bentoweb.org/refs/schemas/uri.xsd
      http://www.w3.org/WAI/ER/EARL/nmg-strawman# http://bentoweb.org/refs/schemas/earlwd.xsd">
  <!--exclude-result-prefixes="xsi"  -->
  <!-- This version: $Date: 2009-01-12 14:58:59 $ -->
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="no"/>

  <!--
    WARNING: This transformation does not convert all data to TCDL 2.0, but only those data used by TSD TF ! 
  -->
  <xsl:template match="/">
    <testCaseDescription>
      <xsl:attribute name="id"><xsl:call-template name="oldIDtoNew"><xsl:with-param name="oldID" select="/tcd:testCaseDescription/@id" /></xsl:call-template>_<xsl:value-of select="substring-after(substring-after(/tcd:testCaseDescription/@id, '_'), '_')"/></xsl:attribute>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="/tcd:testCaseDescription/@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="xsi:schemaLocation">
        <!-- http://bentoweb.org/refs/TCDL1.1 http://bentoweb.org/refs/schemas/tcdl1.1.xsd  not needed here -->
        <xsl:text disable-output-escaping="yes">http://bentoweb.org/refs/TCDL2.0/ http://bentoweb.org/refs/schemas/tcdl2.0.xsd http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd http://www.w3.org/2006/http# http://bentoweb.org/refs/schemas/http.xsd http://www.w3.org/2006/uri# http://bentoweb.org/refs/schemas/uri.xsd http://www.w3.org/WAI/ER/EARL/nmg-strawman# http://bentoweb.org/refs/schemas/earlwd.xsd</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates select="/tcd:testCaseDescription/*" />
    </testCaseDescription>
  </xsl:template>

  <xsl:template match="tcd:formalMetadata">
    <formalMetadata>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <title><xsl:copy-of select="tcd:title//node() | @*" /></title>
      <dc:creator xsi:type="btw:dcHtmlInline">Developed by <html:a href="http://www.w3.org/"><html:acronym title="World Wide Web Consortium">W3C</html:acronym></html:a>/<html:a href="http://www.w3.org/WAI/"><html:acronym title="Web Accessibility Initiative">WAI</html:acronym></html:a>'s <html:a href="http://www.w3.org/WAI/ER/">Evaluation and Repair Tools Working Group</html:a> (ERT WG). We invite comments and discussion. Please address your feedback to <html:a href="mailto:public-wai-ert-tests@w3.org">public-wai-ert-tests@w3.org</html:a>, a mailing list with a <html:a href="http://lists.w3.org/Archives/Public/public-wai-ert-tsdtf/">public archive</html:a>.</dc:creator>
      <dc:language><xsl:value-of select="dc:language"/></dc:language>
      <dc:rights xsi:type="btw:dcHtmlInline"><html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</html:a> &#169; 1994-2009 <html:a href="http://www.w3.org/"><html:acronym title="World Wide Web Consortium">W3C</html:acronym></html:a><html:sup>&#174;</html:sup> (<html:a href="http://www.csail.mit.edu/"><html:acronym title="Massachusetts Institute of Technology">MIT</html:acronym></html:a>, <html:a href="http://www.ercim.org/"><html:acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</html:acronym></html:a>, <html:a href="http://www.keio.ac.jp/">Keio</html:a>), All Rights Reserved. <html:acronym title="World Wide Web Consortium">W3C</html:acronym> <html:a href="http://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</html:a>, <html:a href="http://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</html:a>, <html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-documents">document use</html:a> and <html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-software">software licensing</html:a> rules apply. Your interactions with this site are in accordance with our <html:a href="http://www.w3.org/Consortium/Legal/privacy-statement#Public">public</html:a> and <html:a href="http://www.w3.org/Consortium/Legal/privacy-statement#Members">Member</html:a> privacy statements.</dc:rights>
      <dc:date xsi:type="btw:btwDate">&#36;Date&#36;</dc:date>
      <status>unconfirmed</status>
      <version>&#36;Revision&#36;</version>
    </formalMetadata>
  </xsl:template>

  <xsl:template match="dc:creator"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="dc:rights"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="date"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="status"><!-- DO NOTHING --></xsl:template>

  <xsl:template match="tcd:technologies">
    <technologies>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:for-each select="tcd:technicalSpec">
        <technicalSpec>
          <xsl:if test="@xlink:href">
            <xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="@mediatype">
            <xsl:attribute name="mediatype"><xsl:value-of select="@mediatype"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="@baseline">
            <xsl:attribute name="baseline"><xsl:value-of select="@baseline"/></xsl:attribute>
          </xsl:if>
          <specName>
            <xsl:apply-templates select="tcd:specName/child::node()"/>
          </specName>
          <xsl:if test="tcd:testElements">
            <xsl:apply-templates select="tcd:testElements"/>
          </xsl:if>
        </technicalSpec>
      </xsl:for-each>
    </technologies>
  </xsl:template>

  <xsl:template match="tcd:testElements">
    <testElements>
      <xsl:if test="@baseline">
        <xsl:attribute name="baseline"><xsl:value-of select="@baseline"/></xsl:attribute>
      </xsl:if>
      <xsl:for-each select="tcd:testElement">
        <testElement>
          <xsl:if test="@baseline">
            <xsl:attribute name="baseline"><xsl:value-of select="@baseline"/></xsl:attribute>
          </xsl:if>
          <xsl:for-each select="tcd:elementName">
            <elementName>
              <xsl:if test="@localname">
                <xsl:attribute name="localname"><xsl:value-of select="@localname"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@namespace">
                <xsl:attribute name="namespace"><xsl:value-of select="@namespace"/></xsl:attribute>
              </xsl:if>
              <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
              </xsl:if>
            </elementName>
          </xsl:for-each>
          <xsl:if test="tcd:specReference">
            <specReference>
              <xsl:if test="tcd:specReference/@xlink:href">
                <xsl:attribute name="xlink:href"><xsl:value-of select="tcd:specReference/@xlink:href"/></xsl:attribute>
              </xsl:if>
              <xsl:apply-templates select="tcd:specReference/child::node()"/>
            </specReference>
          </xsl:if>
          <xsl:if test="tcd:specQuote">
            <specQuote>
              <xsl:apply-templates select="tcd:specQuote/child::node()"/>
            </specQuote>
          </xsl:if>
        </testElement>
      </xsl:for-each>
    </testElements>
  </xsl:template>

  <xsl:template match="tcd:testCase">
    <testCase>
      <!--xsl:if test="@complexity">
        <xsl:attribute name="complexity"><xsl:value-of select="@complexity"/></xsl:attribute>
      </xsl:if--><!--@complexity has been removed from TSD TF metadata-->
      <dc:description xsi:type="btw:dcHtmlInline">
        <xsl:apply-templates select="dc:description//child::node()"/>
      </dc:description>
      <xsl:apply-templates select="tcd:purpose"/>
      <xsl:if test="tcd:expertGuidance">
        <xsl:apply-templates select="tcd:expertGuidance"/>
      </xsl:if>
      <!--requiredTests>
        <testModes>
          <xsl:for-each select="tcd:requiredTests/tcd:testModes/tcd:testMode">
            <testMode><xsl:value-of select="."/></testMode>
          </xsl:for-each>
        </testModes>
      </requiredTests-->
      <xsl:apply-templates select="tcd:files"/>
    </testCase>
  </xsl:template>

  <xsl:template match="tcd:files">
    <files>
      <xsl:if test="@sequential">
        <xsl:attribute name="sequential"><xsl:value-of select="@sequential"/></xsl:attribute>
      </xsl:if>
      <xsl:for-each select="tcd:file">
        <file>
          <xsl:choose>
            <xsl:when test="@xlink:href">
              <!--xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute-->
              <http:GetRequest>
                <http:requestURI><http:absoluteURI>../testfiles/<xsl:call-template name="oldIDtoNew"><xsl:with-param name="oldID" select="substring-after(@xlink:href,'testfiles/')" /></xsl:call-template>_<xsl:value-of select="substring-after(substring-after(@xlink:href, '_l'), '_')"/></http:absoluteURI></http:requestURI>
                <xsl:comment>@@TODO: the above is actually a relative URI!</xsl:comment>
                <http:version>1.1</http:version>
              </http:GetRequest>
            </xsl:when>
            <xsl:when test="http:GetRequest">
              <xsl:apply-templates select="http:GetRequest" />
            </xsl:when>
            <xsl:otherwise><xsl:comment>@@warning: missing file references!!</xsl:comment></xsl:otherwise>
          </xsl:choose>
        </file>
      </xsl:for-each>
    </files>
  </xsl:template>

  <xsl:template match="http:GetRequest">
    <xsl:variable name="theURI"><xsl:value-of select="normalize-space(http:requestURI/http:absoluteURI)"/></xsl:variable>
    <http:GetRequest>
      <http:requestURI><http:absoluteURI>../testfiles/<xsl:call-template name="oldIDtoNew"><xsl:with-param name="oldID" select="substring-after($theURI,'testfiles/')" /></xsl:call-template>_<xsl:value-of select="substring-after(substring-after($theURI, '_l'), '_')"/></http:absoluteURI></http:requestURI>
      <xsl:if test="http:version"><http:version><xsl:value-of select="normalize-space(http:version)"/></http:version></xsl:if>
      <xsl:if test="http:header"><http:header><xsl:value-of select="http:header"/></http:header></xsl:if>
      <xsl:if test="http:body"><http:body><xsl:value-of select="http:body"/></http:body></xsl:if>
    </http:GetRequest>
  </xsl:template>

  <xsl:template match="tcd:rules">
    <rules>
      <!-- For TSD TF, @primary='yes' has been deleted. -->
      <xsl:for-each select="tcd:rule">
        <rule>
          <xsl:if test="@primary"><xsl:comment>@@warning: @primary not allowed!</xsl:comment></xsl:if>
          <xsl:attribute name="xlink:href">
            <xsl:choose>
              <!-- If rule contains 200705, replace with matching rule from 200804 -->
              <xsl:when test="contains(@xlink:href, '200705')">http://bentoweb.org/refs/rulesets.xml#WCAG2_20080430_<xsl:value-of select="substring-after(substring-after(@xlink:href, '_'), '_')"/></xsl:when>
              <!-- Else if rule contains 200604, replace with matching rule from 200804 -->
              <xsl:when test="contains(@xlink:href, '200604')">
                <xsl:choose>
                  <!-- Guideline 2.5 became guideline 3.3 -->
                  <xsl:when test="contains(@xlink:href, '_2.5_')">http://bentoweb.org/refs/rulesets.xml#WCAG2_20080430_3.3_<xsl:value-of select="substring-after(@xlink:href, '_2.5_')"/></xsl:when>
                  <!-- SC 1.3.2 is covered by SC 1.4.1 -->
                  <xsl:when test="contains(@xlink:href, '1.3_content-structure-separation-without-color')">http://bentoweb.org/refs/rulesets.xml#WCAG2_20080430_1.4_visual-audio-contrast-without-color</xsl:when>
                  <xsl:otherwise>http://bentoweb.org/refs/rulesets.xml#WCAG2_20080430_<xsl:value-of select="substring-after(substring-after(@xlink:href, '_'), '_')"/></xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>@@ERROR</xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
          <locations>
            <xsl:attribute name="expectedResult">
              <xsl:value-of select="tcd:locations/@expectedResult"/>
            </xsl:attribute>
            <xsl:for-each select="tcd:locations/tcd:location">
              <location>
                <!--xsl:if test="@xlink:href">
                  <xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute>
                </xsl:if-->
                <xsl:choose>
                  <xsl:when test="@techrefs">
                    <xsl:attribute name="techrefs"><xsl:value-of select="@techrefs" /></xsl:attribute>
                  </xsl:when>
                  <xsl:otherwise><xsl:comment>@@warning: missing @techrefs!</xsl:comment></xsl:otherwise>
                </xsl:choose>
                <xsl:comment>If the test file uses client-side or server-side scripting to write content, check that the locations refer to the generated content!</xsl:comment>
                <xsl:choose>
                  <xsl:when test="@line and @column">
                    <earlwd:lineCharLen>
                      <earlwd:line><xsl:value-of select="@line" /></earlwd:line>
                      <earlwd:char><xsl:value-of select="@column" /></earlwd:char>
                    </earlwd:lineCharLen>
                  </xsl:when>
                  <xsl:when test="earlwd:lineCharLen">
                    <earlwd:lineCharLen>
                      <earlwd:line><xsl:value-of select="normalize-space(earlwd:lineCharLen/earlwd:line)" /></earlwd:line>
                      <earlwd:char><xsl:value-of select="normalize-space(earlwd:lineCharLen/earlwd:char)" /></earlwd:char>
                    </earlwd:lineCharLen>
                  </xsl:when>
                  <xsl:otherwise><xsl:comment>@@warning: no line and column pointers</xsl:comment></xsl:otherwise>
                </xsl:choose>
                <xsl:choose>
                  <xsl:when test="@xpath">
                    <earlwd:xPath>
                      <earlwd:expression><xsl:value-of select="@xpath" /></earlwd:expression>
                    </earlwd:xPath>
                  </xsl:when>
                  <xsl:when test="earlwd:xPath">
                    <earlwd:xPath>
                      <earlwd:expression><xsl:value-of select="normalize-space(earlwd:xPath/earlwd:expression)" /></earlwd:expression>
                    </earlwd:xPath>
                  </xsl:when>
                  <xsl:otherwise><xsl:comment>@@warning: no XPath pointers</xsl:comment></xsl:otherwise>
                </xsl:choose>
                <!--xsl:for-each select="earlwd:lineCharLen"><earlwd:lineCharLen><xsl:copy-of select="earlwd:lineCharLen/earlwd:*"/></earlwd:lineCharLen></xsl:for-each-->
                <!--xsl:for-each select="earlwd:xPath"><earlwd:xPath><xsl:copy-of select="earlwd:xPath/earlwd:*"/></earlwd:xPath></xsl:for-each-->
              </location>
            </xsl:for-each>
          </locations>
          <techniques>
            <xsl:choose>
              <xsl:when test="tcd:techniques/tcd:technique">
                <xsl:for-each select="tcd:techniques/tcd:technique">
                  <technique>
                    <xsl:attribute name="id"><xsl:value-of select="@id" /></xsl:attribute>
                    <xsl:attribute name="xlink:href">
                      <xsl:choose>
                        <xsl:when test="contains(@xlink:href, 'TECHS-20070517')">http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20080430/<xsl:value-of select="substring-after(@xlink:href, '#')"/>.html</xsl:when>
                        <xsl:when test="contains(@xlink:href, 'TECHS-20060427')">http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20080430/<xsl:value-of select="substring-after(@xlink:href, '#')"/>.html</xsl:when>
                        <xsl:otherwise>@@ERROR<xsl:value-of select="@xlink:href"/></xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                  </technique>
                </xsl:for-each>
              </xsl:when>
              <xsl:otherwise><xsl:comment>@@warning: no techniques!</xsl:comment></xsl:otherwise>
            </xsl:choose>
          </techniques>
          <xsl:if test="tcd:functionalOutcome">
            <xsl:apply-templates select="tcd:functionalOutcome"/>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="tcd:techComment">
              <techComment>
                <xsl:if test="tcd:techComment/@xml:lang">
                  <xsl:attribute name="xml:lang"><xsl:value-of select="tcd:techComment/@xml:lang"/></xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="tcd:techComment/*" />
                <xsl:call-template name="referenceOriginalTestcase" />
              </techComment>
            </xsl:when>
            <xsl:otherwise>
              <techComment>
                <xsl:call-template name="referenceOriginalTestcase" />
              </techComment>
            </xsl:otherwise>
          </xsl:choose>
        </rule>
      </xsl:for-each>
    </rules>
  </xsl:template>

  <xsl:template match="tcd:namespaceMappings">
    <namespaceMappings>
      <xsl:for-each select="tcd:namespace">
        <namespace nsPrefix="{@nsPrefix}" nsURI="{@nsURI}"/>
      </xsl:for-each>
    </namespaceMappings>
  </xsl:template>

  <xsl:template match="tcd:purpose">
    <purpose><xsl:apply-templates /></purpose>
  </xsl:template>

  <xsl:template match="tcd:expertGuidance">
    <expertGuidance><xsl:apply-templates /></expertGuidance>
  </xsl:template>

  <xsl:template match="tcd:functionalOutcome">
    <functionalOutcome>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </functionalOutcome>
  </xsl:template>

  <!--xsl:template match="tcd:techComment">
    <techComment>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
      <xsl:choose>
        <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href ,'WCAG2_20070517')"><p>Based on <html:span class="btwsource"><html:a><xsl:attribute name="href">http://www.bentoweb.org/ts/XHTML1_TestSuite3/metadata/<xsl:value-of select="/tcd:testCaseDescription/@id"/></xsl:attribute><xsl:value-of select="/tcd:testCaseDescription/@id"/></html:a></html:span> from the third version of the BenToWeb test suite.</p></xsl:when>
        <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href ,'WCAG2_20060427')"><p>Based on <html:span class="btwsource"><html:a><xsl:attribute name="href">http://www.bentoweb.org/ts/XHTML1_TestSuite2/metadata/<xsl:value-of select="/tcd:testCaseDescription/@id"/></xsl:attribute><xsl:value-of select="/tcd:testCaseDescription/@id"/></html:a></html:span> from the second version of the BenToWeb test suite.</p></xsl:when>
        <xsl:otherwise><xsl:comment>@@original test case not known</xsl:comment></xsl:otherwise>
      </xsl:choose>
    </techComment>
  </xsl:template-->

  <xsl:template name="referenceOriginalTestcase">
    <xsl:choose>
      <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href ,'WCAG2_20070517')"><p>Based on <html:span class="btwsource"><html:a><xsl:attribute name="href">http://www.bentoweb.org/ts/XHTML1_TestSuite3/metadata/<xsl:value-of select="/tcd:testCaseDescription/@id"/></xsl:attribute><xsl:value-of select="/tcd:testCaseDescription/@id"/></html:a></html:span> from the third version of the BenToWeb test suite.</p></xsl:when>
      <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href ,'WCAG2_20060427')"><p>Based on <html:span class="btwsource"><html:a><xsl:attribute name="href">http://www.bentoweb.org/ts/XHTML1_TestSuite2/metadata/<xsl:value-of select="/tcd:testCaseDescription/@id"/></xsl:attribute><xsl:value-of select="/tcd:testCaseDescription/@id"/></html:a></html:span> from the second version of the BenToWeb test suite.</p></xsl:when>
      <xsl:otherwise><xsl:comment>@@original test case not known</xsl:comment></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="tcd:p">
    <p>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </p>
  </xsl:template>

  <xsl:template name="oldIDtoNew">
    <xsl:param name="oldID" />
    <xsl:choose>
      <!-- Test samples for April 2006 working draft: -->
      <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href , '200604')">
        <xsl:choose>
          <xsl:when test="starts-with($oldID, 'sc1.2.3_l2')">media-equiv-audio-desc-only@@RENUMBERED</xsl:when><!--1.2.5-->
          <xsl:when test="starts-with($oldID, 'sc1.2.4_l2')">media-equiv-captions@@RENUMBER</xsl:when><!--1.2.2-->
          <xsl:when test="starts-with($oldID, 'sc1.3.2_l1')">visual-audio-contrast-without-color@@RENUMBER</xsl:when><!--1.4.1-->
          <xsl:when test="starts-with($oldID, 'sc1.3.3_l1')">content-structure-separation-sequence@@RENUMBER</xsl:when><!--1.3.2-->
          <xsl:when test="starts-with($oldID, 'sc1.4.1_l2')">visual-audio-contrast-contrast@@RENUMBER</xsl:when><!--1.4.3-->
          <xsl:when test="starts-with($oldID, 'sc1.4.2_l2')">visual-audio-contrast-dis-audio</xsl:when><!--1.4.2-->
          <xsl:when test="starts-with($oldID, 'sc1.4.3_l3')">visual-audio-contrast7@@RENUMBER</xsl:when><!--1.4.6-->
          <xsl:when test="starts-with($oldID, 'sc1.4.4_l3')">visual-audio-contrast-noaudio@@RENUMBER</xsl:when><!--1.4.7-->
          <xsl:when test="starts-with($oldID, 'sc1.4.5_l3')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc1.4.6_l3')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc1.4.7_l3')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc2.4.9_l3')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc2.5.1_l1')">minimize-error-identified@@RENUMBER</xsl:when><!--3.3.1-->
          <xsl:when test="starts-with($oldID, 'sc3.3.2_l2')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc3.3.4_l2')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc3.3.5_l3')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:otherwise><xsl:call-template name="unchangedOldIDtoNew"><xsl:with-param name="oldID" select="$oldID" /></xsl:call-template></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- Test samples for May 2007 working draft: -->
      <xsl:when test="contains(/tcd:testCaseDescription/tcd:rules/tcd:rule/@xlink:href , '200705')">
        <xsl:choose>
          <xsl:when test="starts-with($oldID, 'sc1.2.3_l2')">media-equiv-captions</xsl:when><!--1.2.2-->
          <xsl:when test="starts-with($oldID, 'sc1.2.4_l2')">media-equiv-audio-desc-only</xsl:when><!--1.2.5-->
          <xsl:when test="starts-with($oldID, 'sc1.3.2_l1')">content-structure-separation-sequence</xsl:when><!--1.3.2.-->
          <xsl:when test="starts-with($oldID, 'sc1.3.3_l1')">content-structure-separation-understanding</xsl:when><!--1.3.3-->
          <xsl:when test="starts-with($oldID, 'sc1.4.1_l1')">visual-audio-contrast-without-color</xsl:when><!--1.4.1-->
          <xsl:when test="starts-with($oldID, 'sc1.4.2_l1')">visual-audio-contrast-dis-audio</xsl:when><!--1.4.2--><!--@@no samples in TF??-->
          <xsl:when test="starts-with($oldID, 'sc1.4.2_l2')">visual-audio-contrast-dis-audio</xsl:when><!--1.4.2--><!--@@incorrectly assigned to L2 in TF and TS3-->
          <xsl:when test="starts-with($oldID, 'sc1.4.3_l2')">visual-audio-contrast-contrast</xsl:when><!--1.4.3-->
          <xsl:when test="starts-with($oldID, 'sc1.4.4_l2')">visual-audio-contrast-scale</xsl:when><!--1.4.4.-->
          <xsl:when test="starts-with($oldID, 'sc1.4.5_l3')">visual-audio-contrast7</xsl:when><!--1.4.6-->
          <xsl:when test="starts-with($oldID, 'sc1.4.6_l3')">visual-audio-contrast-noaudio</xsl:when><!--1.4.7-->
          <xsl:when test="starts-with($oldID, 'sc1.4.7_l3')">visual-audio-contrast-scale@@RENUMBER</xsl:when><!--1.4.4-->
          <xsl:when test="starts-with($oldID, 'sc2.4.9_l3')">navigation-mechanisms-headings</xsl:when><!--2.4.10-->
          <xsl:when test="starts-with($oldID, 'sc2.5.1_l1')">@@ERROR_<xsl:value-of select="$oldID"/></xsl:when>
          <xsl:when test="starts-with($oldID, 'sc3.3.1_l1')">minimize-error-identified</xsl:when><!--3.3.1-->
          <xsl:when test="starts-with($oldID, 'sc3.3.2_l2')">minimize-error-suggestions</xsl:when><!--3.3.3-->
          <xsl:when test="starts-with($oldID, 'sc3.3.4_l2')">minimize-error-cues</xsl:when><!--3.3.2-->
          <xsl:when test="starts-with($oldID, 'sc3.3.5_l3')">minimize-error-context-help</xsl:when><!--3.3.5-->
          <xsl:otherwise><xsl:call-template name="unchangedOldIDtoNew"><xsl:with-param name="oldID" select="$oldID" /></xsl:call-template></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>@@ERROR_<xsl:value-of select="$oldID"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Process SCs that had same number in April 2006 and May 2007 working drafts: -->
  <xsl:template name="unchangedOldIDtoNew">
    <xsl:param name="oldID" />
    <xsl:choose>
      <xsl:when test="starts-with($oldID, 'sc1.1.1_l1')">text-equiv-all</xsl:when><!--1.1.1-->
      <xsl:when test="starts-with($oldID, 'sc1.2.1_l1')">media-equiv-captions</xsl:when><!--1.2.2-->
      <xsl:when test="starts-with($oldID, 'sc1.2.2_l1')">media-equiv-audio-desc</xsl:when><!--1.2.3-->
      <xsl:when test="starts-with($oldID, 'sc1.2.5_l3')">media-equiv-sign</xsl:when><!--1.2.6-->
      <xsl:when test="starts-with($oldID, 'sc1.2.6_l3')">media-equiv-extended-ad</xsl:when><!--1.2.7-->
      <xsl:when test="starts-with($oldID, 'sc1.2.7_l3')">media-equiv-text-doc</xsl:when><!--1.2.8-->
      <xsl:when test="starts-with($oldID, 'sc1.3.1_l1')">content-structure-separation-programmatic</xsl:when><!--1.3.1-->
      <xsl:when test="starts-with($oldID, 'sc2.3.1_l1')">seizure-does-not-violate</xsl:when><!--2.3.1-->
      <xsl:when test="starts-with($oldID, 'sc2.3.2_l3')">seizure-three-times</xsl:when><!--2.3.2-->
      <xsl:when test="starts-with($oldID, 'sc2.4.7_l3')">navigation-mechanisms-location</xsl:when><!--2.4.8-->
      <xsl:when test="starts-with($oldID, 'sc2.4.8_l3')">navigation-mechanisms-link</xsl:when><!--2.4.9-->
    </xsl:choose>
  </xsl:template>


  <xsl:template match="html:acronym"><html:acronym><xsl:copy-of select="@*"/><xsl:apply-templates /></html:acronym></xsl:template>
  <xsl:template match="html:abbr"><html:abbr><xsl:copy-of select="@*"/><xsl:apply-templates /></html:abbr></xsl:template>
  <xsl:template match="html:br"><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text></xsl:template>
  <xsl:template match="html:strong"><html:strong><xsl:copy-of select="@*"/><xsl:apply-templates /></html:strong></xsl:template>
  <xsl:template match="html:em"><html:em><xsl:copy-of select="@*"/><xsl:apply-templates /></html:em></xsl:template>
  <xsl:template match="html:span"><html:span><xsl:copy-of select="@*"/><xsl:apply-templates /></html:span></xsl:template>
  <xsl:template match="html:code"><html:code><xsl:copy-of select="@*"/><xsl:apply-templates /></html:code></xsl:template>
  <xsl:template match="dc:description/html:code"><xsl:copy-of select="@*"/><xsl:apply-templates /></xsl:template>
  <xsl:template match="html:q"><html:q><xsl:copy-of select="@*"/><xsl:apply-templates /></html:q></xsl:template>
  <xsl:template match="html:samp"><html:samp><xsl:copy-of select="@*"/><xsl:apply-templates /></html:samp></xsl:template>
  <xsl:template match="html:kbd"><html:kbd><xsl:copy-of select="@*"/><xsl:apply-templates /></html:kbd></xsl:template>
  <xsl:template match="html:var"><html:var><xsl:copy-of select="@*"/><xsl:apply-templates /></html:var></xsl:template>
  <xsl:template match="html:cite"><html:cite><xsl:copy-of select="@*"/><xsl:apply-templates /></html:cite></xsl:template>
  <xsl:template match="html:dfn"><html:dfn><xsl:copy-of select="@*"/><xsl:apply-templates /></html:dfn></xsl:template>
  <xsl:template match="html:sub"><html:sub><xsl:copy-of select="@*"/><xsl:apply-templates /></html:sub></xsl:template>
  <xsl:template match="html:sup"><html:sup><xsl:copy-of select="@*"/><xsl:apply-templates /></html:sup></xsl:template>

</xsl:stylesheet>
