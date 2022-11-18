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
The transform generates a list of links to members of the test suite

-->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
     <xsl:param name="title">DOM Level 1 Core Test Suite - XHTML</xsl:param>
     
	
	<xsl:output method="xml"
   		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
   		doctype-system="xhtml1-transitional.dtd"
		encoding="UTF-8"
		indent="yes"/>



<xsl:template match="/">
    <html>
        <head>
			<xsl:call-template name="copyright-comment"/>
			<title><xsl:value-of select="$title"/></title>        
        </head>
        <body>
        	<h2><xsl:value-of select="$title"/></h2>
        	<form action="about:blank">
        		<p>
        	    <input type="button" value="Start Logging" onclick="parent.startLogging()"/>
        	    <input type="button" value="End Logging" onclick="parent.endLogging()"/>
        	    </p>
        	</form>
            <ol>
            	<xsl:for-each select="*/*[local-name() = 'suite.member']">
                    <xsl:sort select="@href"/>
                    <xsl:variable name="test" select="document(@href, .)"/>
                    <xsl:variable name="testName" select="$test/*/@name"/>
                    <xsl:variable name="loads" select="$test/*/*[local-name() = 'load']"/>
                    <xsl:choose>
                    	<xsl:when test="$loads[@href = 'staff' or @href = 'nodtdstaff' or @href = 'datatype_normalization']">
                    	</xsl:when>
                    	<xsl:otherwise>
                    		<li><a href="{$testName}.xhtml" target='test_frame'><xsl:value-of select="$testName"/></a></li>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</ol>
		</body>
	</html>
</xsl:template>

<xsl:template name="copyright-comment">
<xsl:comment>
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
</xsl:comment>
</xsl:template>



</xsl:stylesheet>
