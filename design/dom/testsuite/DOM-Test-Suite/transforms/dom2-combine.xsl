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
This transforms builds a composite of the DOM 2 Specs.

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.


Usage:

saxon -o dom2-interfaces.xml core/dom-spec.xml combine-dom2.xsl


-->

<!--
$Log: dom2-combine.xsl,v $
Revision 1.5  2003-10-24 17:10:16  dom-ts-4
Changed copyright dates, bug 369

Revision 1.4  2003/01/21 15:27:54  dom-ts-4
Injected some missing exceptions from errata

Revision 1.3  2003/01/20 06:14:36  dom-ts-4
Move change of Element.getElementByTagName from patch file to here.

Revision 1.2  2001/07/20 05:44:32  dom-ts-4
Initial SVG support.  multiply renamed mult,
All implementation conditions combined into implementationAttribute element

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
			<xsl:apply-templates select="document('../views/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../events/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../style/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../traversal-range/dom-spec.xml',.)/spec/*"/>
			<xsl:apply-templates select="document('../html/dom-spec.xml',.)/spec/*"/>
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

    <!--   errata from http://www.w3.org/2000/11/DOM-Level-2-errata    -->

    <!--  core-3a. 2001-05-09   -->
    <xsl:template match="method[@id='Level-2-Core-DOM-createDocument']" mode="interface">
		<method>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*[local-name() != 'raises']|text()" mode="interface"/>
            <raises>
                <exception name="DOMException">
                    <descr>
                        <xsl:apply-templates select="raises/exception/descr/*" mode="interface"/>
                        <p>NOT_SUPPORTED_ERR: May be raised by DOM implementations which do not support the "XML" feature, if they choose not to support this method. Note: Other features introduced in the future, by the DOM WG or in extensions defined by other groups, may also demand support for this method; please consult the definition of the feature to see if it requires this method.</p>
                    </descr>
                </exception>
            </raises>
		</method>
    </xsl:template> 


    <!--   core-4. 2001-01-17. [clarification]. NamedNodeMap.setNamedItem    -->
    <xsl:template match="method[@id='ID-1025163788' or @id='ID-setNamedItemNS']" mode="interface">
		<method>
			<!--   replicate attributes   -->
			<xsl:apply-templates select="@*"/>
			<!--   process children and text content in "interface" mode  -->				
			<xsl:apply-templates select="*[local-name() != 'raises']|text()" mode="interface"/>
            <raises>
                <exception name="DOMException">
                    <descr>
                        <xsl:apply-templates select="raises/exception/descr/*" mode="interface"/>
                        <p>HIERARCHY_REQUEST_ERR: Raised if an attempt is made to add a node doesn't belong in this NamedNodeMap. Examples would include trying to insert something other than an Attr node into an Element's map of attributes, or a non-Entity node into the DocumentType's map of Entities</p>
                    </descr>
                </exception>
            </raises>
		</method>
    </xsl:template> 


</xsl:stylesheet>
