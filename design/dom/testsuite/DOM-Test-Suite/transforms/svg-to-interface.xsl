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
This transforms builds interface definitions compatible with 
the DOM spec from the SVG HTML sources (after processing by
SED to make them valid XML)


Usage:

saxon -o coords.xml svg-interfaces.xml svg-to-interface.xsl


-->

<!--
$Log: svg-to-interface.xsl,v $
Revision 1.1  2001-07-20 05:44:32  dom-ts-4
Initial SVG support.  multiply renamed mult,
All implementation conditions combined into implementationAttribute element

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="dom2-interfaces"/>
	<xsl:output method="xml" indent="yes"/>
	<xsl:variable name="specURI">http://www.w3.org/TR/2001/PR-SVG-20010719/</xsl:variable>

	<!--  match document root    -->
	<xsl:template match="/">
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
		<xsl:comment>This file is an extract of interface definitions from <xsl:value-of select="$specURI"/></xsl:comment>
		<!--  must enclose interface elements in
		       some container, chose library ala COM 
			   Type Library   -->
		<library>
			<xsl:apply-templates select="document('coords.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>coords.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('animate.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>animate.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('color.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>color.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('extend.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>extend.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('filters.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>filters.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('interact.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>interact.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('linking.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>linking.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('masking.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>masking.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('painting.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>painting.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('paths.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>paths.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('pservers.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>pservers.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('script.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>script.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('shapes.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>shapes.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('struct.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>struct.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('styling.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>styling.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('text.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>text.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:apply-templates select="document('types.xml',.)/*">
				<xsl:with-param name="baseURI"><xsl:value-of select="$specURI"/>types.html#</xsl:with-param>
			</xsl:apply-templates>
			<xsl:comment>The following is copied from dom2-interfaces.xml</xsl:comment>
			<xsl:apply-templates select="document($dom2-interfaces)/library" mode="copy"/>
		</library>
	</xsl:template>
	
	<xsl:template match="a[substring(@name,1,9) = 'Interface']">
		<xsl:param name="baseURI"/>
		<interface id="{concat($baseURI,@name)}" name="{substring(@name,10)}">
			<xsl:variable name="def" select="following-sibling::dl[1]"/>
			<xsl:for-each select="$def/dd/dl/dt[span[@class='dom-attr-name']]">
				<attribute type="{span[@class='dom-attr-type']}"
				    name="{span[@class='dom-attr-name']}">
					<xsl:if test="descendant::span[@class='dom-readonly']">
						<xsl:attribute name="readonly">yes</xsl:attribute>
					</xsl:if>
					<xsl:variable name="setraises" select="following-sibling::dd[1]/dl/dd/table[@summary='attribute setting exceptions']"/>
					<xsl:if test="$setraises">
						<setraises>
							<xsl:for-each select="$setraises/tr[td/span[@class='dom-exception-type']]">
								<exception name="{td/span[@class='dom-exception-type']}">
									<descr>
										<xsl:for-each select="td[3]/div">
											<p><xsl:value-of select="normalize-space(.)"/></p>
										</xsl:for-each>
									</descr>
								</exception>
							</xsl:for-each>
						</setraises>
					</xsl:if>

				</attribute>
			</xsl:for-each>

			<xsl:for-each select="$def/dd/dl/dt[span[@class='dom-method-name']]">
				<method name="{span[@class='dom-method-name']}">
					<descr><xsl:apply-templates select="following-sibling::dd[1]" mode="descr"/></descr>
					<xsl:variable name="parameters" select="following-sibling::dd[1]/dl/dd/table[@summary='method parameters']"/>
					<xsl:if test="$parameters">
						<parameters>
							<xsl:for-each select="$parameters/tr">
								<param name="{descendant::span[@class='dom-parameter-name']}"
								       type="{descendant::span[@class='dom-parameter-type']}"
									   attr="{normalize-space(td/text()[1])}"/>
							</xsl:for-each>
						</parameters>
					</xsl:if>
					<xsl:variable name="returns" select="following-sibling::dd[1]/dl/dd/table[@summary='method return value']"/>
					<xsl:if test="$returns">
						<returns type="{normalize-space($returns/descendant::span[@class='dom-returnvalue-type'])}">
							<p><xsl:value-of select="normalize-space($returns/tr[1]/td[3])"/></p>
						</returns>
					</xsl:if>
					<xsl:variable name="exceptions" select="following-sibling::dd[1]/dl/dd/table[@summary='method exceptions']"/>
					<xsl:if test="$exceptions">
						<raises>
							<xsl:for-each select="$exceptions/tr">
								<exception name="{td/span[@class='dom-exception-type']}">
									<descr>
										<xsl:for-each select="td[3]/div">
											<p><xsl:value-of select="normalize-space(.)"/></p>
										</xsl:for-each>
									</descr>
								</exception>
							</xsl:for-each>
						</raises>
					</xsl:if>
				</method>
			</xsl:for-each>

		</interface>
	</xsl:template>

	<!--   if unrecognized element, apply templates to children  -->	       
	<xsl:template match="*">
		<xsl:param name="baseURI"/>
		<xsl:apply-templates select="*">
			<xsl:with-param name="baseURI" select="$baseURI"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="p" mode="descr">
		<p><xsl:value-of select="normalize-space(.)"/></p>
	</xsl:template>

	<xsl:template match="*" mode="descr">
		<xsl:apply-templates select="*" mode="descr"/>
	</xsl:template>

	<xsl:template match="*" mode="copy">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*" mode="copy"/>
			<xsl:apply-templates select="*|text()" mode="copy"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="library" mode="copy">
		<xsl:apply-templates select="*" mode="copy"/>
	</xsl:template>


	<xsl:template match="@*" mode="copy">
		<xsl:attribute name="{local-name()}" namespace="{namespace-uri(.)}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
