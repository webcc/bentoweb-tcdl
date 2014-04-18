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
><!--   exclude-result-prefixes="btw dc html xlink xml" -->
  <xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
  />

  <!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="DEBUG" select="'false'" />

  <xsl:variable name="rulesets" select="document('http://bentoweb.org/refs/rulesets.xml')" />
  <!--xsl:variable name="rulesets" select="document('http://localhost:8080/bentoweb/refs/rulesets.xml')" /-->

  <!-- The number of test files in the test case -->
  <xsl:variable name="varTestFileCount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file)"/></xsl:variable>
  <xsl:variable name="varAbsURICount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file/http:GetRequest/http:requestURI/http:absoluteURI)"/></xsl:variable>



  <xsl:template match="btw:testCaseDescription">
    <html xml:lang="en" lang="en">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Test <xsl:value-of select="/btw:testCaseDescription/@id"/>: <xsl:value-of select="btw:formalMetadata/btw:title" /> [<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:status"/>]<!-- (WCAG 2.0 Test Samples) --></title>
        <style type="text/css">
body { font-family: 'Trebuchet MS', Verdana, Geneva, Helvetica, Arial, sans-serif; 
 color: #000; background: #fff; 
 margin-bottom: 2em; 
}
h1 { text-align: left;}
table { border-collapse: collapse; }
th, td { padding: .3em; border: 1pt solid #000; }
code { color: #00f; background: #fff; }
.todo { color: #f00; background: transparent; }
.debug { color: #0f0; background: transparent; }
        </style>
      </head>
      <body>
        <!-- The title of a test case is usually stored in English; 
          should it be stored in another language, then the correct language attribute will also be set 
        -->
        <h1>
          <xsl:choose>
            <xsl:when test="@xml:lang">
              <xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang" /></xsl:attribute>
              <xsl:attribute name="lang"><xsl:value-of select="@xml:lang" /></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name="xml:lang">en</xsl:attribute>
              <xsl:attribute name="lang">en</xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <span class="testTitle"><!-- @@ other lang code? -->
           Test <code class="id"><xsl:value-of select="/btw:testCaseDescription/@id"/></code>: <xsl:value-of select="btw:formalMetadata/btw:title" />
          </span> <span class="status">[<xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:status"/>]</span>
        </h1>

        <div lang="en" xml:lang="en" id="metadata">
          <h2>Metadata</h2>
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
                <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:status" /><xsl:text> </xsl:text> <span><xsl:call-template name="explainStatus"><xsl:with-param name="theStatus" select="/btw:testCaseDescription/btw:formalMetadata/btw:status" /></xsl:call-template></span> (<a href="http://www.w3.org/WAI/ER/tests/process">Review Process</a>)</td>
              </tr>
              <tr>
                <td>Review History</td>
                <td><a href="http://www.w3.org/2006/tsdtf/TestSampleStatusList">Test Samples Satus List</a></td>
              </tr>
              <tr>
                <td>Creator</td>
                <td>Developed by <a href="http://www.w3.org/"><acronym title="World Wide Web Consortium">W3C</acronym></a>/<a href="http://www.w3.org/WAI/"><acronym title="Web Accessibility Initiative">WAI</acronym></a>'s <a href="http://www.w3.org/WAI/ER/">Evaluation and Repair Tools Working Group</a> (ERT WG). We invite comments and discussion. Please address your feedback to <a href="mailto:public-wai-ert-tests@w3.org">public-wai-ert-tests@w3.org</a>, a mailing list with a <a href="http://lists.w3.org/Archives/Public/public-wai-ert-tsdtf/">public archive</a>.</td>
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
          <h2>Test Case</h2>
          <h3>Description</h3>
            <xsl:for-each select="/btw:testCaseDescription/btw:testCase/dc:description">
              <div class="description"><p><xsl:apply-templates /></p></div>
            </xsl:for-each>
          <h3>Purpose</h3>
            <xsl:for-each select="/btw:testCaseDescription/btw:testCase/btw:purpose/btw:p">
              <p><xsl:apply-templates /></p>
            </xsl:for-each>
          <h3>Test Files</h3>
            <!-- @@ this only works for the current test suite! -->
            <p>Metadata: <a href="{/btw:testCaseDescription/@id}.xml"><acronym>XML</acronym> file</a>.</p>
            <!--p>Metadata: <a href="http://www.w3.org/WAI/ER/tests/xhtml/metadata/{/btw:testCaseDescription/@id}.xml"><acronym>XML</acronym> file</a>.</p-->
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
                          <a href="{/btw:testCaseDescription/btw:testCase/btw:files/btw:file/http:GetRequest/http:requestURI/http:absoluteURI}">file</a>
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
            <h3>Expected Results</h3>
              <xsl:for-each select="/btw:testCaseDescription/btw:rules/btw:rule[1]">
                <xsl:call-template name="printRuleInfo">
                  <xsl:with-param name="accRule" select="." />
                  <xsl:with-param name="isPrimary" select="yes" />
                </xsl:call-template>
              </xsl:for-each>
          </div>
        </div>

        <div>
          <h2>Technologies and Features</h2>
          <p>Technologies are markup languages or data formats. If the technology is a markup language, &#8220;features&#8221; refers to elements and attributes.</p>
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
    <xsl:param name="isPrimary" />
    <xsl:variable name="ruleID" select="substring-after(string($accRule/@xlink:href), '#')" />
    <a>
      <xsl:attribute name="href"><xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $ruleID]/@xlink:href"/><!--xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$accRule" /></xsl:call-template--></xsl:attribute>
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
            <p>The test case <strong class="fail">fails</strong><!--success criterion 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template--><!--commented out 2009-03-03-->
              <xsl:if test="earlwd:lineCharLen"> at line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" /></xsl:if>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'pass'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <p>The test case <strong class="pass">passes</strong> <xsl:if test="earlwd:lineCharLen"><!--success criterion 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template--><!--commented out 2009-03-03--> 
              (line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" />)</xsl:if>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'cannotTell'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <p>The test case <strong class="cannotTell">needs review</strong> before it can be established if it passes or fails<!--success criterion 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template--><!--commented out 2009-03-03-->.
              <xsl:if test="earlwd:lineCharLen"> The code that causes doubt can be found at line <xsl:value-of select="earlwd:lineCharLen/earlwd:line" />, column <xsl:value-of select="earlwd:lineCharLen/earlwd:char" />.</xsl:if>
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'notApplicable'">
            <xsl:variable name="theRule" select="substring-after(string(../../@xlink:href), '#')" />
            <!--p>Success criterion <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template> is <strong class="notApplicable">not applicable</strong> to this test case.</p--><!--commented out 2009-03-03-->
            <p>Not applicable.</p>
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
        <p>
         <strong>Relevant technique/failure</strong>: 
         <a href="{../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href}"><xsl:value-of select="substring-after(../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href, '#')" /></a>. (From <xsl:call-template name="addDateForTechRefs"><xsl:with-param name="theTechRefs" select="../../btw:techniques/btw:technique[@id=substring-before($theTechRefs, ' ')]/@xlink:href"/></xsl:call-template>).
        </p>
        <!-- Call the same template again with the list of techRefs minus the one processed above: -->
        <xsl:call-template name="processTechRefs"><xsl:with-param name="theTechRefs" select="substring-after($theTechRefs, ' ')"/></xsl:call-template>
      </xsl:when>
      <xsl:when test="string-length($theTechRefs) = 0">
        <!-- do nothing -->
      </xsl:when>
      <!-- Otherwise, there's only one reference to process: -->
      <xsl:otherwise>
        <p><strong>Relevant technique/failure</strong>: <a href="{../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href}"><!--xsl:value-of select="substring-after(../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href, '#')"/--><xsl:value-of select="$theTechRefs" /></a> (From <xsl:call-template name="addDateForTechRefs"><xsl:with-param name="theTechRefs" select="../../btw:techniques/btw:technique[@id=$theTechRefs]/@xlink:href"/></xsl:call-template>).</p>
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
        <!--xsl:when test="contains($theTechRefs,'TECHS-20050630')">
          <xsl:variable name="URL">@@</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - June 2005 Working Draft</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20051123')">
          <xsl:variable name="URL">@@</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - November 2005 Working Draft</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'TECHS-20050211')">
          <xsl:variable name="URL">@@</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0 - February 2005 Editor's Draft</a>)
        </xsl:when>
        <xsl:when test="contains($theTechRefs,'WAI-WEBCONTENT-19990505')">
          <xsl:variable name="URL">@@</xsl:variable>
          (<a href="{$URL}"><acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 1.0</a>)
        </xsl:when-->
        <xsl:otherwise><xsl:if test="$DEBUG = 'true'">[URL: <xsl:value-of select="$theTechRefs"/>]</xsl:if></xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="getRuleLink">
    <xsl:param name="aRule" />
    <xsl:choose>
      <!-- Normally, one should get the URL from the successCriterion element in rulesets.xml ... -->
      <xsl:when test="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule][@xlink:href]">
        <a href="{$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href}"><xsl:call-template name="successsCriterionIdAndLevel" /><!--xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href" /--></a>
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
      <xsl:when test="$theStatus = 'unconfirmed'">(test sample received and under review for completeness)</xsl:when>
      <xsl:when test="$theStatus = 'new'">(test sample is complete and under initial evaluation)</xsl:when>
      <xsl:when test="$theStatus = 'assigned'">(test sample is currently being reviewed by the task force)</xsl:when>
      <xsl:when test="$theStatus = 'pending'">(review complete, waiting for decision on teleconference)</xsl:when>
      <xsl:when test="$theStatus = 'holding'">(waiting for a decision by the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:when test="$theStatus = 'rejected'">(task force or <acronym>WCAG</acronym> Working Group decision)</xsl:when>
      <xsl:when test="$theStatus = 'accepted'">(test sample has been accepted by the <acronym>WCAG</acronym> Working Group)</xsl:when>
      <xsl:when test="$theStatus = 'deprecated'">(test sample has been become obsolete (for example due to changes in the <acronym>WCAG</acronym> documents or other reasons))</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="successsCriterionIdAndLevel">
    <!--xsl:value-of select="substring-after(substring-before(/btw:testCaseDescription/@id, '_l'), 'sc')"/-->
    <xsl:variable name="RuleRef" select="/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href" />
    <xsl:choose>
      <!-- Test assumes that the 27 April 2006 draft is the only WD covered by the test suite that doesn't use A-AA-AAA! -->
      <xsl:when test="contains($RuleRef, '20060427')"> (Level <xsl:value-of select="substring-before(substring-after(/btw:testCaseDescription/@id, '_l'), '_')"/>)</xsl:when>
      <xsl:when test="contains($RuleRef, '20070517') or contains($RuleRef, '20071211')">
        <xsl:choose>
          <xsl:when test="contains(/btw:testCaseDescription/@id, '_l1_')"> (Level A)</xsl:when>
          <xsl:when test="contains(/btw:testCaseDescription/@id, '_l2_')"> (Level AA)</xsl:when>
          <xsl:when test="contains(/btw:testCaseDescription/@id, '_l3_')"> (Level AAA)</xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <!--xsl:variable name="RSsuccessCriterion" select="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[substring-after(substring-after(string(@id),'_'), '_') = substring-before(/btw:testCaseDescription/@id, '_') ]" /-->
        <xsl:variable name="scID" select="substring-before(/btw:testCaseDescription/@id, '_')" />
        <!--<xsl:if test="$DEBUG = 'true'"><strong class="debug">SC ID = <xsl:value-of select="$scID"/>.</strong></xsl:if>-->
        <xsl:variable name="accRule" select="/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href" />
        <xsl:variable name="rsRuleset">
          <xsl:choose>
            <xsl:when test="contains(/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href,'WCAG2_20080430')">WCAG2_20080430</xsl:when>
            <xsl:when test="contains($accRule,'WCAG2_20071211')">WCAG2_20071211</xsl:when>
            <xsl:when test="contains($accRule,'WCAG2_20070517')">WCAG2_20070517</xsl:when>
            <xsl:otherwise><xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset[@id='WCAG1_19990505']" /></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="RSsuccessCriterion" select="$rulesets/rs:rulesets/rs:ruleset[@id = $rsRuleset]/rs:guideline/rs:successCriterion[substring-after(@xlink:href,'#') = $scID ]" />
        <xsl:variable name="RSlevel" select="$RSsuccessCriterion/@level" />
        <!--xsl:if test="$DEBUG = 'true'">
          <span class="debug">
          <span class="debug">@xlink:href: <xsl:value-of select="/btw:testCaseDescription/btw:rules/btw:rule[1]/@xlink:href"/>.</span>
            <xsl:choose>
              <xsl:when test="$rulesets/rs:rulesets/rs:ruleset[@id = $rsRuleset]">[Has ruleset: <xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset[@id = $rsRuleset]/@id"/>].</xsl:when>
              <xsl:otherwise>No ruleset found!</xsl:otherwise>
            </xsl:choose>
          </span>
          <span class="debug">[RSsuccessCriterion = <xsl:value-of select="$RSsuccessCriterion/@id"/>]</span>
          <span class="debug">(Level <xsl:value-of select="$RSlevel"/>)</span>
          <span class="debug"># rulesets = <xsl:value-of select="count($rulesets/rs:rulesets/rs:ruleset)"/>!</span>
          <xsl:if test="$DEBUG = 'true'"><span class="debug"># SC for 2008 = <xsl:value-of select="count($rulesets/rs:rulesets/rs:ruleset[contains(string(@id), '2008')]/rs:guideline/rs:successCriterion)"/>!</span></xsl:if>
          <xsl:if test="$DEBUG = 'true'"><span class="debug">$RSsuccessCriterion = <xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset[contains(string(@id), '2008')]/rs:guideline/rs:successCriterion[contains(string(@id),substring-before(/btw:testCaseDescription/@id, '_'))]"/>! </span></xsl:if>
          <xsl:if test="$DEBUG = 'true'"><span class="debug">$RSlevel = <xsl:value-of select="$RSlevel"/>!</span></xsl:if>
        </xsl:if-->
        <xsl:value-of select="$RSsuccessCriterion/../@name"/>.<xsl:value-of select="$RSsuccessCriterion/@name"/>
        <xsl:choose>
          <xsl:when test="$RSlevel = '1'"> (Level A)</xsl:when>
          <xsl:when test="$RSlevel = '2'"> (Level AA)</xsl:when>
          <xsl:when test="$RSlevel = '3'"> (Level AAA)</xsl:when>
          <xsl:otherwise> (Level ?)</xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
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
      <xsl:choose>
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
        <xsl:otherwise><xsl:if test="$DEBUG = 'true'">[not found @@<xsl:value-of select="$accRule"/>]</xsl:if></xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>