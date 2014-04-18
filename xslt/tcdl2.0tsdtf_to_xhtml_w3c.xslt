<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:btw="http://bentoweb.org/refs/TCDL2.0/"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:earlwd="http://www.w3.org/WAI/ER/EARL/nmg-strawman#"
  xmlns:http="http://www.w3.org/2006/http#"
  xmlns:uri="http://www.w3.org/2006/uri#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rs="http://bentoweb.org/refs/rulesets"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="
    http://bentoweb.org/refs/TCDL2.0/ http://bentoweb.org/refs/schemas/tcdl2.0.xsd
    http://purl.org/dc/elements/1.1/ http://dublincore.org/schemas/xmls/qdc/2006/01/06/dc.xsd
    http://www.w3.org/1999/xhtml http://www.w3.org/2004/07/xhtml/xhtml1-strict.xsd
    http://www.w3.org/1999/xlink http://bentoweb.org/refs/schemas/xlink.xsd
    http://www.w3.org/2006/http# http://bentoweb.org/refs/schemas/http.xsd
    http://www.w3.org/2006/uri# http://bentoweb.org/refs/schemas/uri.xsd
    http://www.w3.org/WAI/ER/EARL/nmg-strawman# http://bentoweb.org/refs/schemas/earlwd.xsd"
  exclude-result-prefixes="btw dc earlwd http rdf rs uri xlink xml xs xsi"
>
  <!-- This version: $Date: 2009-06-25 10:53:45 $ -->
  <xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
  />

  <!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="DEBUG" select="'false'" />

  <!-- Username from W3C authentication mechanism. Default value is 'false'. --><!--added 2009-04-27-->
  <xsl:param name="w3cusername" select="'false'" />

  <!-- Test sample ID from database --><!--added 2009-04-27-->
  <xsl:param name="testsampleID" select="'[unknown ID]'" />

  <!-- Test sample status from database  --><!--added 2009-06-23-->
  <xsl:param name="testsamplestatus" select="'[unknown status]'" />

  <xsl:variable name="rulesets" select="document('http://www.bentoweb.org/refs/rulesets.xml')" />
  <!--xsl:variable name="rulesets" select="document('http://localhost:8080/bentoweb/refs/rulesets.xml')" /-->

  <!--added 2009-06-24-->
  <xsl:variable name="techniqueList" select="document('http://canada.esat.kuleuven.be/bentoweb/mergedTechs_titleList.xml')" />
  <!--xsl:variable name="techniqueList" select="document('http://localhost:8080/bentoweb/refs/mergedTechs_titleList.xml')" /-->

  <!-- The number of test files in the test case -->
  <xsl:variable name="varTestFileCount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file)"/></xsl:variable>
  <xsl:variable name="varAbsURICount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file/http:GetRequest/http:requestURI/http:absoluteURI)"/></xsl:variable>


  <xsl:template match="btw:testCaseDescription">
    <html xml:lang="en" lang="en">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Test Sample <xsl:value-of select="$testsampleID"/></title>
        <link href="http://www.w3.org/WAI/wai-main.css" rel="stylesheet" type="text/css" /><!--W3C @added 2009-04-27-->
        <style type="text/css">
.spaced { margin-bottom: 1.2em; }
.nobull { list-style: none; }
.noindent {
  list-style-type: none;
  margin: 0; padding: 0;
}
table { border-collapse: collapse; }
th, td { padding: .3em; border: 1pt solid #000; }
code { color: #00f; background: #fff; 
        </style>
        <xsl:comment>[if IE 7]><link rel="stylesheet" href="http://www.w3.org/WAI/ie-old.css" type="text/css" media="all" /></xsl:comment>
      </head>
      <body>
      <div><p id="logos"><a href="http://www.w3.org/" title="W3C Home"><img alt="W3C logo" height="48" src="http://www.w3.org/Icons/w3c_home" width="72" /></a><a href="http://www.w3.org/WAI/" title="WAI Home"><img alt="Web Accessibility Initiative (WAI) logo" height="48" src="http://www.w3.org/WAI/images/wai-temp" /></a></p>
      </div>
      <p>You are identified as: 
        <xsl:choose>
          <xsl:when test="$w3cusername = 'false'">[username]</xsl:when>
          <xsl:otherwise><xsl:value-of select="$w3cusername"/></xsl:otherwise>
        </xsl:choose>
      </p>
      <h1><a name="startcontent" id="startcontent">View Test Sample <xsl:value-of select="$testsampleID"/></a></h1>

        <div lang="en" xml:lang="en" id="metadata">
          <table>
            <caption>Formal Metadata</caption>
            <tbody>
              <tr>
                <td>Title</td>
                <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:title" /></td>
              </tr>
              <tr>
                <td>Applies To</td>
                <td>
                  <xsl:call-template name="printRuleLink">
                    <!-- There must be only one primary rule. [@primary='yes'] was removed from TSD TF metadata 2008-02-25-->
                    <xsl:with-param name="accRule" select="/btw:testCaseDescription/btw:rules/btw:rule[1]" />
                    <xsl:with-param name="isPrimary" select="yes" />
                  </xsl:call-template>
                  <!--copied with modifications from tcdl1.1_to_xhtml_print_noscenarios.xslt 2008-03-18-->
                  <xsl:call-template name="getReadableRuleName"><xsl:with-param name="accRule" select="/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href" /></xsl:call-template>
                </td>
              </tr>
              <tr>
                <td>Status</td>
                <td>
                  <span><xsl:call-template name="explainStatus"><xsl:with-param name="theStatus" select="$testsamplestatus" /></xsl:call-template></span> 
                  (<a href="http://www.w3.org/WAI/ER/tests/process">Review Process</a>)
                </td>
              </tr>
              <tr>
                <td>Creator</td>
                <td>Developed by the <a href="http://www.w3.org/WAI/ER">W3C Evaluation and Repair Tools Working Group (ERT WG)</a>. We invite comments and discussion. Please address your feedback to <a href="mailto:public-wai-ert-tests@w3.org">public-wai-ert-tests@w3.org</a>, a mailing list with a <a href="http://lists.w3.org/Archives/Public/public-wai-ert-tests/">public archive</a>.</td>
              </tr>
              <tr>
                <td>Rights</td>
                <td><a rel="Copyright" href="http://www.w3.org/Consortium/Legal/ipr-notice#Copyright">Copyright</a> &#169; 1994-2009 <a href="http://www.w3.org/"><acronym title="World Wide Web Consortium">W3C</acronym></a><sup>&#174;</sup> (<a href="http://www.csail.mit.edu/"><acronym title="Massachusetts Institute of Technology">MIT</acronym></a>, <a href="http://www.ercim.org/"><acronym title="European Research Consortium for Informatics and Mathematics">ERCIM</acronym></a>, <a href="http://www.keio.ac.jp/">Keio</a>), All Rights Reserved. <acronym title="World Wide Web Consortium">W3C</acronym> <a href="http://www.w3.org/Consortium/Legal/ipr-notice#Legal_Disclaimer">liability</a>, <a href="http://www.w3.org/Consortium/Legal/ipr-notice#W3C_Trademarks">trademark</a>, <a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-documents">document use</a> and <a rel="Copyright" href="http://www.w3.org/Consortium/Legal/copyright-software">software licensing</a> rules apply. Your interactions with this site are in accordance with our <a href="http://www.w3.org/Consortium/Legal/privacy-statement#Public">public</a> and <a href="http://www.w3.org/Consortium/Legal/privacy-statement#Members">Member</a> privacy statements.</td>
              </tr>
              <tr>
                <td>Language</td>
                <td><xsl:choose>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'en'">English (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'fr'">French (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'de'">German (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'es'">Spanish (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'it'">Italian (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'nl'">Dutch (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:when test="/btw:testCaseDescription/btw:formalMetadata/dc:language = 'zh'">Chinese (<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" />)</xsl:when>
                  <xsl:otherwise><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" /></xsl:otherwise>
                </xsl:choose></td>
              </tr>
              <tr>
                <td>Last Updated</td>
                <td><xsl:value-of select="substring-before(substring-after(/btw:testCaseDescription/btw:formalMetadata/dc:date, 'Date: '), '$')" /> (last change of metadata file)</td>
              </tr>
            </tbody>
          </table>
        </div>

        <div id="testCase">
          <h2><a name="description" id="description">Description</a></h2>
            <xsl:for-each select="/btw:testCaseDescription/btw:testCase/dc:description">
              <div class="description"><p><xsl:apply-templates /></p></div>
            </xsl:for-each>
          <h2><a name="purpose" id="purpose">Purpose</a></h2>
            <xsl:for-each select="/btw:testCaseDescription/btw:testCase/btw:purpose/btw:p">
              <p><xsl:apply-templates /></p>
            </xsl:for-each>
          <h2><a name="data" id="data">Test Data</a></h2>
            <!-- @@ This only works for the current test suite! -->
            
            <p>Metadata: <a href="http://www.w3.org/WAI/ER/tests/xhtml/metadata/{/btw:testCaseDescription/@id}.xml"><acronym>XML</acronym> file</a>.</p>
            <xsl:choose>
              <xsl:when test="$varTestFileCount &gt; 1">
                <p>Sample content:</p>
                <ul>
                  <xsl:for-each select="/btw:testCaseDescription/btw:testCase/btw:files/btw:file">
                    <li>
                      <xsl:choose>
                        <xsl:when test="@xlink:href">
                          <a href="{@xlink:href}">file <xsl:value-of select="position()" /></a>
                        </xsl:when>
                        <xsl:otherwise>
                          <!-- @@todo process HTTP request elements -->
                          <a href="{http:GetRequest/http:requestURI/http:absoluteURI}">file</a>
                        </xsl:otherwise>
                      </xsl:choose>
                    </li>
                  </xsl:for-each>
                </ul>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$DEBUG = 'true'"><p class="todo"><strong>$varTestFileCount !&gt; 1 !</strong> varAbsURICount = <xsl:value-of select="$varAbsURICount"/>.</p></xsl:if>
                <xsl:choose>
                  <xsl:when test="/btw:testCaseDescription/btw:testCase/btw:files/btw:file/@xlink:href">
                    <p>Sample content: <a href="{/btw:testCaseDescription/btw:testCase/btw:files/btw:file/@xlink:href}">file</a>.</p>
                  </xsl:when>
                  <xsl:otherwise>
                    <!-- @@todo process HTTP request elements -->
                    <p>Sample content: <a href="{/btw:testCaseDescription/btw:testCase/btw:files/btw:file/http:GetRequest/http:requestURI/http:absoluteURI}">file</a>.</p>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>

          <div id="results">
            <h2><a name="result" id="result">Expected Results</a></h2>
              <xsl:for-each select="/btw:testCaseDescription/btw:rules/btw:rule[1]">
                <xsl:call-template name="printRuleInfo">
                  <xsl:with-param name="accRule" select="." />
                  <xsl:with-param name="isPrimary" select="yes" />
                </xsl:call-template>
              </xsl:for-each>
              <p>Note: each pass or fail statement is based on the test procedure of the relevant technique or failure, 
                and does not imply a pass or fail with regard to a related success criterion.
              </p>
          </div>
        </div>

        <div>
          <h2>Technologies and Features</h2>
          <!--p>Technologies are markup languages or data formats. If the technology is a markup language, &#8220;features&#8221; refers to elements and attributes.</p-->
          <xsl:if test="$DEBUG = 'true'"><p class="debug">Number of technologies: <xsl:value-of select="count(/btw:testCaseDescription/btw:technologies/btw:technicalSpec)"/>.</p></xsl:if>
          <xsl:choose>
            <xsl:when test="count(/btw:testCaseDescription/btw:technologies/btw:technicalSpec) &gt; 1">
              <xsl:if test="$DEBUG = 'true'"><p class="debug">More than one technology.</p></xsl:if>
              Technologies:<!--added 2009-01-14-->
              <ul>
              <xsl:for-each select="/btw:testCaseDescription/btw:technologies/btw:technicalSpec">
                <!-- <h4><xsl:apply-templates select="btw:specName" /></h4> -->
                <li><a href="{@xlink:href}"><xsl:apply-templates select="btw:specName" /></a>
                  <!-- @@todo test if-block below -->
                  <xsl:if test="btw:testElements">
                    <ul>
                      <xsl:for-each select="btw:testElements/btw:testElement">
                        <li>Feature: <code><xsl:value-of select="btw:elementName/@localname"/></code>
                          <xsl:if test="btw:elementName/@namespace">
                            (namespace: <xsl:choose><xsl:when test="string-length(btw:elementName/@namespace) &gt; 0"><code><xsl:value-of select="btw:elementName/@namespace"/></code></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>)
                          </xsl:if>.
                        </li>
                        <xsl:if test="btw:specReference/@xlink:href"><!--/@xlink:href added 20080509-->
                          <li>Technical specification: 
                            <a href="{btw:specReference/@xlink:href}"><xsl:choose>
                              <xsl:when test="string-length(btw:specReference/.) &gt; 0">
                               <xsl:apply-templates />
                              </xsl:when>
                              <xsl:otherwise><xsl:value-of select="btw:specReference/@xlink:href" /></xsl:otherwise>
                            </xsl:choose></a>.
                          </li><!--changed 2009-01-14: li instead of p -->
                        </xsl:if>
                        <xsl:if test="btw:specQuote">
                          <p>From the technical specification:</p>
                          <blockquote><xsl:apply-templates /></blockquote>
                        </xsl:if>
                      </xsl:for-each>
                    </ul>
                  </xsl:if>
                </li>
              </xsl:for-each>
              </ul>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$DEBUG = 'true'"><p class="debug">Only one technology.</p></xsl:if>
              <p>Technology:<!--added 2009-01-14--> <a href="{/btw:testCaseDescription/btw:technologies/btw:technicalSpec/@xlink:href}"><xsl:apply-templates select="/btw:testCaseDescription/btw:technologies/btw:technicalSpec/btw:specName" /></a>
              </p>
              <xsl:if test="/btw:testCaseDescription/btw:technologies/btw:technicalSpec/btw:testElements">
                <p>Feature(s):</p>
                <ul>
                  <xsl:for-each select="/btw:testCaseDescription/btw:technologies/btw:technicalSpec/btw:testElements/btw:testElement">
                    <li>Feature: <code><xsl:value-of select="btw:elementName/@localname"/></code>
                      <xsl:if test="btw:elementName/@namespace">
                        (namespace: <xsl:choose><xsl:when test="string-length(btw:elementName/@namespace) &gt; 0"><code><xsl:value-of select="btw:elementName/@namespace"/></code></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>)
                      </xsl:if>.
                    </li>
                    <xsl:if test="btw:specReference/@xlink:href"><!--/@xlink:href added 20080509-->
                      <li>Technical specification: 
                        <a href="{btw:specReference/@xlink:href}"><xsl:choose>
                          <xsl:when test="string-length(btw:specReference/.) &gt; 0">
                           <xsl:apply-templates />
                          </xsl:when>
                          <xsl:otherwise><xsl:value-of select="btw:specReference/@xlink:href" /></xsl:otherwise>
                        </xsl:choose></a>.
                      </li><!--changed 2009-01-14: li instead of p -->
                    </xsl:if>
                    <xsl:if test="btw:specQuote">
                      <li>From the technical specification:</li><!--changed 2009-01-14: li instead of p -->
                      <blockquote><xsl:apply-templates /></blockquote>
                    </xsl:if>
                  </xsl:for-each>
                </ul>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>

        </div>
      </body>
    </html>
  </xsl:template>


  <xsl:template name="printRuleLink">
    <xsl:param name="accRule" />
    <!--xsl:param name="isPrimary" /-->
    <xsl:variable name="ruleID" select="$accRule/@xlink:href" />
    <xsl:if test="$DEBUG = 'true'"> <em class="debug">$accRule/@xlink:href = <xsl:value-of select="$accRule/@xlink:href"/> </em></xsl:if>
    <a>
      <xsl:attribute name="href">
        http://www.w3.org/TR/2008/REC-WCAG20-20081211/#<xsl:value-of select="$ruleID"/>
      </xsl:attribute>
      <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 Success Criterion <xsl:call-template name="successsCriterionIdAndLevel" /> 
    </a>
  </xsl:template>


  <xsl:template name="printRuleInfo">
    <xsl:param name="accRule" />
    <xsl:param name="isPrimary" />
    <xsl:choose>
      <xsl:when test="btw:locations/btw:location">
        <xsl:for-each select="btw:locations/btw:location">
          <xsl:if  test="../@expectedResult = 'fail'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <p>The test case <strong class="fail">fails</strong> the test procedure in the technique/failure referenced below 
              <xsl:if test="earlwd:lineCharLen"> at line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" /></xsl:if>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'pass'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <p>The test case <strong class="pass">passes</strong> <xsl:if test="earlwd:lineCharLen"> the test procedure in the technique/failure referenced below 
              (line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" />)</xsl:if>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'cannotTell'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <p>The test case <strong class="cannotTell">needs review</strong> before it can be established if it passes or fails the test procedure in the technique/failure referenced below.
              <xsl:if test="earlwd:lineCharLen"> The code that causes doubt can be found at line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" />.</xsl:if>
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'notApplicable'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <!--p>Success criterion <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template> is <strong class="notApplicable">not applicable</strong> to this test case.</p--><!--commented out 2009-03-03-->
            <p>There is no applicable test procedure in the techniques or failures for the relevant success criterion.<!--@@ get SC and/or technique/failure reference. -->.</p>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="@techrefs">
              <xsl:call-template name="processTechRefs">
                <xsl:with-param name="theTechRefs" select="@techrefs" />
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="../../btw:techComment[starts-with(btw:p, 'This test case does not map to a')]"><p>(This test case does not map to a <acronym>WCAG</acronym> 2.0 technique or failure.)</p></xsl:when>
                <xsl:otherwise><p>Missing references to <strong>techniques/failures</strong>!</p></xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="btw:locations/@expectedResult = 'fail'">
          <xsl:variable name="theRule" select="substring-after(string(@xlink:href), '#')" />
          <p>The test case <strong class="fail">fails</strong> the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if  test="btw:locations/@expectedResult = 'pass'">
          <xsl:variable name="theRule" select="substring-after(string(@xlink:href), '#')" />
          <p>The test case <strong class="pass">passes</strong> the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if test="btw:locations/@expectedResult = 'cannotTell'">
          <xsl:variable name="theRule" select="substring-after(string(@xlink:href), '#')" />
          <p>The test case <strong class="cannotTell">needs review</strong> before it can be established if it passes or fails the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if test="btw:locations/@expectedResult = 'notApplicable'">
          <xsl:variable name="theRule" select="substring-after(string(@xlink:href), '#')" />
          <p>The following success criterion is <strong class="notApplicable">not applicable</strong> to this test case: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.</p>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <!-- @@ template section for functionalOutcome deleted. Warning for using functionalOutcome here? -->

    <!-- Process techComment only if it contains non-empty paragraphs and/or element or comment nodes. @@check -->
    <xsl:if test="btw:techComment/btw:p[count(*|comment())&gt;0 or text()]">
      <div class="techComment">
      <xsl:choose>
        <xsl:when test="$isPrimary = 'yes'"><h4>Technical Comment</h4></xsl:when>
        <xsl:otherwise><h5>Technical Comment</h5></xsl:otherwise>
      </xsl:choose>
        <xsl:for-each select="btw:techComment/btw:p"><p><xsl:apply-templates /></p></xsl:for-each>
      </div>
    </xsl:if>
  </xsl:template>


  <!-- Recursively process space delimited IDREFS to retrieve relevant WCAG 2.0 technique or failure. -->
  <!-- @@todo warn when an ID listed in IDREFS does not have a corresponding technique element -->
  <xsl:template name="processTechRefs">
    <xsl:param name="theTechRefs" />
    <xsl:choose>
      <!-- If there is more than one reference, process space-delimited list: -->
      <xsl:when test="contains($theTechRefs, ' ')">
        <p><strong>Relevant technique/failure</strong>: 
         <a href="{../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href}">
           <xsl:value-of select="substring-after(../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href, '#')" />:
           <xsl:value-of select="$techniqueList/techniquesList/technique[@id=substring-before($theTechRefs, ' ')]/short-name" /><!--added 2009-06-24-->
         </a>.
         (From <xsl:call-template name="addDateForTechRefs"><xsl:with-param name="theTechRefs" select="../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href"/></xsl:call-template>).
        </p>
        <!-- Call the same template again with the list of techRefs minus the one processed above: -->
        <xsl:call-template name="processTechRefs"><xsl:with-param name="theTechRefs" select="substring-after($theTechRefs, ' ')"/></xsl:call-template>
      </xsl:when>
      
      <xsl:when test="string-length($theTechRefs) = 0">
        <!-- do nothing -->
      </xsl:when>
      
      <!-- Otherwise, there's only one reference to process: -->
      <xsl:otherwise>
        <p><strong>Relevant technique/failure</strong>: 
          <a href="{../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href}"><!--xsl:value-of select="substring-after(../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href, '#')"/-->
            <xsl:value-of select="$theTechRefs" />: 
            <xsl:value-of select="$techniqueList/techniquesList/technique[@id=$theTechRefs]/short-name" /><!--added 2009-06-24-->
          </a> 
          (From <xsl:call-template name="addDateForTechRefs"><xsl:with-param name="theTechRefs" select="../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href"/></xsl:call-template>).</p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="addDateForTechRefs">
    <xsl:param name="theTechRefs" />
    <xsl:choose>
        <xsl:when test="contains($theTechRefs,'TECHS-20081211')"><!--added 20090112-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/NOTE-WCAG20-TECHS-20081211/</xsl:variable>
          <a href="{$URL}">December 2008 Working Group Note</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20081103')"><!--added 20090112-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20081103/</xsl:variable>
          <a href="{$URL}">November 2008 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20080430')"><!--added 20080509-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/WD-WCAG20-TECHS-20080430/</xsl:variable>
          <a href="{$URL}">April 2008 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20071211')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-TECHS-20071211/</xsl:variable>
          <a href="{$URL}">December 2007 Working Draft (Last Call)</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20070517')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-TECHS-20070517/Overview.html</xsl:variable>
          <a href="{$URL}">May 2007 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20060427')">
          <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-TECHS-20060427/</xsl:variable>
          <a href="{$URL}">April 2006 Working Draft (Last Call)</a>
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20050630')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/techs-change-history.html</xsl:variable>
          (<a href="{$URL}">History of Changes to Techniques for <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 Working Drafts</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20051123')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/techs-change-history.html</xsl:variable>
          (<a href="{$URL}">History of Changes to Techniques for <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 Working Drafts</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20050211')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/techs-change-history.html</xsl:variable>
          (<a href="{$URL}">History of Changes to Techniques for <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 Working Drafts</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'WAI-WEBCONTENT-19990505')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/techs-change-history.html</xsl:variable>
          (<a href="{$URL}">History of Changes to Techniques for <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 Working Drafts</a>)
        </xsl:when>
        <xsl:otherwise>Unknown techniques document.
          <xsl:if test="$DEBUG = 'true'">[URL: <xsl:value-of select="$theTechRefs"/>]</xsl:if>
        </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="getRuleLink">
    <xsl:param name="aRule" />
        <strong class="getRuleLink"><a href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/#{$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href}">
          <xsl:call-template name="successsCriterionIdAndLevel" />
        </a></strong>
    <xsl:choose>
      <!-- Normally, one should get the URL from the successCriterion element in rulesets.xml ... -->
      <xsl:when test="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule][@xlink:href]">
        <a href="http://www.w3.org/TR/2008/REC-WCAG20-20081211/#{$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href}">
          <xsl:call-template name="successsCriterionIdAndLevel" />
        </a>
      </xsl:when>
      <!-- ... otherwise, hack the rule ID to generate the URL. -->
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="starts-with($aRule, 'WCAG2_20081211')"><!--added 20090112-->
            <xsl:variable name="URL">http://www.w3.org/TR/2008/REC-WCAG20-20081211/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20081211_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20081103')"><!--added 20090112-->
            <xsl:variable name="URL">http://www.w3.org/TR/2008/PR-WCAG20-20081103/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20081103_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20080430')"><!--added 20080509-->
            <xsl:variable name="URL">http://www.w3.org/TR/2008/CR-WCAG20-20080430/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20080430_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20071211')">
            <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20071211/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20071211_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20070517')">
            <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-20070517/Overview.html#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20070517_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20060427')">
            <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-20060427/guidelines.html#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20060427_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20050630')">
            <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-20050630/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20050630_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <xsl:when test="starts-with($aRule, 'WCAG2_20051123')">
            <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG2-200511230/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20051123_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <!-- Hacking the URL does not work for WCAG 1.0. -->
          <xsl:otherwise>
            <strong class="error"><acronym>URL</acronym> unknown!</strong>: <xsl:value-of select="$aRule"/>.
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="explainStatus">
    <xsl:param name="theStatus" />
    <xsl:choose>
      <xsl:when test="($theStatus = 'unconfirmed') or ($theStatus = '0')">unconfirmed (test sample has been received and is not yet reviewed)</xsl:when>
      <xsl:when test="($theStatus = 'new') or ($theStatus = '1')">new (test sample successfully passed the structure review)</xsl:when>
      <xsl:when test="($theStatus = 'ballot') or ($theStatus = '2')">ballot (test sample underwent a content review and is available for group balloting)</xsl:when>
      <xsl:when test="($theStatus = 'pending') or ($theStatus = '3')">pending (test sample underwent balloting and is available for a formal <acronym>TF</acronym> decision)</xsl:when>
      <xsl:when test="($theStatus = 'fixes') or ($theStatus = '5')">fixes (test sample needs minor fixes and a renewed content review and balloting)</xsl:when>
      <xsl:when test="($theStatus = 'edits') or ($theStatus = '4')">edits (test sample needs minor edits before it can be queued for final decision)</xsl:when>
      <xsl:when test="($theStatus = 'holding') or ($theStatus = '6')">holding (test sample is queued for final decision by the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:when test="($theStatus = 'rejected') or ($theStatus = '8')">rejected (test sample has been rejected by the Task Force or the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:when test="($theStatus = 'accepted') or ($theStatus = '7')">accepted (test sample has been accepted by the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:when test="($theStatus = 'deprecated') or ($theStatus = '9')">deprecated (test sample has been deprecated by the Task Force or the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:otherwise><strong class="error">unknown status: <xsl:value-of select="$theStatus"/></strong></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="successsCriterionIdAndLevel">
    <xsl:variable name="rsRuleset">WCAG2_20081211</xsl:variable><!-- This stylesheet is only for WCAG 2.0 REC rules. -->
    <xsl:variable name="RuleRef" select="/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href" />
    <!-- Select the rs:SuccessCriterion that matches $RuleRef: -->
    <xsl:variable name="RSsuccessCriterion" 
      select="$rulesets/rs:rulesets/rs:ruleset[@id = $rsRuleset ]/rs:guideline/rs:successCriterion[substring-after(substring-after(string(@id),'WCAG2_20081211_'), '_') = $RuleRef ]" 
    />
    <!-- Print the Level of the success criterion: -->
    <xsl:variable name="RSlevel" select="$RSsuccessCriterion/@level" />
    <xsl:text> </xsl:text><xsl:value-of select="$RSsuccessCriterion/../@name" />.<xsl:value-of select="$RSsuccessCriterion/@name" />
    <xsl:choose>
      <xsl:when test="$RSlevel = '1'"> (Level A)</xsl:when>
      <xsl:when test="$RSlevel = '2'"> (Level AA)</xsl:when>
      <xsl:when test="$RSlevel = '3'"> (Level AAA)</xsl:when>
      <xsl:otherwise> (Level ?)</xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$DEBUG = 'true'">
      <strong class="debug"><xsl:value-of select="$RuleRef"/> (level <xsl:value-of select="$RSlevel"/>; SC: <xsl:value-of select="$RSsuccessCriterion"/>)</strong><br />
      <strong class="debug">rulesets count= <xsl:value-of select="count($rulesets/rs:rulesets/rs:ruleset[@id = $rsRuleset ])"/></strong>
    </xsl:if>
  </xsl:template>

  <xsl:template match="html:acronym"><acronym><xsl:copy-of select="@*"/><xsl:apply-templates /></acronym></xsl:template>
  <xsl:template match="html:abbr"><abbr><xsl:copy-of select="@*"/><xsl:apply-templates /></abbr></xsl:template>
  <xsl:template match="html:br"><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text></xsl:template>
  <xsl:template match="html:strong"><strong><xsl:copy-of select="@*"/><xsl:apply-templates /></strong></xsl:template>
  <xsl:template match="html:em"><em><xsl:copy-of select="@*"/><xsl:apply-templates /></em></xsl:template>
  <xsl:template match="html:span[@class='btwsource']/a"><a><xsl:copy-of select="@*"/><xsl:apply-templates /></a></xsl:template>
  <xsl:template match="html:span"><span><xsl:copy-of select="@*"/><xsl:apply-templates /></span></xsl:template>
  <xsl:template match="html:code"><code><xsl:copy-of select="@*"/><xsl:apply-templates /></code></xsl:template>
  <xsl:template match="html:q"><q><xsl:copy-of select="@*"/><xsl:apply-templates /></q></xsl:template>
  <xsl:template match="html:samp"><samp><xsl:copy-of select="@*"/><xsl:apply-templates /></samp></xsl:template>
  <xsl:template match="html:kbd"><kbd><xsl:copy-of select="@*"/><xsl:apply-templates /></kbd></xsl:template>
  <xsl:template match="html:var"><var><xsl:copy-of select="@*"/><xsl:apply-templates /></var></xsl:template>
  <xsl:template match="html:cite"><cite><xsl:copy-of select="@*"/><xsl:apply-templates /></cite></xsl:template>
  <xsl:template match="html:dfn"><dfn><xsl:copy-of select="@*"/><xsl:apply-templates /></dfn></xsl:template>
  <xsl:template match="html:sub"><sub><xsl:copy-of select="@*"/><xsl:apply-templates /></sub></xsl:template>
  <xsl:template match="html:sup"><sup><xsl:copy-of select="@*"/><xsl:apply-templates /></sup></xsl:template>


  <!--copied from tcdl1.1_to_xhtml_print_noscenarios.xslt 2008-03-18-->
  <xsl:template name="getReadableRuleName">
    <xsl:param name="accRule" />
      <xsl:choose><!--@@todo remove choose-when: only WCAG 2.0 REC is supported (@xlink:href no longer uses Rulesets.xml-->
        <xsl:when test="contains($accRule,'WCAG2_20081211')"><!--added 20091103-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/REC-WCAG20-20081211/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - December 2008 Recommendation</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20081103')"><!--added 20091103-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/PR-WCAG20-20081103/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - November 2008 Proposed Recommendation</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20080430')"><!--added 20080509-->
          <xsl:variable name="URL">http://www.w3.org/TR/2008/CR-WCAG20-20080430/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - April 2008 Candidate Recommendation</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20071211')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20071211/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - December 2007 Working Draft (Last Call)</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20070517')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20070517/Overview.html</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - May 2007 Working Draft</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20060427')">
          <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-20060427/Overview.html</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - April 2006 Working Draft (Last Call)</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20050630')">
          <xsl:variable name="URL">http://www.w3.org/TR/2005/WD-WCAG20-20050630/Overview.html</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - June 2005 Working Draft</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20051123')">
          <xsl:variable name="URL">http://www.w3.org/TR/2005/WD-WCAG20-20051123/Overview.html</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - November 2005 Working Draft</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20050211')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/WD-WCAG20-20050211/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - February 2005 Editor's Draft</a>)
        </xsl:when>
        <xsl:when test="contains($accRule,'WAI-WEBCONTENT-19990505')">
          <xsl:variable name="URL">http://www.w3.org/TR/1999/WAI-WEBCONTENT-19990505/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 1.0</a>)
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="URL">http://www.w3.org/TR/2008/REC-WCAG20-20081211/</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - December 2008 Recommendation</a>)
        </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>