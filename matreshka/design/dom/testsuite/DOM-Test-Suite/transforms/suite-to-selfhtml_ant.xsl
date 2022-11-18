<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Copyright © 2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
-->

<!--   
This transform generates an Ant file that prepares SVG tests.


Usage:

saxon -o alltests.ant alltests.xml suite-to-svgunit.xsl


-->



<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="extension">.html</xsl:param>
	<xsl:param name="module">core</xsl:param>
	<xsl:param name="level">1</xsl:param>

<xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
    <xsl:apply-templates mode="jsunit"/>
</xsl:template>


<xsl:template match="*[local-name() = 'suite']" mode="jsunit">
    <xsl:call-template name="copyright-comment"/>
    <project default="make-html">
    <target name="make-html">
    	<xsl:for-each select="*[local-name() = 'suite.member']">
    		<xsl:variable name="member" select="."/>
    		<xsl:variable name="test" select="document(@href, .)"/>
    		<xsl:variable name="testname" select="$test/*/@name"/>
    		<xsl:variable name="loads" select="$test/*/*[local-name() = 'load']"/>
		    <xsl:variable name="testdst" select="concat('${html.dir}/', concat($testname, $extension))"/>
		    <xsl:variable name="testjs" select="concat('${html.dir}/', concat($testname, '.js'))"/>
    		<xsl:choose>
    			<xsl:when test="count($loads) &gt; 1 and $loads[@href != $loads[1]/@href]">
    				<xsl:comment><xsl:value-of select="$testname"/> loads multiple test files</xsl:comment>
    				<delete file="{$testjs}"/>    				
    			</xsl:when>
    			<xsl:when test="$loads[substring(@href, 1, 5) = 'staff' or @href = 'nodtdstaff' or @href='datatype_normalization']">
    				<xsl:comment><xsl:value-of select="$testname"/> loads XML-only data type</xsl:comment>
    				<delete file="{$testjs}"/>    				
    			</xsl:when>
    			<xsl:when test="$loads">
		    		<xsl:for-each select="$loads[1]">
		    			<xsl:choose>
		    				<!-- if we are L2 HTML then need to look for files in either location  -->
	    					<xsl:when test="$level = 2 and $module = 'html' and @href != 'frame2' and @href != 'iframe2' and @href != 'optionscollection'">
	    						<xsl:variable name="testsrc" select="concat('${l1files.dir}/', concat(@href, $extension))"/>
	    						<copy tofile="{$testdst}" file="{$testsrc}" overwrite="yes"/>
	    					</xsl:when>
	    					<xsl:otherwise>
	    						<xsl:variable name="testsrc" select="concat('${files.dir}/', concat(@href, $extension))"/>
	    						<copy tofile="{$testdst}" file="{$testsrc}" overwrite="yes"/>
	    					</xsl:otherwise>
	    				</xsl:choose>
	    				<replace file="{$testdst}" token="parent.loadComplete()" value="loadComplete()"/>
	    				<xsl:choose>
	    					<xsl:when test="$loads[1]/@href = 'hc_staff'">
	    						<replace file="{$testdst}" token="svgunit.js">
	    							<xsl:attribute name="value">
	    								<xsl:text>self</xsl:text>
	    								<xsl:value-of select="substring($extension, 2)"/>
	    								<xsl:text>.js</xsl:text>
	    							</xsl:attribute>
	    						</replace>
	    						<replace file="{$testdst}" token="svgtest.js" value="{$testname}.js"/>
	    					</xsl:when>
	    					<xsl:otherwise>
	    						<replace file="{$testdst}" token="&lt;/head&gt;">
	    							<xsl:attribute name="value">
	    								<xsl:text>&lt;script type='text/javascript' src='self</xsl:text>
	    								<xsl:value-of select="substring($extension, 2)"/>
	    								<xsl:text>.js'&gt;&lt;/script&gt;&lt;script charset='UTF-8' type='text/javascript' src='</xsl:text>
	    								<xsl:value-of select="$testname"/>
	    								<xsl:text>.js'&gt;&lt;/script&gt;&lt;script type='text/javascript'&gt;function loadComplete() { startTest(); }&lt;/script&gt;&lt;/head&gt;</xsl:text>
	    							</xsl:attribute>
	    						</replace>
	    						<replace file="{$testdst}" token="&lt;/HEAD&gt;">
	    							<xsl:attribute name="value">
	    								<xsl:text>&lt;script type='text/javascript' src='self</xsl:text>
	    								<xsl:value-of select="substring($extension, 2)"/>
	    								<xsl:text>.js'&gt;&lt;/script&gt;&lt;script charset='UTF-8' type='text/javascript' src='</xsl:text>
	    								<xsl:value-of select="$testname"/>
	    								<xsl:text>.js'&gt;&lt;/script&gt;&lt;script type='text/javascript'&gt;function loadComplete() { startTest(); }&lt;/script&gt;&lt;/HEAD&gt;</xsl:text>
	    							</xsl:attribute>
	    						</replace>
	    					</xsl:otherwise>
	    				</xsl:choose>
		    		</xsl:for-each>
		    	</xsl:when>
		    	<xsl:otherwise>
		    			<copy tofile="{$testdst}" overwrite="yes">
		    				<xsl:attribute name="file">${ecmascript.dir}/implementation<xsl:value-of select="$extension"/></xsl:attribute>
		    			</copy>
		    			<replace file="{$testdst}" token="src='test.js'" value="src='{$testname}.js'"/>
		    	</xsl:otherwise>
		    </xsl:choose>
    	</xsl:for-each>
    </target>
    </project>
</xsl:template>


<xsl:template name="copyright-comment">
<xsl:comment>
Copyright (c) 2001-2004 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Software
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
</xsl:comment>
</xsl:template>


</xsl:stylesheet>
