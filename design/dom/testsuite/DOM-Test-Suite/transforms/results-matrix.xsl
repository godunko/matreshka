<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Copyright © 2004-2005 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
-->

<!--   
This transform generates a test matrix from the output of subjects.xsl
and combine-metadata.xsl


-->

<xsl:stylesheet version="1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
     exclude-result-prefixes="rdf dc">
     <xsl:param name="specURI">http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/level-one-core#</xsl:param>
     <xsl:param name="testPath">tests</xsl:param>
     <xsl:param name="doxyPath">doxygen/html/</xsl:param>
     <xsl:param name="doxySuffix">_8java-source.html</xsl:param>
     <xsl:param name="title">DOM Level 1 Core Test Suite Matrix</xsl:param>
     <xsl:param name="resultsURL">../transforms/dom1-core-results.xml</xsl:param>
     <xsl:param name="testBaseURI">http://www.w3.org/2001/DOM-Test-Suite/level1/core/</xsl:param>
	<xsl:output method="html" 
		doctype-public="-//W3C//DTD HTML 4.01//EN" 
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		encoding="US-ASCII"/>

    <xsl:variable name="descriptions" select="/rdf:RDF/rdf:Description"/>
    <xsl:variable name="results" select="document($resultsURL,.)//testsuite"/>
    <xsl:variable name="tests" select="$descriptions[not(contains(@rdf:about, 'alltests')) and substring(@rdf:about, string-length(@rdf:about)) != '/']"/>

	<!--  match document root    -->
	<xsl:template match="/">
        <html>
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<title><xsl:value-of select="$title"/></title>
			<link href="http://www.w3.org/StyleSheets/activity-home.css" rel="stylesheet" type="text/css" />
		</head>
        	<body>
		<h1><xsl:value-of select="$title"/></h1>
        <h2>Summary</h2>
        <xsl:variable name="testCount" select="count($tests)"/>
		<table border="1" width="100%" cols="5" summary="Summary">
			<thead><tr><th>Implementation</th><th>Run</th><th>Not run</th><th>Failures</th><th>Errors</th></tr></thead>
			<tbody>
                 <xsl:for-each select="$results">
                 	<tr>
                 		<td><xsl:value-of select="ancestor::implementation/@name"/></td>
                 		<td><xsl:value-of select="count(testcase)"/></td>
                 		<td><xsl:value-of select="$testCount - count(testcase)"/></td>
                 		<td><xsl:value-of select="count(testcase/failure)"/></td>
                 		<td><xsl:value-of select="count(testcase/error)"/></td>
                 	</tr>
                 </xsl:for-each>
			</tbody>
		</table>
        <h2>Tests with failures or errors</h2>
        <table border="1" cols="2" width="100%" summary="Tests with failures or errors">
        	<thead>
            <tr>
            	<th>Test</th>
            	<th>Details</th>
            </tr>
            </thead>
            <tbody>
            <xsl:for-each select="$descriptions">
                <xsl:sort select="ancestor::*[local-name() = 'test']/@name"/>
                <xsl:variable name="test" select="."/>
                <xsl:variable name="testName" select="$test/@rdf:about"/>
                <xsl:variable name="shortName" select="substring($test/@rdf:about, string-length($testBaseURI) + 1)"/>
                
                <xsl:choose>
                	<xsl:when test="contains(@rdf:about, 'alltests')"/>
                	<xsl:when test="substring(@rdf:about, string-length(@rdf:about)) = '/'"/> 
                
                <!--  if there aren't the same number of successes and implementations   -->
                <xsl:when test="$results/testcase[(@name = $testName or substring(@name, string-length(@name) - string-length($shortName)) = concat(':', $shortName))  and (failure or error)]">

                <tr>
                    <td width="25%">
                    <xsl:variable name="testName"><xsl:value-of select="ancestor::*[local-name() = 'test']/@name" /></xsl:variable>                             
                    <xsl:call-template name="emit-title"/>
                    <xsl:text> (</xsl:text> 
        		    <a href="{concat($testPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'.xml'))}" title="XML Test Definition">XML</a>
                    <xsl:text> </xsl:text>
        		    <a href="{concat($doxyPath,concat(translate($testName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),$doxySuffix))}" title="Java Source">Java</a>
                    <xsl:text>)</xsl:text>
                    </td>
                    <td>
                    	<xsl:for-each select="$results">
                    		<xsl:variable name="test-result" select="testcase[@name = $testName or substring(@name, string-length(@name) - string-length($shortName)) = concat(':', $shortName)]"/>
                    		<xsl:variable name="implName" select="ancestor::implementation/@name"/>
                    		<xsl:choose>
                    			<xsl:when test="contains(normalize-space($test-result/failure/@message), ' ')">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Failure:</xsl:text>
                    				<xsl:value-of select="substring-before(normalize-space($test-result/failure/@message), ' ')"/>
                    				<br/>
                    			</xsl:when>
                    			<xsl:when test="$test-result/failure/@message">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Failure:</xsl:text>
									<xsl:value-of select="$test-result/failure/@message"/>
                    				<br/>
								</xsl:when>
								<xsl:when test="$test-result/failure">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Failure</xsl:text>
                    				<br/>
								</xsl:when>                    				

                    			<xsl:when test="$test-result/error/@message">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Error:</xsl:text>
                    				<xsl:value-of select="substring($test-result/error/@message, 1, 80)"/>
                    				<br/>
                    			</xsl:when>
                    			<xsl:when test="$test-result/error/@type">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Error:</xsl:text>
                    				<xsl:value-of select="$test-result/error/@type"/>
                    				<br/>
                    			</xsl:when>
                    			<xsl:when test="$test-result/error">
                    				<xsl:value-of select="$implName"/>
                    				<xsl:text> Error</xsl:text>
                    				<br/>
                    			</xsl:when>
                    		</xsl:choose>
                    	</xsl:for-each>
                    </td>
                </tr>
                </xsl:when>
                <xsl:otherwise/>
                </xsl:choose>
            </xsl:for-each>
            </tbody>
        </table>     



        <h2>Tests skipped</h2>
        <table border="1" cols="2" width="100%" summary="Tests skipped">
        	<thead>
            <tr>
            	<th>Test</th>
            	<th>Implementations</th>
            </tr>
            </thead>
            <tbody>
            <xsl:variable name="implCount" select="count($results)"/>
            <xsl:for-each select="$descriptions">
                <xsl:sort select="ancestor::*[local-name() = 'test']/@name"/>
                <xsl:variable name="test" select="."/>
                <xsl:variable name="testName" select="$test/@rdf:about"/>
                <xsl:variable name="shortName" select="substring($test/@rdf:about, string-length($testBaseURI) + 1)"/>
                <xsl:variable name="reportCount" select="count($results/testcase[(@name = $testName or substring(@name, string-length(@name) - string-length($shortName)) = concat(':', $shortName))])"/>
                
                <xsl:choose>
                	<xsl:when test="contains(@rdf:about, 'alltests')"/>
                	<xsl:when test="substring(@rdf:about, string-length(@rdf:about)) = '/'"/> 
                
                <!--  if there aren't the same number of reports   -->
                <xsl:when test="$implCount != $reportCount">

                <tr>
                    <td width="25%">
                    <xsl:variable name="testName"><xsl:value-of select="ancestor::*[local-name() = 'test']/@name" /></xsl:variable>                             
                    <xsl:call-template name="emit-title"/>
                    <xsl:text> (</xsl:text> 
        		    <a href="{concat($testPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'.xml'))}" title="XML Test Definition">XML</a>
                    <xsl:text> </xsl:text>
        		    <a href="{concat($doxyPath,concat(translate($testName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),$doxySuffix))}" title="Java Source">Java</a>
                    <xsl:text>)</xsl:text>
                    </td>
                    <td>
                    	<xsl:for-each select="$results">
                    		<xsl:if test="not(testcase[(@name = $testName or substring(@name, string-length(@name) - string-length($shortName)) = concat(':', $shortName))])">
                    			<xsl:variable name="implName" select="ancestor::implementation/@name"/>
                    			<xsl:value-of select="$implName"/>
                    			<br/>
                    		</xsl:if>
                    	</xsl:for-each>
                    </td>
                </tr>
                </xsl:when>
                </xsl:choose>
            </xsl:for-each>
            </tbody>
        </table>     





                <!--  the copyright notice placed in the output file.    -->
		
			<br />
			<xsl:text>Tests in this table are released under the </xsl:text><a 
href="resources/COPYRIGHT.html">W3C Software 
Copyright Notice and License</a><xsl:text>:</xsl:text>
			<br />
			<xsl:text>Copyright © 2001-2005 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.</xsl:text>
			<br />
			<xsl:text>[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
			See W3C License </xsl:text>


	    </body>
        </html>
    </xsl:template>

    <xsl:template name="rowmethods">
        <xsl:param name="methods"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
        <tr>
            <xsl:for-each select="$methods[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
                <td>
                    <a href="{concat($specURI,@id)}">
                        <xsl:value-of select="ancestor::interface/@name"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="@name"/>
                    </a>
                </td>
            </xsl:for-each>
        </tr>
        <xsl:if test="count($methods) &gt; $index + $columns">
            <xsl:call-template name="rowmethods">
                <xsl:with-param name="methods" select="$methods"/>
                <xsl:with-param name="index" select="$index + $columns"/>
                <xsl:with-param name="columns" select="$columns"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


    <xsl:template name="rowtests">
        <xsl:param name="tests"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
        <tr>
            <xsl:for-each select="$tests[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
                <td>
		    <xsl:variable name="testName"><xsl:value-of select="ancestor::*[local-name() = 'test']/@name" /></xsl:variable>
            <xsl:call-template name="emit-title"/>
            <xsl:text> (</xsl:text>
		    <a href="{concat($testPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'.xml'))}" title="XML Test Definition">XML</a>
            <xsl:text> </xsl:text>
		    <a href="{concat($doxyPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),$doxySuffix))}" title="Java Source">Java</a>
            <xsl:text>) </xsl:text>
			<xsl:value-of select="dc:description" />
                </td>
            </xsl:for-each>
        </tr>
        <xsl:if test="count($tests) &gt; $index + $columns">
            <xsl:call-template name="rowtests">
                <xsl:with-param name="tests" select="$tests"/>
                <xsl:with-param name="index" select="$index + $columns"/>
                <xsl:with-param name="columns" select="$columns"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>



    <xsl:template name="rowsubjects">
        <xsl:param name="subjects"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
        <tr>
            <xsl:for-each select="$subjects[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
                <td>
                    <a title="{normalize-space(dc:description)}">
						<xsl:call-template name="emit-href"/>
                        <xsl:call-template name="emit-title"/>
                    </a>
                </td>
            </xsl:for-each>
        </tr>
        <xsl:if test="count($subjects) &gt; $index + $columns">
            <xsl:call-template name="rowsubjects">
                <xsl:with-param name="subjects" select="$subjects"/>
                <xsl:with-param name="index" select="$index + $columns"/>
                <xsl:with-param name="columns" select="$columns"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


<xsl:template name="emit-title">
    <xsl:choose>
        <xsl:when test="dc:title">
            <xsl:value-of select="dc:title"/>
        </xsl:when>
		<xsl:when test="dc:description">
			<xsl:value-of select="substring-before(dc:description,':')"/>
		</xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="@rdf:about"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="emit-href">
	<xsl:choose>
		<!--  if we have an XPointer, change it to a fragment identifier -->
		<xsl:when test="contains(@rdf:about,'#xpointer(id(')">
			<xsl:attribute name="href">
				<xsl:value-of select="substring-before(@rdf:about,'#xpointer')"/>
				<xsl:text>#</xsl:text>
				<xsl:variable name="after" select="substring-after(@rdf:about,&quot;#xpointer(id(&apos;&quot;)"/>
				<xsl:value-of select="substring-before($after,&quot;')&quot;)"/>
			</xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="href">
				<xsl:value-of select="@rdf:about"/>
			</xsl:attribute>
		</xsl:otherwise>
	</xsl:choose>				
</xsl:template>

</xsl:stylesheet>
