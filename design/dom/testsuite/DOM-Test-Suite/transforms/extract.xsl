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
This transforms extracts the interface definitions from
a DOM specification and produces an extract just containing
the interface definitions.

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.

For example, the DOM Level 1 .zip file, 
http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/DOM.zip 
contains a nested file, xml-source.zip, which contains an
XML file, wd-dom.xml which expresses the DOM recommendation
in XML.  (Note: most of the other .xml files are external 
entities expanded by one enclosing document).


Usage:

saxon -o interfaces.xml wd-dom.xml extract.xsl


-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>
	<xsl:variable name="specTitle" select="/spec/header/title"/>

	<!--  match document root    -->
	<xsl:template match="/">
		<xsl:comment>
Copyright (c) 2001-2003 World Wide Web Consortium,
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
		</library>
	</xsl:template>
	
	<!--   replicate attributes   -->
	<xsl:template match="@*">
        <!--  intentionally dropping the namespace for xlink attributes  -->
		<xsl:attribute name="{local-name(.)}"><xsl:value-of select="."/></xsl:attribute>
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

	<xsl:template match="exception">
		<exception>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</exception>
	</xsl:template>

	<xsl:template match="group">
		<group>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*|text()" mode="interface"/>
		</group>
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

</xsl:stylesheet>
