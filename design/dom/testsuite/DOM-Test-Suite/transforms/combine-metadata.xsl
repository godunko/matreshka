<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2001-2004 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Software
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
-->

<!--   
This transform combines all the metadata from the tests
in the specified suite and one file passed as a parameter
-->

<xsl:stylesheet version="1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
     <xsl:param name="externalMetadata"/>
     <xsl:param name="baseURI">http://www.w3.org/2001/DOM-Test-Suite/level1/core/</xsl:param>
     <xsl:param name="oldSpecURI">http://www.example.example</xsl:param>
     <xsl:param name="newSpecURI"/>

	<xsl:output method="xml" indent="yes"/>

	<!--  match document root    -->
	<xsl:template match="/">
		<!--  the copyright notice placed in the output file.    -->
		<xsl:comment>
Copyright (c) 2001-2004 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Document
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
</xsl:comment>
		<rdf:RDF>
            <xsl:apply-templates select="*"/>
        </rdf:RDF>
    </xsl:template>

    <xsl:template match="*[local-name() = 'suite']">
		<xsl:comment>This file is collection of metadata from all tests referenced by <xsl:value-of select="@name"/></xsl:comment>
        <rdf:Description rdf:about="{concat($baseURI,@name)}">
            <xsl:apply-templates select="*[local-name() = 'metadata' and not(@about)]"/>
        </rdf:Description>
        <xsl:if test="$externalMetadata">
            <xsl:comment>Metadata from <xsl:value-of select="$externalMetadata"/></xsl:comment>
        </xsl:if>
        <xsl:apply-templates select="document($externalMetadata,.)/*"/>
        <xsl:for-each select="*[local-name() = 'suite.member']">
            <xsl:comment>Metadata from <xsl:value-of select="@href"/></xsl:comment>
            <xsl:apply-templates select="document(@href,.)/*"/>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="*[local-name() = 'test']">
		<xsl:comment>metadata for tests <xsl:value-of select="@name"/></xsl:comment>
        <xsl:apply-templates select="*[local-name() = 'metadata' and not(@about)]"/>
    </xsl:template>

    <xsl:template match="*[local-name() = 'metadata']">
        <xsl:choose>
            <xsl:when test="@about">
                <rdf:Description>
                    <xsl:apply-templates select="@*|*"/>
                </rdf:Description>
            </xsl:when>
            <xsl:otherwise>
                <rdf:Description rdf:about="{concat($baseURI,parent::*/@name)}">
                    <xsl:apply-templates select="@*|*"/>
                </rdf:Description>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="*">
        <!--  create the same local name in Dublin Core      -->
        <xsl:element name="{local-name()}" namespace="http://purl.org/dc/elements/1.1/">
            <xsl:apply-templates select="@*|text()|*"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="@resource">
        <xsl:attribute name="resource" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
        	<xsl:choose>
        		<xsl:when test="contains(., $oldSpecURI)">
        			<xsl:value-of select="concat($newSpecURI, substring-after(., $oldSpecURI))"/>
        		</xsl:when>
        		<xsl:otherwise>
            		<xsl:value-of select="."/>
            	</xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>

    <xsl:template match="@about">
        <xsl:attribute name="about" namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
            <xsl:choose>
                <xsl:when test="starts-with(.,'http:')">
                    <xsl:value-of select="."/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat($baseURI,.)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
    </xsl:template>


    <xsl:template match="@*">
        <xsl:attribute name="{name()}" namespace="http://purl.org/dc/elements/1.1/">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>

</xsl:stylesheet>
