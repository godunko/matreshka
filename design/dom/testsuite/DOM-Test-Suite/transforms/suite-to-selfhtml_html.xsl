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
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
     <xsl:param name="title">DOM Level 1 Core Test Suite - HTML</xsl:param>
     
	
	<xsl:output method="html" 
		doctype-public="-//W3C//DTD HTML 4.01//EN" 
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		encoding="US-ASCII"/>



<xsl:template match="/">
	<xsl:call-template name="copyright-comment"/>
    <html>
        <head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<title><xsl:value-of select="$title"/></title>        
        </head>
        <body>
        	<h2><xsl:value-of select="$title"/></h2>
        	<form action="about:blank">
        	    <input type="button" value="Start Logging" onclick="parent.startLogging()"/>
        	    <input type="button" value="End Logging" onclick="parent.endLogging()"/>
        	</form>
            <ol>
            	<xsl:for-each select="*/*[local-name() = 'suite.member']">
                    <xsl:sort select="@href"/>
                    <xsl:variable name="test" select="document(@href, .)"/>
                    <xsl:variable name="testName" select="$test/*/@name"/>
                    <xsl:variable name="loads" select="$test/*/*[local-name() = 'load']"/>
                    <xsl:choose>
    					<xsl:when test="count($loads) &gt; 1 and $loads[@href != $loads[1]/@href]">
    						<xsl:comment><xsl:value-of select="$testName"/> loads multiple test documents</xsl:comment>
    					</xsl:when>
                    	<xsl:when test="$loads[substring(@href, 1, 5) = 'staff' or @href = 'nodtdstaff' or @href = 'datatype_normalization']">
    						<xsl:comment><xsl:value-of select="$testName"/> loads an XML-only test document</xsl:comment>
                    	</xsl:when>
                    	<xsl:otherwise>
                    		<li><a href="{$testName}.html" target='test_frame'><xsl:value-of select="$testName"/></a></li><xsl:text>
</xsl:text>
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
