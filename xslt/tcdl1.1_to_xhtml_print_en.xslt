<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:btw="http://bentoweb.org/refs/TCDL1.1"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  exclude-result-prefixes="xlink dc btw xml"
>
<xsl:include href="tcdl1.1_to_xhtml_print_all.xslt"/>
<xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="yes" omit-xml-declaration="no"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
/>

  <!-- the user's language, passed in from the user profile database -->
  <xsl:param name="language" select="'en'" />
  <!-- The number of test in one batch (users get tests in batches of e.g. 20 @TODO determine final number -->
  <xsl:variable name="batchTotal" select="'20'" />
  <!-- The position of the test in the batch of tests that the user is doing -->
  <xsl:variable name="batchPosition" select="'0'" />

  

  <xsl:template name="getInstructionsTitle">Instructions:</xsl:template>

  <xsl:template name="getTestCaseString">Test Case:</xsl:template>

  <xsl:template name="getQuestionString">Question:</xsl:template>

  <xsl:template name="getYes">Yes</xsl:template>
  <xsl:template name="getNo">No</xsl:template>

  <xsl:template name="getSelectFileText">
    <xsl:param name="testFileCount" />
        <xsl:if test="$testFileCount &gt; 1">
          <p>Inspect the following files:</p>
        </xsl:if>
        <xsl:if test="$testFileCount = 1">
          Inspect the following
        </xsl:if>
        <xsl:if test="$testFileCount = 0">
          <strong class="debug">Test file is missing!</strong>
        </xsl:if>
  </xsl:template>


  <xsl:template name="printTestFileWithNumber">
    <xsl:param name="testFilePosition" />
        <xsl:if test="$testFilePosition &gt;  0">Test file <xsl:value-of select="$testFilePosition" /></xsl:if>
        <xsl:if test="$testFilePosition = 0"><strong class="debug">Test file is missing!</strong></xsl:if>
  </xsl:template>


  <xsl:template name="printTestFileWithoutNumber">
    test file
  </xsl:template>


  <!-- Text for label element for textarea in userfeedback form (localised) -->
  <xsl:template name="getTextAreaLabel">
      Please provide your comment:
  </xsl:template>


  <!-- Text for submit button (localised) -->
  <xsl:template name="getSubmitButtonText">Submit and go to next</xsl:template>

  <!-- Text for comment button (localised) -->
  <xsl:template name="getCommentButtonText">Comment</xsl:template>
  
  <!-- Text for exit button (localised) -->
  <xsl:template name="getExitButtonText">Exit</xsl:template>

  </xsl:stylesheet>