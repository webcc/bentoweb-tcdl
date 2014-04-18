<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:rs="http://bentoweb.org/refs/rulesets"
  exclude-result-prefixes="btw dc html xlink xml"
>
<xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="no" omit-xml-declaration="no"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
/>

  <!--    
        WARNING !

        This XSLT file is not meant to be used on its own, but
        to be included by another XSLT file with localised strings,
        for example:
          - tcdl1_to_xhtml_print_noscenarios_en.xslt (for English),
          - tcdl1_to_xhtml_print_noscenarios_de.xslt (for German),
          - etcetera.

        HINTS & TIPS

        For hints to speed up transformations, see http://xml.apache.org/xalan-j/faq.html#faq-N1015C
  -->


  <!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="DEBUG" select="'false'" />
  <!-- The test suite -->
  <xsl:param name="testsuite" select="'xhtml1_wcag2_'" />

  <!-- The number of test files in the test case -->
  <xsl:variable name="varTestFileCount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file)"/></xsl:variable>

  <!--xsl:variable name="rulesets" select="document('http://www.bentoweb.org/refs/rulesets.xml')" /-->
  <xsl:variable name="rulesets" select="document('../rulesets/rulesets.xml')" />


  <xsl:template match="btw:testCaseDescription">
    <html lang="en" xml:lang="en"><!--@@ lang stricly depends on parameter / importing language specific XSLT-->
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><xsl:value-of select="btw:formalMetadata/btw:title" /> (<xsl:call-template name="getTestSuiteName" />)</title>
        <link media="screen,projection" href="/css/html.css" type="text/css" rel="stylesheet" title="Default stylesheet" />
        <link media="screen,projection" href="/css/default.css" type="text/css" rel="stylesheet" title="Default stylesheet" />
        <link href="/images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
        <link href="http://purl.org/DC/elements/1.0/" rel="schema.DC" />
        <meta content="BIKA Team" name="author" />
        <meta content="application/xhtml+xml" name="DC.Format" />
        <meta content="en" name="DC.Language" />
        <meta content="BIKA Team" name="DC.Creator" />
        <meta content="Christophe Strobbe - DocArch - K.U.Leuven" name="DC.Creator" />
        <meta content="© BenToWeb (2004-2006)" name="DC.Rights" />
        <meta content="BenToWeb Consortium members" lang="en" name="DC.Subject" />
        <!--style type="text/css">strong.fail { color: #f00; background: transparent;} strong.pass { color: #060; background: transparent;} strong.cannotTell { font-style: italic; color: #f30; background: transparent;}
          div.rules { border: 1px dotted #f00; padding: .5em; }
        </style-->
      </head>
      <body>
    	<div class="logo"><a href="http://bentoweb.org/"><img src="/images/bentoweb_logo.png" alt="BenToWeb Home Page" /></a></div>
        <h1>
          <span class="testTitle">
            Test Case <xsl:value-of select="/btw:testCaseDescription/@id"/>: <xsl:value-of select="btw:formalMetadata/btw:title" />
          </span>
        </h1>
        <xsl:apply-templates />
      </body>
    </html>
  </xsl:template>


  <xsl:template match="btw:formalMetadata">
    <xsl:variable name="lang" select="normalize-space(dc:language)" />
    <div lang="en" xml:lang="en" id="metadata">
      <h2>Formal Metadata</h2>
      <table summary="Table with two columns: headings in the left column, data in the right column">
        <caption>Formal Metadata</caption>
        <tbody>
          <tr>
            <th>Title</th>
            <td><xsl:value-of select="btw:title" /></td>
          </tr>
          <tr>
            <th scope="row">Description</th>
            <td>
              <xsl:for-each select="btw:description">
                <xsl:apply-templates />
              </xsl:for-each>
            </td>
          </tr>
          <tr>
            <th scope="row">Creator</th>
            <td>BenToWeb (<xsl:value-of select="substring-before(dc:creator, '@')" />@&#8230;)</td>
          </tr>
          <tr>
            <th scope="row">Rights</th>
            <td><xsl:value-of select="dc:rights" /></td>
          </tr>
          <tr>
            <th scope="row">Language</th>
            <td>
              <xsl:choose>
                <xsl:when test="$lang = 'en'">English</xsl:when>
                <xsl:when test="$lang = 'de'">German</xsl:when>
                <xsl:when test="$lang = 'es'">Spanish</xsl:when>
                <xsl:when test="$lang = 'fr'">French</xsl:when>
                <xsl:when test="$lang = 'nl'">Dutch</xsl:when>
                <xsl:otherwise><xsl:value-of select="$lang" /></xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>
          <tr>
            <th scope="row">Date</th>
            <td><xsl:value-of select="btw:date" /></td>
          </tr>
          <tr>
            <th scope="row">Status</th>
            <td><xsl:value-of select="btw:status" /></td>
          </tr>
          <xsl:if test="btw:source">
            <tr>
              <th scope="row">Source</th>
              <td>
                <p>Test suite: 
                  <a href="{btw:source/btw:testSuite/@xlink:href}"><xsl:for-each select="btw:source/btw:testSuite/btw:name"><xsl:apply-templates /></xsl:for-each></a>.
                </p>
                <p>Source file: <a href="{btw:source/btw:sourceFile/@xlink:href}"><xsl:value-of select="btw:source/btw:sourceFile/@xlink:href"/></a>
                  by <xsl:value-of select="btw:source/btw:sourceFile/dc:creator" />
                  <xsl:if test="starts-with(btw:source/btw:sourceFile/@changed, 'true')"> (borrowed with modifications)</xsl:if>.
                </p>
              </td>
            </tr>
          </xsl:if>
          <!-- @TODO dc:rights -->
          <!-- @TODO comment -->
        </tbody>
      </table>
    </div>
  </xsl:template>


  <xsl:template match="btw:technology">
    <div id="technology">
      <h2>Technologies and Features</h2>
      <p>Technologies are markup languages or data formats. If the technology is a markup language, &#8220;features&#8221; refers to elements and attributes.</p>
      <!-- @@todo expand explanation? -->
      <xsl:for-each select="btw:recommendation">
        <h3><xsl:apply-templates mode="technology" /></h3>
        <p><a href="{@xlink:href}"><xsl:apply-templates mode="technology" /></a></p>
        <xsl:if test="btw:testElements">
          <xsl:for-each select="btw:testElements/btw:testElement">
            <p>Feature: <code><xsl:value-of select="btw:elementName/@localname"/></code>
              <xsl:if test="btw:elementName/@namespace">
                (namespace: <xsl:choose><xsl:when test="string-length(btw:elementName/@namespace) &gt; 0"><code><xsl:value-of select="btw:elementName/@namespace"/></code></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>)
              </xsl:if>.
            </p>
            <xsl:if test="btw:specReference">
              <p>Technical specification: 
                <a href="{btw:specReference/@xlink:href}"><xsl:choose>
                  <xsl:when test="string-length(btw:specReference/.) &gt; 0">
                   <xsl:apply-templates />
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="btw:specReference/@xlink:href" /></xsl:otherwise>
                </xsl:choose></a>.
              </p>
            </xsl:if>
            <xsl:if test="btw:specQuote">
              <p>From the technical specification:</p>
              <blockquote><xsl:apply-templates /></blockquote>
            </xsl:if>
          </xsl:for-each>
        </xsl:if>
      </xsl:for-each>
    </div>
  </xsl:template>


  <xsl:template match="btw:testCase">
    <div id="testCase">
      <h2>Test Data</h2>
      <xsl:apply-templates mode="testCase" />
      <h3><acronym title="Test Case Description Language">TCDL</acronym> Data</h3>
      <p><a><xsl:attribute name="href"><xsl:value-of select="/btw:testCaseDescription/@id"/>.xml</xsl:attribute><xsl:value-of select="/btw:testCaseDescription/@id"/> (<acronym title="extensible markup language">XML</acronym>).</a></p>
    </div>
  </xsl:template>


  <xsl:template match="btw:purpose" mode="testCase">
    <div id="purpose">
      <h3>Purpose</h3>
      <xsl:for-each select="btw:p">
        <p><xsl:apply-templates /></p>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="btw:expertGuidance" mode="testCase">
    <div id="expertguidance">
      <h3>Expert Guidance</h3>
      <xsl:for-each select="btw:p">
        <p><xsl:apply-templates /></p>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="btw:scenario"><!-- DO NOTHING --></xsl:template>
  <xsl:template match="btw:scenario" mode="testCase"><!-- DO NOTHING --></xsl:template>

  <xsl:template match="btw:testModes" mode="testCase">
    <div id="testmodes">
      <h3>Test Modes</h3>
      <!--xsl:variable name="testModeCount"><xsl:value-of select="count(btw:testMode)" /></xsl:variable>
      <xsl:if test="starts-with($DEBUG, 'true')"><p>Test mode count =  <xsl:value-of select="$testModeCount" />.</p></xsl:if-->      
      <xsl:choose>
        <xsl:when test="count(btw:testMode) &gt; 1">
          <ul>
            <xsl:for-each select="btw:testMode">
              <li><xsl:call-template name="getTestMode"><xsl:with-param name="mode" select="normalize-space(.)" /></xsl:call-template></li>
            </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:when test="count(btw:testMode) = 1">
          <p><xsl:call-template name="getTestMode"><xsl:with-param name="mode" select="normalize-space(.)" /></xsl:call-template></p>
        </xsl:when>
        <xsl:otherwise><p>(No test mode specified.)</p></xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>

  <xsl:template match="btw:files" mode="testCase">
    <div id="testFiles">
      <h3>Test Files</h3>
      <xsl:choose>
        <xsl:when test="starts-with(@sequential, 'true') and $varTestFileCount &gt; 1">
          <p>The test files must be inspected in the order defined below.</p>
          <ol>
            <xsl:for-each select="btw:file">
              <li>
                <a href="{./@xlink:href}">
                  <xsl:call-template name="printTestFileWithNumber">
                    <xsl:with-param name="testFilePosition" select="position()" />
                  </xsl:call-template>
                </a>
              </li>
            </xsl:for-each>
          </ol>
        </xsl:when>
        <xsl:when test="not(starts-with(@sequential, 'true')) and $varTestFileCount &gt; 1">
          <ul>
            <xsl:for-each select="btw:file">
              <li>
                <a href="{./@xlink:href}">
                  <xsl:call-template name="printTestFileWithNumber">
                    <xsl:with-param name="testFilePosition" select="position()" />
                  </xsl:call-template>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:when>
        <xsl:otherwise>
          <p>
            <a href="{btw:file/@xlink:href}">Test file</a>.
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </div>
  </xsl:template>


  <xsl:template match="btw:rules">
    <div id="rules">
      <h2>Rules</h2>
      <p>&#8220;Rules&#8221; refer to success criteria in <acronym>WCAG</acronym> 2.0, checkpoints in <acronym>WCAG</acronym> 1.0 and similar requirements.</p>
      <!-- any rule that says primary='yes' or that does not have a primary attribute and is not followed by a rule that says primary='no' -->
      <!--xsl:for-each select="btw:rule[@primary='yes'] | btw:rule[not(@primary='yes')][not(following-sibling::btw:rule[@primary='no'])]"-->
      <!-- any rule that says primary='yes' or that does not have a primary attribute and is not preceded by another rule. -->
      <xsl:for-each select="btw:rule[@primary='yes'] | btw:rule[not(@primary='yes')][not(preceding-sibling::btw:rule)]">
        <h3>Primary Rules</h3>
        <xsl:call-template name="printRuleInfo">
          <xsl:with-param name="accRule" select="." />
          <xsl:with-param name="isPrimary" select="yes" />
        </xsl:call-template>
      </xsl:for-each>
      <!-- any rule that says primary='no' or that does not have a primary attribute and is preceded by a rule that says primary='yes' -->
      <xsl:if test="btw:rule[@primary='no'] | btw:rule[not(@primary='yes')][preceding-sibling::btw:rule[@primary='yes']]">
        <div id="secRules">
          <h3>Secondary Rules</h3>
          <xsl:for-each select="btw:rule[@primary='no'] | btw:rule[not(@primary='yes')][preceding-sibling::btw:rule[@primary='yes']]">
            <h4>Secondary Rule <xsl:call-template name="getReadableRuleName"><xsl:with-param name="accRule" select="./@id" /></xsl:call-template></h4>
            <xsl:call-template name="printRuleInfo">
              <xsl:with-param name="accRule" select="." />
              <xsl:with-param name="isPrimary" select="no" />
            </xsl:call-template>
          </xsl:for-each>
        </div>
      </xsl:if>
    </div>
  </xsl:template>


  <xsl:template match="btw:label" mode="technology"><xsl:apply-templates /></xsl:template>
  <xsl:template match="btw:*" mode="technology"><!-- DO NOTHING --></xsl:template>


  <xsl:template match="btw:functionalOutcome" mode="functionalOutcome"><xsl:apply-templates /></xsl:template>

  <xsl:template match="btw:techComment" mode="techComment"><xsl:apply-templates /></xsl:template>

  <xsl:template match="html:span[@class='technique']"><span class="technique"><xsl:apply-templates /></span></xsl:template>
  <xsl:template match="html:span[@class='technique']/html:a"><a href="{@href}"><xsl:value-of select="."/></a></xsl:template>

  <xsl:template match="html:acronym"><acronym><xsl:copy-of select="@*"/><xsl:apply-templates /></acronym></xsl:template>
  <xsl:template match="html:abbr"><abbr><xsl:copy-of select="@*"/><xsl:apply-templates /></abbr></xsl:template>
  <xsl:template match="html:br"><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text></xsl:template>
  <xsl:template match="html:strong"><strong><xsl:copy-of select="@*"/><xsl:apply-templates /></strong></xsl:template>
  <xsl:template match="html:em"><em><xsl:copy-of select="@*"/><xsl:apply-templates /></em></xsl:template>
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


  <xsl:template name="printRuleInfo">
    <xsl:param name="accRule" />
    <xsl:param name="isPrimary" />
    <xsl:choose>
      <xsl:when test="btw:locations/btw:location">
        <xsl:for-each select="btw:locations/btw:location">
          <xsl:if  test="../@expectedResult = 'fail'">
            <xsl:variable name="theRule" select="substring-after(string(../../@id), '#')" />
            <p>The test case <strong class="fail">fails</strong> the following success criterion <xsl:if test="@line and @column"> at line <xsl:value-of select="@line" />, column <xsl:value-of select="@column" /></xsl:if>: 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'pass'">
            <xsl:variable name="theRule" select="substring-after(string(../../@id), '#')" />
            <p>The test case <strong class="pass">passes</strong> <xsl:if test="@line and @column"> (line <xsl:value-of select="@line" />, column <xsl:value-of select="@column" />)</xsl:if> the following success criterion: 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'cannotTell'">
            <xsl:variable name="theRule" select="substring-after(string(../../@id), '#')" />
            <p>The test case <strong class="cannotTell">needs review</strong> before it can be established if it passes or fails the following success criterion: 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
              <xsl:if test="@line and @column"> The code that causes doubt can be found at line <xsl:value-of select="@line" />, column <xsl:value-of select="@column" />.</xsl:if>
            </p>
          </xsl:if>
          <xsl:if  test="../@expectedResult = 'notApplicable'">
            <xsl:variable name="theRule" select="substring-after(string(../../@id), '#')" />
            <p>The following success criterion is <strong class="notApplicable">not applicable</strong> to this test case: 
              <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
            </p>
          </xsl:if>
        </xsl:for-each>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if  test="btw:locations/@expectedResult = 'fail'">
          <xsl:variable name="theRule" select="substring-after(string(@id), '#')" />
          <p>The test case <strong class="fail">fails</strong> the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if  test="btw:locations/@expectedResult = 'pass'">
          <xsl:variable name="theRule" select="substring-after(string(@id), '#')" />
          <p>The test case <strong class="pass">passes</strong> the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if test="btw:locations/@expectedResult = 'cannotTell'">
          <xsl:variable name="theRule" select="substring-after(string(@id), '#')" />
          <p>The test case <strong class="cannotTell">needs review</strong> before it can be established if it passes or fails the following success criterion: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.
          </p>
        </xsl:if>
        <xsl:if test="btw:locations/@expectedResult = 'notApplicable'">
          <xsl:variable name="theRule" select="substring-after(string(@id), '#')" />
          <p>The following success criterion is <strong class="notApplicable">not applicable</strong> to this test case: 
            <xsl:call-template name="getRuleLink"><xsl:with-param name="aRule" select="$theRule" /></xsl:call-template>.</p>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <div class="functionalOutcome">
      <xsl:choose>
        <xsl:when test="$isPrimary = 'yes'"><h4>Functional Outcome</h4></xsl:when>
        <xsl:otherwise><h5>Functional Outcome</h5></xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="btw:functionalOutcome/btw:p"><p><xsl:apply-templates /></p></xsl:for-each>
    </div>
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

  <xsl:template match="btw:techComment/btw:p/html:span[not(@class)]/html:a"><!-- added 2007-11-29 -->
    <a><xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute><xsl:value-of select="."/></a>
  </xsl:template>

  <xsl:template name="getRuleLink">
    <xsl:param name="aRule" />
    <xsl:choose>
      <!-- Normally, one should get the URL from the successCriterion element in rulesets.xml ... -->
      <xsl:when test="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule][@xlink:href]">
        <a href="{$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href}"><xsl:value-of select="$rulesets/rs:rulesets/rs:ruleset/rs:guideline/rs:successCriterion[string(@id) = $aRule]/@xlink:href" /></a>
      </xsl:when>
      <!-- ... otherwise, hack the rule ID to generate the URL. -->
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="starts-with($aRule, 'WCAG2_20070517')">
            <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20070517/Overview.html#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20070517_'),'_')"/></xsl:variable>
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
          <xsl:when test="starts-with($aRule, 'WCAG2_20050211')">
            <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/WD-WCAG20-20050211/#<xsl:value-of select="substring-after(substring-after($aRule, 'WCAG2_20050211_'),'_')"/></xsl:variable>
            <a href="{$URL}"><xsl:value-of select="$URL"/></a>
          </xsl:when>
          <!-- Hacking the URL does not work for WCAG 1.0. -->
          <xsl:otherwise>
            <strong class="error"><acronym>URL</acronym> unknown!</strong>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="getReadableRuleName">
    <xsl:param name="accRule" />
      <xsl:choose>
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
      </xsl:choose>
  </xsl:template>


  <xsl:template name="getFullTestSuiteName">
    <xsl:if test="starts-with($testsuite, 'xhtml1_wcag2')"><acronym>XHTML</acronym> 1 Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'svg_wcag2')"><acronym>SVG</acronym> Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'xforms_wcag2')">XForms Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'xhtml2_wcag2')"><acronym>XHTML</acronym> 2 Test Suite</xsl:if>
  </xsl:template>


  <xsl:template name="getTestSuiteName">
    <xsl:if test="starts-with($testsuite, 'xhtml1_wcag2')">XHTML 1 Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'svg_wcag2')">SVG Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'xforms_wcag2')">XForms Test Suite</xsl:if>
    <xsl:if test="starts-with($testsuite, 'xhtml2_wcag2')">XHTML 2 Test Suite</xsl:if>
  </xsl:template>


</xsl:stylesheet>