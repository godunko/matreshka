<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2001-2003 World Wide Web Consortium,
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
This transforms builds a composite of the DOM 3 Specs from the working group drafts.

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.


Usage:

saxon -o build/dom3-interfaces.xml specs/Level-3/member/level-3-src/xml/core/core.xml transforms/dom3-combine-member.xsl


-->

<!--
$Log: dom3-combine-member.xsl,v $
Revision 1.1  2003-10-24 17:09:08  dom-ts-4
Support for working group drafts, bug 368


-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink">
	<xsl:output method="xml" indent="yes"/>
	<xsl:variable name="specTitle" select="/spec/header/title"/>

	<!--  match document root    -->
	<xsl:template match="/">
		<xsl:comment>
Copyright (c) 2002-2003 World Wide Web Consortium,
(Massachusetts Institute of Technology, Institut National de
Recherche en Informatique et en Automatique, Keio University). All
Rights Reserved. This program is distributed under the W3C's Document
Intellectual Property License. This program is distributed in the
hope that it will be useful, but WITHOUT ANY WARRANTY; without even
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
PURPOSE.
See W3C License http://www.w3.org/Consortium/Legal/ for more details.
</xsl:comment>
		<xsl:comment>This file is an extract of interface definitions from <xsl:value-of select="$specTitle"/></xsl:comment>
		<!--  must enclose interface elements in
		       some container, chose library ala COM 
			   Type Library   -->
		<library>
			<!--   walk through all child elements  -->
			<xsl:apply-templates select="*"/>
            <!--   
                views seems to be stagnant and is missing an entity reference
                    skipping it for now
			<xsl:apply-templates select="document('../xml/views/dom-spec.xml',.)/spec/*"/>
            -->
			<xsl:apply-templates select="document('../events/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../ls/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../validation/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../xpath/dom-spec.xml',.)/spec/*"/>
            <!--  traversal range from DOM 2   -->
			<xsl:apply-templates select="document('../../../../../Level-2/xml/traversal-range/dom-spec.xml',.)/spec/*"/>

		</library>
	</xsl:template>
	
	<!--   replicate attributes   -->
	<xsl:template match="@*">
		<xsl:attribute name="{local-name(.)}" namespace="{namespace-uri(.)}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>
	
	<!--   if unrecognized element, apply templates to children  -->	       
	<xsl:template match="*">
		<xsl:apply-templates select="*"/>
	</xsl:template>

	<!--   if interface element
	          produce <interface> element    -->	
	<xsl:template match="interface">
		<interface>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</interface>
	</xsl:template>

	<xsl:template match="exception[@id]">
		<exception>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</exception>
		<!--  must also bring following group element  -->
		<xsl:apply-templates select="following-sibling::group[1]" mode="interface"/>
	</xsl:template>


	<!--    if interface mode, replicate any element   -->
	<xsl:template match="*" mode="interface">
		<xsl:element name="{local-name()}" namespace="{namespace-uri()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</xsl:element>
	</xsl:template>
	
	<!--    if interface mode, replicate any text    -->
	<xsl:template match="text()" mode="interface">
		<xsl:value-of select="normalize-space(.)"/>
	</xsl:template>

	<xsl:template match="xspecref" mode="interface">
		<xsl:apply-templates select="*" mode="interface"/>
	</xsl:template>

	<xsl:template match="loc" mode="interface">
		<xsl:apply-templates select="*" mode="interface"/>
	</xsl:template>

    <!--  change parameter 'name' to 'tagname' on Elements.getElementByTagName'   -->
    <xsl:template match="param[@name='name' and ancestor::method/@name='getElementsByTagName']" mode="interface">
        <param> 
            <!--  element all existing attributes    -->
			<xsl:apply-templates select="@*"/>
            <!--  overwrite the name attribute  -->
            <xsl:attribute name="name">tagname</xsl:attribute>
            <!--  produce the element content   -->
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</param>
    </xsl:template>

    <!--  strip out any namespace scoping in base class names   -->
    <xsl:template match="@inherits">
        <xsl:choose>
            <xsl:when test="contains(., '::')">
                <xsl:attribute name="inherits"><xsl:value-of select="substring-after(., '::')"/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="inherits"><xsl:value-of select="."/></xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
