<?xml version="1.0" encoding="ISO-8859-1"?>
<!--
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
-->

<!--   
This transforms generates an XML Schema for a DOM test definition
language from  an DOM specification.

DOM recommendations are defined in XML and the XML source for these
specifications is available within the .zip version of the specification.

For example, the DOM Level 1 .zip file, 
http://www.w3.org/TR/1998/REC-DOM-Level-1-19981001/DOM.zip 
contains a nested file, xml-source.zip, which contains an
XML file, wd-dom.xml which expresses the DOM recommendation
in XML.  (Note: most of the other .xml files are external 
entities expanded by one enclosing document).


Usage:

saxon -o dom1-test.xsd wd-dom.xml dom-to-schema.xsl


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<xsl:param name="schema-namespace">http://www.w3.org/2001/DOM-Test-Suite/Level-X</xsl:param>


	<!--   symbolic constant for schema namespace   -->
	<xsl:variable name="source" select="/spec/header/publoc/loc[1]/@href"/>
	<xsl:output method="xml" indent="yes" 
		doctype-system="http://www.w3.org/2001/XMLSchema.dtd" 
		doctype-public="-//W3C//DTD XMLSCHEMA 200102//EN"
		encoding="UTF-8"/>


	<!--  interfaces defined in DOM recommendation  -->
	<xsl:variable name="interfaces" select="//interface"/>
	<!--  attributes defined in DOM recommendation  -->
	<xsl:variable name="attributes" select="//attribute"/>
	<!--  methods defined in DOM recommendation  -->
	<xsl:variable name="methods" select="//method"/>
    <xsl:variable name="features" select="//*[name() = 'method' or name() = 'attribute']"/>
	<xsl:variable name="exceptions" select="//exception[@id]"/>

	<!--  methods keyed by name           -->
	<xsl:key name="methodByName" match="//method[@name]" use="@name"/>
	<!--  attributes and methods keyed by name        -->
	<xsl:key name="featureByName" match="//*[(name()='attribute' or name()='method') and @name]" use="@name"/>

    <!--   list method names (such as EventHandler) that
               are implemented by the caller, not by the DOM implementation
               must provide leading and trailing space    -->              
    <xsl:variable name="sink-interfaces"> EventListener LSResourceResolver LSParserFilter LSSerializerFilter NodeFilter DOMErrorHandler </xsl:variable>

	<!--   match document root   -->
	<xsl:template match="/">
		<xs:schema targetNamespace="{$schema-namespace}" 
			_xmlns="{$schema-namespace}" 
            _xmlns_test="{$schema-namespace}"
			elementFormDefault="qualified">
		<xsl:comment>
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
</xsl:comment><xsl:text>

</xsl:text>
		<xsl:comment>This schema was generated from <xsl:value-of select="$source"/> by dom-to-xsd.xsl.</xsl:comment><xsl:text>

</xsl:text>

			<!--   produce fixed simpleType definitions    -->
			<xsl:call-template name="static-simpleTypes"/>
			<!--   produce simpleType definitions that depend on the source document  -->
			<xsl:call-template name="dynamic-simpleTypes"/>
			<!--   produce fixed element definitions        -->			
			<xsl:call-template name="static-elements"/>
			<!--   produce element definitions that depend on the source document    -->
			<xsl:call-template name="dynamic-elements"/>
			<!--   generate assertion elements that depend on the source document    -->
			<xsl:call-template name="dynamic-assertions"/>

			<!--   produce elements that correspond to DOM attributes   -->
			<xsl:call-template name="produce-properties"/>
			<!--   produce elements that correspond to DOM methods     -->
			<xsl:call-template name="produce-methods"/>
		</xs:schema>
	</xsl:template>

    <!--  
             produces a element definition for a property of an interface  
    -->
    <xsl:template name="produce-property">
		<!--  create an element whose tag name is the same as the attribute  -->
		<xs:element name="{@name}">
			<xs:complexType>
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xsl:choose>
					<xsl:when test="@name = 'contentType'">
						<xs:attribute name="obj" type="variable" use="optional"/>
						<xs:attribute name="type" type="loadContentType" use="optional"/>
						<xs:attribute name="var" type="variable" use="optional"/>
					</xsl:when>
					
					<xsl:otherwise>
				    
				<xs:attribute name="obj" type="variable" use="required"/>
				<!--  if readonly, only the "var" attribute is produced.
					  Otherwise both a "var" and "value" attribute are produced  -->
				<xsl:choose>
					<xsl:when test="key('featureByName',@name)[not(@readonly) or @readonly!='yes']">
						<xs:attribute name="var" type="variable" use="optional"/>

						<!--  produces a "value" attribute, 
							  the schema type is selected based on the attribute type   -->
						<xsl:call-template name="param-type">
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="paramName">value</xsl:with-param>
							<xsl:with-param name="use">optional</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xs:attribute name="var" type="variable" use="required"/>
					</xsl:otherwise>
				</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>

				<!--  collect all attributes with this name   -->
				<xsl:variable name="dups" select="key('featureByName',@name)"/>

				<!--  produce the "interface" attribute       -->
				<xs:attribute name="interface">
					<!--  choose whether interface is required based
							 on number of interfaces method is introduced by  -->
					<xsl:choose>
						<xsl:when test="@name='length' or @name='data' or @name = 'src'">
							<xsl:attribute name="use">required</xsl:attribute>
						</xsl:when>
						<xsl:when test="@name = 'contentType'">
							<xsl:attribute name="use">optional</xsl:attribute>
						</xsl:when>
							
						<xsl:when test="count($dups) &gt; 1">
							<xsl:attribute name="use">required</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="use">optional</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>

					<!--   create the enumeration of appropriate interface values  -->
					<xs:simpleType>
						<xs:restriction base="xs:string">
							<xsl:for-each select="$dups">
								<xs:enumeration value="{parent::interface/@name}"/>
							</xsl:for-each>
                            <xsl:if test="@name='length'">
                                <xs:enumeration value="DOMString"/>
                            </xsl:if>
                            <xsl:if test="@name='data' or @name = 'src'">
                            	<xs:enumeration value="UserDataNotification"/>
                            </xsl:if>
						</xs:restriction>
					</xs:simpleType>
				</xs:attribute>
			</xs:complexType>
		</xs:element>
    </xsl:template>

	<!--    produce elements that correspond to DOM attributes    
			If the same attribute name is used in multiple contexts,
			for example, target is used both by Event and ProcessingInstruction,
			only one element will be created.  The interface attribute
			will be required to disambiguate.
	-->
    <xsl:template name="produce-properties">
			<!--   generate an schema element for each interface attribute    -->
			<xsl:for-each select="$attributes">
				<xsl:sort select="@name"/>

				<!--   Note: some DOM processors have had problems with current(),
				       so as a kludge, the current context is made an
					   explicit variable and used in place of current()   -->
				<xsl:variable name="current" select="."/>

				<!--  only the first entry creates an entry  -->
				<xsl:if test="not(preceding::attribute[@name=$current/@name]) and @name != 'implementation'">
                    <xsl:call-template name="produce-property"/>
				</xsl:if>
			</xsl:for-each>
	</xsl:template>


	<!--   produce elements for all of the DOM methods.  Identically named
	       methods, for example, Document.getElementsByTagName and 
		   Element.getElementsByTag name will be represented by
		   one element.  Since these are much rarer than identically
		   named attributes and the function signatures are identical
		   for all known instances.  This template assumes that the
		   signature of the first instance is appropriate for all.
	-->
	<xsl:template name="produce-methods">

			<!--  produce an element for all methods  -->
			<xsl:for-each select="$methods[@name != 'hasFeature']">
				<xsl:sort select="@name"/>
				<xsl:variable name="current" select="."/>

				<!--   for only the first occurance of the name   -->
				<xsl:if test="not(preceding::method[@name=$current/@name]) and @name != 'hasFeature' and not(@name = $attributes/@name)">
					
					<!--   create an element whose tag name is the same as the method   -->
					<xs:element name="{@name}">
						<xs:complexType>
							<xs:attribute name="id" type="xs:ID" use="optional"/>


                            <xsl:choose>
                                <!--  if the method name is load,
                                      create a special element that is compatible
                                      with the DOM method and the framework method 
                                -->
                                <xsl:when test="@name = 'load'">
									<xs:attribute name="var" type="variable" use="required"/>
							        <!--  the invocation target attribute is required   -->
							        <xs:attribute name="obj" type="variable" use="optional"/>
                                    <!--  all framework parameters are optional    -->
					                <xs:attribute name="href" type="xs:anyURI" use="optional"/>
					                <xs:attribute name="willBeModified" type="xs:boolean" use="optional">
						                <xs:annotation>
							                <xs:documentation>If true then this test may modify the document, so a fresh copy should be loaded instead of a cached copy.</xs:documentation>
						                </xs:annotation>
					                </xs:attribute>

							        <!--  all DOM method parameters are optional  -->
							        <xsl:for-each select="parameters/param">
								        <!--  need to check that all the types are consistent  -->
								        <xsl:call-template name="param-type">
									        <xsl:with-param name="type" select="@type"/>
									        <xsl:with-param name="paramName" select="@name"/>
									        <xsl:with-param name="use">optional</xsl:with-param>
								        </xsl:call-template>
							        </xsl:for-each>
                                </xsl:when>
                                
                                <xsl:when test="@name = 'contains'">
									<xs:attribute name="var" type="variable" use="optional"/>
                       				<xs:attribute name="obj" type="variable" use="required"/>
                                    <xs:attribute name="str" type="variableOrStringLiteral" use="optional"/>
                                </xsl:when>
                                
                                <xsl:when test="@name = 'evaluate'">
				         			<xs:attribute name="var" type="variable" use="required"/>
				         			<xs:attribute name="obj" type="variable" use="required"/>
				         			<xs:attribute name="expression" type="variableOrStringLiteral" use="optional"/>
				         			<xs:attribute name="contextNode" type="variable" use="required"/>
				         			<xs:attribute name="resolver" type="variable" use="optional"/>
				         			<xs:attribute name="type" type="variableOrIntLiteral" use="required"/>
				         			<xs:attribute name="result" type="variable" use="required"/>
                                </xsl:when>

                                <xsl:otherwise>
									<!--  If the method has a (non-void) return value then
							      		the var attribute is required to receive the return value  -->
									<xsl:if test="returns[@type!='void']">
										<xs:attribute name="var" type="variable" use="required"/>
									</xsl:if>
							        <!--  the invocation target attribute is required   -->
							        <xs:attribute name="obj" type="variable" use="required"/>
							        <!--  for each parameter    -->
							        <xsl:for-each select="parameters/param">
								        <!--  need to check that all the types are consistent  -->
								        <xsl:call-template name="param-type">
									        <xsl:with-param name="type" select="@type"/>
									        <xsl:with-param name="paramName" select="@name"/>
									        <xsl:with-param name="use">required</xsl:with-param>
								        </xsl:call-template>
							        </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>


							<!--  produce interface attribute   -->
							<xsl:choose>
								<xsl:when test="contains(@name, 'getDOMImplementation')">
									<xs:attribute name="interface" use="required">
										<xs:simpleType>
											<xs:restriction base="xs:string">
													<xs:enumeration value="DOMImplementationSource"/>
													<xs:enumeration value="DOMImplementationRegistry"/>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:variable name="dups" select="key('methodByName',@name)"/>
									<xs:attribute name="interface">
										<xsl:choose>
											<xsl:when test="count($dups) &gt; 1 and @name != 'load' and @name != 'contains'">
												<xsl:attribute name="use">required</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="use">optional</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
										<xs:simpleType>
											<xs:restriction base="xs:string">
												<xsl:for-each select="$dups">
													<xs:enumeration value="{parent::interface/@name}"/>
												</xsl:for-each>
												<xsl:if test="@name = 'contains'">
													<xs:enumeration value="DOMString"/>
												</xsl:if>
											</xs:restriction>
										</xs:simpleType>
									</xs:attribute>
								</xsl:otherwise>
							</xsl:choose>
						</xs:complexType>
					</xs:element>
				</xsl:if>
			</xsl:for-each>
	</xsl:template>

	<!--  this template contains simple types that are indepenent
	      of the DOM recommendation.	
	-->
    <xsl:template name="static-simpleTypes">
            <xs:simpleType name="absoluteURI">
			     <xs:restriction base="xs:anyURI">
				     <xs:pattern value="[a-zA-Z]*:.*"/>
				 </xs:restriction>
			</xs:simpleType>

			<!--  all the pattern could be tighter   -->
			<xs:simpleType name="variable">
				<xs:annotation>
					<xs:documentation>A variable name</xs:documentation>
				</xs:annotation>
				<xs:restriction base="xs:string">
					<xs:pattern value="([A-Za-mo-z][A-Za-z0-9_]*)|(n)|(n[^u].*)|(nu[^l].*)|(nul[^l].*)|(null.+)"/>
				</xs:restriction>
			</xs:simpleType>

			<xs:simpleType name="className">
				<xs:annotation>
					<xs:documentation>A class name</xs:documentation>
				</xs:annotation>
				<xs:restriction base="xs:string">
					<xs:pattern value="[A-Za-z_][A-Za-z0-9_]*"/>
				</xs:restriction>
			</xs:simpleType>

			<xs:simpleType name="stringLiteral">
				<xs:annotation>
					<xs:documentation>A string literal.  Distinguished from a variable reference by the enclosing double quotes.  The following subset of Java escape sequences are supported, \", \\, \n</xs:documentation>
				</xs:annotation>
				<xs:restriction base="xs:string">
					<xs:pattern value='"([^"\\]|\\"|\\\\|\\n)*"'/>
				</xs:restriction>
			</xs:simpleType>
			

			<xs:simpleType name="literal">
				<xs:annotation>
					<xs:documentation>The union of accepted literal types</xs:documentation>
				</xs:annotation>
				<xs:union memberTypes="xs:integer xs:boolean xs:double stringLiteral"/>
			</xs:simpleType>
			<xs:simpleType name="variableOrLiteral">
				<xs:union memberTypes="literal variable"/>
			</xs:simpleType>
			<xs:simpleType name="variableOrStringLiteral">
				<xs:union memberTypes="stringLiteral variable"/>
			</xs:simpleType>
			<xs:simpleType name="variableOrIntLiteral">
				<xs:union memberTypes="xs:integer variable"/>
			</xs:simpleType>
			<xs:simpleType name="variableOrBoolLiteral">
				<xs:union memberTypes="xs:boolean variable"/>
			</xs:simpleType>
			<xs:simpleType name="variableOrDoubleLiteral">
				<xs:union memberTypes="xs:double variable"/>
			</xs:simpleType>

			<xs:simpleType name="literalTypes">
				<xs:annotation>
					<xs:documentation>All types with literal representations.</xs:documentation>
				</xs:annotation>
				<xs:restriction base="xs:string">
					<xs:enumeration value="int"/>
					<xs:enumeration value="short"/>
					<xs:enumeration value="double"/>
                    <xs:enumeration value="boolean"/>
					<xs:enumeration value="DOMString"/>
				</xs:restriction>
			</xs:simpleType>

   </xsl:template>

	<!--   this template generates any simple types
	       that are dependent on the source document.  Currently only
		   the allowable types for variables    -->
	<xsl:template name="dynamic-simpleTypes">
			<xs:simpleType name="variableType">
				<xs:annotation>
					<xs:documentation>All known DOM interfaces plus int, DOMString maybe some others.</xs:documentation>
				</xs:annotation>
				<xs:restriction base="xs:string">
					<xs:enumeration value="int"/>
					<xs:enumeration value="short"/>
					<xs:enumeration value="double"/>
                    <xs:enumeration value="boolean"/>
					<xs:enumeration value="DOMString"/>
					<xs:enumeration value="List">
						<xs:annotation>
							<xs:documentation>A List variable is used to compare two ordered collections, such as the expected and actual child element names.</xs:documentation>
						</xs:annotation>
					</xs:enumeration>
					<xs:enumeration value="Collection">
						<xs:annotation>
							<xs:documentation>A collection variable is used to compare two unordered collections, such as the expected and actual attribute names.</xs:documentation>
						</xs:annotation>
					</xs:enumeration>
					<xs:enumeration value="EventMonitor">
						<xs:annotation>
							<xs:documentation>An implementation of EventListener that will capture and store all events encountered.</xs:documentation>
						</xs:annotation>
					</xs:enumeration>
                    <!--   DOM 3 Core and LS defines some new platform pseudo types   -->
                    <xsl:if test="$schema-namespace='http://www.w3.org/2001/DOM-Test-Suite/Level-3'">
					    <xs:enumeration value="LSInputStream"/>
                        <xs:enumeration value="LSOutputStream"/>
                        <xs:enumeration value="LSReader"/>
                        <xs:enumeration value="LSWriter"/>
                        <xs:enumeration value="DOMUserData"/>
                        <xs:enumeration value="DOMObject"/>
                        <xs:enumeration value="DOMImplementationRegistry"/>
                        <xs:enumeration value="DOMErrorMonitor"/>
                        <xs:enumeration value="UserDataMonitor"/>
                        <xs:enumeration value="UserDataNotification"/>
                    </xsl:if>
					<xsl:for-each select="$interfaces">
						<xsl:sort select="@name"/>
						<xs:enumeration value="{@name}"/>
					</xsl:for-each>
				</xs:restriction>
			</xs:simpleType>
	</xsl:template>

	<!--   This template contains the elements that are 
	       independent of the source document.  Examples of these
		   elements are <test>, <var>, <assign>, etc.
	-->
    <xsl:template name="static-elements">
            <xs:simpleType name="loadContentType">
                <xs:restriction base="xs:string">
                    <xs:enumeration value="text/xml">
                        <xs:annotation>
                            <xs:documentation>Generic XML</xs:documentation>
                        </xs:annotation>
                    </xs:enumeration>
                    <xs:enumeration value="image/svg+xml">
                        <xs:annotation>
                            <xs:documentation>SVG</xs:documentation>
                        </xs:annotation>
                    </xs:enumeration>
                    <xs:enumeration value="text/html">
                        <xs:annotation>
                            <xs:documentation>HTML</xs:documentation>
                        </xs:annotation>
                    </xs:enumeration>
                    <xs:enumeration value="application/pdf">
                        <xs:annotation>
                            <xs:documentation>Portable Document Format</xs:documentation>
                        </xs:annotation>
                    </xs:enumeration>
                </xs:restriction>
            </xs:simpleType>

			<xs:element name="test">
				<xs:annotation>
					<xs:documentation>A test.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:choice minOccurs="0" maxOccurs="unbounded">
							<xs:element ref="hasFeature"/>
							<xs:element ref="implementationAttribute"/>
						</xs:choice>
						<xs:element ref="var" minOccurs="0" maxOccurs="unbounded"/>
						<xs:choice>
							<xs:element ref="load"/>
							<xs:element ref="implementation"/>
							<xs:element ref="DOMImplementationRegistry.newInstance"/>
						</xs:choice>
						<xs:group ref="statement" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="name" type="className" use="required">
						<xs:annotation>
							<xs:documentation>Used in method name in generated code.</xs:documentation>
						</xs:annotation>
					</xs:attribute>
				</xs:complexType>
                <!--  variables must be uniquely named   -->
                <xs:key name="var-name">
                    <xs:selector xpath="./test:var"/>
                    <xs:field xpath="@name"/>
                </xs:key>
                <!--  all var attributes must correspond to a previously declared variable  -->
                <xs:keyref name="var-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@var"/>
                </xs:keyref>
                <!--  all obj attributes must correspond to a previously declared variable  -->
                <xs:keyref name="obj-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@obj"/>
                </xs:keyref>
                <!--  all actual attributes must correspond to a previously declared variable  -->
                <xs:keyref name="actual-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@actual"/>
                </xs:keyref>
                <!--  all collection attributes must correspond to a previously declared variable  -->
                <xs:keyref name="collection-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@collection"/>
                </xs:keyref>
                <!--  all member attributes must correspond to a previously declared variable  -->
                <xs:keyref name="member-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@member"/>
                </xs:keyref>
                <!--  all refChild attributes must correspond to a previously declared variable  -->
                <xs:keyref name="refChild-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@refChild"/>
                </xs:keyref>
                <!--  all doctype attributes must correspond to a previously declared variable  -->
                <xs:keyref name="doctype-attrib" refer="var-name">
                    <xs:selector xpath="./*"/>
                    <xs:field xpath="@doctype"/>
                </xs:keyref>
			</xs:element>

			<xs:element name="suite.member">
				<xs:annotation>
					<xs:documentation>A member of a test suite, either a individual test or another suite.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="href" type="xs:anyURI" use="required"/>
				</xs:complexType>
			</xs:element>

			<xs:element name="suite">
				<xs:annotation>
					<xs:documentation>A suite of tests</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:choice minOccurs="0" maxOccurs="unbounded">
							<xs:element ref="hasFeature"/>
							<xs:element ref="implementationAttribute"/>
						</xs:choice>
						<xs:choice minOccurs="0" maxOccurs="unbounded">
							<xs:element ref="suite.member"/>
						</xs:choice>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="name" type="className" use="required">
						<xs:annotation>
							<xs:documentation>Used in method name in generated code.</xs:documentation>
						</xs:annotation>
					</xs:attribute>
				</xs:complexType>
			</xs:element>

			<xs:element name="package">
				<xs:annotation>
					<xs:documentation>A package of tests in one resource</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:choice minOccurs="0" maxOccurs="unbounded">
							<xs:element ref="test"/>
							<xs:element ref="suite"/>
						</xs:choice>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>

			<xs:element name="comment">
				<xs:annotation>
					<xs:documentation>Injects comment into generated code.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:simpleContent>
						<xs:extension base="xs:string">
							<xs:attribute name="id" type="xs:ID" use="optional"/>
						</xs:extension>
					</xs:simpleContent>
				</xs:complexType>
			</xs:element>
			<xs:element name="wait">
				<xs:annotation>
					<xs:documentation>Attempts to pause for a specified period</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="milliseconds" type="xs:positiveInteger" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="append">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="collection" type="variable" use="required"/>
					<xs:attribute name="item" type="variableOrLiteral" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:complexType name="unaryAssignment">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="var" type="variable" use="required"/>
				<xs:attribute name="value" type="variableOrLiteral" use="required"/>
			</xs:complexType>
			<xs:element name="assign">
				<xs:annotation>
					<xs:documentation>Assigns the specified value or condition to the a variable.  If both are specified, the value will be AND'd with the condition.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:group ref="condition" minOccurs="0"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="var" type="variable" use="required"/>
					<xs:attribute name="value" type="variableOrLiteral" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="increment" type="unaryAssignment"/>
			<xs:element name="decrement" type="unaryAssignment"/>
			<xs:complexType name="binaryAssignment">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="var" type="variable" use="required"/>
				<xs:attribute name="op1" type="variableOrLiteral" use="required"/>
				<xs:attribute name="op2" type="variableOrLiteral" use="required"/>
			</xs:complexType>
			<!--  can't be add since that conflicts with HTMLSelectElement.add  -->
			<xs:element name="plus" type="binaryAssignment"/>
			<xs:element name="subtract" type="binaryAssignment"/>
			<xs:element name="mult" type="binaryAssignment"/>
			<xs:element name="divide" type="binaryAssignment"/>
			<!--  can't be declare since that conflicts with HTMLObjectElement.declare --> 
            <xs:complexType name="sinkMethod">
                <xs:sequence>
                    <xs:element maxOccurs="unbounded" minOccurs="0" ref="var"/>
                    <xs:group maxOccurs="unbounded" minOccurs="0" ref="statement"/>
                </xs:sequence>
            </xs:complexType>

            <xs:complexType name="sinkAttribute">
                <xs:sequence>
                    <xs:element name="get">
                        <xs:complexType>
                            <xs:sequence>
                                <xs:element maxOccurs="unbounded" minOccurs="0" ref="var"/>
                                <xs:group maxOccurs="unbounded" minOccurs="0" ref="statement"/>
                            </xs:sequence>
                        </xs:complexType>
                    </xs:element>
                    <xs:element name="set">
                        <xs:complexType>
                            <xs:sequence>
                                <xs:element maxOccurs="unbounded" minOccurs="0" ref="var"/>
                                <xs:group maxOccurs="unbounded" minOccurs="0" ref="statement"/>
                            </xs:sequence>
                        </xs:complexType>
                    </xs:element>
                </xs:sequence>
            </xs:complexType>

            <xs:complexType name="sinkReadOnlyAttribute">
                <xs:sequence>
                    <xs:element name="get">
                        <xs:complexType>
                            <xs:sequence>
                                <xs:element maxOccurs="unbounded" minOccurs="0" ref="var"/>
                                <xs:group maxOccurs="unbounded" minOccurs="0" ref="statement"/>
                            </xs:sequence>
                        </xs:complexType>
                    </xs:element>
                </xs:sequence>
            </xs:complexType>


            <xs:element name="return">
                <xs:complexType>
                    <xs:sequence/>
                    <xs:attribute name="value" type="variableOrLiteral" use="optional"/>
                </xs:complexType>
            </xs:element>
			<xs:element name="var">
				<xs:annotation>
					<xs:documentation>Declare and optionally initialize a variable.  [Tenative] All variables must be declared.  Use instanceOf for type assertions.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:choice minOccurs="0">
						<xs:element ref="member" maxOccurs="unbounded"/>
                        <xsl:variable name="sinks" select="$interfaces[contains($sink-interfaces,concat(' ',concat(@name,' ')))]"/>
                        <xsl:if test="$sinks">
                            <xs:sequence>
                                <xs:element ref="var" minOccurs="0" maxOccurs="unbounded"/>
                                <!--  define elements for every method in user implemented interfaces
                                    used like anonymous inner class definitions  -->
                                <xs:choice>
                                    <xsl:for-each select="$sinks[not(@inherits)]">
                                        <xs:sequence>
                                            <xsl:call-template name="produce-sink">
                                                <xsl:with-param name="sinks" select="$sinks"/>
                                            </xsl:call-template>
                                        </xs:sequence>
                                    </xsl:for-each>
                                </xs:choice>
                            </xs:sequence>
                        </xsl:if>
                    </xs:choice>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="name" type="variable" use="required"/>
					<xs:attribute name="type" type="variableType" use="required"/>
					<xs:attribute name="value" type="variableOrLiteral" use="optional"/>
                    <xs:attribute name="isNull" type="xs:boolean" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="member">
				<xs:annotation>
					<xs:documentation>Member children are used to initialize List and Collection types.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:simpleContent>
						<xs:extension base="literal">
							<xs:attribute name="type" type="literalTypes" use="optional"/>
						</xs:extension>
					</xs:simpleContent>
				</xs:complexType>
			</xs:element>
            <!--   
                if there is not a load method in the spec
                   then produce a load element that uses the
                   test framework loader    -->
            <xsl:if test="not(key('methodByName','load'))">
			    <xs:element name="load">
				    <xs:annotation>
					    <xs:documentation>Loads the document declared in the corresponding document element.</xs:documentation>
				    </xs:annotation>
				    <xs:complexType>
					    <xs:attribute name="var" type="variable" use="required"/>
					    <xs:attribute name="href" type="xs:anyURI" use="required"/>
					    <xs:attribute name="willBeModified" type="xs:boolean" use="required">
						    <xs:annotation>
							    <xs:documentation>If true then this test may modify the document, so a fresh copy should be loaded instead of a cached copy.</xs:documentation>
						    </xs:annotation>
					    </xs:attribute>
				    </xs:complexType>
			    </xs:element>
            </xsl:if>
			<xs:element name="implementation">
				<xs:annotation>
					<xs:documentation>Gets a DOMImplementation.  If the obj attribute is not specified, it creates a default implementation as determined by the test framework.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="var" type="variable" use="required"/>
					<xs:attribute name="obj" type="variable" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="DOMImplementationRegistry.newInstance">
				<xs:annotation>
					<xs:documentation>Gets a DOMImplementationRegistry instance.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="var" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="metadata">
				<xs:complexType>
					<xs:choice minOccurs="0" maxOccurs="unbounded">
						<xs:element ref="metadata"/>						
						<!-- xs:any namespace="http://www.w3.org/1999/02/22-rdf-syntax-ns#" processContents="lax"/ -->
						<!--  omitted a few DC elements that seemed extraneous  -->
						<!--  title is done locally to avoid conflicts with the HTMLDocument.title   -->
						<xs:element name="title" type="rdf-statement">
							<xs:annotation>
								<xs:documentation>Name given to the test.</xs:documentation>
							</xs:annotation>
						</xs:element>
						<xs:element ref="creator"/>
						<xs:element ref="subject"/>
						<xs:element ref="description"/>
						<xs:element ref="contributor"/>
						<xs:element ref="date"/>
						<xs:element ref="source"/>
						<xs:element ref="relation"/>
					</xs:choice>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="about" type="xs:anyURI" use="optional"/>
				</xs:complexType>
			</xs:element>
			<!--   this is patterned after RDF's representation in XML   -->
			<xs:complexType name="rdf-statement">
				<xs:simpleContent>
				    <xs:extension base="xs:string">
						<xs:attribute name="id" type="xs:ID" use="optional"/>
						<xs:attribute name="resource" type="absoluteURI" use="optional"/>
						<xs:attribute name="type" type="absoluteURI" use="optional"/>
					</xs:extension>
				</xs:simpleContent>
			</xs:complexType>
			<!--   the semantics of these elements are based on Dublin Core  -->
			<xs:element name="creator" type="rdf-statement">
				<xs:annotation>
					<xs:documentation>Entity primarily responsible for making the test definition.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="subject" type="rdf-statement">
				<xs:annotation>
					<xs:documentation>One topic of the test.  May be repeated.  Preferably, a URI identifing a particular section of the DOM specification.</xs:documentation>
				</xs:annotation>
			</xs:element>

			<xs:element name="description" type="rdf-statement">
				<xs:annotation>
					<xs:documentation>A free-text account of the test.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="contributor" type="rdf-statement">
				<xs:annotation>
					<xs:documentation>An entity responsible for making contributions to the test.</xs:documentation>
				</xs:annotation>
			</xs:element>

			<xs:simpleType name="dateQualifier">
				<xs:restriction base="xs:string">
					<xs:enumeration value="created"/>
					<xs:enumeration value="valid"/>
					<xs:enumeration value="available"/>
					<xs:enumeration value="issued"/>
					<xs:enumeration value="modified"/>
				</xs:restriction>
			</xs:simpleType>

			<xs:element name="date">
				<xs:annotation>
					<xs:documentation>A reference to a rest from which the current test is derived.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:simpleContent>
						<xs:extension base="xs:date">
							<xs:attribute name="id" type="xs:ID" use="optional"/>
							<xs:attribute name="qualifier" use="required" type="dateQualifier"/>
						</xs:extension>
					</xs:simpleContent>
				</xs:complexType>
			</xs:element>
							
			<xs:element name="source" type="rdf-statement">
				<xs:annotation>
					<xs:documentation>A reference to a rest from which the current test is derived.</xs:documentation>
				</xs:annotation>
			</xs:element>

			<xs:simpleType name="relationQualifier">
				<xs:restriction base="xs:string">
					<xs:enumeration value="isVersionOf"/>
					<xs:enumeration value="hasVersion"/>
					<xs:enumeration value="isReplacedBy"/>
					<xs:enumeration value="isRequiredBy"/>
					<xs:enumeration value="requires"/>
					<xs:enumeration value="isPartOf"/>
					<xs:enumeration value="hasPart"/>
					<xs:enumeration value="isReferenceBy"/>
					<xs:enumeration value="references"/>
				</xs:restriction>
			</xs:simpleType>


			<xs:element name="relation">
				<xs:annotation>
					<xs:documentation>A reference to a rest from which the current test is derived.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:simpleContent>
					    <xs:extension base="xs:string">
							<xs:attribute name="id" type="xs:ID" use="optional"/>
							<xs:attribute name="resource" type="absoluteURI" use="optional"/>
							<xs:attribute name="type" type="absoluteURI" use="optional"/>
							<xs:attribute name="qualifier" use="required" type="relationQualifier"/>
						</xs:extension>
					</xs:simpleContent>
				</xs:complexType>
			</xs:element>

			<xs:element name="fail">
				<xs:annotation>
					<xs:documentation>Will unconditionally fail the test.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:complexType name="assertTrueFalse">
				<xs:sequence>
					<xs:group ref="condition" minOccurs="0"/>
                    <!-- can't do this since hasFeature is both a condition and a statement  -->
					<!-- xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/ -->
				</xs:sequence>
				<xs:attribute name="id" type="xs:ID" use="required"/>
				<xs:attribute name="actual" type="variable" use="optional"/>
			</xs:complexType>
			<xs:element name="assertTrue" type="assertTrueFalse">
				<xs:annotation>
					<xs:documentation>Will result in the test failing unless the condition expression content and  the value of the variable specified in the "actual" attribute are either absent or true.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="assertFalse" type="assertTrueFalse">
				<xs:annotation>
					<xs:documentation>Will result in the test failing unless the condition expression content or the value of the variable specified in the "actual" attribute is false.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:complexType name="unaryAssertion">
				<xs:sequence>
					<xs:element ref="metadata" minOccurs="0"/>
					<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
				</xs:sequence>
				<xs:attribute name="actual" type="variable" use="required"/>
				<xs:attribute name="id" type="xs:ID" use="required"/>
			</xs:complexType>
			<xs:element name="assertNull" type="unaryAssertion"/>
			<xs:element name="assertNotNull" type="unaryAssertion"/>
			<xs:complexType name="comparisonAssertion">
				<xs:sequence>
					<xs:element ref="metadata" minOccurs="0"/>
					<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
				</xs:sequence>
				<xs:attribute name="actual" type="variable" use="required"/>
				<xs:attribute name="expected" type="variableOrLiteral" use="required"/>
				<xs:attribute name="id" type="xs:ID" use="required"/>
			</xs:complexType>
			<xs:element name="assertSame">
				<xs:annotation>
					<xs:documentation>This asserts that the parameters reference the same object.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="actual" type="variable" use="required"/>
					<xs:attribute name="expected" type="variable" use="required"/>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="assertInstanceOf">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="obj" type="variable" use="required"/>
					<xs:attribute name="type" type="variableType" use="required"/>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="assertSize">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="collection" type="variable" use="required"/>
					<xs:attribute name="size" type="variableOrIntLiteral" use="required"/>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:complexType name="comparisonAssertionWithCase">
				<xs:attribute name="actual" type="variable" use="required"/>
				<xs:attribute name="expected" type="variableOrLiteral" use="required"/>
				<xs:attribute name="id" type="xs:ID" use="required"/>
				<xs:attribute name="ignoreCase" use="required" type="ignoreCaseEnum"/>
				<xs:attribute name="context" use="optional" type="ignoreCaseContext"/>
				<xs:attribute name="bitmask" use="optional" type="xs:integer"/>
			</xs:complexType>
			<xs:element name="assertEquals" type="comparisonAssertionWithCase"/>
			<xs:element name="assertNotEquals" type="comparisonAssertionWithCase"/>
			<xs:element name="assertEventCount">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="atCount" type="variableOrIntLiteral" use="optional"/>
					<xs:attribute name="captureCount" type="variableOrIntLiteral" use="optional"/>
					<xs:attribute name="bubbleCount" type="variableOrIntLiteral" use="optional"/>
					<xs:attribute name="totalCount" type="variableOrIntLiteral" use="optional"/>
					<xs:attribute name="monitor" type="variable" use="required"/>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="assertURIEquals">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
					</xs:sequence>
					<xs:attribute name="actual" type="variable" use="required"/>
					<xs:attribute name="scheme" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="path" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="host" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="file" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="name" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="query" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="fragment" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="isAbsolute" type="variableOrBoolLiteral" use="optional"/>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>

            <xs:element name="assertImplementationException">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
                        <xs:group ref="statement" minOccurs="1" maxOccurs="1"/>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
            </xs:element>

			<xs:group name="framework-assertion">
				<xs:choice>
				    <xs:element ref="fail"/>
					<xs:element ref="assertTrue"/>
					<xs:element ref="assertFalse"/>
					<xs:element ref="assertNull"/>
					<xs:element ref="assertNotNull"/>
					<xs:element ref="assertEquals"/>
					<xs:element ref="assertNotEquals"/>
					<xs:element ref="assertSame"/>
					<xs:element ref="assertInstanceOf"/>
					<xs:element ref="assertSize"/>
					<xs:element ref="assertEventCount"/>
					<xs:element ref="assertURIEquals"/>
                    <xs:element ref="assertImplementationException"/>
				</xs:choice>
			</xs:group>
			<xs:group name="framework-statement">
				<xs:choice>
					<xs:element ref="assign"/>
					<xs:element ref="increment"/>
					<xs:element ref="decrement"/>
					<xs:element ref="append"/>
					<xs:element ref="plus"/>
					<xs:element ref="subtract"/>
					<xs:element ref="mult"/>
					<xs:element ref="divide"/>
					<xs:element ref="load"/>
					<xs:element ref="implementation"/>
					<xs:element ref="hasFeature"/>
					<xs:element ref="if"/>
					<xs:element ref="try"/>
					<xs:element ref="while"/>
					<xs:element ref="for-each"/>
					<xs:element ref="comment"/>
                    <xs:element ref="return"/>
					<xs:element ref="atEvents"/>
					<xs:element ref="capturedEvents"/>
					<xs:element ref="bubbledEvents"/>
					<xs:element ref="allEvents"/>
					<xs:element ref="allNotifications"/>
					<xs:element ref="allErrors"/>
					<xs:element ref="assertLowerSeverity"/>
					<xs:element ref="operation"/>
					<xs:element ref="key"/>
					<xs:element ref="dst"/>
					<xs:element ref="createXPathEvaluator"/>
					<xs:element ref="getResourceURI"/>
					<xs:element ref="substring"/>
					<xs:element ref="createTempURI"/>
					<xsl:if test="not($attributes[@name = 'src'])">
						<xs:element ref="src"/>
					</xsl:if>
					<xsl:if test="not($attributes[@name = 'data'])">
						<xs:element ref="data"/>
					</xsl:if>
				</xs:choice>
			</xs:group>

			<xs:complexType name="comparison">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="actual" type="variable" use="required"/>
				<xs:attribute name="expected" type="variableOrLiteral" use="required"/>
			</xs:complexType>
			<xs:element name="same">
				<xs:annotation>
					<xs:documentation>Object identity comparison</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="actual" type="variable" use="required"/>
					<xs:attribute name="expected" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
            <xs:simpleType name="ignoreCaseEnum">
                <xs:restriction base="xs:string">
                    <xs:enumeration value="true"/>
                    <xs:enumeration value="false"/>
                    <xs:enumeration value="auto">
                        <xs:annotation>
                            <xs:documentation>If auto, the comparision will perform case folding 
                            as appropriate for the content type.  Case insensitive for contentType="text/html",
                            case sensitive for all others.</xs:documentation>
                        </xs:annotation>
                    </xs:enumeration>
                </xs:restriction>
            </xs:simpleType>
            <xs:simpleType name="ignoreCaseContext">
                <xs:restriction base="xs:string">
                    <xs:enumeration value="attribute"/>
                    <xs:enumeration value="element"/>
                </xs:restriction>
            </xs:simpleType>
			<xs:complexType name="comparisonWithCase">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="actual" type="variable" use="required"/>
				<xs:attribute name="expected" type="variableOrLiteral" use="required"/>
				<xs:attribute name="ignoreCase" use="required" type="ignoreCaseEnum"/>
				<xs:attribute name="context" use="optional" type="ignoreCaseContext"/>
				<xs:attribute name="bitmask" use="optional" type="xs:integer"/>
			</xs:complexType>
			<xs:element name="equals" type="comparisonWithCase">
				<xs:annotation>
					<xs:documentation>Value comparison, element-wise on collections.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="notEquals" type="comparisonWithCase"/>
			<xs:element name="less" type="comparison">
				<xs:annotation>
					<xs:documentation>Actual is less than to expected.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="lessOrEquals" type="comparison">
				<xs:annotation>
					<xs:documentation>Actual is less than or equal to expected.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="greaterOrEquals" type="comparison">
				<xs:annotation>
					<xs:documentation>Actual is greater than or equal to expected.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:element name="greater" type="comparison">
				<xs:annotation>
					<xs:documentation>Actual is greater than expected.</xs:documentation>
				</xs:annotation>
			</xs:element>
			<xs:complexType name="unaryComparison">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="obj" type="variable" use="required"/>
			</xs:complexType>
			<xs:element name="isNull" type="unaryComparison"/>
			<xs:element name="notNull" type="unaryComparison"/>
			<xs:element name="instanceOf">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="obj" type="variable" use="required"/>
					<xs:attribute name="type" type="variableType" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="hasSize">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="obj" type="variable" use="required"/>
					<xs:attribute name="expected" type="variableOrIntLiteral" use="required"/>
				</xs:complexType>
			</xs:element>



			<xs:element name="implementationAttribute">
				<xs:complexType>
					<xs:attribute name="name" use="required">
						<xs:simpleType>
							<xs:restriction base="xs:string">
								<xs:enumeration value="validating"/>
								<xs:enumeration value="coalescing"/>
								<xs:enumeration value="expandEntityReferences"/>
								<xs:enumeration value="namespaceAware"/>
								<xs:enumeration value="ignoringElementContentWhitespace"/>
								<xs:enumeration value="signed"/>
								<xs:enumeration value="hasNullString"/>
								<xs:enumeration value="schemaValidating"/>
								<xs:enumeration value="ignoringComments"/>
							</xs:restriction>
						</xs:simpleType>
					</xs:attribute>
					<xs:attribute name="value" use="required" type="xs:boolean"/>
					<xs:attribute name="id" use="optional" type="xs:ID"/>
				</xs:complexType>
			</xs:element>

			<xs:element name="hasFeature">
				<xs:annotation>
					<xs:documentation>hasFeature is used both as a property of a DOMImplementation (when obj and var attributes are provided) and as a implementationCondition.</xs:documentation>
				</xs:annotation>
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="feature" type="variableOrStringLiteral" use="required"/>
					<xs:attribute name="version" type="variableOrStringLiteral" use="optional"/>
                    <xs:attribute name="value" type="xs:boolean" use="optional"/>
					<xs:attribute name="var" type="variable" use="optional"/>
					<xs:attribute name="obj" type="variable" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="not">
				<xs:complexType>
					<xs:group ref="condition"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="isTrue">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="value" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="isFalse">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="value" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="or">
				<xs:complexType>
					<xs:group ref="condition" minOccurs="2" maxOccurs="unbounded"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="and">
				<xs:complexType>
					<xs:group ref="condition" minOccurs="2" maxOccurs="unbounded"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="xor">
				<xs:complexType>
					<xs:group ref="condition" minOccurs="2" maxOccurs="2"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:group name="condition">
				<xs:choice>
					<xs:element ref="same"/>
					<xs:element ref="equals"/>
					<xs:element ref="notEquals"/>
					<xs:element ref="less"/>
					<xs:element ref="lessOrEquals"/>
					<xs:element ref="greater"/>
					<xs:element ref="greaterOrEquals"/>
					<xs:element ref="isNull"/>
					<xs:element ref="notNull"/>
					<xs:element ref="and"/>
					<xs:element ref="or"/>
					<xs:element ref="xor"/>
					<xs:element ref="not"/>
					<xs:element ref="instanceOf"/>
					<xs:element ref="isTrue"/>
					<xs:element ref="isFalse"/>
					<xs:element ref="hasSize"/>
					<xs:element ref="hasFeature"/>
					<xs:element ref="implementationAttribute"/>
					<xs:element ref="contentType"/>
					<xs:element ref="contains"/>
				</xs:choice>
			</xs:group>

			<!-- if the spec does not contain a contentType attribute (L1 & L2)
			          then create the stock contentType condition element  -->
			<xsl:if test="not($features[@name = 'contentType'])">
	        	<xs:element name="contentType">
                	 <xs:annotation>
                       	<xs:documentation>This condition will evaluate to true if the default
                            content type for this test matches the specified type.</xs:documentation>
                 	  </xs:annotation>
		              <xs:complexType>
			     	     <xs:attribute name="id" type="xs:ID" use="optional"/>
			             <xs:attribute name="type" type="loadContentType" use="required"/>
		               </xs:complexType>
	            </xs:element>
	         </xsl:if>
	         
			<!-- if the spec does not contain a contains method (L1 & L2)
			          then create the stock contains condition element  -->
	         <xsl:if test="not($features[@name = 'contains'])">
                <xs:element name="contains">
             	    <xs:complexType>
                 	   <xs:attribute name="id" type="xs:ID" use="optional"/>
                       <xs:attribute name="obj" type="variable" use="required"/>
                       <xs:attribute name="str" type="variableOrStringLiteral" use="required"/>
                	   <xs:attribute name="interface" use="required">
                    		<xs:simpleType>
                        		<xs:restriction base="xs:string">
                            		<xs:enumeration value="DOMString"/>
                        		</xs:restriction>
                    		</xs:simpleType>
                		</xs:attribute>
                     </xs:complexType>
                </xs:element>
             </xsl:if>
			
			<xs:element name="else">
				<xs:complexType>
					<xs:group ref="statement" maxOccurs="unbounded"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="if">
				<xs:complexType>
					<xs:sequence>
						<xs:group ref="condition"/>
						<xs:group ref="statement" maxOccurs="unbounded"/>
						<xs:element ref="else" minOccurs="0"/>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="try">
				<xs:complexType>
					<xs:sequence>
						<xs:group ref="statement" maxOccurs="unbounded"/>
						<xs:element name="catch">
							<xs:complexType>
								<xs:sequence>
									<xsl:for-each select="$exceptions">
										<xs:element name="{@name}" minOccurs="0" maxOccurs="unbounded">
											<xs:complexType>
												<xs:sequence>
													<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
												</xs:sequence>
												<xs:attribute name="id" type="xs:ID" use="optional"/>
												<xs:attribute name="code" use="required">
													<xs:simpleType>
														<xs:restriction base="xs:string">
															<xsl:for-each select="following-sibling::group[1]/constant">
																<xs:enumeration value="{@name}"/>
															</xsl:for-each>
														</xs:restriction>
													</xs:simpleType>
												</xs:attribute>
											</xs:complexType>
										</xs:element>
									</xsl:for-each>
									<xs:element name="ImplementationException" minOccurs="0">
										<xs:complexType>
											<xs:sequence>
												<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
											</xs:sequence>
											<xs:attribute name="id" type="xs:ID" use="optional"/>
										</xs:complexType>
									</xs:element>
								</xs:sequence>
							</xs:complexType>
						</xs:element>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="while">
				<xs:complexType>
					<xs:sequence>
						<xs:group ref="condition"/>
						<xs:group ref="statement" maxOccurs="unbounded"/>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="for-each">
				<xs:complexType>
					<xs:group ref="statement" minOccurs="0" maxOccurs="unbounded"/>
					<xs:attribute name="collection" type="variable" use="required"/>
					<xs:attribute name="member" type="variable" use="required"/>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				</xs:complexType>
			</xs:element>
			<xs:complexType name="EventMonitorAccessor">
				<xs:attribute name="id" type="xs:ID" use="optional"/>
				<xs:attribute name="obj" type="variable" use="required"/>
                <xs:attribute name="interface" use="optional">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xs:enumeration value="EventMonitor"/>
                        </xs:restriction>
                    </xs:simpleType>
                </xs:attribute>
				<xs:attribute name="var" type="variable" use="required"/>
			</xs:complexType>
			<xs:element name="atEvents" type="EventMonitorAccessor"/>
			<xs:element name="capturedEvents" type="EventMonitorAccessor"/>
			<xs:element name="bubbledEvents" type="EventMonitorAccessor"/>
			<xs:element name="allEvents" type="EventMonitorAccessor"/>
			<xs:element name="allNotifications">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="obj" type="variable" use="required"/>
                	<xs:attribute name="interface" use="optional">
                    	<xs:simpleType>
                        	<xs:restriction base="xs:string">
                            	<xs:enumeration value="UserDataMonitor"/>
                        	</xs:restriction>
                    	</xs:simpleType>
                	</xs:attribute>
					<xs:attribute name="var" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="allErrors">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="obj" type="variable" use="required"/>
                	<xs:attribute name="interface" use="optional">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xs:enumeration value="DOMErrorMonitor"/>
                        </xs:restriction>
                    </xs:simpleType>
                	</xs:attribute>
					<xs:attribute name="var" type="variable" use="required"/>
				</xs:complexType>
			</xs:element>
			<xs:element name="assertLowerSeverity">
				<xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="required"/>
					<xs:attribute name="obj" type="variable" use="required"/>
                	<xs:attribute name="interface" use="optional">
                    	<xs:simpleType>
                        	<xs:restriction base="xs:string">
                            	<xs:enumeration value="DOMErrorMonitor"/>
                        	</xs:restriction>
                    	</xs:simpleType>
                	</xs:attribute>
					<xs:attribute name="severity" use="required">
                    	<xs:simpleType>
                        	<xs:restriction base="xs:string">
                            	<xs:enumeration value="SEVERITY_WARNING"/>
                            	<xs:enumeration value="SEVERITY_ERROR"/>
                            	<xs:enumeration value="SEVERITY_FATAL_ERROR"/>
                        	</xs:restriction>
                    	</xs:simpleType>
                    </xs:attribute>
				</xs:complexType>
			</xs:element>
			
			<xs:complexType name="UserDataNotificationAccessor">
					<xs:attribute name="id" type="xs:ID" use="optional"/>
					<xs:attribute name="obj" type="variable" use="required"/>
                	<xs:attribute name="interface" use="optional">
                    <xs:simpleType>
                        <xs:restriction base="xs:string">
                            <xs:enumeration value="UserDataNotification"/>
                        </xs:restriction>
                    </xs:simpleType>
                	</xs:attribute>
					<xs:attribute name="var" type="variable" use="required"/>
			</xs:complexType>
			<xs:element name="operation" type="UserDataNotificationAccessor"/>
			<xs:element name="key" type="UserDataNotificationAccessor"/>
			<xs:element name="dst" type="UserDataNotificationAccessor"/>
			<xsl:if test="not($attributes[@name = 'data'])">
				<xs:element name="data" type="UserDataNotificationAccessor"/>
			</xsl:if>	
			<xsl:if test="not($attributes[@name = 'src'])">
				<xs:element name="src" type="UserDataNotificationAccessor"/>
			</xsl:if>	
			
            <xs:element name="createXPathEvaluator">
                <xs:complexType>
					<xs:attribute name="id" type="xs:ID" use="optional"/>
				    <xs:attribute name="var" type="variable" use="required"/>
				    <xs:attribute name="document" type="variable" use="required"/>
			    </xs:complexType>
            </xs:element>
			<xs:simpleType name="uriScheme">
				<xs:restriction base="xs:string">
					<xs:enumeration value="file"/>
					<xs:enumeration value="http"/>
				</xs:restriction>
			</xs:simpleType>
            <xs:element name="getResourceURI">
            	<xs:complexType>
            		<xs:attribute name="id" type="xs:ID" use="optional"/>
            		<xs:attribute name="var" type="variable" use="required"/>
            		<xs:attribute name="href" type="variableOrStringLiteral" use="required"/>
            		<xs:attribute name="scheme" type="uriScheme" use="optional"/>
            		<xs:attribute name="contentType" type="loadContentType" use="optional"/>
            	</xs:complexType>
            </xs:element>
            <xs:element name="createTempURI">
            	<xs:complexType>
            		<xs:attribute name="id" type="xs:ID" use="optional"/>
            		<xs:attribute name="var" type="variable" use="required"/>
            		<xs:attribute name="scheme" type="uriScheme" use="required"/>
            	</xs:complexType>
            </xs:element>
            
            <xs:element name="substring">
            	<xs:complexType>
            		<xs:attribute name="id" type="xs:ID" use="optional"/>
            		<xs:attribute name="var" type="variable" use="required"/>
            		<xs:attribute name="obj" type="variableOrStringLiteral" use="required"/>
            		<xs:attribute name="beginIndex" type="variableOrIntLiteral" use="required"/>
            		<xs:attribute name="endIndex" type="variableOrIntLiteral" use="optional"/>         		
            	</xs:complexType>
            </xs:element>
	</xsl:template>

	<!--   This template produces assertion elements for each
	       defined exception type   -->
    <xsl:template name="dynamic-assertions">

		<!--  checking for non-null id attributes gets exception definitions
		         not uses  -->
		<xsl:for-each select="//exception[@id]">		
			<xsl:variable name="exception" select="@name"/>
			<xs:element name="assert{@name}">
				<xs:complexType>
					<xs:sequence>
						<xs:element ref="metadata" minOccurs="0"/>
						<xs:choice>
							<!--  the immediately following group defines the codes  -->
							<xsl:for-each select="following-sibling::group[1]/constant">
				                <xsl:variable name="constant" select="."/>
			                    <xs:element name="{@name}">
				                    <xs:complexType>
					                    <xs:choice>
                                            <!--  must suppress duplicates 
                                                (like ProcessingInstruction.data and CharacterData.data)  -->
                                            <xsl:for-each select="$attributes">
                                                <!--  only do it for the first attribute with that name   -->
                                                <xsl:if test="not(preceding::attribute[@name = current()/@name])">
                                                    <!--  but check all attributes with the same name for
                                                            a getraises or setraises clause with the constant name appearing
                                                            in the description   -->
                                                    <xsl:variable name="throwingAttrs" select="$attributes[@name = current()/@name and *[contains(name(),'raises')]/exception[@name=$exception]]"/>
                                                    <!-- if any of the attributes with this name, throw the exception  -->
                                                    <xsl:if test="contains(string($throwingAttrs),concat($constant/@name,':'))">
                                                        <xs:element ref="{@name}"/>
                                                    </xsl:if>
                                                </xsl:if>
                                            </xsl:for-each>
                                            <xsl:for-each select="$methods">
                                                <xsl:if test="not(preceding::method[@name = current()/@name])">
                                                    <!--  but check all attributes with the same name for
                                                            a getraises or setraises clause with the constant name appearing
                                                            in the description   -->
                                                    <xsl:variable name="throwingMeths" select="$methods[@name = current()/@name and raises/exception[@name=$exception]]"/>
                                                    <!-- if any of the attributes with this name, throw the exception  -->
                                                    <xsl:if test="contains(string($throwingMeths),concat($constant/@name,':'))">
                                                        <xs:element ref="{@name}"/>
                                                    </xsl:if>
                                                </xsl:if>
                                            </xsl:for-each>

					                    </xs:choice>
					                    <xs:attribute name="id" type="xs:ID" use="optional"/>
				                    </xs:complexType>
			                    </xs:element>
							</xsl:for-each>
						</xs:choice>
					</xs:sequence>
					<xs:attribute name="id" type="xs:ID" use="required"/>
				</xs:complexType>
			</xs:element>

		</xsl:for-each>
		<!--  generate assertion group  -->
		<xs:group name="assertion">
			<xs:choice>
				<xs:group ref="framework-assertion"/>
				<xsl:for-each select="//exception[@id]">
					<xs:element ref="assert{@name}"/>
				</xsl:for-each>
			</xs:choice>
		</xs:group>
	</xsl:template>

			
	<!--  generate element that depend on the source document   -->				
    <xsl:template name="dynamic-elements">
			<xs:group name="statement">
				<xs:choice>
					<xs:group ref="framework-statement"/>
					<xs:group ref="assertion"/>
					<xsl:for-each select="$attributes">
						<xsl:sort select="@name"/>
						<xsl:variable name="current" select="."/>
						<xsl:if test="not(preceding::attribute[@name=$current/@name])">
                            <xsl:choose>
                                <!--  if the attribute is named implementation
                                           suppress it   -->
                                <xsl:when test="@name = 'implementation'"/>

                                <!--  when the attribute name is "test"
                                       create a locally defined element
                                       to avoid conflict with the test definition
                                       element   -->
                                <xsl:when test="@name = 'test'">
                                    <xsl:call-template name="produce-property"/>
                                </xsl:when>

                                <!--   any other attribute,
                                          reference the global element   -->
                                <xsl:otherwise>
								    <xs:element ref="{@name}"/>
                                </xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
					<xsl:for-each select="$methods">
						<xsl:sort select="@name"/>
						<xsl:variable name="current" select="."/>
						<xsl:if test="not(preceding::method[@name=$current/@name])">
							<xsl:choose>
								<xsl:when test="@name = 'hasFeature'"/>
								<!--  firstChild and lastChild are both an attribute on Node
								        and a method on TreeWalker.   
								        Suppress the entry for the method to 
								        avoid entering it twice in the statements group  -->
								<xsl:when test="$attributes[@name = current()/@name]"/>
								
								
								<xsl:otherwise>
									<xs:element ref="{@name}"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
					</xsl:for-each>
				</xs:choice>
			</xs:group>
	</xsl:template>

	<!--  produce an attribute with the name specified by $paramName,
	      use specified by $use and whose type is appropriate for
		  the type of the param   -->
	<xsl:template name="param-type">
		<xsl:param name="paramName"/>
		<xsl:param name="type"/>
		<xsl:param name="use"/>
		<xsl:choose>
			<xsl:when test="$type='DOMString'">
				<xs:attribute name="{$paramName}" type="variableOrStringLiteral" use="{$use}"/>
			</xsl:when>

			<xsl:when test="$type='long'">
				<xs:attribute name="{$paramName}" type="variableOrIntLiteral" use="{$use}"/>
			</xsl:when>

			<xsl:when test="$type='unsigned long'">
				<xs:attribute name="{$paramName}" type="variableOrIntLiteral" use="{$use}"/>
			</xsl:when>

			<xsl:when test="$type='unsigned short'">
				<xs:attribute name="{$paramName}" type="variableOrIntLiteral" use="{$use}"/>
			</xsl:when>

			<xsl:when test="$type='boolean'">
				<xs:attribute name="{$paramName}" type="variableOrBoolLiteral" use="{$use}"/>
			</xsl:when>

			<xsl:otherwise>
				<xsl:comment>type = <xsl:value-of select="$type"/></xsl:comment>
				<xs:attribute name="{$paramName}" type="variable" use="{$use}"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


    <xsl:template name="produce-sink">
        <xsl:param name="sinks"/>
        	<xs:sequence>
            <!--  produce methods and attributes of this class  -->
            <xsl:for-each select="method|attribute">
                <xsl:choose>
                    <xsl:when test="name() = 'method'">
                        <xs:element name="{@name}" type="sinkMethod"/>
                    </xsl:when>
                    <xsl:when test="@readonly='yes'">
                        <xs:element name="{@name}" type="sinkReadOnlyAttribute"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xs:element name="{@name}" type="sinkAttribute"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
            <xsl:variable name="derivedSinks" select="$sinks[contains(@inherits, current()/@name)]"/>
            <xsl:if test="count($derivedSinks) != 0">
            	<xs:choice minOccurs="0">
            		<xsl:for-each select="$derivedSinks">
            			<xsl:call-template name="produce-sink">
            				<xsl:with-param name="sinks" select="$sinks"/>
            			</xsl:call-template>
            		</xsl:for-each>
            	</xs:choice>
            </xsl:if>
        </xs:sequence>
    </xsl:template>

</xsl:stylesheet>
