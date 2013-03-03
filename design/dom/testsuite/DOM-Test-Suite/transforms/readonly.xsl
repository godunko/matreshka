<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2001 World Wide Web Consortium,
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
This transform creates creates a test suite containing only the
read-only tests from another test suite

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>

	<!--  match document root    -->
	<xsl:template match="/">
		<xsl:apply-templates select="*"/>
	</xsl:template>
	
	<!--   replicate attributes   -->
	<xsl:template match="@*">
		<xsl:attribute namespace="{namespace-uri(.)}" name="{local-name(.)}"><xsl:value-of select="."/></xsl:attribute>
   	</xsl:template>

    <xsl:template match="*">
        <xsl:element namespace="{namespace-uri(.)}" name="{local-name(.)}">
            <xsl:apply-templates select="@*|*|text()"/>
        </xsl:element>
    </xsl:template>

	<xsl:template match="*[local-name() = 'suite']">
        <xsl:element namespace="{namespace-uri(.)}" name="suite">
            <xsl:attribute name="name">readonly</xsl:attribute>
		    <xsl:apply-templates select="*"/>
        </xsl:element>
	</xsl:template>


	<xsl:template match="*[local-name() = 'suite.member']">
        <xsl:if test="not(document(@href,.)//*[local-name() = 'load' and @willBeModified='true'])">
            <xsl:element namespace="{namespace-uri(.)}" name="suite.member">
                <xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
            </xsl:element>
        </xsl:if>
	</xsl:template>

</xsl:stylesheet>
