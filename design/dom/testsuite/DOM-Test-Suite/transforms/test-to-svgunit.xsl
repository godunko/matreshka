<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
-->
<!--   
This transform generates .js files for SVG files


Usage:

saxon -o someTest.js someTest.xml test-to-svgunit.xsl


-->



<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="test-to-ecmascript.xsl"/>
    <xsl:param name="testpath">../level1/core/</xsl:param>

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
    <xsl:apply-templates mode="jsunit"/>
</xsl:template>

<xsl:template match="*[local-name() = 'test']" mode="jsunit">
    <xsl:variable name="loads" select="*[local-name() = 'load' and not(@interface)]"/>

        <xsl:call-template name="copyright-comment"/>

// expose test function names
function exposeTestFunctionNames()
{
return ['<xsl:value-of select="@name"/>'];
}

var docsLoaded = -1000000;
var builder = null;

//
//   This function is called by the testing framework before
//      running the test suite.
//
//   If there are no configuration exceptions, asynchronous
//        document loading is started.  Otherwise, the status
//        is set to complete and the exception is immediately
//        raised when entering the body of the test.
//
function setUpPage() {
   setUpPageStatus = 'running';
   try {
     //
     //   creates test document builder, may throw exception
     //
     builder = createConfiguredBuilder();
<xsl:for-each select="*[local-name() = 'hasFeature' and not(preceding-sibling::*[local-name()='var'])]">
    <xsl:text>       checkFeature(</xsl:text>
    <xsl:value-of select="@feature"/>
    <xsl:text>, </xsl:text>
    <xsl:choose>
        <xsl:when test="@version">
            <xsl:value-of select="@version"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>null</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>);
</xsl:text>
</xsl:for-each>
<xsl:for-each select="*[local-name() = 'implementationAttribute']">
    <xsl:text>       setImplementationAttribute("</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>", </xsl:text><xsl:value-of select="@value"/><xsl:text>);
</xsl:text>
</xsl:for-each>
      <xsl:text>
      docsLoaded = 0;
      </xsl:text>
      <xsl:for-each select="$loads">
        <xsl:text>
      var </xsl:text><xsl:value-of select="@var"/><xsl:text>Ref = null;
      if (typeof(this.</xsl:text><xsl:value-of select="@var"/><xsl:text>) != 'undefined') {
        </xsl:text>
        <xsl:value-of select="@var"/><xsl:text>Ref = this.</xsl:text><xsl:value-of select="@var"/><xsl:text>;
      }
      </xsl:text>
      <xsl:text>docsLoaded += preload(</xsl:text><xsl:value-of select="@var"/><xsl:text>Ref, "</xsl:text>
          <xsl:value-of select="@var"/><xsl:text>", "</xsl:text><xsl:value-of select="@href"/><xsl:text>");
        </xsl:text>
       </xsl:for-each>
       if (docsLoaded == <xsl:value-of select="count($loads)"/>) {
          setUpPage = 'complete';
       }
    } catch(ex) {
    	catchInitializationError(builder, ex);
        setUpPage = 'complete';
    }
}



//
//   This method is called on the completion of 
//      each asychronous load started in setUpTests.
//
//   When every synchronous loaded document has completed,
//      the page status is changed which allows the
//      body of the test to be executed.
function loadComplete() {
    if (++docsLoaded == <xsl:value-of select="count($loads)"/>) {
        setUpPageStatus = 'complete';
    }
}

<xsl:apply-templates select="."/>


function runTest() {
   <xsl:value-of select="@name"/>();
}
</xsl:template>




<xsl:template name="copyright-comment">
/*
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
*/
</xsl:template>



</xsl:stylesheet>
