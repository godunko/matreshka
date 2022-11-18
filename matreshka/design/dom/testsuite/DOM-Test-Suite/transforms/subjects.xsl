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
This transform generates an document that describes the
potential subjects or purposes of DOM tests in a specification .

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.

For example, the DOM Level 1 .zip file, 
http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/DOM.zip 
contains a nested file, xml-source.zip, which contains an
XML file, wd-dom.xml which expresses the DOM recommendation
in XML.  (Note: most of the other .xml files are external 
entities expanded by one enclosing document).


Usage:

saxon -o subjects.xml wd-dom.xml subjects.xsl


-->

<xsl:stylesheet version="1.0" 
     xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
     xmlns:dc="http://purl.org/dc/elements/1.1/"
     xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
     <xsl:param name="specURI" select="/spec/header/publoc/loc[1]/@href"/>
     <xsl:param name="specTitle" select="/spec/header/title"/>

	<xsl:output method="xml" indent="yes"/>


	<!--  match document root    -->
	<xsl:template match="/">
		<!--  the copyright notice placed in the output file.    -->
		<xsl:comment>
Copyright (c) 2001 World Wide Web Consortium,
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
		<xsl:comment>This file is an list of potential test subjects generated from <xsl:value-of select="$specTitle"/></xsl:comment>
			<xsl:for-each select="descendant::interface">
				<xsl:choose>
					<xsl:when test="ancestor::div1[head='Document Object Model (Core) Level 1']">
						<xsl:apply-templates select=".">
							<xsl:with-param name="subspecURI" select="concat($specURI,'/level-one-core')"/>
						</xsl:apply-templates>
					</xsl:when>

					<xsl:when test="ancestor::div1[head='Document Object Model (HTML) Level 1']">
						<xsl:apply-templates select=".">
							<xsl:with-param name="subspecURI" select="concat($specURI,'/level-one-html')"/>
						</xsl:apply-templates>
					</xsl:when>

					<xsl:otherwise>
						<xsl:apply-templates select=".">
							<xsl:with-param name="subspecURI" select="$specURI"/>
						</xsl:apply-templates>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

		</rdf:RDF>
	</xsl:template>
	
	<!--   if unrecognized element, apply templates to children  -->	       
	<xsl:template match="*">
		<xsl:apply-templates select="*"/>
	</xsl:template>

	<!--   if interface element
	          produce <interface> element    -->	
	<xsl:template match="interface">
		<xsl:param name="subspecURI"/>
		<rdf:Description rdf:about="{concat($subspecURI,concat('#',@id))}">
			<dc:title><xsl:value-of select="@name"/></dc:title>
			<dc:description><xsl:value-of select="normalize-space(descr/p[1])"/></dc:description>
			<xsl:text>
</xsl:text>
			<xsl:comment> <xsl:value-of select="$specTitle"/> </xsl:comment><xsl:text>
		</xsl:text>
			<dc:relation dc:qualifier="isPartOf" rdf:resource="{$subspecURI}"/>
			<xsl:for-each select="method">
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="@name"/></xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="hasPart" rdf:resource="{concat($subspecURI,concat('#',@id))}"/>
			</xsl:for-each>
			<xsl:for-each select="attribute">
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="@name"/> attribute </xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="hasPart" rdf:resource="{concat($subspecURI,concat('#',@id))}"/>
			</xsl:for-each>
		</rdf:Description>
		<xsl:apply-templates select="*" mode="interface">
			<xsl:with-param name="subspecURI" select="$subspecURI"/>
		</xsl:apply-templates>

	</xsl:template>

	<!--    if interface mode, replicate any element   -->
	<xsl:template match="*" mode="interface">
		<xsl:apply-templates select="*" mode="interface"/>
	</xsl:template>

	<xsl:template match="method" mode="interface">
		<xsl:param name="subspecURI"/>
		<xsl:variable name="methodURI" select="concat($subspecURI,concat('#',@id))"/>
		<xsl:variable name="methodName" select="concat(parent::interface/@name,concat('.',concat(@name,' method')))"/>
		<xsl:variable name="baseXPointer"><xsl:value-of select="$subspecURI"/>#xpointer(id('<xsl:value-of select="@id"/>')/</xsl:variable>
		<rdf:Description rdf:about="{$methodURI}">
			<dc:title><xsl:value-of select="$methodName"/></dc:title>
			<dc:description><xsl:value-of select="normalize-space(descr)"/></dc:description>
			<xsl:text>
</xsl:text>
			<xsl:comment> <xsl:value-of select="parent::interface/@name"/> interface </xsl:comment><xsl:text>
</xsl:text>
			<dc:relation dc:qualifier="isPartOf" rdf:resource="{concat($subspecURI,concat('#',parent::interface/@id))}"/>

			<!--  produce relations for parameters   -->
			<xsl:for-each select="parameters/param">
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="@name"/> parameter</xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="hasPart" rdf:resource="{concat($baseXPointer,concat('parameters/param[',concat(position(),'])')))}"/>
			</xsl:for-each>

			<!--  produce relation for return value   -->
			<xsl:if test="returns[@type != 'void']">
				<xsl:text>
</xsl:text>
				<xsl:comment> return value </xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="hasPart" rdf:resource="{concat($baseXPointer,'returns)')}"/>
			</xsl:if>

			<!--  produce metadata for exceptions  -->
			<xsl:for-each select="raises/exception">
				<xsl:call-template name="relation-exception">
					<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'raises/')"/>
				</xsl:call-template>
			</xsl:for-each>

		</rdf:Description>

		<!--    produce metadata for parameters  -->
		<xsl:for-each select="parameters/param">
			<rdf:Description rdf:about="{concat($baseXPointer,concat('parameters/param[',concat(position(),'])')))}">
				<dc:title><xsl:value-of select="@name"/> parameter</dc:title>
				<dc:description><xsl:value-of select="normalize-space(descr/p[1])"/></dc:description>
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="$methodName"/></xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="isPartOf" rdf:resource="{$methodURI}"/>
			</rdf:Description>
		</xsl:for-each>

		<!--  produce metadata for return value   -->
		<xsl:if test="returns[@type != 'void']">
			<rdf:Description rdf:about="{concat($baseXPointer,'returns)')}">
				<dc:title><xsl:value-of select="$methodName"/> return value</dc:title>
				<dc:description><xsl:value-of select="normalize-space(descr)"/></dc:description>
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="$methodName"/></xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="isPartOf" rdf:resource="{$methodURI}"/>
			</rdf:Description>
		</xsl:if>

		<!--  produce metadata for exceptions  -->
		<xsl:for-each select="raises/exception">
			<xsl:call-template name="about-exception">
				<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'raises/')"/>
				<xsl:with-param name="featureName" select="$methodName"/>
				<xsl:with-param name="featureURI" select="$methodURI"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="about-exception">
		<xsl:param name="baseXPointer"/>
		<xsl:param name="featureName"/>
		<xsl:param name="featureURI"/>
		<xsl:variable name="exceptionURI"><xsl:value-of select="$baseXPointer"/>exception[@name='<xsl:value-of select="@name"/>']/descr/p[</xsl:variable>
		<xsl:for-each select="descr/p">
			<rdf:Description>
				<xsl:attribute 
				    namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
				    name="about"><xsl:value-of select="$exceptionURI"/>substring-before(.,':')='<xsl:value-of select="substring-before(.,':')"/>'])</xsl:attribute>
				<dc:description><xsl:value-of select="normalize-space(.)"/></dc:description>
				<xsl:text>
</xsl:text>
				<xsl:comment> <xsl:value-of select="$featureName"/> </xsl:comment><xsl:text>
</xsl:text>
				<dc:relation dc:qualifier="isPartOf" rdf:resource="{$featureURI}"/>
			</rdf:Description>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="relation-exception">
		<xsl:param name="baseXPointer"/>
		<xsl:variable name="exceptionURI"><xsl:value-of select="$baseXPointer"/>exception[@name='<xsl:value-of select="@name"/>']/descr/p[</xsl:variable>
		<xsl:for-each select="descr/p">
			<xsl:text>
</xsl:text>
			<xsl:comment> <xsl:value-of select="normalize-space(.)"/> </xsl:comment><xsl:text>
</xsl:text>
			<dc:relation dc:qualifier="hasPart">
				<xsl:attribute 
                    namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
				    name="resource"><xsl:value-of select="$exceptionURI"/>substring-before(.,':')='<xsl:value-of select="substring-before(.,':')"/>'])</xsl:attribute>
			</dc:relation>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="attribute" mode="interface">
		<xsl:param name="subspecURI"/>
		<xsl:variable name="attrURI" select="concat($subspecURI,concat('#',@id))"/>
		<xsl:variable name="attrName" select="concat(parent::interface/@name,concat('.',@name))"/>
		<xsl:variable name="baseXPointer"><xsl:value-of select="$subspecURI"/>#xpointer(id('<xsl:value-of select="@id"/>')/</xsl:variable>
		<rdf:Description rdf:about="{$attrURI}">
			<dc:title><xsl:value-of select="$attrName"/> attribute</dc:title>
			<dc:description><xsl:value-of select="normalize-space(descr)"/></dc:description>
			<xsl:text>
</xsl:text>
			<xsl:comment> <xsl:value-of select="parent::interface/@name"/> interface </xsl:comment><xsl:text>
</xsl:text>
			<dc:relation dc:qualifier="isPartOf" rdf:resource="{concat($subspecURI,concat('#',parent::interface/@id))}"/>

			<!--  produce about for set exceptions  -->
			<xsl:for-each select="setraises/exception">
				<xsl:call-template name="relation-exception">
					<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'setraises/')"/>
				</xsl:call-template>												
			</xsl:for-each>

			<!--  produce about for get exceptions  -->
			<xsl:for-each select="getraises/exception">
				<xsl:call-template name="relation-exception">
					<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'getraises/')"/>
				</xsl:call-template>
			</xsl:for-each>

		</rdf:Description>

		<!--  produce about for set exceptions  -->
		<xsl:for-each select="setraises/exception">
			<xsl:call-template name="about-exception">
				<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'setraises/')"/>
				<xsl:with-param name="featureName" select="$attrName"/>
				<xsl:with-param name="featureURI" select="$attrURI"/>
			</xsl:call-template>												
		</xsl:for-each>

		<!--  produce about for get exceptions  -->
		<xsl:for-each select="getraises/exception">
			<xsl:call-template name="about-exception">
				<xsl:with-param name="baseXPointer" select="concat($baseXPointer,'getraises/')"/>
				<xsl:with-param name="featureName" select="$attrName"/>
				<xsl:with-param name="featureURI" select="$attrURI"/>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
