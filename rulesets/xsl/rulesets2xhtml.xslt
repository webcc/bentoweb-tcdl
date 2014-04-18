<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:html="http://www.w3.org/1999/xhtml"
  xmlns:r="http://bentoweb.org/refs/rulesets"
  exclude-result-prefixes="html xlink"
>
  <xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="no" omit-xml-declaration="no"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
  />
  <!--xsl:output method="xml" media-type="text/html" encoding="UTF-8" indent="no" omit-xml-declaration="no"
    doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
    doctype-system="http://localhost/www/www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" 
  /-->

  <!-- Switching debugging information on or off: 'true' or 'false' (or something else). -->
  <xsl:param name="DEBUG" select="'true'" />

  <xsl:template match="r:rulesets">
    <html xml:lang="en" lang="en">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>BenToWeb Rulesets: HTML View</title>
        <style type="text/css">
          body { margin-left: 8pt; color: #000; background: #fff; font-family: 'Trebuchet MS', Verdana, Geneva, Helvetica, sans-serif;}
          h1 { text-align: left; margin-left: 0pt;}
          div.ruleset {margin-left: 0pt; margin-bottom: 2em; border: 1px dotted #00f; /*width:49%; float:left;*/ }
          div.guideline { margin-left: 2pt; border: 1px dotted #000; }
          div { padding: 2pt; margin-bottom: 2pt; }
          li { list-style-type: none; margin: 0 0 0 2pt; }
          span.number { font-weight: normal; color: #000; background: #fff; }
          /*span.ruleid a { color: #060; padding-left: .5em; padding-right: .5em; }*/
          span.scname { color: #f00; background: transparent; font-weight: bold; }
        </style>
      </head>
      <body>
        <h1>BenToWeb Rulesets: <acronym>HTML</acronym> View</h1>
        <p>This page is an <acronym>HTML</acronym> view of the <a href="http://bentoweb.org/refs/rulesets.xml">Rulesets <acronym>XML</acronym> file</a> (see also <a href="http://bentoweb.org/refs/rulesets"><acronym title="Resource Directory Description Language">RDDL</acronym> for Rulesets <acronym>XML</acronym></a>).
          It lists unique identifiers for the success criteria of specific versions of 
          <a href="http://www.w3.org/TR/WCAG20/">Web Content Accessibility Guidelines 2.0</a>.
          <!-- For each <acronym>WCAG</acronym> draft, the success criteria are listed by guideline, then by number. -->
          These identifiers are used in <a href="http://www.bentoweb.org/refs/TCDL2.0.html">Test Case Description Language (<acronym>TCDL</acronym>) 2.0</a>
          to declare the specific version of the Guidelines for which a test case or test sample was developed.
          <!-- Some <acronym>WCAG</acronym> drafts use the levels A, AA and AAA; in rulesets.xml, these levels correspond to levels 1, 2 and 3 respectively.
          For each success criterion, the list provides two links: a direct link to the text of the success criterion (long blue link),
          and a &#8220;link&#8221; to the rule in rulesets.xml (short green link).  -->
          For more information about rulesets, see the
          <a href="http://bentoweb.org/refs/TCDL2.0.html#edef-rule"><acronym>TCDL</acronym><xsl:text> </xsl:text><code>rule</code> element</a>.
        </p>
        <xsl:for-each select="r:ruleset[@id='WCAG2_20081211'] | r:ruleset[@id='WCAG2_20081103'] | r:ruleset[@id='WCAG2_20080430'] | r:ruleset[@id='WCAG2_20071211'] | r:ruleset[@id='WCAG2_20070517'] | r:ruleset[@id='WCAG2_20060427'] | r:ruleset[@id='WCAG2_20051123'] | r:ruleset[@id='WCAG2_20050630']">
        <!--xsl:for-each select="r:ruleset"-->
          <div class="ruleset" id="{@id}">
            <h2>
              <!--a>
                <xsl:attribute name="href"><xsl:value-of select="@xlink:href" /></xsl:attribute>
                <xsl:value-of select="@id" />
              </a-->
              <xsl:call-template name="getReadableRuleName"><xsl:with-param name="accRule" select="@id" /></xsl:call-template>
              (<xsl:value-of select="count(r:guideline/r:successCriterion)"/> success criteria)
            </h2>
            
            <xsl:for-each select="r:guideline">
              <div class="guideline" id="{@id}">
                <h3>Guideline: 
                  <a>
                    <xsl:attribute name="href"><xsl:value-of select="@xlink:href" /></xsl:attribute>
                    <xsl:value-of select="substring-after(substring-after(@id, '_'), '_')" />
                  </a>
                </h3>

                <xsl:if test="r:successCriterion">
                  <ul>
                    <xsl:for-each select="r:successCriterion">
                      <li id="{@id}">
                        <span class="number"><xsl:value-of select="@name" /></span>. Success criterion: 
                        <a>
                          <xsl:attribute name="href"><xsl:value-of select="@xlink:href" /></xsl:attribute>
                          <span class="scname"><xsl:value-of select="../@name" />.<xsl:value-of select="@name" /></span>
                          <xsl:if test="@level">
                            <span class="level">
                              (Level <xsl:call-template name="successCriterionLevel"><xsl:with-param name="rulesetID" select="../../@id"/><xsl:with-param name="theLevel" select="@level"/></xsl:call-template>)
                            </span> 
                          </xsl:if>
                        </a>. 
                        <!-- ruleid added 2007-06-14; works only for numbering system adopted in WCAG 2.0 27 April 2006 --><!-- @@ add if test -->
                        Ruleset <abbr>ID</abbr>: <span class="ruleid"><a href="http://bentoweb.org/refs/rulesets.xml#{@id}"><xsl:value-of select="@id" /></a></span>
                      </li>
                    </xsl:for-each>
                  </ul>
                </xsl:if>
              </div>
            </xsl:for-each>
          </div>
        </xsl:for-each>
        <p>This page: <a href="http://bentoweb.org/refs/rulesets.html">http://bentoweb.org/refs/rulesets.html</a>.</p>
      </body>
    </html>
  </xsl:template>


  <!--copied with modifications from tcdl1.1_to_xhtml_print_noscenarios.xslt 2008-03-18-->
  <xsl:template name="getReadableRuleName">
    <xsl:param name="accRule" />
      <xsl:choose>
        <xsl:when test="contains($accRule,'WCAG2_20081211')">
          <xsl:variable name="URL">http://www.w3.org/TR/2008/REC-WCAG20-20081211/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">December 2008 Recommendation</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20081103')">
          <xsl:variable name="URL">http://www.w3.org/TR/2008/PR-WCAG20-20081103/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">November 2008 Proposed Recommendation</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20080430')">
          <xsl:variable name="URL">http://www.w3.org/TR/2008/CR-WCAG20-20080430/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">April 2008 Candidate Recommendation</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20071211')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20071211/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">December 2007 Working Draft (Last Call)</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20070517')">
          <xsl:variable name="URL">http://www.w3.org/TR/2007/WD-WCAG20-20070517/Overview.html</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">May 2007 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20060427')">
          <xsl:variable name="URL">http://www.w3.org/TR/2006/WD-WCAG20-20060427/Overview.html</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">April 2006 Working Draft (Last Call)</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20050630')">
          <xsl:variable name="URL">http://www.w3.org/TR/2005/WD-WCAG20-20050630/Overview.html</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">June 2005 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20051123')">
          <xsl:variable name="URL">http://www.w3.org/TR/2005/WD-WCAG20-20051123/Overview.html</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">November 2005 Working Draft</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WCAG2_20050211')">
          <xsl:variable name="URL">http://www.w3.org/WAI/GL/WCAG20/WD-WCAG20-20050211/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 2.0: <a href="{$URL}">February 2005 Editor's Draft</a>
        </xsl:when>
        <xsl:when test="contains($accRule,'WAI-WEBCONTENT-19990505')">
          <xsl:variable name="URL">http://www.w3.org/TR/1999/WAI-WEBCONTENT-19990505/</xsl:variable>
          <acronym title="Web Content Accessibility Guidelines">WCAG</acronym> 1.0: <a href="{$URL}">Recommendation May 1999</a>
        </xsl:when>
        <xsl:otherwise><xsl:if test="$DEBUG = 'true'">[not found @@<xsl:value-of select="$accRule"/>]</xsl:if></xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <!-- For WCAG 2.0 versions: choose between Level 1, 2, 3 or Level A, AA, AAA. -->
  <xsl:template name="successCriterionLevel">
    <xsl:param name="rulesetID" />
    <xsl:param name="theLevel" />
    <xsl:choose>
      <xsl:when test="not(contains($rulesetID, 'WCAG2_2007') or contains($rulesetID, 'WCAG2_2008'))"> <xsl:value-of select="$theLevel"/></xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="contains($theLevel, '1')"> A</xsl:when>
          <xsl:when test="contains($theLevel, '2')"> AA</xsl:when>
          <xsl:when test="contains($theLevel, '3')"> AAA</xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>