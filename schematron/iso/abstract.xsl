<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:iso="http://purl.oclc.org/dsdl/schematron" 
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:err="uri-for-xslt-implementation"
                exclude-result-prefixes="err xs"
                version="2.0">

  <d:doc xmlns:d="rnib.org.uk/tbs#">
    <revhistory>
      <purpose>
        <para>This stylesheet converts abstract patterns into concrete
          ones.</para>
      </purpose>
      <revision>
        <revnumber>1.0</revnumber>
        <date>2007-02-03T10:19:28Z</date>
        <authorinitials>DaveP</authorinitials>
        <revdescription>
          <para></para>
        </revdescription>
        <revremark></revremark>
      </revision>
      <revision>
        <revnumber>1.1</revnumber>
        <date>2007-02-03T11:39:19Z</date>
        <authorinitials>DaveP</authorinitials>
        <revdescription>
          <para>Added testing for required attributes.</para>
        </revdescription>
        <revremark></revremark>
      </revision>
      <revision>
        <revnumber>1.2</revnumber>
        <date>2007-02-04T16:15:00Z</date>
        <authorinitials>Florent Georges</authorinitials>
        <revdescription>
          <para>Use analyze-string to replace parameter values, in new
            function iso:replace-params().</para>
          <para>Removed indented output and process text nodes to keep
            the same indentation as in the input.  In general, used
            apply-templates when appropriate (for example instead of
            for-each) to preserve the same structure as in the
            input.</para>
          <para>Doesn't copy @abstract anymore (the @abstract = 'true'
            was copied to the generated pattern :-/).</para>
        </revdescription>
        <revremark>
          <para>iso:replace-params() doesn't handle prefixed parameter
            names.</para>
        </revremark>
      </revision>

      <revision>
        <revnumber>1.3</revnumber>
        <date>2007-02-05T19:44:32Z</date>
        <authorinitials>DaveP</authorinitials>
        <revdescription>
          <para>Added include procssing.</para>
        </revdescription>
        <revremark></revremark>
      </revision>

      <revision>
        <revnumber>1.4</revnumber>
        <date>2007-02-07T08:19:16.0Z</date>
        <authorinitials>DaveP</authorinitials>
        <revdescription>
          <para>Removed include procssing. Inappropriate due to mix of
          documents for key usage</para>
        </revdescription>
        <revremark></revremark>
      </revision>



    </revhistory>
  </d:doc>




  <!-- Key to select the abstract patterns. -->
  <xsl:key name="abstract-pattern" match="iso:pattern[@abstract='true']" use="@id"/>

  <!-- Remove abstract patterns -->
  <xsl:template match="iso:pattern[@abstract='true']"/>

  <xsl:template match="iso:pattern[@is-a]">
    <xsl:variable name="abstract" select="key('abstract-pattern', @is-a)"/>
    <xsl:if test="empty($abstract)">
      <xsl:message terminate='yes'>
        Unable to continue. No abstract pattern found with matching id 
        '<xsl:value-of select='@is-a'/>'
        Pattern is <xsl:value-of select="concat(name(), ', id  ', @id)"/>
      </xsl:message>
    </xsl:if>
    <!-- Now process the abstract pattern, moded, to obtain the  content -->
    <xsl:variable name='parms' select="iso:param" as="element()*"/> 
    <xsl:apply-templates select="$abstract" mode='abstract'>
      <xsl:with-param name='parms' select='$parms'/>
      <xsl:with-param name='id'    select='@id'/>
    </xsl:apply-templates>
  </xsl:template>

  <!-- Moded template to process the abstract patterns -->
  <xsl:template match="iso:pattern[@abstract='true']" mode='abstract'>
    <xsl:param name='parms'/>
    <xsl:param name='id'/>
    <iso:pattern>
      <xsl:if test='string($id)'>
        <xsl:attribute name='id'>
          <xsl:value-of select='$id'/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name='rich'/>
      <xsl:apply-templates>
        <xsl:with-param name="params" select="$parms"/>
      </xsl:apply-templates>
    </iso:pattern>
  </xsl:template>

<!-- rule template, with added parameters from the instantiating pattern -->
  <xsl:template match='iso:rule'>
    <xsl:param name="params" as="element(iso:param)*"/>
    <iso:rule context="{ iso:replace-params(@context, $params) }">
      <xsl:copy-of select="@*[not(name()='context')]"/>
      <xsl:apply-templates>
        <xsl:with-param name="params" select="$params"/>
      </xsl:apply-templates>
    </iso:rule>
  </xsl:template>

<!-- assert template, with added parameters from the instantiating pattern -->
  <xsl:template match='iso:assert'>
    <xsl:param name="params" as="element(iso:param)*"/>
    <iso:assert test="{ iso:replace-params(@test, $params) }">
      <xsl:copy-of select="@*[not(name()='test')]"/>
      <xsl:apply-templates/>
    </iso:assert>
  </xsl:template>

<!-- report template, with added parameters from the instantiating pattern -->
  <xsl:template match='iso:report'>
    <xsl:param name="params" as="element(iso:param)*"/>
    <iso:report test="{ iso:replace-params(@test, $params) }">
      <xsl:copy-of select="@*[not(name()='test')]"/>
      <xsl:apply-templates/>
    </iso:report>
  </xsl:template>









  <!-- Copy over id and the rich attributes -->
  <xsl:template name='rich'>
    <xsl:copy-of select="@*[normalize-space(.)][not(name()=('id', 'abstract'))]"/>
  </xsl:template>

  <!-- Identity template  -->
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <!--
      Replaces variable references in $str with the mappings in $params.

      TODO: Doesn't handle prefixed variable references.  I don't know
      how to deal with them in this case.
  -->
  <xsl:function name="iso:replace-params" as="xs:string">
    <xsl:param name="str"    as="xs:string"/>
    <xsl:param name="params" as="element(iso:param)*"/>
    <xsl:variable name="result" as="xs:string*">
      <xsl:analyze-string select="$str" regex="\$\i\c*">
        <xsl:matching-substring>
          <xsl:if test="contains(., ':')">
            <xsl:sequence select="
                error(xs:QName('err:ERR0001'),
                      'Prefixed names for parameters not supported!')"/>
          </xsl:if>
          <xsl:variable name="p" select="
              $params[@name eq substring(current(), 2)]"/>
          <xsl:if test="empty($p)">
            <xsl:sequence select="
                error(xs:QName('err:ERR0002'),
                      concat('No parameter matches [', ., ']!'))"/>
          </xsl:if>
          <xsl:sequence select="$p/@value"/>
        </xsl:matching-substring>
        <xsl:non-matching-substring>
          <xsl:copy-of select="."/>
        </xsl:non-matching-substring>
      </xsl:analyze-string>
    </xsl:variable>
    <xsl:sequence select="string-join($result, '')"/>
  </xsl:function>

</xsl:stylesheet>
