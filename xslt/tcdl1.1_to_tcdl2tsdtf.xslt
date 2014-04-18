<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://bentoweb.org/refs/TCDL2.0/"
    xmlns:btw="http://bentoweb.org/refs/TCDL2.0/"
    xmlns:tcd="http://bentoweb.org/refs/TCDL1.1"
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
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
  <!--
    WARNING: This transformation does not convert all data to TCDL 2.0, but only those data used by TSD TF ! 
  -->
  <xsl:template match="/">
    <testCaseDescription id="{/tcd:testCaseDescription/@id}">
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
      <dc:rights xsi:type="btw:dcHtmlInline"><html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</html:a> &#169; 1994-2008 <html:a href="http://www.w3.org/"><html:acronym title="World Wide Web Consortium">W3C</html:acronym></html:a><html:sup>&#174;</html:sup> (<html:a href="http://www.csail.mit.edu/"><html:acronym title="Massachusetts Institute of Technology">MIT</html:acronym></html:a>, <html:a href="http://www.ercim.org/"><html:acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</html:acronym></html:a>, <html:a href="http://www.keio.ac.jp/">Keio</html:a>), All Rights Reserved. <html:acronym title="World Wide Web Consortium">W3C</html:acronym> <html:a href="http://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</html:a>, <html:a href="http://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</html:a>, <html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-documents">document use</html:a> and <html:a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-software">software licensing</html:a> rules apply. Your interactions with this site are in accordance with our <html:a href="http://www.w3.org/Consortium/Legal/privacy-statement#Public">public</html:a> and <html:a href="http://www.w3.org/Consortium/Legal/privacy-statement#Members">Member</html:a> privacy statements.</dc:rights>
      <dc:date xsi:type="btw:btwDate">&#36;Date&#36;</dc:date>
      <status>unconfirmed</status>
      <version>&#36;Revision&#36;</version>
    </formalMetadata>
  </xsl:template>

  <xsl:template match="dc:creator"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="dc:rights"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="date"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="status"><!-- DO NOTHING --></xsl:template>

  <xsl:template match="tcd:technology">
    <technologies>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:for-each select="tcd:recommendation">
        <technicalSpec>
          <xsl:if test="@xlink:href">
            <xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="@baseline">
            <xsl:attribute name="baseline"><xsl:value-of select="@baseline"/></xsl:attribute>
          </xsl:if>
          <specName>
            <xsl:apply-templates select="tcd:label/child::node()"/>
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
      <xsl:if test="@complexity">
        <xsl:attribute name="complexity"><xsl:value-of select="@complexity"/></xsl:attribute>
      </xsl:if>
      <dc:description xsi:type="btw:dcHtmlInline">
        <xsl:apply-templates select="/tcd:testCaseDescription/tcd:formalMetadata/tcd:description//child::node()"/>
      </dc:description>
      <xsl:apply-templates select="tcd:purpose"/>
      <xsl:if test="tcd:expertGuidance">
        <xsl:apply-templates select="tcd:expertGuidance"/>
      </xsl:if>
      <!-- requiredTests>
        <testModes>
          <xsl:for-each select="tcd:requiredTests/tcd:testModes/tcd:testMode">
            <testMode><xsl:value-of select="."/></testMode>
          </xsl:for-each>
        </testModes>
      </requiredTests -->
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
          <xsl:if test="@xlink:href">
            <!--xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute-->
            <http:GetRequest>
              <http:requestURI><http:absoluteURI><xsl:value-of select="@xlink:href"/></http:absoluteURI></http:requestURI>
              <http:version>1.1</http:version>
            </http:GetRequest>
          </xsl:if>
        </file>
      </xsl:for-each>
    </files>
  </xsl:template>

  <xsl:template match="tcd:rules">
    <rules>
      <!-- For TSD TF, copy only rules where primary="yes" -->
      <xsl:for-each select="tcd:rule[@primary='yes']">
        <rule>
          <xsl:attribute name="primary">yes</xsl:attribute><!-- 2007-12-10: @@comment out until issue about the attribute is resolved? -->
          <xsl:attribute name="xlink:href">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <locations>
            <xsl:attribute name="expectedResult">
              <xsl:value-of select="tcd:locations/@expectedResult"/>
            </xsl:attribute>
            <xsl:for-each select="tcd:locations/tcd:location">
              <location>
                <xsl:if test="@xlink:href">
                  <!-- @todo check HTTP in RDF to replace this attribute? -->
                  <xsl:attribute name="xlink:href"><xsl:value-of select="@xlink:href"/></xsl:attribute>
                </xsl:if>
                <xsl:if test="../../tcd:techComment/tcd:p/html:span[@class='technique']">
                  <xsl:attribute name="techrefs"><xsl:for-each select="../../tcd:techComment/tcd:p/html:span[@class='technique']/html:a"><xsl:value-of select="substring-after(@href, '#')" /><xsl:text> </xsl:text></xsl:for-each></xsl:attribute>
                </xsl:if>
                <xsl:comment>If the test file uses client-side or server-side scripting to write content, check that the locations refer to the generated content!</xsl:comment>
                <xsl:if test="@line and @column">
                  <earlwd:lineCharLen>
                    <earlwd:line>
                      <xsl:value-of select="@line" />
                    </earlwd:line>
                    <earlwd:char>
                      <xsl:value-of select="@column" />
                    </earlwd:char>
                  </earlwd:lineCharLen>
                </xsl:if>
                <xsl:if test="@xpath">
                  <earlwd:xPath><!-- @todo check: rdf:datatype not valid? -->
                    <earlwd:expression><!-- rdf:datatype="http://www.w3.org/2001/XMLSchema#string" removed 2007-09-04; cf comment in earlwd.xsd -->
                      <xsl:value-of select="@xpath" />
                    </earlwd:expression>
                  </earlwd:xPath>
                </xsl:if>
              </location>
            </xsl:for-each>
          </locations>
          <techniques>
            <xsl:for-each select="tcd:techComment/tcd:p/html:span[@class='technique']/html:a">
              <technique>
                <xsl:attribute name="id"><xsl:value-of select="substring-after(@href, '#')" /></xsl:attribute>
                <xsl:attribute name="xlink:href"><xsl:value-of select="@href" /></xsl:attribute>
              </technique>
            </xsl:for-each>
          </techniques>
          <xsl:apply-templates select="tcd:functionalOutcome"/>
          <xsl:if test="tcd:techComment">
            <xsl:apply-templates select="tcd:techComment"/>
          </xsl:if>
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

  <xsl:template match="tcd:functionalOutcome"><!-- Do nothing! -->
    <!-- functionalOutcome>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </functionalOutcome -->
  </xsl:template>

  <xsl:template match="tcd:techComment">
    <techComment>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </techComment>
  </xsl:template>

  <xsl:template match="tcd:p">
    <p>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates />
    </p>
  </xsl:template>


  <xsl:template match="html:acronym"><html:acronym><xsl:copy-of select="@*"/><xsl:apply-templates /></html:acronym></xsl:template>
  <xsl:template match="html:abbr"><html:abbr><xsl:copy-of select="@*"/><xsl:apply-templates /></html:abbr></xsl:template>
  <xsl:template match="html:br"><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text></xsl:template>
  <xsl:template match="html:strong"><html:strong><xsl:copy-of select="@*"/><xsl:apply-templates /></html:strong></xsl:template>
  <xsl:template match="html:em"><html:em><xsl:copy-of select="@*"/><xsl:apply-templates /></html:em></xsl:template>
  <xsl:template match="html:span"><html:span><xsl:copy-of select="@*"/><xsl:apply-templates /></html:span></xsl:template>
  <xsl:template match="html:code"><html:code><xsl:copy-of select="@*"/><xsl:apply-templates /></html:code></xsl:template>
  <xsl:template match="html:q"><html:q><xsl:copy-of select="@*"/><xsl:apply-templates /></html:q></xsl:template>
  <xsl:template match="html:samp"><html:samp><xsl:copy-of select="@*"/><xsl:apply-templates /></html:samp></xsl:template>
  <xsl:template match="html:kbd"><html:kbd><xsl:copy-of select="@*"/><xsl:apply-templates /></html:kbd></xsl:template>
  <xsl:template match="html:var"><html:var><xsl:copy-of select="@*"/><xsl:apply-templates /></html:var></xsl:template>
  <xsl:template match="html:cite"><html:cite><xsl:copy-of select="@*"/><xsl:apply-templates /></html:cite></xsl:template>
  <xsl:template match="html:dfn"><html:dfn><xsl:copy-of select="@*"/><xsl:apply-templates /></html:dfn></xsl:template>
  <xsl:template match="html:sub"><html:sub><xsl:copy-of select="@*"/><xsl:apply-templates /></html:sub></xsl:template>
  <xsl:template match="html:sup"><html:sup><xsl:copy-of select="@*"/><xsl:apply-templates /></html:sup></xsl:template>

</xsl:stylesheet>
