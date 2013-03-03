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
This transforms builds a composite of the DOM 3 Specs.

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.


Usage:

saxon -o build/dom3-interfaces.xml lib/specs/Level-3/Core/xml-source.xml transforms/dom3-combine.xsl


-->

<!--
$Log: dom3-combine.xsl,v $
Revision 1.9  2003-10-24 17:10:16  dom-ts-4
Changed copyright dates, bug 369

Revision 1.8  2003/06/11 03:20:18  dom-ts-4
Updated for the 09 June 2003 L3 Core Working Draft

Revision 1.7  2003/02/28 06:26:49  dom-ts-4
Update for 2003-02-26 Level 3 WD

Revision 1.6  2003/01/28 06:08:15  dom-ts-4
Combines DOM L2 traversal/range
Removes :: from inherits attribute

Revision 1.5  2003/01/20 06:14:46  dom-ts-4
Move change of Element.getElementByTagName from patch file to here.

Revision 1.4  2003/01/16 06:40:47  dom-ts-4
Change for 27 Nov 2002 DOM 3 Validation WD

Revision 1.3  2002/07/31 04:58:27  dom-ts-4
Update for July DOM 3 drafts

Revision 1.2  2002/04/21 23:11:36  dom-ts-4
Updated for DOM L3

Revision 1.1  2002/03/27 07:41:21  dom-ts-4
Combines dom-spec.xml from the DOM 3 parts into dom3-interfaces.xml

Revision 1.2  2001/07/20 05:44:32  dom-ts-4
Initial SVG support.  multiply renamed mult,
All implementation conditions combined into implementationAttribute element

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
			<xsl:apply-templates select="document('../Events/xml-source.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../LS/xml-source.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../Val/xml-source.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../XPath/xml-source.xml',.)/spec/*"/>
            <!--  traversal range from DOM 2   -->
			<xsl:apply-templates select="document('../../Level-2/xml/traversal-range/dom-spec.xml',.)/spec/*"/>

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
