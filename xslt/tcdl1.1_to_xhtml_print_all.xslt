<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="btw dc html xlink xml"
>
<xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
/>

  <!--    
            WARNING !

            This XSLT file is not meant to be used on its own, but
            to be included in another XSLT file with localised strings,
            for example:
              - tcdl1_to_xhtml_print_en.xslt (for English),
              - tcdl1_to_xhtml_print_de.xslt (for German),
              - etcetera.

          HINTS & TIPS

          For hints to speed up transformations, see http://xml.apache.org/xalan-j/faq.html#faq-N1015C
  -->

  <!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="DEBUG" select="'false'" />
  <!-- Switching metadata on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="METADATA" select="'true'" />
  <!-- The test suite -->
  <xsl:param name="testsuite" select="'xhtml1_wcag2_'" />
  <!-- URL of the script that processes the user's feedback -->
  <xsl:param name="formaction" select="'usereval/'" />
  <!-- The ID of the scenario to use -->
  <xsl:param name="scenarioID" select="'s01'" />
  <!-- The scenario to use -->
  <xsl:variable name="testScenario" select="/btw:testCaseDescription/btw:testCase/btw:requiredTests/btw:scenario[@id=$scenarioID]" />

  <!-- The number of test files in the test case -->
  <xsl:variable name="varTestFileCount"><xsl:value-of select="count(/btw:testCaseDescription/btw:testCase/btw:files/btw:file)"/></xsl:variable>

  <!-- The test mode: only test cases where testMode contains "enduser" should be evaluated by end users. -->
  <xsl:variable name="testMode">
    <xsl:choose>
      <xsl:when test="starts-with(/btw:testCaseDescription/btw:testCase/btw:requiredTests/btw:testModes/btw:testMode, 'enduser')">enduser</xsl:when><!-- @TODO better function ??? -->
      <xsl:otherwise>nouser</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:template match="btw:testCaseDescription">
    <html xml:lang="en" lang="en">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title><xsl:value-of select="btw:formalMetadata/btw:title" /> (<xsl:call-template name="getTestSuiteName" />)</title>
        <style type="text/css">
body { font-family: 'Trebuchet MS', Helvetica, Geneva, Verdana, Arial, sans-serif; 
 color: #000; background: #fff; 
 margin-bottom: 2em; 
}
h1 { text-align: left;}
div.usertest { margin-bottom: 2em; padding: 1em; border: 2px solid black; }
/*div.usertest h1 { text-align: left; }*/
div.instructions { padding-bottom: .5em; border-bottom: 1px solid #000; }
div.testcase { padding-bottom: .5em; border-bottom: 1px solid #000; }
div.experience { border-top: 1px solid #000; }
textarea { font-size: 14pt; border: 1px solid #000; padding: 1px 4px 1px 4px; }
input.submit, button.submit { font-size: 14pt; border: 1px solid #000; padding: 1px 4px 1px 4px;  float: left; margin-right: 1em; } 
p.navlinks a { font-size: 14pt; 
  text-decoration: none; border: 1px solid #000; border-bottom: 1px solid #000; 
  padding: 1px 4px 1px 4px; 
  background: #ccc; color: #000; }
input#exitbutton { float: right;}
table { border-collapse: collapse; }
th, td { padding: .3em; border: 1pt solid #000; }

/*body { margin-left: 20pt;}
h1 {  text-align: left; margin-left: -12pt;}
h2 { margin-left: -8pt; }*/
<xsl:if test="starts-with($METADATA, 'true')">
div#metadata { display: block; clear: left; margin-top: 2em; /* border-top: 1pt dotted #000; */ }
</xsl:if>
<xsl:if test="starts-with($DEBUG, 'true')">
.debug { color: #f00; } 
</xsl:if>
        </style>
      </head>
      <body lang="{$language}" xml:lang="{$language}">
        <!-- The title of a test case is usually stored in English; 
          should it be stored in another language, then the correct language attribute will also be set 
        -->
        <h1>
          <xsl:choose>
            <xsl:when test="@xml:lang">
              <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
              <!--xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute-->
            </xsl:when>
            <xsl:otherwise>
              <xsl:choose>
                <xsl:when test="../@xml:lang">
                  <xsl:attribute name="lang"><xsl:value-of select="../@xml:lang"/></xsl:attribute>
                  <!--xsl:attribute name="xml:lang"><xsl:value-of select="../@xml:lang"/></xsl:attribute-->
                </xsl:when>
                <xsl:otherwise><xsl:value-of select="../../@xml:lang"/></xsl:otherwise>
              </xsl:choose>
            </xsl:otherwise>
          </xsl:choose>
          
          <span class="testTitle">
            <xsl:choose>
              <xsl:when test="@xml:lang">
                <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
                <!--xsl:attribute name="xml:lang"><xsl:value-of select="@xml:lang"/></xsl:attribute-->
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="../@xml:lang">
                    <xsl:attribute name="lang"><xsl:value-of select="../@xml:lang"/></xsl:attribute>
                    <!--xsl:attribute name="xml:lang"><xsl:value-of select="../@xml:lang"/></xsl:attribute-->
                  </xsl:when>
                  <xsl:otherwise><xsl:value-of select="../../@xml:lang"/></xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
            Test Case <xsl:value-of select="/btw:testCaseDescription/@id"/>: <xsl:value-of select="btw:formalMetadata/btw:title" />
          </span>
        </h1>


        <xsl:if test="starts-with($METADATA, 'true')">
          <div lang="en" xml:lang="en" id="metadata">
            <h2>Formal Metadata</h2>
            <table>
              <tbody>
                <tr>
                  <td>Title</td>
                  <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:title" /></td>
                </tr>
                <tr>
                  <td>Description</td>
                  <td>
                    <xsl:for-each select="/btw:testCaseDescription/btw:formalMetadata/btw:description">
                      <xsl:apply-templates />
                    </xsl:for-each>
                  </td>
                </tr>
                <tr>
                  <td>Purpose</td>
                  <td>
                    <xsl:for-each select="/btw:testCaseDescription/btw:testCase/btw:purpose/btw:p">
                      <p><xsl:apply-templates /></p>
                    </xsl:for-each>
                  </td>
                </tr>
                <tr>
                  <td>Creator</td>
                  <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:creator" /></td>
                </tr>
                <tr>
                  <td>Rights</td>
                  <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:rights" /></td>
                </tr>
                <tr>
                  <td>Language</td>
                  <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/dc:language" /></td>
                </tr>
                <tr>
                  <td>Date</td>
                  <td><xsl:value-of select="/btw:testCaseDescription/btw:formalMetadata/btw:date" /></td>
                </tr>
              </tbody>
            </table>
          </div>
        </xsl:if>


        <xsl:for-each select="btw:testCase/btw:requiredTests/btw:scenario">
          <div class="usertest">
            <xsl:attribute name="id">usertest_<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute>
            <h1>Scenario <xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></h1>
            <!-- display user instructions (matching instructions to the user's language) -->
            <xsl:if test="btw:testCase/btw:requiredTests/btw:scenario/btw:userGuidance[@xml:lang=$language]">
              <h2><xsl:call-template name="getInstructionsTitle" /></h2>
              <div class="instructions">
                <xsl:for-each select="btw:testCase/btw:requiredTests/btw:scenario/btw:userGuidance[@xml:lang=$language]/btw:p">
                  <p><xsl:apply-templates /></p>
                </xsl:for-each>
              </div>
            </xsl:if>
  
            <div class="testcase">
              <h2><xsl:call-template name="getTestCaseString" /></h2>
              <xsl:choose>
                <!-- More than one file: print "Inspect the following files " + list of files -->
                <xsl:when test="$varTestFileCount &gt; 1">
                  <!-- @@TODO getSelectFileText -->
                  <xsl:call-template name="getSelectFileText">
                    <xsl:with-param name="testFileCount" select="$varTestFileCount" /><!-- count(testCase/files/file) -->
                  </xsl:call-template>
                  <ul>
                    <xsl:for-each select="../../btw:files/btw:file">
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
                <!-- One file: print "Inspect the following  " + testfile -->
                <xsl:otherwise>
                  <!-- @@TODO getSelectFileText -->
                  <p>
                    <xsl:call-template name="getSelectFileText">
                      <xsl:with-param name="testFileCount" select="$varTestFileCount" /><!-- count(testCase/files/file) -->
                    </xsl:call-template>
                    <a href="{../../btw:files/btw:file/@xlink:href}">
                      <xsl:call-template name="printTestFileWithoutNumber" />
                    </a>.
                  </p>
                </xsl:otherwise>
              </xsl:choose>
            </div>
  
            <h2><xsl:call-template name="getQuestionString" /></h2>
            <form>
              <xsl:attribute name="id">userfeedback_<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute>              <xsl:attribute name="action"><xsl:value-of select="$formaction" /></xsl:attribute>
              <xsl:attribute name="method">post</xsl:attribute>
              <xsl:attribute name="enctype">application/x-www-form-urlencoded</xsl:attribute><!-- or multipart/form-data ??? -->
              <xsl:attribute name="accept-charset">us-ascii iso-8859-1 utf8</xsl:attribute>
              <xsl:attribute name="accept">text/plain</xsl:attribute>
  
              <!--   ===   Detect the question type   ===   -->
              <xsl:choose>
                <!--   ===   Yes-no question   ===   -->
                <xsl:when test="$testScenario/btw:questions/btw:yesNoQuestion">
                  <xsl:for-each select="$testScenario/btw:questions/btw:yesNoQuestion/btw:questionText[@xml:lang=$language]/btw:p">
                    <p><xsl:apply-templates /></p>
                  </xsl:for-each>
                  <p>
                    <input type="radio" name="yesOrNo"
                      value="{normalize-space($testScenario/btw:questions/btw:yesNoQuestion/btw:optionYes/@value)}"><xsl:attribute name="id">yesRadio<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute></input><label><xsl:attribute name="for">yesRadio<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute><xsl:call-template name="getYes" /></label>
                      <xsl:text disable-output-escaping="yes">&lt;br /></xsl:text>
                    <input type="radio" name="yesOrNo"
                      value="{normalize-space($testScenario/btw:questions/btw:yesNoQuestion/btw:optionNo/@value)}"><xsl:attribute name="id">noRadio<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute></input><label><xsl:attribute name="for">noRadio<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute><xsl:call-template name="getNo" /></label>
                  </p>
                </xsl:when>
  
                <!--   ===   Likert scale   ===   -->
                <xsl:when test="$testScenario/btw:questions/btw:likertScale">
                  <p>
                    <xsl:copy-of select="$testScenario/btw:questions/btw:likertScale/btw:questionText[@xml:lang=$language]/btw:p/node()" />
                  </p>
                  <p>
                    <xsl:for-each select="$testScenario/btw:questions/btw:likertScale/btw:likertLevel">
                      <input type="radio" name="likertScale" id="{concat('choice_', position())}" value="{normalize-space(btw:value)}" /><label for="{concat('choice_', position())}"><xsl:value-of select="btw:label[@xml:lang=$language]"/></label><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text><!-- instead of <br />-->
                    </xsl:for-each>
                  </p>
                </xsl:when>
  
                <!--   ===   Multiple-choice question   ===   -->
                <xsl:when test="$testScenario/btw:questions/btw:multipleChoice">
                  <xsl:for-each select="$testScenario/btw:questions/btw:multipleChoice/btw:questionText[@xml:lang=$language]/btw:p">
                    <p><xsl:apply-templates /></p>
                  </xsl:for-each>
                  <xsl:choose>
                    <xsl:when test="starts-with($testScenario/btw:questions/btw:multipleChoice/@select, 'one')">
                      <p>
                        <xsl:for-each select="$testScenario/btw:questions/btw:multipleChoice/btw:choice">
                          <input type="radio" name="radioXXX" id="{concat('choice_', position())}" value="{normalize-space(btw:value)}" /><label for="{concat('choice_', position())}"><xsl:value-of select="btw:label[@xml:lang=$language]"/></label><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text><!-- instead of <br />-->
                        </xsl:for-each>
                      </p>
                    </xsl:when>
                    <xsl:otherwise>
                      <p>
                        <xsl:for-each select="$testScenario/btw:questions/btw:multipleChoice/btw:choice">
                          <input type="checkbox" name="checkXXX" id="{concat('choice_', position())}" value="{normalize-space(btw:value)}" /><label for="{concat('choice_', position())}"><xsl:value-of select="btw:label[@xml:lang=$language]"/></label><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text><!-- instead of <br />-->
                        </xsl:for-each>
                      </p>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
  
                <!--   ===   Open-ended question   ===   -->
                <xsl:when test="$testScenario/btw:questions/btw:openQuestion">
                  <xsl:for-each select="$testScenario/btw:questions/btw:openQuestion/btw:questionText[@xml:lang=$language]/btw:p">
                    <p><xsl:apply-templates /></p>
                  </xsl:for-each>
                  <p>
                    <label>
                      <xsl:attribute name="for">usertext<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute>
                      <xsl:call-template name="getTextAreaLabel" />
                    </label><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text><!-- instead of <br />-->
                    <!-- When outputting XML, textarea must not be an 'empty element', because browsers do not support this! -->
                    <textarea
                      cols="{$testScenario/btw:questions/btw:openQuestion/btw:space/btw:columns}" 
                      rows="{$testScenario/btw:questions/btw:openQuestion/btw:space/btw:rows}"
                      onfocus="if(this.value=='&#8230;')this.value='';"
                      onblur="if(this.value=='')this.value='&#8230;';"><xsl:attribute name="id">usertext<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute><xsl:text disable-output-escaping="yes">&amp;#8230;</xsl:text></textarea>
                  </p>
                </xsl:when>
  
                <!--   ===   Yes-no question combined with open-ended question   ===   -->
                <xsl:when test="$testScenario/btw:questions/btw:yesNoOpenQuestion">
                  <xsl:for-each select="$testScenario/btw:questions/btw:yesNoOpenQuestion/btw:optionYes/preceding-sibling::btw:questionText[@xml:lang=$language]/btw:p">
                    <p><xsl:apply-templates /></p>
                  </xsl:for-each>
                  <p>
                    <input type="radio" name="yesOrNo" id="yesRadio" 
                      value="{normalize-space($testScenario/btw:questions/btw:yesNoOpenQuestion/btw:optionYes/@value)}" /><label for="yesRadio"><xsl:call-template name="getYes" /></label>
                      <xsl:text disable-output-escaping="yes">&lt;br /></xsl:text>
                    <input type="radio" name="yesOrNo" id="noRadio"
                      value="{normalize-space($testScenario/btw:questions/btw:yesNoOpenQuestion/btw:optionNo/@value)}" /><label for="noRadio"><xsl:call-template name="getNo" /></label>
                  </p>
                  <xsl:for-each select="$testScenario/btw:questions/btw:yesNoOpenQuestion/btw:optionNo/following-sibling::btw:questionText[@xml:lang=$language]/btw:p">
                    <p><xsl:apply-templates /></p>
                  </xsl:for-each>
                  <p>
                    <label>
                      <xsl:attribute name="for">usertext<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute>
                      <xsl:call-template name="getTextAreaLabel" />
                    </label><xsl:text disable-output-escaping="yes">&lt;br /></xsl:text><!-- instead of <br />-->
                    <!-- When outputting XML, textarea must not be an 'empty element', because browsers do not support this! -->
                    <textarea 
                      cols="{$testScenario/btw:questions/btw:yesNoOpenQuestion/btw:space/btw:columns}" 
                      rows="{$testScenario/btw:questions/btw:yesNoOpenQuestion/btw:space/btw:rows}"
                      onfocus="if(this.value=='&#8230;')this.value='';"
                      onblur="if(this.value=='')this.value='&#8230;';"><xsl:attribute name="id">usertext<xsl:number count="btw:testCase/btw:requiredTests/btw:scenario" value="position()"/></xsl:attribute><xsl:text disable-output-escaping="yes">&amp;#8230;</xsl:text></textarea>
                  </p>
                </xsl:when>
  
                <xsl:otherwise>
                  <xsl:if test="starts-with($DEBUG, 'true')">
                    <p class="debug"><strong>No question!</strong></p>
                  </xsl:if>
                  <p>Contact &#8230; <!-- @TODO add contact information -->.</p>
                </xsl:otherwise>
              </xsl:choose>
              <!--   ===   End 'Detect the question type'   ===   -->

              <!-- submit button disabled in print XSLT stylesheet --><!--
              <p><button class="submit" type="submit"><xsl:call-template name="getSubmitButtonText"></xsl:call-template></button>
                <xsl:element name="input">
                  <xsl:attribute name="class">submit</xsl:attribute>
                  <xsl:attribute name="type">button</xsl:attribute>
                  <xsl:attribute name="value"><xsl:call-template name="getCommentButtonText" /></xsl:attribute>
                  <xsl:attribute name="name">comment</xsl:attribute>
                </xsl:element>
                <xsl:element name="input">
                  <xsl:attribute name="class">submit</xsl:attribute>
                  <xsl:attribute name="type">button</xsl:attribute>
                  <xsl:attribute name="value"><xsl:call-template name="getExitButtonText" /></xsl:attribute>
                  <xsl:attribute name="name">exit</xsl:attribute>
                  <xsl:attribute name="id">exitbutton</xsl:attribute>
                </xsl:element>
              </p>-->
            </form>
            <div class="experience">
              <h2>Required Experience</h2>
              <p>The table below shows what setup is required for user evaluation. If more than one product of a certain type is listed (for example, several browsers or versions of the same browser), any of these can be used, i.e. they have an OR relationship.
                However, the different types have an AND relationship: for example, if the table contains two screen readers and one browser, that means that one of these screen readers must be used in combination with the browser.
              </p>
              <table>
                <thead>
                  <tr>
                    <th scope="col">Type</th>
                    <th scope="col" abbr="Level">Minimum level</th>
                    <th scope="col">Product</th>
                    <th scope="col">Version</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="btw:experience/btw:AssistiveTechnology | btw:experience/btw:UserAgent | btw:experience/btw:Device">
                    <tr>
                      <th scope="row"><xsl:value-of select="@type"/></th>
                      <td ><xsl:value-of select="@minimumLevel"/></td>
                      <td >
                        <xsl:choose>
                          <xsl:when test="@product"><xsl:value-of select="@product"/></xsl:when>
                          <xsl:otherwise>(any <xsl:value-of select="@type"/>)</xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td >
                        <xsl:choose>
                          <xsl:when test="@version"><xsl:value-of select="@version"/></xsl:when>
                          <xsl:otherwise>(any version)</xsl:otherwise>
                        </xsl:choose>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>
            <div class="disabilities">
              <h2>Disabilities</h2>
                <xsl:choose>
                  <xsl:when test="btw:disabilities/btw:disability">
                    <ul>
                      <xsl:for-each select="btw:disabilities/btw:disability">
                        <li><xsl:value-of select="."/></li>
                      </xsl:for-each>
                    </ul>
                  </xsl:when>
                  <xsl:otherwise>
                    <p>No disabilities are listed.</p>
                  </xsl:otherwise>
                </xsl:choose>
            </div>
          </div>
        </xsl:for-each>



      </body>
    </html>
  </xsl:template>


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