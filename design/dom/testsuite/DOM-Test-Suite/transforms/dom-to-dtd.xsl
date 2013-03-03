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
This transforms generates an XML DTD for a DOM test definition
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

saxon -o dom1-test.dtd wd-dom.xml dom-to-dtd.xsl


-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:param name="schema-namespace">http://www.w3.org/2001/DOM-Test-Suite/Level-X</xsl:param>
    <xsl:param name="additional-types"/>
    <xsl:param name="schema-location">domX.xsd</xsl:param>

	<!--   symbolic constant for schema namespace   -->
	<xsl:variable name="source" select="/spec/header/publoc/loc[1]/@href"/>
	<xsl:output method="text" encoding="UTF-8"/>

	<!--  interfaces defined in DOM recommendation  -->
	<xsl:variable name="interfaces" select="//interface"/>
	<!--  attributes defined in DOM recommendation  -->
	<xsl:variable name="attributes" select="//attribute"/>
	<!--  methods defined in DOM recommendation  -->
	<xsl:variable name="methods" select="//method"/>
	<xsl:variable name="exceptions" select="//exception[@id]"/>

	<!--  attributes and methods keyed by name        -->
	<xsl:key name="featureByName" match="//*[(name()='attribute' or name()='method') and @name]" use="@name"/>

    <!--   list method names (such as EventHandler) that
               are implemented by the caller, not by the DOM implementation
               must provide leading and trailing space    -->              
    <xsl:variable name="sink-interfaces"> EventListener LSResourceResolver LSParserFilter LSSerializerFilter NodeFilter DOMErrorHandler </xsl:variable>

	<!--   match document root   -->
	<xsl:template match="/">
<xsl:text>
&lt;!--
 Copyright (c) 2001-2004 World Wide Web Consortium,
 (Massachusetts Institute of Technology, Institut National de
 Recherche en Informatique et en Automatique, Keio University). All
 Rights Reserved. This program is distributed under the W3C's Software
 Intellectual Property License. This program is distributed in the
 hope that it will be useful, but WITHOUT ANY WARRANTY; without even
 the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.
 See W3C License http://www.w3.org/Consortium/Legal/ for more details.

This schema was generated from </xsl:text><xsl:value-of select="$source"/><xsl:text> by dom-to-dtd.xsl.

--&gt;

&lt;!ENTITY % framework-assertion "fail|assertTrue|assertFalse|assertNull|assertNotNull|assertEquals|assertNotEquals|assertSame|assertInstanceOf|assertSize|assertEventCount|assertURIEquals|assertImplementationException"&gt;

&lt;!ENTITY % framework-statement "assign|increment|decrement|append|plus|subtract|mult|divide|load|implementation|hasFeature|implementationAttribute|if|while|try|for-each|comment|return|userObj|atEvents|capturedEvents|bubbledEvents|allEvents|createXPathEvaluator|getResourceURI|substring|createTempURI|DOMImplementationRegistry.newInstance|allErrors|assertLowerSeverity|allNotifications|operation|key|dst</xsl:text>
<xsl:if test="not($attributes[@name = 'src'])">|src</xsl:if>
<xsl:if test="not($attributes[@name = 'data'])">|data</xsl:if>
<xsl:text>"&gt;

&lt;!ENTITY % implementation-condition "hasFeature | implementationAttribute"&gt;

&lt;!ENTITY % condition "same|equals|notEquals|less|lessOrEquals|greater|greaterOrEquals|isNull|notNull|and|or|xor|not|instanceOf|isTrue|isFalse|hasSize|contentType|contains| %implementation-condition;"&gt;

&lt;!ENTITY % assertion "%framework-assertion;</xsl:text>
	<xsl:if test="$exceptions">
		<xsl:for-each select="$exceptions">
			<xsl:text>| assert</xsl:text>
			<xsl:value-of select="@name"/>
		</xsl:for-each>
	</xsl:if>
	<xsl:text>" &gt;
</xsl:text>


			<!--   produce fixed simpleType definitions    -->
			<xsl:call-template name="static-simpleTypes"/>
			<!--   produce simpleType definitions that depend on the source document  -->
			<xsl:call-template name="dynamic-simpleTypes"/>
			<!--   produce element definitions that depend on the source document    -->
			<xsl:call-template name="dynamic-elements"/>
			<!--   generate assertion elements that depend on the source document    -->
			<xsl:call-template name="dynamic-assertions"/>

			<!--   produce elements that correspond to DOM attributes   -->
			<xsl:call-template name="produce-properties"/>
			<!--   produce elements that correspond to DOM methods     -->
			<xsl:call-template name="produce-methods"/>

			<!--   produce fixed element definitions        -->			
			<xsl:call-template name="static-elements"/>
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

                <xsl:choose>
                	<!--  ElementEditVAL.contentType conflicts with contentType conditional
                	           contentType element appears in fixed section   -->
                	<xsl:when test="@name = 'contentType'"/>
                	
                    <xsl:when test="contains($sink-interfaces, 
                            concat(' ',concat(parent::interface/@name,' ')))">
                        <xsl:choose>
                            <!--    some form of the attribute name is not readonly   -->
                            <xsl:when test="key('featureByName',@name)[not(@readonly) or @readonly!='yes']">
                                <xsl:call-template name="produce-property">
                                    <xsl:with-param name="required">#IMPLIED</xsl:with-param>
                                    <xsl:with-param name="content">(get?, set?)</xsl:with-param>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="produce-property">
                                    <xsl:with-param name="required">#IMPLIED</xsl:with-param>
                                    <xsl:with-param name="content">(get?)</xsl:with-param>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>

                    <xsl:otherwise>
                        <xsl:call-template name="produce-property"/>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:for-each>
	</xsl:template>


    <xsl:template name="produce-property">
        <xsl:param name="required">#REQUIRED</xsl:param>
        <xsl:param name="content">EMPTY</xsl:param>
			  <!--  suppress creation of title element since it is also used
			          as metadata, hardcoded version that can do both appears
					  elsewhere   -->
			  <xsl:if test="@name != 'title'">

				<!--   Note: some DOM processors have had problems with current(),
				       so as a kludge, the current context is made an
					   explicit variable and used in place of current()   -->
				<xsl:variable name="current" select="."/>

				<!--  only the first entry creates an entry  -->
				<xsl:if test="not(preceding::attribute[@name=$current/@name]) and @name != 'implementation'">

					<!--  create an element whose tag name is the same as the attribute  -->
&lt;!ELEMENT <xsl:value-of select="concat(concat(@name,' '),$content)"/>&gt;
&lt;!ATTLIST <xsl:value-of select="@name"/><xsl:text>
    id ID #IMPLIED
	obj CDATA </xsl:text><xsl:value-of select="$required"/><xsl:text>
</xsl:text>
					<xsl:choose>
						<xsl:when test="key('featureByName',@name)[not(@readonly) or @readonly!='yes']">
							<xsl:text>    var CDATA #IMPLIED
</xsl:text>
							<!--  produces a "value" attribute, 
							      the schema type is selected based on the attribute type   -->
							<xsl:call-template name="param-type">
								<xsl:with-param name="type" select="@type"/>
								<xsl:with-param name="paramName">value</xsl:with-param>
								<xsl:with-param name="use">#IMPLIED</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>    var CDATA </xsl:text><xsl:value-of select="$required"/><xsl:text>
</xsl:text>
						</xsl:otherwise>
					</xsl:choose>

					<!--  collect all attributes with this name   -->
					<xsl:variable name="dups" select="key('featureByName',@name)"/>

							<!--  produce the "interface" attribute       -->
<xsl:text>    interface ( </xsl:text>
							<xsl:for-each select="$dups[1]">
								<xsl:value-of select="parent::interface/@name"/>
							</xsl:for-each>
							<xsl:for-each select="$dups[position() &gt; 1]">
								<xsl:text> | </xsl:text>
								<xsl:value-of select="parent::interface/@name"/>
							</xsl:for-each>
                            <xsl:if test="@name='length'">
                                <xsl:text> | DOMString </xsl:text>
                            </xsl:if>
                            <xsl:if test="@name='data' or @name = 'src'">
                            	<xsl:text> | UserDataNotification </xsl:text>
                            </xsl:if>
							<xsl:text> ) </xsl:text>
						<!--  choose whether interface is required based
						         on number of interfaces method is introduced by  -->
						<xsl:choose>
							<xsl:when test="@name='length' or @name='data'">
								<xsl:value-of select="$required"/>
							</xsl:when>
							<xsl:when test="count($dups) &gt; 1">
								<xsl:value-of select="$required"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>#IMPLIED</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					<xsl:text>&gt;</xsl:text>
				</xsl:if>
              </xsl:if>
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
        <xsl:param name="required">#REQUIRED</xsl:param>
        <xsl:param name="content">EMPTY</xsl:param>

			<!--  produce an element for all methods  -->
			<xsl:for-each select="$methods">
				<xsl:sort select="@name"/>

                <xsl:choose>
                	<!--  these methods have custom productions  -->
					<xsl:when test="@name = 'hasFeature'"/>
					<xsl:when test="@name = 'load'"/>
					<xsl:when test="@name = 'contentType'"/>
					<xsl:when test="@name = 'contains'"/>
					<xsl:when test="@name = 'evaluate'">
						<xsl:if test="@id = 'XPathEvaluator-evaluate'">
&lt;!ELEMENT evaluate EMPTY &gt;
&lt;!ATTLIST evaluate
    id ID #IMPLIED
    obj CDATA #REQUIRED
    var CDATA #REQUIRED
    expression CDATA #IMPLIED
    contextNode CDATA #REQUIRED
    resolver CDATA #IMPLIED
    type CDATA #REQUIRED
    result CDATA #REQUIRED
    interface (XPathEvaluator|XPathExpression) #REQUIRED
&gt;
</xsl:if>
					</xsl:when>
					
					<xsl:when test="@name = 'getDOMImplementation' or @name = 'getDOMImplementationList'">
&lt;!ELEMENT <xsl:value-of select="@name"/> EMPTY &gt;
&lt;!ATTLIST <xsl:value-of select="@name"/>
    id ID #IMPLIED
    obj CDATA #REQUIRED
    var CDATA #REQUIRED
    features CDATA #REQUIRED
    interface (DOMImplementationSource|DOMImplementationRegistry) #IMPLIED
&gt;
					</xsl:when>

                    <!--   if the interface is something like EventListener
                             that might be defined using anonymous inner classes  
                             which makes all the required attributes optional
                             -->
                    <xsl:when test="contains($sink-interfaces, concat(' ',concat(parent::interface/@name,' ')))">
                        <xsl:call-template name="produce-method">
                            <xsl:with-param name="required">#IMPLIED</xsl:with-param>
                            <xsl:with-param name="content">(var*, (%statement;)* )</xsl:with-param>
                        </xsl:call-template>
                    </xsl:when>

                    <xsl:otherwise>
                        <!--  normal method, required is required, content is empty  -->
                        <xsl:call-template name="produce-method">
                            <xsl:with-param name="required">#REQUIRED</xsl:with-param>
                            <xsl:with-param name="content">EMPTY</xsl:with-param>
                        </xsl:call-template>
                    </xsl:otherwise>
                </xsl:choose>
			</xsl:for-each>
	</xsl:template>

	<!--  this template contains simple types that are indepenent
	      of the DOM recommendation.	
	-->
	<xsl:template name="produce-method">
        <xsl:param name="required">#REQUIRED</xsl:param>
        <xsl:param name="content">EMPTY</xsl:param>

				<xsl:variable name="name" select="@name"/>
				<xsl:variable name="current" select="."/>

				<!--   for only the first occurance of the name and the method
				               name wasn't also an attribute name
				               (TreeWalker defines firstChild, etc as methods   
				-->
				<xsl:if test="not(preceding::method[@name=$name]) and not(@name = $attributes/@name)">					
					<xsl:text>
&lt;!ELEMENT </xsl:text><xsl:value-of select="$name"/><xsl:text> </xsl:text><xsl:value-of select="$content"/><xsl:text> &gt;
&lt;!ATTLIST </xsl:text><xsl:value-of select="$name"/><xsl:text>
    id ID #IMPLIED
    obj CDATA </xsl:text><xsl:value-of select="$required"/><xsl:text>
</xsl:text>

					<!--  If the method has a (non-void) return value then
					      the var attribute is required to receive the return value  -->
					<xsl:if test="returns[@type!='void']">
						<xsl:text>    var CDATA </xsl:text><xsl:value-of select="$required"/><xsl:text>
</xsl:text>
					</xsl:if>

					<!--  for each parameter    -->
					<xsl:for-each select="parameters/param">
						<!--  need to check that all the types are consistent  -->
						<xsl:call-template name="param-type">
							<xsl:with-param name="type" select="@type"/>
							<xsl:with-param name="paramName" select="@name"/>
							<xsl:with-param name="use" select="$required"/>
						</xsl:call-template>
					</xsl:for-each>

					<!--  produce interface attribute   -->
					<xsl:variable name="dups" select="key('featureByName',@name)"/>
					<xsl:text>    interface (</xsl:text>
					<xsl:for-each select="$dups[1]">
						<xsl:value-of select="parent::interface/@name"/>
					</xsl:for-each>
					<xsl:for-each select="$dups[position() &gt; 1]">
						<xsl:text>|</xsl:text>
						<xsl:value-of select="parent::interface/@name"/>
					</xsl:for-each>
					<xsl:text>)</xsl:text>

					<xsl:choose>
						<xsl:when test="count($dups) &gt; 1">
							<xsl:text> </xsl:text><xsl:value-of select="$required"/><xsl:text>
</xsl:text>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text> #IMPLIED
</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>&gt;

</xsl:text>
				</xsl:if>
	</xsl:template>

	<!--  this template contains simple types that are indepenent
	      of the DOM recommendation.	
	-->
    <xsl:template name="static-simpleTypes">
   </xsl:template>


	<!--   this template generates any simple types
	       that are dependent on the source document.  Currently only
		   the allowable types for variables    -->
	<xsl:template name="dynamic-simpleTypes">
		<xsl:text>&lt;!ENTITY % variable-type "int|short|double|boolean|DOMString|List|Collection|EventMonitor|DOMErrorMonitor|UserDataMonitor|UserDataNotification</xsl:text>
        <xsl:value-of select="$additional-types"/>
		<xsl:for-each select="$interfaces">
			<xsl:sort select="@name"/>
			<xsl:text>|</xsl:text>
			<xsl:value-of select="@name"/>
		</xsl:for-each>
		<xsl:text>"&gt;
</xsl:text>
	</xsl:template>

	<!--   This template contains the elements that are 
	       independent of the source document.  Examples of these
		   elements are <test>, <var>, <assign>, etc.
	-->
    <xsl:template name="static-elements">

&lt;!ELEMENT test (metadata?,(%implementation-condition;)*,var*,(load|implementation|DOMImplementationRegistry.newInstance),(%statement;)*) &gt;
&lt;!ATTLIST test 
   xmlns CDATA #FIXED "<xsl:value-of select="$schema-namespace"/>"
   id ID #IMPLIED
   name CDATA #REQUIRED
   xmlns:xsi CDATA #FIXED "http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation CDATA "<xsl:value-of select="concat($schema-namespace, concat(' ',$schema-location))"/>"
&gt;

&lt;!ELEMENT package (metadata?, (test|suite)*)&gt;
&lt;!ATTLIST package
   xmlns CDATA #FIXED "<xsl:value-of select="$schema-namespace"/>"
	id ID #IMPLIED
&gt;

&lt;!ELEMENT suite (metadata?,(%implementation-condition;)*,(suite.member)*)&gt;
&lt;!ATTLIST suite
   xmlns CDATA #FIXED "<xsl:value-of select="$schema-namespace"/>"
   id ID #IMPLIED
   name CDATA #REQUIRED
   xmlns:xsi CDATA #FIXED "http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation CDATA "<xsl:value-of select="concat($schema-namespace, concat(' ',$schema-location))"/>"
&gt;

&lt;!ELEMENT suite.member EMPTY&gt;
&lt;!ATTLIST suite.member
   href CDATA #REQUIRED
&gt;


&lt;!ELEMENT comment (#PCDATA)&gt;
&lt;!ATTLIST comment
	id ID #IMPLIED
&gt;

&lt;!ELEMENT wait EMPTY&gt;
&lt;!ATTLIST wait
	id ID #IMPLIED
	milliseconds CDATA #REQUIRED
&gt;

&lt;!ELEMENT append EMPTY&gt;
&lt;!ATTLIST append
	id ID #IMPLIED
	collection CDATA #REQUIRED
	item CDATA #REQUIRED
&gt;

&lt;!ELEMENT assign ((%condition;)?)?&gt;
&lt;!ATTLIST assign
	id ID #IMPLIED
	var CDATA #REQUIRED
	value CDATA #IMPLIED
&gt;

&lt;!ELEMENT increment EMPTY&gt;
&lt;!ATTLIST increment
	id ID #IMPLIED
	var CDATA #REQUIRED
	value CDATA #REQUIRED
&gt;

&lt;!ELEMENT decrement EMPTY&gt;
&lt;!ATTLIST decrement
	id ID #IMPLIED
	var CDATA #REQUIRED
	value CDATA #REQUIRED
&gt;

&lt;!ELEMENT plus EMPTY&gt;
&lt;!ATTLIST plus
	id ID #IMPLIED
	var CDATA #REQUIRED
	op1 CDATA #REQUIRED
	op2 CDATA #REQUIRED
&gt;

&lt;!ELEMENT subtract EMPTY&gt;
&lt;!ATTLIST subtract
	id ID #IMPLIED
	var CDATA #REQUIRED
	op1 CDATA #REQUIRED
	op2 CDATA #REQUIRED
&gt;

&lt;!ELEMENT mult EMPTY&gt;
&lt;!ATTLIST mult
	id ID #IMPLIED
	var CDATA #REQUIRED
	op1 CDATA #REQUIRED
	op2 CDATA #REQUIRED
&gt;

&lt;!ELEMENT divide EMPTY&gt;
&lt;!ATTLIST divide
	id ID #IMPLIED
	var CDATA #REQUIRED
	op1 CDATA #REQUIRED
	op2 CDATA #REQUIRED
&gt;

&lt;!ELEMENT return EMPTY&gt;
&lt;!ATTLIST return
	id ID #IMPLIED
	value CDATA #IMPLIED
&gt;

&lt;!ELEMENT get (var*, (%statement;)* )&gt;
&lt;!ELEMENT set (var*, (%statement;)* )&gt;


<xsl:text>&lt;!ELEMENT var </xsl:text>
        <!--  define elements for every method in user implemented interfaces
                  used like anonymous inner class definitions  -->
    <xsl:variable name="sinks" select="$interfaces[contains($sink-interfaces,concat(' ',concat(@name,' ')))]"/>
    <xsl:choose>
        <xsl:when test="$sinks">
            <xsl:text> (member+ | ( var* , ( ( </xsl:text>
            <xsl:for-each select="$sinks">
                <xsl:if test="position() &gt; 1">
                    <xsl:text> | ( </xsl:text>
                </xsl:if>
                <xsl:call-template name="produce-sink">
                    <xsl:with-param name="interface" select="@name"/>
                    <xsl:with-param name="sinks" select="$sinks"/>
                </xsl:call-template>
                <xsl:text> ) </xsl:text>
            </xsl:for-each>
            <xsl:text> ) ) )? &gt;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text> (member*) &gt; </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
 <xsl:text>
&lt;!ATTLIST var
	id ID #IMPLIED
	name CDATA #REQUIRED
	type (%variable-type;) #REQUIRED
	value CDATA #IMPLIED
    isNull (true|false) #IMPLIED
&gt;
</xsl:text>

&lt;!ELEMENT member (#PCDATA)&gt;
&lt;!ATTLIST member
    type (int|short|double|boolean|DOMString) #IMPLIED
&gt;    


&lt;!ELEMENT load EMPTY&gt;
&lt;!ATTLIST load
	var CDATA #REQUIRED
	href CDATA #IMPLIED
    uri CDATA #IMPLIED
    obj CDATA #IMPLIED
    interface (DocumentLS) #IMPLIED
	willBeModified (true | false) #IMPLIED
&gt;

&lt;!ELEMENT implementation EMPTY&gt;
&lt;!ATTLIST implementation
	var CDATA #REQUIRED
	obj CDATA #IMPLIED
&gt;

&lt;!ELEMENT DOMImplementationRegistry.newInstance EMPTY&gt;
&lt;!ATTLIST DOMImplementationRegistry.newInstance
	var CDATA #REQUIRED
&gt;


&lt;!--  since title is used both as a metadata element and
            a read-write attribute, it is hard coded here   --&gt;
&lt;!ELEMENT title (#PCDATA)&gt;
&lt;!ATTLIST title
    id ID #IMPLIED
	obj CDATA #IMPLIED					
    var CDATA #IMPLIED
	value CDATA #IMPLIED
    interface CDATA #IMPLIED
&gt;


&lt;!ELEMENT metadata (metadata | title | creator | subject | description | contributor | date | source | relation)*&gt;
&lt;!ATTLIST metadata
        xmlns CDATA #FIXED "<xsl:value-of select="$schema-namespace"/>"
	id ID #IMPLIED
	about CDATA #IMPLIED
&gt;

&lt;!ELEMENT creator (#PCDATA)&gt;
&lt;!ATTLIST creator
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
&gt;

&lt;!ELEMENT subject (#PCDATA)&gt;
&lt;!ATTLIST subject
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
&gt;

&lt;!ELEMENT description (#PCDATA)&gt;
&lt;!ATTLIST description
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
&gt;

&lt;!ELEMENT contributor (#PCDATA)&gt;
&lt;!ATTLIST contributor
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
&gt;

&lt;!ELEMENT date (#PCDATA)&gt;
&lt;!ATTLIST date
	id ID #IMPLIED
	qualifier (created | valid | available | issued | modified) #REQUIRED
&gt;

&lt;!ELEMENT source (#PCDATA)&gt;
&lt;!ATTLIST source
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
&gt;

&lt;!ELEMENT relation (#PCDATA)&gt;
&lt;!ATTLIST relation
	id ID #IMPLIED
	resource CDATA #IMPLIED
	type CDATA #IMPLIED
	qualifier (isVersionOf | hasVersion | isReplacedBy | isRequiredBy | requires | isPartOf | hasPart | isReferenceBy | references) #REQUIRED
&gt;
					
&lt;!ELEMENT fail EMPTY&gt;
&lt;!ATTLIST fail
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertTrue ((%condition;)?)&gt;
&lt;!ATTLIST assertTrue
	id ID #REQUIRED
	actual CDATA #IMPLIED
&gt;
							
&lt;!ELEMENT assertFalse ((%condition;)?)&gt;
&lt;!ATTLIST assertFalse
	id ID #REQUIRED
	actual CDATA #IMPLIED
&gt;

&lt;!ELEMENT assertNull (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertNull
	actual CDATA #REQUIRED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertNotNull (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertNotNull
	actual CDATA #REQUIRED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertSame (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertSame
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertInstanceOf (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertInstanceOf
	obj CDATA #REQUIRED
	type (%variable-type;) #REQUIRED
	id ID #REQUIRED
&gt;


&lt;!ELEMENT assertSize (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertSize
	collection CDATA #REQUIRED
	size CDATA #REQUIRED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertEquals (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertEquals
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
	id ID #REQUIRED
	ignoreCase (true|false|auto) #REQUIRED
	context (attribute|element) #IMPLIED
	bitmask CDATA #IMPLIED
&gt;

&lt;!ELEMENT assertNotEquals (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertNotEquals
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
	id ID #REQUIRED
	ignoreCase (true|false|auto) #REQUIRED
	context (attribute|element) #IMPLIED
	bitmask CDATA #IMPLIED
&gt;

&lt;!ELEMENT assertEventCount (metadata?, (%statement;)*)&gt;
&lt;!ATTLIST assertEventCount
	atCount CDATA #IMPLIED
	captureCount CDATA #IMPLIED
	bubbleCount CDATA #IMPLIED
	totalCount CDATA #IMPLIED
	monitor CDATA #REQUIRED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertURIEquals (metadata?)&gt;
&lt;!ATTLIST assertURIEquals
	actual CDATA #REQUIRED
    scheme CDATA #IMPLIED
    path CDATA #IMPLIED
    host CDATA #IMPLIED
    file CDATA #IMPLIED
    name CDATA #IMPLIED
    query CDATA #IMPLIED
    fragment CDATA #IMPLIED
    isAbsolute CDATA #IMPLIED
	id ID #REQUIRED
&gt;

&lt;!ELEMENT assertImplementationException (metadata?, (%statement;))&gt;
&lt;!ATTLIST assertImplementationException
	id ID #REQUIRED
&gt;


&lt;!ELEMENT same EMPTY&gt;
&lt;!ATTLIST same
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT equals EMPTY&gt;
&lt;!ATTLIST equals
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
	ignoreCase (true|false|auto) "false"
	context (attribute|element) #IMPLIED
	bitmask CDATA #IMPLIED
&gt;

&lt;!ELEMENT notEquals EMPTY&gt;
&lt;!ATTLIST notEquals
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
	ignoreCase (true|false|auto) "false"
	context (attribute|element) #IMPLIED
	bitmask CDATA #IMPLIED
&gt;

&lt;!ELEMENT less EMPTY&gt;
&lt;!ATTLIST less
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT lessOrEquals EMPTY&gt;
&lt;!ATTLIST lessOrEquals
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT greater EMPTY&gt;
&lt;!ATTLIST greater
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT greaterOrEquals EMPTY&gt;
&lt;!ATTLIST greaterOrEquals
	id ID #IMPLIED
	actual CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT isNull EMPTY&gt;
&lt;!ATTLIST isNull
	id ID #IMPLIED
	obj CDATA #REQUIRED
&gt;

&lt;!ELEMENT notNull EMPTY&gt;
&lt;!ATTLIST notNull
	id ID #IMPLIED
	obj CDATA #REQUIRED
&gt;

&lt;!ELEMENT instanceOf EMPTY&gt;
&lt;!ATTLIST instanceOf
	id ID #IMPLIED
	obj CDATA #REQUIRED
	type (%variable-type;) #REQUIRED
&gt;

&lt;!ELEMENT hasSize EMPTY&gt;
&lt;!ATTLIST hasSize
	id ID #IMPLIED
	obj CDATA #REQUIRED
	expected CDATA #REQUIRED
&gt;

&lt;!ELEMENT contentType EMPTY&gt;
&lt;!ATTLIST contentType
	id ID #IMPLIED
	type CDATA #IMPLIED
	obj CDATA #IMPLIED
	var CDATA #IMPLIED
	interface (ElementEditVAL) #IMPLIED
&gt;


&lt;!ELEMENT contains EMPTY&gt;
&lt;!ATTLIST contains
	id ID #IMPLIED
	obj CDATA #REQUIRED
	str CDATA #REQUIRED
	var CDATA #IMPLIED
	interface (DOMStringList|NameList|DOMString) #REQUIRED
	 
&gt;

&lt;!ELEMENT implementationAttribute EMPTY&gt;
&lt;!ATTLIST implementationAttribute
	id ID #IMPLIED
	value (true|false) #REQUIRED
	name (validating|coalescing|expandEntityReferences|namespaceAware|ignoringElementContentWhitespace|signed|hasNullString|schemaValidating|ignoringComments) #REQUIRED
&gt;


&lt;!ELEMENT hasFeature EMPTY&gt;
&lt;!ATTLIST hasFeature
	id ID #IMPLIED
	feature CDATA #REQUIRED
	version CDATA #IMPLIED
    value (true | false) #IMPLIED
	var CDATA #IMPLIED
	obj CDATA #IMPLIED
&gt;

&lt;!ELEMENT not ((%condition;))&gt;
&lt;!ATTLIST not
	id ID #IMPLIED
&gt;

&lt;!ELEMENT isTrue EMPTY&gt;
&lt;!ATTLIST isTrue
	id ID #IMPLIED
	value CDATA #REQUIRED
&gt;

&lt;!ELEMENT isFalse EMPTY&gt;
&lt;!ATTLIST isFalse
	id ID #IMPLIED
	value CDATA #REQUIRED
&gt;

&lt;!ELEMENT or ((%condition;),(%condition;)+)&gt;
&lt;!ATTLIST or
	id ID #IMPLIED
&gt;

&lt;!ELEMENT and ((%condition;),(%condition;)+)&gt;
&lt;!ATTLIST and
	id ID #IMPLIED
&gt;

&lt;!ELEMENT xor ((%condition;),(%condition;))&gt;
&lt;!ATTLIST xor
	id ID #IMPLIED
&gt;

&lt;!ELEMENT else ((%statement;)+)&gt;
&lt;!ATTLIST else
	id ID #IMPLIED
&gt;

&lt;!ELEMENT if ((%condition;), (%statement;)+, else?)&gt;
&lt;!ATTLIST if
	id ID #IMPLIED
&gt;

&lt;!ELEMENT while ((%condition;),(%statement;)+)&gt;
&lt;!ATTLIST while
	id ID #IMPLIED
&gt;

&lt;!ELEMENT for-each ((%statement;)*)&gt;
&lt;!ATTLIST for-each
	collection CDATA #REQUIRED
	member CDATA #REQUIRED
	id ID #IMPLIED
&gt;

&lt;!ELEMENT try ((%statement;)+, catch)&gt;
&lt;!ATTLIST try
	id ID #IMPLIED
&gt;

<xsl:text>
&lt;!ELEMENT catch ((</xsl:text>
<xsl:for-each select="$exceptions">
	<xsl:value-of select="@name"/>
	<xsl:text>*,</xsl:text>
</xsl:for-each>
	<xsl:text>ImplementationException?))&gt;
&lt;!ATTLIST catch
    id ID #IMPLIED&gt;
    
&lt;!ELEMENT ImplementationException ((%statement;)*)&gt;
&lt;!ATTLIST ImplementationException 
    id ID #IMPLIED&gt;    
 
 </xsl:text>   
 
 <xsl:for-each select="$exceptions">
 	<xsl:variable name="codes" select="following-sibling::group[1]/constant"/>
 
 	<xsl:text>&lt;!ELEMENT </xsl:text>
 	<xsl:value-of select="@name"/>
 	<xsl:text> ((%statement;)*)&gt;
 &lt;!ATTLIST </xsl:text>
 	<xsl:value-of select="@name"/>
 	<xsl:text> code (</xsl:text>
 	<xsl:for-each select="$codes">
 		<xsl:if test="position() &gt; 1">|</xsl:if>
 		<xsl:value-of select="@name"/>
 	</xsl:for-each>
 	<xsl:text>) #REQUIRED&gt;
 </xsl:text>
 
 </xsl:for-each>
    
    
&lt;!ELEMENT atEvents EMPTY&gt;
&lt;!ATTLIST atEvents
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (EventMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;

&lt;!ELEMENT bubbledEvents EMPTY&gt;
&lt;!ATTLIST bubbledEvents
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (EventMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;

&lt;!ELEMENT capturedEvents EMPTY&gt;
&lt;!ATTLIST capturedEvents
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (EventMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;


&lt;!ELEMENT allEvents EMPTY&gt;
&lt;!ATTLIST allEvents
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (EventMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;

&lt;!ELEMENT allNotifications EMPTY&gt;
&lt;!ATTLIST allNotifications
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (UserDataMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;

&lt;!ELEMENT operation EMPTY&gt;
&lt;!ATTLIST operation
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	interface (UserDataNotification) #IMPLIED
&gt;

&lt;!ELEMENT key EMPTY&gt;
&lt;!ATTLIST key
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	interface (UserDataNotification) #IMPLIED
&gt;

&lt;!ELEMENT dst EMPTY&gt;
&lt;!ATTLIST dst
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	interface (UserDataNotification) #IMPLIED
&gt;

<xsl:if test="not($attributes[@name = 'src'])">
&lt;!ELEMENT src EMPTY&gt;
&lt;!ATTLIST src
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	interface (UserDataNotification) #IMPLIED
&gt;
</xsl:if>

<xsl:if test="not($attributes[@name = 'data'])">
&lt;!ELEMENT data EMPTY&gt;
&lt;!ATTLIST data
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	interface (UserDataNotification) #IMPLIED
&gt;
</xsl:if>



&lt;!ELEMENT allErrors EMPTY&gt;
&lt;!ATTLIST allErrors
	id ID #IMPLIED
	obj CDATA #REQUIRED
    interface (DOMErrorMonitor) #IMPLIED
	var CDATA #REQUIRED
&gt;

&lt;!ELEMENT assertLowerSeverity EMPTY&gt;
&lt;!ATTLIST assertLowerSeverity
	id ID #REQUIRED
	obj CDATA #REQUIRED
    interface (DOMErrorMonitor) #IMPLIED
	severity (SEVERITY_WARNING|SEVERITY_ERROR|SEVERITY_FATAL_ERROR) #REQUIRED
&gt;

&lt;!ELEMENT createXPathEvaluator EMPTY&gt;
&lt;!ATTLIST createXPathEvaluator
	id ID #IMPLIED
	var CDATA #REQUIRED
    document CDATA #REQUIRED
&gt;

&lt;!ELEMENT getResourceURI EMPTY&gt;
&lt;!ATTLIST getResourceURI
	id ID #IMPLIED
	var CDATA #REQUIRED
    href CDATA #REQUIRED
    scheme (file|http) #IMPLIED
    contentType CDATA #IMPLIED
&gt;


&lt;!ELEMENT substring EMPTY&gt;
&lt;!ATTLIST substring
	id ID #IMPLIED
	var CDATA #REQUIRED
	obj CDATA #REQUIRED
	beginIndex CDATA #REQUIRED
	endIndex CDATA #IMPLIED
&gt;

&lt;!ELEMENT createTempURI EMPTY&gt;
&lt;!ATTLIST createTempURI
	id ID #IMPLIED
	var CDATA #REQUIRED
    scheme (file|http) #REQUIRED
&gt;



	</xsl:template>

	<!--   This template produces assertion elements for each
	       defined exception type   -->
    <xsl:template name="dynamic-assertions">

		<!--  checking for non-null id attributes gets exception definitions
		         not uses  -->
		<xsl:for-each select="//exception[@id]">		
			<xsl:variable name="exception" select="@name"/>
			<xsl:text>&lt;!ELEMENT assert</xsl:text>
			<xsl:value-of select="@name"/>
			<xsl:text> (metadata?,(</xsl:text>
			<xsl:variable name="codes" select="following-sibling::group[1]/constant"/>
			<xsl:value-of select="$codes[1]/@name"/>
			<xsl:for-each select="$codes[position() &gt; 1]">
				<xsl:text>|</xsl:text>
				<xsl:value-of select="@name"/>
			</xsl:for-each>
			<xsl:text>))&gt;
&lt;!ATTLIST assert</xsl:text>
			<xsl:value-of select="@name"/>
			<xsl:text> id ID #REQUIRED&gt;
</xsl:text>

		</xsl:for-each>


		<!--  produce elements for each of the defined codes for
			    the exception.  The content model of these
				elements are the methods and attributes that
				raise that specific code.
		-->
		<xsl:for-each select="//constant[contains(@name, '_ERR') or contains(@name, 'NO_GRAMMAR_AVAILABLE')]">
            <xsl:variable name="current" select="."/>
            <!--   only produce an element for the first occurance   -->
            <xsl:if test="not(preceding::constant[@name = $current/@name])">
				<xsl:text>&lt;!ELEMENT </xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:variable name="code" select="@name"/>
				<xsl:variable name="code-colon"><xsl:value-of select="@name"/>:</xsl:variable>
				<xsl:variable name="attrraises" select="$attributes/*[name() = 'getraises' or name() = 'setraises']/exception[contains(string(.),$code-colon)]"/>
                <!-- suppress production for XPathExpression.evaluate since it is a subset of XPathEvaluator.evaluate  -->
				<xsl:variable name="methodraises" select="$methods[not(@id = 'XPathExpression-evaluate')]/raises/exception[contains(string(.),$code-colon)]"/>
				<xsl:variable name="total" select="count($attrraises) + count($methodraises)"/>
				<xsl:choose>
					<xsl:when test="$total = 0">
						<xsl:text> EMPTY </xsl:text>
					</xsl:when>

					<xsl:when test="$total = 1">
						<xsl:text> ( </xsl:text>
						<xsl:for-each select="$attrraises">
							<xsl:value-of select="ancestor::attribute/@name"/>
						</xsl:for-each>
						<xsl:for-each select="$methodraises">
							<xsl:value-of select="ancestor::method/@name"/>
						</xsl:for-each>
						<xsl:text> ) </xsl:text>
					</xsl:when>

					<xsl:when test="count($attrraises) = 0">
						<xsl:text> ( </xsl:text>
						<xsl:for-each select="$methodraises[1]">
							<xsl:value-of select="ancestor::method/@name"/>
						</xsl:for-each>
						<xsl:for-each select="$methodraises[position() &gt; 1]">
							<xsl:text> | </xsl:text>
							<xsl:value-of select="ancestor::method/@name"/>
						</xsl:for-each>
						<xsl:text> ) </xsl:text>
					</xsl:when>


					<xsl:otherwise>
						<xsl:text> ( </xsl:text>
						<xsl:for-each select="$attrraises[1]">
							<xsl:value-of select="ancestor::attribute/@name"/>
						</xsl:for-each>
						<xsl:for-each select="$attrraises[position() &gt; 1]">
							<xsl:text> | </xsl:text>
							<xsl:value-of select="ancestor::attribute/@name"/>
						</xsl:for-each>
						<xsl:for-each select="$methodraises">
							<xsl:text> | </xsl:text>
							<xsl:value-of select="ancestor::method/@name"/>
						</xsl:for-each>
						<xsl:text> ) </xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text> &gt;
</xsl:text>
            </xsl:if>
		</xsl:for-each>

	</xsl:template>

	<!--  generate element that depend on the source document   -->				
    <xsl:template name="dynamic-elements">

		<xsl:text>&lt;!ENTITY % statement "%framework-statement;|%assertion;</xsl:text>

		<xsl:for-each select="$attributes">
			<xsl:sort select="@name"/>
			<xsl:variable name="current" select="."/>
			<xsl:if test="not(preceding::attribute[@name=$current/@name])">
				<xsl:text> | </xsl:text>
				<xsl:value-of select="@name"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:for-each select="$methods[@name != 'handleEvent']">
			<xsl:sort select="@name"/>
			<xsl:variable name="current" select="."/>
			<xsl:if test="not(preceding::method[@name=$current/@name] or @name = $attributes/@name)">
				<xsl:text> | </xsl:text>
				<xsl:value-of select="@name"/>
			</xsl:if>
		</xsl:for-each>
		<xsl:text> "&gt;
</xsl:text>
	</xsl:template>

	<!--  produce an attribute with the name specified by $paramName,
	      use specified by $use and whose type is appropriate for
		  the type of the param   -->
	<xsl:template name="param-type">
		<xsl:param name="paramName"/>
		<xsl:param name="type"/>
		<xsl:param name="use"/>
		<xsl:text>    </xsl:text>
		<xsl:value-of select="normalize-space($paramName)"/>
		<xsl:text> CDATA </xsl:text>
		<xsl:value-of select="$use"/>
		<xsl:text>
</xsl:text>
	</xsl:template>

    <xsl:template name="produce-sink">
        <xsl:param name="sinks"/>
        <xsl:param name="interface"/>
        <xsl:for-each select="$sinks[@name=$interface]">
            <!-- if interface inherits from another sink interface then
                       produce its methods and attributes first   -->
            <xsl:choose>
                <!--   if inherits contains a namespace scope   -->
                <xsl:when test="contains(@inherits,'::')">
                    <xsl:call-template name="produce-sink">
                        <xsl:with-param name="sinks" select="$sinks"/>
                        <xsl:with-param name="interface" select="substring-after(@inherits, '::')"/>
                    </xsl:call-template>
                    <xsl:for-each select="method|attribute">
                        <xsl:text> , </xsl:text>
                        <xsl:value-of select="@name"/>
                    </xsl:for-each>
                </xsl:when>
                <!--  inherits in the same module   -->
                <xsl:when test="@inherits">
                    <xsl:call-template name="produce-sink">
                        <xsl:with-param name="sinks" select="$sinks"/>
                        <xsl:with-param name="interface" select="@inherits"/>
                    </xsl:call-template>
                    <xsl:for-each select="method|attribute">
                        <xsl:text> , </xsl:text>
                        <xsl:value-of select="@name"/>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:for-each select="method|attribute">
                        <xsl:if test="position() &gt; 1"> , </xsl:if>
                        <xsl:value-of select="@name"/>
                    </xsl:for-each>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
