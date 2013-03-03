<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright &#xA9; 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C&#xAE; Software License [1] in the 
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
     <xsl:param name="interfacesURL">../build/dom1-interfaces.xml</xsl:param>
     <xsl:param name="specURI">http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/level-one-core#</xsl:param>
     <xsl:param name="specMetadataURL">../build/dom1-subjects.xml</xsl:param>
     <xsl:param name="buildPath">tests/</xsl:param>
     <xsl:param name="doxyPath">doxygen/html/</xsl:param>
     <xsl:param name="doxySuffix">_8java-source.html</xsl:param>
     <xsl:param name="title">DOM Level 1 Core Test Suite Matrix</xsl:param>
     <xsl:param name="specVersion"></xsl:param>
     <xsl:param name="excludeInterfaces"></xsl:param>
     <xsl:param name="noTestInterfaces"></xsl:param>

	<xsl:output method="html" 
		doctype-public="-//W3C//DTD HTML 4.01//EN" 
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		encoding="US-ASCII"/>

    <!--   filter subjects by specification    -->
    <xsl:variable name="subjects" select="document($specMetadataURL,.)/rdf:RDF/rdf:Description[contains(@rdf:about,$specURI)]"/>

    <xsl:variable name="interfacesDoc" select="document($interfacesURL,.)"/>

    <xsl:variable name="interfaces" select="$interfacesDoc//interface[concat($specURI,@id) = $subjects/@rdf:about and not(contains($excludeInterfaces, @name))]"/>
    <xsl:variable name="methods" select="$interfaces/method"/>
    <xsl:variable name="attributes" select="$interfaces/attribute"/>
    <xsl:variable name="descriptions" select="/rdf:RDF/rdf:Description"/>

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
		<p>Below you will find a description of and pointer to each test in the DOM TS categorized under interface, attribute and method, 
sorted alphabetically. 
</p>

                <xsl:variable name="untestedMethods" select="$methods[not(concat($specURI,@id) = $descriptions/dc:subject/@rdf:resource) and 
                  (string-length($specVersion) = 0 or @since= $specVersion or @version = $specVersion or ancestor::interface/@since = $specVersion) and
                  not(contains($excludeInterfaces, ancestor::interface/@name))]"/>
                <xsl:if test="$untestedMethods">
                	<p>The following methods do not have associated tests:
                        <xsl:call-template name="brmethods">
                            <xsl:with-param name="methods" select="$untestedMethods"/>
                            <xsl:with-param name="index">0</xsl:with-param>
                            <xsl:with-param name="columns">1</xsl:with-param>
                        </xsl:call-template>
                    </p>
                </xsl:if>
                <xsl:variable name="untestedAttributes" select="$attributes[not(concat($specURI,@id) = $descriptions/dc:subject/@rdf:resource) and 
                       (string-length($specVersion) = 0 or @since= $specVersion or @version = $specVersion  or ancestor::interface/@since = $specVersion) and
                       not(contains($excludeInterfaces, ancestor::interface/@name))]"/>
                <xsl:if test="$untestedAttributes">
                	<p>The following attributes do not have associated tests:
                        <xsl:call-template name="brmethods">
                            <xsl:with-param name="methods" select="$untestedAttributes"/>
                            <xsl:with-param name="index">0</xsl:with-param>
                            <xsl:with-param name="columns">1</xsl:with-param>
                        </xsl:call-template>
                    </p>
                </xsl:if>


                <xsl:for-each select="$interfaces">
                    <xsl:sort select="@name"/>
                     <xsl:variable name="interface" select="."/>
					<h2>Interface <xsl:value-of select="@name" /></h2>
                     <table border="1" summary="Tests for interface {@name}" width="100%">
                        <!-- tests which have the interface as a subject  -->
                        <xsl:variable name="interfacetests" select="$descriptions[dc:subject/@rdf:resource= concat($specURI,current()/@id)]"/>
                        <xsl:choose>
                        	<xsl:when test="$interfacetests">
                        		<tr><td/><td><p>
                            	<xsl:call-template name="brtests">
                                	<xsl:with-param name="tests" select="$interfacetests"/>
                                	<xsl:with-param name="index">0</xsl:with-param>
                                	<xsl:with-param name="columns">1</xsl:with-param>
                            	</xsl:call-template>
                           		</p></td></tr>
                        	</xsl:when>
                        	<!--  if there are no tests defined for the interface
                        	         and the interface appears in noTestInterfaces
                        	         output a row to avoid an empty table  -->            
                        	<xsl:when test="contains($noTestInterfaces, @name)">
                        		<tr><td/><td>No tests defined for interface</td></tr>
                        	</xsl:when>
                        </xsl:choose>

                        <xsl:if test="attribute">
                            <xsl:for-each select="attribute">
                                <xsl:sort select="@name"/>
                                <xsl:variable name="featureURI" select="concat($specURI,@id)"/>
                                <tr>
                                    <td>
                                        <a href="{$featureURI}">
                                            <xsl:value-of select="@name"/>
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:variable name="featuretests" select="$descriptions[dc:subject/@rdf:resource=$featureURI]"/>
                                        <xsl:if test="$featuretests">
                                        	<p>
                                            <xsl:call-template name="brtests">
                                                <xsl:with-param name="tests" select="$featuretests"/>
                                                <xsl:with-param name="index">0</xsl:with-param>
                                                <xsl:with-param name="columns">1</xsl:with-param>
                                            </xsl:call-template>
                                           	</p>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:if>

                        <xsl:if test="method">
                            <xsl:for-each select="method">
                                <xsl:sort select="@name"/>
                                <xsl:variable name="featureURI" select="concat($specURI,@id)"/>
                                <tr>
                                    <td>
                                        <a href="{$featureURI}">
                                            <xsl:value-of select="@name"/>
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:variable name="featuretests" select="$descriptions[dc:subject/@rdf:resource=$featureURI]"/>
                                        <xsl:if test="$featuretests">
                                        	<p>
                                                <xsl:call-template name="brtests">
                                                    <xsl:with-param name="tests" select="$featuretests"/>
                                                    <xsl:with-param name="index">0</xsl:with-param>
                                                    <xsl:with-param name="columns">1</xsl:with-param>
                                                </xsl:call-template>
                                            </p>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:if>
                        
                        <xsl:variable name="interface-parameters" select="descendant::label[contains(@id, 'parameter-')]"/>
                        <xsl:if test="$interface-parameters">
                            <tr><th width="25%">Parameter</th><th>Tests</th></tr>
                            <xsl:for-each select="$interface-parameters">
                                <xsl:sort select="code/text()"/>
                                <xsl:variable name="featureURI" select="concat($specURI,@id)"/>
                                <tr>
                                    <td>
                                        <a href="{$featureURI}">
                                            <xsl:value-of select="code/text()"/>
                                        </a>
                                    </td>
                                    <td>
                                        <xsl:variable name="featuretests" select="$descriptions[dc:subject/@rdf:resource=$featureURI]"/>
                                        <xsl:if test="$featuretests">
                                        	<p>
                                                <xsl:call-template name="brtests">
                                                    <xsl:with-param name="tests" select="$featuretests"/>
                                                    <xsl:with-param name="index">0</xsl:with-param>
                                                    <xsl:with-param name="columns">1</xsl:with-param>
                                                </xsl:call-template>
                                            </p>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </xsl:if>
                    </table>
                </xsl:for-each>

				<h2>All tests</h2>
                <table border="1" summary="Subjects">
                    <xsl:for-each select="$descriptions">
                        <xsl:sort select="dc:title"/>

                        <xsl:variable name="test" select="."/>
                        <tr>
                            <td>
		                    <xsl:variable name="testName"><xsl:value-of select="dc:title" /></xsl:variable>                             
                            <xsl:call-template name="emit-title"/>
                            <xsl:text> (</xsl:text> 
                		    <a href="{concat($buildPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'.xml'))}" title="XML definition">XML</a>
                            <xsl:text> </xsl:text>
                		    <a href="{concat($doxyPath,concat(translate($testName, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),$doxySuffix))}" title="Generated Java">Java</a>
                            <xsl:text>)</xsl:text>
                            </td>
                            <td><p>
                                <xsl:variable name="testsubjects" select="$subjects[@rdf:about = $test/dc:subject/@rdf:resource]"/>
                                <xsl:choose>
                                    <xsl:when test="$testsubjects">
                                            <xsl:call-template name="brsubjects">
                                                <xsl:with-param name="subjects" select="$testsubjects"/>
                                                <xsl:with-param name="index">0</xsl:with-param>
                                                <xsl:with-param name="columns">1</xsl:with-param>
                                            </xsl:call-template>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <span style="color:red">No subjects defined for test</span>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </p></td>
                        </tr>
                    </xsl:for-each>
                </table>     
                <!--  the copyright notice placed in the output file.    -->

			<p>		
			Tests in this table are released under the <a 
href="resources/COPYRIGHT.html">W3C Software 
Copyright Notice and License</a>:
			<br />
Copyright &#xA9; 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C&#xAE; Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
			<br />
			</p>

	    </body>
        </html>
    </xsl:template>
    
    <xsl:template name="brmethods">
        <xsl:param name="methods"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
            <xsl:for-each select="$methods[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
                    <a href="{concat($specURI,@id)}">
                        <xsl:value-of select="ancestor::interface/@name"/>
                        <xsl:text>.</xsl:text>
                        <xsl:value-of select="@name"/>
                    </a>
            </xsl:for-each>
        <br/>
        <xsl:if test="count($methods) &gt; $index + $columns">
            <xsl:call-template name="brmethods">
                <xsl:with-param name="methods" select="$methods"/>
                <xsl:with-param name="index" select="$index + $columns"/>
                <xsl:with-param name="columns" select="$columns"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


    
    

    <xsl:template name="brtests">
        <xsl:param name="tests"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
            <xsl:for-each select="$tests[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
		    <xsl:variable name="testName"><xsl:value-of select="dc:title" /></xsl:variable>
            <xsl:call-template name="emit-title"/>
            <xsl:text> (</xsl:text>
		    <a href="{concat($buildPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),'.xml'))}" title="XML definition">XML</a>
            <xsl:text> </xsl:text>
		    <a href="{concat($doxyPath,concat(translate($testName,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz'),$doxySuffix))}" title="Generated Java">Java</a>
            <xsl:text>) </xsl:text>
            </xsl:for-each>
        <br/>
        <xsl:if test="count($tests) &gt; $index + $columns">
            <xsl:call-template name="brtests">
                <xsl:with-param name="tests" select="$tests"/>
                <xsl:with-param name="index" select="$index + $columns"/>
                <xsl:with-param name="columns" select="$columns"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>


    <xsl:template name="brsubjects">
        <xsl:param name="subjects"/>
        <xsl:param name="index"/>
        <xsl:param name="columns"/>
            <xsl:for-each select="$subjects[position() &gt; $index and position() &lt; ($index + $columns + 1)]"> 
                    <a>
						<xsl:call-template name="emit-href"/>
                        <xsl:call-template name="emit-title"/>
                    </a>
            </xsl:for-each>
        <br/>
        <xsl:if test="count($subjects) &gt; $index + $columns">
            <xsl:call-template name="brsubjects">
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
