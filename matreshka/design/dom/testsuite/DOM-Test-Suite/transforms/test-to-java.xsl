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
This transform generates Java source code from a language independent
test representation.

This transform requires an auxiliary file "interfaces.xml" that 
is produced by applying "extract.xsl" to the appropriate DOM
specificiation.


Usage:

saxon -o someTest.java someTest.xml test-to-java.xsl


-->

<!--
$Log: test-to-java.xsl,v $
Revision 1.66  2004-04-15 14:59:29  dom-ts-4
Copyright notice update (bug 672)

Revision 1.65  2004/03/11 01:44:22  dom-ts-4
Checkstyle fixes (bug 592)

Revision 1.64  2004/02/17 16:57:58  dom-ts-4
Refined criteria for detection of doubles in list members (bug 532)

Revision 1.63  2004/02/17 05:39:21  dom-ts-4
normalization error instrumentation and req NS awareness (bug 531)

Revision 1.62  2004/02/09 21:41:14  dom-ts-4
Tweak for src production (bug 513)

Revision 1.61  2004/02/09 07:12:22  dom-ts-4
Changed tests to expect LSException (bug 518)

Revision 1.60  2004/01/21 17:46:03  dom-ts-4
Add UserDataHandler and DOMErrorHandler tests (bug 477)

Revision 1.59  2004/01/16 06:50:32  dom-ts-4
DOMImplementationRegistry tests (bug 463)

Revision 1.58  2004/01/05 08:27:15  dom-ts-4
XHTML compatible L3 Core tests  (bug 455)

Revision 1.57  2003/12/30 06:17:07  dom-ts-4
Miscellaneous L&S changes based on implementor feedback (bug 447)

Revision 1.56  2003/12/23 03:27:25  dom-ts-4
Adds fail construct (bug 445)

Revision 1.55  2003/12/19 22:20:49  dom-ts-4
willBeModified violation detection support (bug 412)

Revision 1.54  2003/12/19 07:50:01  dom-ts-4
L3 XPath schema validation fixes (incl change of append element) (bug 430)

Revision 1.53  2003/12/18 05:25:41  dom-ts-4
Refinement of try production (bug 439)

Revision 1.52  2003/12/17 19:29:15  dom-ts-4
Add try construct to test language (bug 439)

Revision 1.51  2003/12/16 05:36:31  dom-ts-4
Adds support for for-each member variables of value types (bug 429)

Revision 1.50  2003/12/15 21:37:45  dom-ts-4
test-matrix and test-to-jsunit transform, list member type (Bug 429)

Revision 1.49  2003/12/09 08:22:27  dom-ts-4
Additional L&S tests, mostly configuration (Bug 401)

Revision 1.48  2003/12/08 07:50:50  dom-ts-4
L&S support for Oracle XDK 10.0.1.0A, metadata fixes, test results matrix (bug 396)

Revision 1.47  2003/12/02 04:01:19  dom-ts-4
Load/save fixup (bug 396)

Revision 1.46  2003/11/19 03:55:52  dom-ts-4
ECMAScript missing ) on assertEqualsCollection
expected instead of @expected on less, lessOrEquals...
Bug 364

Revision 1.45  2003/11/18 08:39:58  dom-ts-4
Fix Java production for attributes that start with is (bug 379)

Revision 1.44  2003/11/10 07:34:13  dom-ts-4
Update for 2003-11-07 CRs (bug 375)

Revision 1.43  2003/10/24 17:10:16  dom-ts-4
Changed copyright dates, bug 369

Revision 1.42  2003/07/11 08:05:49  plehegar
The test-to-java.xsl incorrectly transformed DOMStringList to Java String.

Revision 1.41  2003/06/27 05:37:30  dom-ts-4
contentType condition fixes: http://www.w3.org/Bugs/Public/show_bug.cgi?id=241

Revision 1.40  2003/04/23 05:48:24  dom-ts-4
DOMTSML and framework support for createXPathEvaluator
http://www.w3.org/Bugs/Public/show_bug.cgi?id=190

Revision 1.39  2003/04/09 21:16:53  plehegar
Added handling for assertXPathException
Modified import statements to differenciate DOM Level 3 XPath and LS

Revision 1.38  2003/04/03 07:19:19  dom-ts-4
Support value parameter for DOMInputStream variable definition by call to openStream

Revision 1.37  2003/02/28 07:42:59  dom-ts-4
Update for 2003-02-26 L3 Working Drafts

Revision 1.36  2003/02/13 03:24:57  dom-ts-4
Added casting logic to return value of the framework's load method

Revision 1.35  2003/02/10 05:04:54  dom-ts-4
Removed spurious brace from production for assertFalse

Revision 1.34  2003/02/04 05:51:35  dom-ts-4
Added contains condition

Revision 1.33  2003/02/02 21:38:03  dom-ts-4
Fixes for DocumentLS.load

Revision 1.32  2003/01/29 04:58:15  dom-ts-4
Added (short) on short literals passed to inner classes
Added recursion into base interface for inner class feature
production (DOMWriterFilter.acceptNode)

Revision 1.31  2003/01/25 17:59:16  dom-ts-4
Prettified generated java to conform to Sun coding conventions

Revision 1.30  2003/01/20 06:11:17  dom-ts-4
Fixed inner class production to change DOMString to String.

Revision 1.29  2003/01/17 06:46:20  dom-ts-4
Fixed "undeclared" on declared variable problem

Revision 1.28  2003/01/16 06:38:44  dom-ts-4
Added cast to short when needed on number literal parameters

Revision 1.27  2002/11/26 07:17:24  dom-ts-4
Fixed improper placement of a few xsl:param elements.

Revision 1.26  2002/08/13 04:46:44  dom-ts-4
Added intermediate get and set elements for attributes
on user implemented interfaces
Other load-save support

Revision 1.25  2002/08/12 09:01:27  dom-ts-4
Added production of inner class property accessors

Revision 1.24  2002/07/01 03:57:06  dom-ts-4
Added name parameter to assertURIEquals

Revision 1.23  2002/06/06 05:09:33  dom-ts-4
Parameterized 'import org.w3c.dom.html.*' so that L2 tests can import org.w3c.dom.html2.*

Revision 1.22  2002/06/04 05:03:22  dom-ts-4
Added support for [return], automatic constructor of EventMonitor

Revision 1.21  2002/06/03 23:45:22  dom-ts-4
Updates for Events tests

Revision 1.20  2002/02/26 05:25:52  dom-ts-4
Support for hasFeature("HTML", "2.0") == "false" conditions on tests

Revision 1.19  2002/02/03 04:22:35  dom-ts-4
DOM4J and Batik support added.
Rework of parser settings

Revision 1.18  2002/01/04 08:09:47  dom-ts-4
Added import org.w3c.dom.html.* and .events.*;

Revision 1.17  2001/12/10 05:37:22  dom-ts-4
Added xml_alltests, svg_alltests, and html_alltests suites to run all tests
using a particular content type.

Revision 1.16  2001/11/16 08:23:20  dom-ts-4
Eliminated spurious casts on method parameters

Revision 1.15  2001/10/25 09:29:28  dom-ts-4
test-to-java updates for DOM L2

Revision 1.14  2001/10/18 14:21:59  dom-ts-4
Fixed regexp pattern for stringLiteral
Explicitly specified UTF-8 encoding for test-to-java.xsl, etc
Specified UTF8 encoding for javac

Revision 1.13  2001/10/18 07:58:17  dom-ts-4
assertURIEquals added
Can now run from dom1-core.jar

Revision 1.12  2001/08/30 08:30:18  dom-ts-4
Added metadata and Software licence (dropped in earlier processing) to test
Enhanced test-matrix.xsl

Revision 1.11  2001/08/23 08:01:49  dom-ts-4
Test fixups for ignoring whitespace, et al

Revision 1.10  2001/08/22 22:12:50  dom-ts-4
Now passing all tests with default settings

Revision 1.9  2001/08/21 06:06:12  dom-ts-4
DOM 1 SE targets
Fixed cases that locked Xalan
org.w3c.domts.level1.core.alltests
DOM2 DTD/Schema

Revision 1.8  2001/08/20 06:56:38  dom-ts-4
Full compile (-2 files that lock up Xalan 2.1)

Revision 1.7  2001/08/15 04:44:03  dom-ts-4
Added dom1-gen-ecmascript target to build.xml
Minor fixes to test-to-java.xsl and test-to-ecmascript.xsl

Revision 1.6  2001/08/14 18:49:35  dom-ts-4
Changed location of resource files
Remove spurious required ID's from DTD
Added xmlns:xsi and xsi:schema location to DTD
Removed package and targetURI attributes from Schema/DTD

Revision 1.5  2001/07/23 04:52:20  dom-ts-4
Initial test running using JUnit.

Revision 1.4  2001/07/20 05:44:32  dom-ts-4
Initial SVG support.  multiply renamed mult,
All implementation conditions combined into implementationAttribute element

-->


<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--  relative to transform   -->
    <xsl:param name="interfaces-docname">../build/dom1-interfaces.xml</xsl:param>
    <xsl:param name="package">org.w3.domts.level1.core</xsl:param>
    <xsl:param name="target-uri-base">http://www.w3.org/2001/DOM-Test-Suite/tests/Level-1/</xsl:param>
    <xsl:param name="import-html">import org.w3c.dom.html.*;</xsl:param>
<xsl:output method="text" encoding="UTF-8"/>
<xsl:variable name="domspec" select="document($interfaces-docname)"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<!-- 
       Copy any comments from the source file that have
       a copyright notice  

-->
<xsl:template match="comment()[contains(., 'Copyright')]">
/*
This Java source file was generated by test-to-java.xsl
and is a derived work from the source document.
The source document contained the following notice:

<xsl:value-of select="."/>
*/
</xsl:template>

<xsl:template name="expand-tabs">
    <xsl:param name="text"/>
    <xsl:choose>
        <xsl:when test="contains($text, '&#9;')">
            <xsl:value-of select="substring-before($text, '&#9;')"/>
            <xsl:text>    </xsl:text>
            <xsl:call-template name="expand-tabs">
                <xsl:with-param name="text" select="substring-after($text, '&#9;')"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="$text"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="text()" mode="metadata">
    <xsl:call-template name="expand-tabs">
        <xsl:with-param name="text" select="."/>
    </xsl:call-template>
</xsl:template>

<!--   produces JavaDoc for metadata elements   -->
<xsl:template match="*[local-name() = 'metadata']">
    <xsl:text>/**
</xsl:text>
    <xsl:call-template name="emit-description">
    	<xsl:with-param name="description" select="translate(*[local-name() = 'description'], '&#9;', ' ')"/>
    </xsl:call-template>

<xsl:for-each select="*[local-name()='creator']">
<xsl:text>* @author </xsl:text><xsl:apply-templates select="." mode="metadata"/><xsl:text>
</xsl:text>
</xsl:for-each>

<xsl:for-each select="*[local-name()='contributor']">
<xsl:text>* @author </xsl:text><xsl:apply-templates select="." mode="metadata"/><xsl:text>
</xsl:text>
</xsl:for-each>

<xsl:for-each select="*[local-name()='subject']">
<xsl:text>* @see &lt;a href="</xsl:text><xsl:value-of select="@resource"/>"&gt;<xsl:value-of select="@resource"/><xsl:text>&lt;/a&gt;
</xsl:text>
</xsl:for-each>

<xsl:for-each select="*[local-name()='source']">
<xsl:text>* @see &lt;a href="</xsl:text><xsl:value-of select="@resource"/>"&gt;<xsl:value-of select="@resource"/><xsl:text>&lt;/a&gt;
</xsl:text>
</xsl:for-each>
<xsl:text>*/
</xsl:text>
</xsl:template>

<xsl:template name="emit-description">
	<xsl:param name="description"/>
	<xsl:choose>
		<xsl:when test="contains($description, '&#xA;')">
			<xsl:variable name="preceding" select="substring-before($description, '&#xA;')"/>
			<xsl:if test="string-length($preceding) &gt; 0">		
				<xsl:text> * </xsl:text>
				<xsl:value-of select="substring-before($description, '&#xA;')"/>
				<xsl:text>
</xsl:text>
			</xsl:if>
			<xsl:variable name="following" select="substring-after($description, '&#xA;')"/>
			<xsl:if test="string-length($following) &gt; 0">
				<xsl:call-template name="emit-description">
					<xsl:with-param name="description" select="substring-after($description, '&#xA;')"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text> * </xsl:text>
			<xsl:value-of select="$description"/>
			<xsl:text>
</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!--   
    this template assumes that the context node is an implementationAttribute
    and emits something like DocumentBuilderSetting.validating or
        DocumentBuilderSetting.notExpandEntityReferences

-->
<xsl:template name="emit-setting">
    <xsl:text>org.w3c.domts.DocumentBuilderSetting.</xsl:text>
    <xsl:choose>
        <xsl:when test="@value='true'">
            <xsl:value-of select="@name"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>not</xsl:text>
            <xsl:value-of select="translate(substring(@name, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
            <xsl:value-of select="substring(@name, 2)"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="implCheck">
<xsl:variable name="implAttrs" select="*[local-name() = 'implementationAttribute']"/>
<xsl:choose>
    <xsl:when test="$implAttrs">
        <xsl:text>
      org.w3c.domts.DocumentBuilderSetting[] settings = 
          new org.w3c.domts.DocumentBuilderSetting[] {
</xsl:text>
        <xsl:for-each select="$implAttrs">
            <xsl:if test="position() &gt; 1">,
</xsl:if>
            <xsl:call-template name="emit-setting"/>
        </xsl:for-each>
        <xsl:text>
        };
        DOMTestDocumentBuilderFactory testFactory = factory.newInstance(settings);
        setFactory(testFactory);
</xsl:text>
    </xsl:when>
    <xsl:otherwise>
        <xsl:text>      super(factory);
</xsl:text>
    </xsl:otherwise>
</xsl:choose>

<xsl:variable name="featureConditions" select="*[local-name() = 'hasFeature' and not(preceding-sibling::*[local-name()='var'])]"/>

<xsl:if test="$featureConditions">
    <xsl:for-each select="$featureConditions">
        <xsl:text>      if (factory.hasFeature(</xsl:text>
        <xsl:value-of select="@feature"/>
        <xsl:text>, </xsl:text>
        <xsl:choose>
            <xsl:when test="@version">
                <xsl:value-of select="@version"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>null</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>) != </xsl:text>
        <xsl:choose>
            <xsl:when test="@value='false'">false</xsl:when>
            <xsl:otherwise>true</xsl:otherwise>
        </xsl:choose>
        <xsl:text>) {
         throw org.w3c.domts.DOMTestIncompatibleException.incompatibleFeature(</xsl:text>
        <xsl:value-of select="@feature"/>
        <xsl:choose>
            <xsl:when test="@version">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="@version"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>, null</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>);
      }
</xsl:text>
    </xsl:for-each>
</xsl:if>

</xsl:template>


<!--   when encountering a test   -->
<xsl:template match="*[local-name()='test']">
package <xsl:value-of select="$package"/>;

import org.w3c.dom.*;
<xsl:value-of select="$import-html"/>
<xsl:if test="descendant::*[local-name() = 'var' and contains('EventTarget EventListener Event EventException UIEvent MouseEvent KeyEvent MutationEvent DocumentEvent ', concat(@type, ' '))]">
import org.w3c.dom.events.*;
</xsl:if>
<xsl:if test="contains($package, 'level3.ls')">
import org.w3c.dom.ls.*;
</xsl:if>
<xsl:if test="contains($package, 'level3.xpath')">
import org.w3c.dom.xpath.*;
</xsl:if>
<xsl:if test="contains($package, 'level3.validation')">
import org.w3c.dom.validation.*;
</xsl:if>

import org.w3c.domts.DOMTestCase;
import org.w3c.domts.DOMTestDocumentBuilderFactory;


<!--  if there is a metadata child element then
          produce documentation comments    -->
<xsl:apply-templates select="*[local-name()='metadata']"/>
<xsl:text>public final class </xsl:text><xsl:value-of select="@name"/>
    <xsl:text> extends DOMTestCase {

   /**
    * Constructor.
    * @param factory document factory, may not be null
    </xsl:text>
    <xsl:variable name="potentialIncompatibilities" select="*[local-name() = 'implementationAttribute' or local-name() = 'load' or (local-name() = 'hasFeature' and not(preceding-sibling::*[local-name()='var']))]"/>
    <xsl:if test="$potentialIncompatibilities">
        <xsl:text>* @throws org.w3c.domts.DOMTestIncompatibleException Thrown if test is not compatible with parser configuration
    </xsl:text>
    </xsl:if>
    <xsl:text>*/
   public </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>(final DOMTestDocumentBuilderFactory factory) </xsl:text>
    <!--  if there are any implementationAttribute, load or hasFeature (before a var) elements
               then must declare that we might throw an incompatible test exception   -->
    <xsl:if test="$potentialIncompatibilities">
        <xsl:text> throws org.w3c.domts.DOMTestIncompatibleException</xsl:text>
    </xsl:if>
    <xsl:text> {
</xsl:text>
<xsl:call-template name="implCheck"/>
<xsl:text>
    //
    //   check if loaded documents are supported for content type
    //
    String contentType = getContentType();
    </xsl:text>
	<xsl:for-each select="*[local-name() = 'load' and @href]">
		<xsl:text>preload(contentType, "</xsl:text>
		<xsl:value-of select="@href"/>
		<xsl:text>", </xsl:text>
		<xsl:value-of select="@willBeModified"/>
		<xsl:text>);
    </xsl:text>
	</xsl:for-each>
	<xsl:text>}
</xsl:text>

<xsl:apply-templates mode="innerClass" select="*[local-name() = 'var' and *[local-name() != 'member']]"/>


<xsl:text>
   /**
    * Runs the test case.
    * @throws Throwable Any uncaught exception causes test to fail
    */
   public void runTest() throws Throwable {
      </xsl:text>
<xsl:apply-templates mode="body">
    <xsl:with-param name="vardefs" select="*[local-name() = 'var']"/>
</xsl:apply-templates>}
   /**
    *  Gets URI that identifies the test.
    *  @return uri identifier of test
    */
   public String getTargetURI() {
      return "<xsl:value-of select="concat($target-uri-base, @name)"/>";
   }
   /**
    * Runs this test from the command line.
    * @param args command line arguments
    */
   public static void main(final String[] args) {
        DOMTestCase.doMain(<xsl:value-of select="@name"/>.class, args);
   }
}

</xsl:template>

<xsl:template match="*[local-name() = 'var']" mode="innerClass">
   <xsl:param name="vardefs"/>
   <xsl:text>
     /**
      *    Inner class implementation for variable </xsl:text>
   <xsl:value-of select="@name"/>
   <xsl:text> 
      */
      private static class </xsl:text>
   <xsl:value-of select="concat(@type, generate-id(.))"/>
   <xsl:text>
           extends org.w3c.domts.DOMTestInnerClass 
           implements </xsl:text>
   <xsl:value-of select="@type"/>
   <xsl:text> {
       </xsl:text>
   <xsl:for-each select="*[local-name() = 'var']">

        <xsl:text> /**
        * local copy of variable specified in value parameter
        */
        private </xsl:text>
        <xsl:call-template name="produce-type">
            <xsl:with-param name="type" select="@type"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>;
        </xsl:text>
   </xsl:for-each>
   <!-- constructor    -->
   <xsl:text>/**
        * Constructor
        * @param test test case</xsl:text>
       <!--  write @param comments for each parameter   -->
        <xsl:for-each select="*[local-name() = 'var' and @value]">
        <xsl:text>
        * @param </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> Value from value attribute of nested var element</xsl:text>
   </xsl:for-each>
   <xsl:text>
        */
        public </xsl:text>
   <xsl:value-of select="concat(@type, generate-id(.))"/>
   <xsl:text>(DOMTestCase test</xsl:text>
   <xsl:for-each select="*[local-name() = 'var' and @value]">
        <xsl:text>, </xsl:text>
        <xsl:call-template name="produce-type">
            <xsl:with-param name="type" select="@type"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:value-of select="@name"/>
   </xsl:for-each>
   <xsl:text>) { 
        super(test);
           </xsl:text>
   <xsl:for-each select="*[local-name() = 'var' and @value]">
        <xsl:text>this.</xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text> = </xsl:text>
        <xsl:value-of select="@name"/>
        <xsl:text>;
           </xsl:text>
   </xsl:for-each>
   <xsl:text>}
   </xsl:text>
   <xsl:variable name="interface-name" select="@type"/>
   <xsl:variable name="interface" select="$domspec/library/interface[@name=$interface-name]"/>
   <xsl:for-each select="*[local-name() != 'var']">
        <xsl:call-template name="produce-inner-feature">
            <xsl:with-param name="method-name" select="local-name()"/>
            <xsl:with-param name="interface" select="$interface"/>
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:call-template>
   </xsl:for-each>
   <xsl:text>}
</xsl:text>
</xsl:template>


<xsl:template name="produce-inner-feature">
    <xsl:param name="interface"/>
    <xsl:param name="method-name"/>
    <xsl:param name="vardefs"/>

    <xsl:variable name="method-def" select="$interface/method[@name=$method-name]"/>
        <xsl:choose>
            <xsl:when test="$method-def">
                <xsl:text>
        /**
         *    </xsl:text><xsl:value-of select="$method-def/descr"/>
         <xsl:for-each select="$method-def/parameters/param">
            <xsl:text>
         * @param </xsl:text><xsl:value-of select="@name"/><xsl:text> </xsl:text><xsl:value-of select="normalize-space(descr)"/>
         </xsl:for-each>
         <xsl:for-each select="$method-def/returns[@type and @type != 'void']">
         	<xsl:text>
         * @return </xsl:text>
         	<xsl:value-of select="normalize-space(descr)"/>         
         </xsl:for-each>
         <xsl:text>
         */
         public </xsl:text>
                <xsl:choose>
                    <xsl:when test="$method-def/returns[@type and @type != 'void']">
                        <xsl:apply-templates select="$method-def/returns/@type">
                            <xsl:with-param name="vardefs" select="$vardefs"/>
                        </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>void</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
                <xsl:value-of select="$method-def/@name"/>
                <xsl:text>(</xsl:text>
                <xsl:for-each select="$method-def/parameters/param">
                    <xsl:if test="position() &gt; 1">
                        <xsl:text>, </xsl:text>
                    </xsl:if>
                    <xsl:apply-templates select="@type">
                        <xsl:with-param name="vardefs" select="$vardefs"/>
                    </xsl:apply-templates>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@name"/>
                </xsl:for-each>
                <xsl:text>) {
        </xsl:text>

             <xsl:apply-templates mode="body">
                    <xsl:with-param name="vardefs" select="*[local-name() = 'var'] | $method-def/parameters/param | preceding-sibling::*[local-name() = 'var']"/>
             </xsl:apply-templates>
                <xsl:text>}
</xsl:text>
            </xsl:when>

            <!--  not method, possibly an attribute   -->
            <xsl:when test="$interface/attribute[@name = $method-name]">
                <xsl:for-each select="*">
                    <xsl:text>
        /**
         *    </xsl:text><xsl:value-of select="$method-def/descr"/>
                    <xsl:for-each select="$method-def/parameters/param">
                        <xsl:text>
         * @param </xsl:text><xsl:value-of select="@name"/><xsl:text> </xsl:text><xsl:value-of select="descr"/>
                    </xsl:for-each>
                    <xsl:text>
         */ 
         public </xsl:text>
                <xsl:choose>
                    <xsl:when test="local-name() = 'get'">
                        <xsl:call-template name="produce-type">
                            <xsl:with-param name="type" select="$interface/attribute[@name = $method-name]/@type"/>
                        </xsl:call-template>
                        <xsl:text> get</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>void set</xsl:otherwise>
                </xsl:choose>
                <xsl:value-of select="concat(translate(
                    substring($method-name, 1, 1), 'abcdefghijklmnopqrstuvwxyz',
                    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'), substring($method-name, 2))"/>
                <xsl:text>(</xsl:text>
                <xsl:if test="local-name() = 'set'">
                    <xsl:call-template name="produce-type">
                        <xsl:with-param name="type" select="$interface/attribute[@name = $method-name]/@type"/>
                    </xsl:call-template>
                    <xsl:text> value</xsl:text>
                </xsl:if>
                <xsl:text>) {
        </xsl:text>

             <xsl:apply-templates mode="body">
                    <xsl:with-param name="vardefs" select="*[local-name() = 'var'] | $method-def/parameters/param | preceding-sibling::*[local-name() = 'var']"/>
             </xsl:apply-templates>
                <xsl:text>}
</xsl:text>
                </xsl:for-each>
            </xsl:when>

            <xsl:when test="$interface/@inherits">
                <xsl:call-template name="produce-inner-feature">
                    <xsl:with-param name="interface" select="$domspec/library/interface[@name=$interface/@inherits]"/>
                    <xsl:with-param name="method-name" select="$method-name"/>
                </xsl:call-template>
            </xsl:when>

            <xsl:otherwise>
                <xsl:message terminate="yes">Method <xsl:value-of select="$method-name"/> not found for interface <xsl:value-of select="$interface/@name"/>.</xsl:message>
            </xsl:otherwise>
        </xsl:choose>
</xsl:template>

<!--   when encountering a test suite   -->
<xsl:template match="*[local-name()='suite']">
package <xsl:value-of select="$package"/>;

import org.w3c.domts.DOMTestCase;
import org.w3c.domts.DOMTestSuite;
import org.w3c.domts.DOMTestSink;
import org.w3c.domts.DOMTestDocumentBuilderFactory;

<!--  if there is a metadata child element then
          produce documentation comments    -->
<xsl:choose>
        <xsl:when test="*[local-name()='metadata']">
            <xsl:apply-templates select="*[local-name()='metadata']"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>    /**
    *  Test suite
    *  @author W3C DOM Test Working Group
    **/
    </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>public class </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text> extends DOMTestSuite {

    /**
    * Constructor
    * @param factory document factory, may not be null
    * @throws Exception Thrown if test is not compatible with settings
    */
   public </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>(DOMTestDocumentBuilderFactory factory) throws Exception {
</xsl:text>
    <xsl:call-template name="implCheck"/>
    <xsl:text>
      setFactory(factory);
   }

   /**
    *   Build test suite by adding each test to the test sink
    *   @param sink test sink
    */
   public void build(DOMTestSink sink) {
</xsl:text>
    <xsl:for-each select="*[local-name() = 'suite.member']">
        <xsl:variable name="testDef" select="document(@href, .)/*"/>
         <xsl:text>      sink.addTest(</xsl:text>
         <xsl:value-of select="$testDef/@name"/>
         <xsl:text>.class);
</xsl:text>
    </xsl:for-each>
   }
   /**
    *  Gets URI that identifies the test suite
    *  @return uri identifier of test suite
    */
   public String getTargetURI() {
      return "<xsl:value-of select="concat($target-uri-base, @name)"/>";
   }

   /**
    * Runs individual test
    * @param args command line arguments
    */
   public static void main(String[] args) {
        DOMTestCase.doMain(<xsl:value-of select="@name"/>.class, args);
   }

}
</xsl:template>



<!--    
    The following templates generate the body of the test function   
    
-->

<!--

    Implementation conditions and metadata elements produce nothing
    in the body of the test method

-->
<xsl:template match="*[local-name()='metadata']" mode="body"/>
<xsl:template match="*[local-name()='validating']" mode="body"/>
<xsl:template match="*[local-name()='coalescing']" mode="body"/>
<xsl:template match="*[local-name()='expandEntityReferences']" mode="body"/>
<xsl:template match="*[local-name()='ignoringElementContentWhitespace']" mode="body"/>
<xsl:template match="*[local-name()='ignoringComments']" mode="body"/>
<xsl:template match="*[local-name()='namespaceAware']" mode="body"/>
<xsl:template match="*[local-name()='signed']" mode="body"/>
<xsl:template match="*[local-name()='not']" mode="body"/>


<!--   this template generates code for the DOMString.length  -->
<xsl:template match="*[local-name()='length' and @interface='DOMString']" mode="body">
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@obj"/>
    <xsl:text>.length();
      </xsl:text>
</xsl:template>

<!--   implementation attribute doesn't do anything in the body of the test  -->
<xsl:template match="*[local-name()='implementationAttribute']" mode="body"/>

<!--  
     hasFeature is a little unusual as both an implementation
     condition and a DOM function.  This template should only
     produce code when used as a DOM function.
-->
<xsl:template match="*[local-name()='hasFeature']" mode="body">
    <!--  if it doesn't have a var then 
            it is part of the implementation conditions and
            should not be produced in the body of the function  -->
    <xsl:if test="@var">
        <xsl:value-of select="@var"/>
        <xsl:text> = </xsl:text>
        <!--  use @obj if provided, otherwise _framework   -->
        <xsl:if test="@obj">
            <xsl:value-of select="@obj"/>
            <xsl:text>.</xsl:text>
        </xsl:if>
        <xsl:text>hasFeature(</xsl:text>
        <xsl:value-of select="@feature"/>
        <xsl:text>, </xsl:text>
        <xsl:choose>
            <xsl:when test="@version">
                <xsl:value-of select="@version"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>null</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>);
</xsl:text>
    </xsl:if>
</xsl:template>


<xsl:template match="*[local-name()='DOMImplementationRegistry.newInstance']" mode="body">
        <xsl:value-of select="@var"/>
        <xsl:text> = org.w3c.dom.bootstrap.DOMImplementationRegistry.newInstance();
         </xsl:text>
</xsl:template>


<xsl:template match="*[starts-with(local-name(),'getDOMImplementation')]" mode="body">
        <xsl:value-of select="@var"/>
        <xsl:text> = </xsl:text>
        <xsl:value-of select="@obj"/>
        <xsl:text>.</xsl:text>
        <xsl:value-of select="local-name()"/>
        <xsl:text>(</xsl:text>
        <xsl:value-of select="@features"/>
        <xsl:text>);
         </xsl:text>
</xsl:template>

<!--    

    test framework constructs

-->
<xsl:template match="*[local-name()='var']" mode="body">
    <xsl:variable name="varname" select="@name"/>
    <xsl:apply-templates select="@type"/><xsl:text> </xsl:text><xsl:value-of select="$varname"/>
    <xsl:choose>
        <xsl:when test="@isNull='true'">
            <xsl:text> = null;
</xsl:text>
        </xsl:when>

        <xsl:when test="@value and @type = 'LSInputStream'">
            <xsl:text> = createStream(</xsl:text>
            <xsl:value-of select="@value"/>
            <xsl:text>);</xsl:text>
        </xsl:when>
        
        <xsl:when test="@value and @type = 'LSReader'">
        	<xsl:text> = new java.io.StringReader(</xsl:text>
        	<xsl:value-of select="@value"/>
        	<xsl:text>);</xsl:text>
        </xsl:when>
        
        <xsl:when test="@type = 'LSOutputStream' and (not(@isNull) or @isNull='false')">
           <xsl:text> = new java.io.ByteArrayOutputStream();</xsl:text>
        </xsl:when>
        
        <xsl:when test="@type = 'LSWriter' and (not(@isNull) or @isNull='false')">
           <xsl:text> = new java.io.StringWriter();</xsl:text>
        </xsl:when>

        <!--  explict value, just add it  -->
        <xsl:when test="@value"> = <xsl:apply-templates select="@value"/>;</xsl:when>

        <!--  event monitor type implies constructor    -->
        <xsl:when test="@type='EventMonitor'">
            <xsl:text> = new org.w3c.domts.EventMonitor();
      </xsl:text>
        </xsl:when>


        <!--  DOMErrorMonitor type implies constructor    -->
        <xsl:when test="@type='DOMErrorMonitor'">
            <xsl:text> = new org.w3c.domts.DOMErrorMonitor();
      </xsl:text>
        </xsl:when>


        <!--  UserDataMonitor type implies constructor    -->
        <xsl:when test="@type='UserDataMonitor'">
            <xsl:text> = new org.w3c.domts.UserDataMonitor();
      </xsl:text>
        </xsl:when>

        <!--  member, allocate collection or list and populate it  -->
        <xsl:when test="@type='List' or @type='Collection'">
            <xsl:text> = new java.util.ArrayList();
      </xsl:text>
            <xsl:for-each select="*[local-name()='member']">
                <xsl:value-of select="$varname"/><xsl:text>.add(</xsl:text>
                <xsl:choose>
                	<!-- if explicitly declared a short -->
                    <xsl:when test="@type = 'short'">
                    	<xsl:text>new Short((short) </xsl:text>
                        <xsl:value-of select="text()"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <!--  if value is NaN  -->
                    <xsl:when test="text() = 'NaN'">
                    	<xsl:text>new Double(Double.NaN)</xsl:text>
                    </xsl:when>
                    <!--  if value is -Infinity  -->
                    <xsl:when test="text() = '-Infinity'">
                    	<xsl:text>new Double(Double.NEGATIVE_INFINITY)</xsl:text>
                    </xsl:when>
                    <!--  if value Infinity or +Infinity  -->
                    <xsl:when test="text() = 'Infinity' or text() = '+Infinity'">
                    	<xsl:text>new Double(Double.POSITIVE_INFINITY)</xsl:text>
                    </xsl:when>
                    <!--  if value is declared as a double or looks like a double   -->
                    <xsl:when test="@type = 'double' or (substring(text(), 1, 1) != '&quot;' and contains(text(), '.'))">
                        <xsl:text>new Double(</xsl:text>
                        <xsl:value-of select="text()"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <!--  if value is declared a boolean or looks like a boolean   -->
                    <xsl:when test="text() = 'true'">
                    	<xsl:text>Boolean.TRUE</xsl:text>
                    </xsl:when>
                    <xsl:when test="text() = 'false'">
                    	<xsl:text>Boolean.FALSE</xsl:text>
                    </xsl:when>
                    <!--  if value is declared an integer or looks like an integer -->
                    <xsl:when test="@type = 'int' or string(number(text())) != 'NaN'">
                        <xsl:text>new Integer(</xsl:text>
                        <xsl:value-of select="text()"/>
                        <xsl:text>)</xsl:text>
                    </xsl:when>
                    <!--  member is not a number, just add it to collection  -->
                    <xsl:otherwise>
                        <xsl:value-of select="text()"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:text>);
      </xsl:text>
            </xsl:for-each>
        </xsl:when>
        <!--  inner classes    -->
        <xsl:when test="*">
            <xsl:text> = new </xsl:text>
            <xsl:value-of select="@type"/>
            <xsl:value-of select="generate-id(.)"/>
            <xsl:text>(this</xsl:text>
            <!--  any var's with value attributes are passed
                    to the constructor    -->
            <xsl:for-each select="*[local-name() = 'var' and @value]">
                <xsl:text>, </xsl:text>
                <!--  if the value of the variable is a number literal
                         and the type is a short then
                         add a cast to short      -->
                <xsl:if test="@type = 'short' and string(number(@value)) != 'NaN'">
                    <xsl:text> (short) </xsl:text>
                </xsl:if>
                <xsl:value-of select="@value"/>
            </xsl:for-each>
            <xsl:text>);</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='comment']" mode="body">
    <xsl:text>/* </xsl:text>
    <xsl:value-of select="."/>
    <xsl:text> */
</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='wait']" mode="body">
    <xsl:text>wait(</xsl:text>
    <xsl:value-of select="@milliseconds"/>
    <xsl:text>);
</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='append']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@collection"/>
    <xsl:text>.add(</xsl:text>
    <xsl:variable name="item" select="@item"/>
    <xsl:variable name="type" select="$vardefs[@name=$item]/@type"/>
    <xsl:choose>
        <xsl:when test="$type = 'int'">
            <xsl:text>new Integer(</xsl:text>
            <xsl:value-of select="@item"/>
            <xsl:text>));</xsl:text>
        </xsl:when>
        <xsl:when test="$type = 'double'">
            <xsl:text>new Double(</xsl:text>
            <xsl:value-of select="@item"/>
            <xsl:text>));</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="@item"/>
            <xsl:text>);</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='assign']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:choose>
        <xsl:when test="substring(@value, 1, 1) = '&quot;' or string(number(@value)) != 'NaN'">
            <xsl:value-of select="@value"/>
            <xsl:text>;
      </xsl:text>
        </xsl:when>
        
        <!--  if the left hand side is LSInputStream and the right hand side is LSOutputStream  -->
        <xsl:when test="$vardefs[@name = current()/@var]/@type = 'LSInputStream' and $vardefs[@name = current()/@value]/@type = 'LSOutputStream'">
        	<xsl:text> new java.io.ByteArrayInputStream(((java.io.ByteArrayOutputStream) </xsl:text>
        	<xsl:value-of select="@value"/>
        	<xsl:text>).toByteArray());
       </xsl:text>
        </xsl:when>

        <!--  if the left hand side is LSReader and the right hand side is LSWriter  -->
        <xsl:when test="$vardefs[@name = current()/@var]/@type = 'LSReader' and $vardefs[@name = current()/@value]/@type = 'LSWriter'">
        	<xsl:text> new java.io.StringReader(((java.io.StringWriter) </xsl:text>
        	<xsl:value-of select="@value"/>
        	<xsl:text>).toString());
       </xsl:text>
        </xsl:when>
        
        <xsl:otherwise>
            <xsl:variable name="var" select="@var"/>
            <xsl:variable name="value" select="@value"/>
            <xsl:call-template name="retval-cast">
                <xsl:with-param name="variable" select="@var"/>
                <xsl:with-param name="vartype" select="$vardefs[@name = $var]/@type"/>
                <xsl:with-param name="rettype" select="$vardefs[@name = $value]/@type"/>
            </xsl:call-template>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@value"/>
            <xsl:text>;
      </xsl:text>
        </xsl:otherwise>
    </xsl:choose>   
</xsl:template>

<xsl:template match="*[local-name()='return']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>        return </xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='increment']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> += </xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='decrement']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> -= </xsl:text>
    <xsl:value-of select="@value"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='plus']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@op1"/>
    <xsl:text> + </xsl:text>
    <xsl:value-of select="@op2"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='subtract']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@op1"/>
    <xsl:text> - </xsl:text>
    <xsl:value-of select="@op2"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='mult']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@op1"/>
    <xsl:text> * </xsl:text>
    <xsl:value-of select="@op2"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='divide']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@op1"/>
    <xsl:text> / </xsl:text>
    <xsl:value-of select="@op2"/>
    <xsl:text>;
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='substring']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:value-of select="@obj"/>
    <xsl:text>.substring(</xsl:text>
    <xsl:value-of select="@beginIndex"/>
    <xsl:if test="@endIndex">
    	<xsl:text>, </xsl:text>
    	<xsl:value-of select="@endIndex"/>
    </xsl:if>
    <xsl:text>);
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='implementation']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:call-template name="retval-cast">
        <xsl:with-param name="variable" select="@var"/>
        <xsl:with-param name="vartype" select="$vardefs[@name = current()/@var]/@type"/>
        <xsl:with-param name="rettype" select="'DOMImplementation'"/>
    </xsl:call-template>
    <xsl:if test="@obj">
        <xsl:value-of select="@obj"/>
        <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:text>getImplementation();
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='createXPathEvaluator']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = (XPathEvaluator) createXPathEvaluator(</xsl:text>
    <xsl:value-of select="@document"/>
    <xsl:text>);
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='assertTrue']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:param name="type"/>
    <xsl:value-of select="@var"/>
    <xsl:choose>
        <xsl:when test="@actual">
            <xsl:text>assertTrue("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:text>);
      </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>assertTrue("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:apply-templates select="*[1]" mode="condition"/>
            <xsl:text>);
      </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template match="*[local-name()='assertFalse']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:param name="type"/>
    <xsl:value-of select="@var"/>
    <xsl:choose>
        <xsl:when test="@actual">
            <xsl:text>assertFalse("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:text>);
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>assertFalse("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:apply-templates select="*[1]" mode="condition"/>
            <xsl:text>);
</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='assertNull']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertNull("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="@actual"/>
    <xsl:text>);
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='assertNotNull']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertNotNull("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="@actual"/>
    <xsl:text>);
      </xsl:text>
    <xsl:if test="*">
        <xsl:text>if (</xsl:text>
        <xsl:value-of select="@actual"/>
        <xsl:text> != null) {</xsl:text>
        <xsl:apply-templates mode="body">
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:apply-templates>
        <xsl:text>}
      </xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='assertSame']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertSame("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="@expected"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="@actual"/>
    <xsl:text>);
</xsl:text>
    <xsl:if test="count(*) &gt; 0">
        <xsl:text>if (same(</xsl:text>
        <xsl:value-of select="@expected"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="@actual"/>
        <xsl:text>)) {</xsl:text>
        <xsl:apply-templates mode="body">
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:apply-templates>
        <xsl:text>}
</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='assertInstanceOf']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertInstanceOf("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:call-template name="produce-type">
        <xsl:with-param name="type" select="@type"/>
    </xsl:call-template>
    <xsl:text>.class, </xsl:text>
    <xsl:value-of select="@obj"/>
    <xsl:text>);
</xsl:text>
    <xsl:if test="*">
        <xsl:text>if (</xsl:text>
        <xsl:value-of select="@obj"/>
        <xsl:text> instanceof </xsl:text>
        <xsl:call-template name="produce-type">
            <xsl:with-param name="type" select="@type"/>
        </xsl:call-template>
        <xsl:text>) {</xsl:text>
        <xsl:apply-templates mode="body">
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:apply-templates>
        <xsl:text>}
</xsl:text>
    </xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='assertSize']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertSize("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:value-of select="@size"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="@collection"/>
    <xsl:text>);
      </xsl:text>
    <xsl:if test="*">
   if (size(<xsl:value-of select="@collection"/>) == <xsl:value-of select="@size"/>) {
<xsl:apply-templates mode="body">
    <xsl:with-param name="vardefs" select="$vardefs"/>
</xsl:apply-templates>
<xsl:text>
   }
      </xsl:text>
</xsl:if>
</xsl:template>

<xsl:template match="*[local-name()='assertURIEquals']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>assertURIEquals("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", </xsl:text>
    <xsl:choose>
        <xsl:when test="@scheme"><xsl:value-of select="@scheme"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@path"><xsl:value-of select="@path"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@host"><xsl:value-of select="@host"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@file"><xsl:value-of select="@file"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@name"><xsl:value-of select="@name"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@query"><xsl:value-of select="@query"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@fragment"><xsl:value-of select="@fragment"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="@isAbsolute='true'">Boolean.TRUE, </xsl:when>
        <xsl:when test="@isAbsolute='false'">Boolean.FALSE, </xsl:when>
        <xsl:when test="@isAbsolute"><xsl:value-of select="@isAbsolute"/>, </xsl:when>
        <xsl:otherwise>null, </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="@actual"/>
    <xsl:text>);
</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='fail']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>fail("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>");
     </xsl:text>
</xsl:template>



<xsl:template match="*[local-name()='assertEquals']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:choose>
        <xsl:when test="@ignoreCase = 'true'">
            <xsl:text>assertEqualsIgnoreCase("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:text>);
</xsl:text>
        </xsl:when>
        <xsl:when test="@ignoreCase = 'auto'">
            <xsl:text>assertEqualsAutoCase("</xsl:text>
            <xsl:choose>
            	<xsl:when test="@context">
            		<xsl:value-of select="@context"/>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:text>element</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:text>", "</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:text>);
        </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>assertEquals("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>
            <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
            <xsl:text>);
      </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template match="*[local-name()='assertNotEquals']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:choose>
        <xsl:when test="@ignoreCase = 'true'">
            <xsl:text>assertNotEqualsIgnoreCase("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>,
            <xsl:value-of select="@actual"/>
            <xsl:text>);
</xsl:text>
        </xsl:when>
        <xsl:when test="@ignoreCase = 'auto'">
            <xsl:text>assertNotEqualsAutoCase("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:choose>
            	<xsl:when test="@context">
            		<xsl:text>, "</xsl:text>
            		<xsl:value-of select="@context"/>
            		<xsl:text>");
</xsl:text>
				</xsl:when>
				<xsl:otherwise>
            		<xsl:text>, "element");
</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>assertNotEquals("</xsl:text>
            <xsl:value-of select="@id"/>
            <xsl:text>", </xsl:text>
            <xsl:value-of select="@expected"/>
            <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="@actual"/>
            <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
            <xsl:text>);
</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='assertEventCount']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>{
    boolean _tmpBool = true;
</xsl:text>
    <xsl:if test="@atCount">
        <xsl:text>_tmpBool &amp;= (</xsl:text>
        <xsl:value-of select="@monitor"/>
        <xsl:text>.getAtCount() == </xsl:text>
        <xsl:value-of select="@atCount"/>
        <xsl:text>);
</xsl:text>
    </xsl:if>
    <xsl:if test="@captureCount">
        <xsl:text>_tmpBool &amp;= (</xsl:text>
        <xsl:value-of select="@monitor"/>
        <xsl:text>.getCaptureCount() == </xsl:text>
        <xsl:value-of select="@captureCount"/>
        <xsl:text>);
</xsl:text>
    </xsl:if>
    <xsl:if test="@bubbleCount">
        <xsl:text>_tmpBool &amp;= (</xsl:text>
        <xsl:value-of select="@monitor"/>
        <xsl:text>.getBubbleCount() == </xsl:text>
        <xsl:value-of select="@BubbleCount"/>
        <xsl:text>);
</xsl:text>
    </xsl:if>
    <xsl:if test="@totalCount">
        <xsl:text>_tmpBool &amp;= (</xsl:text>
        <xsl:value-of select="@monitor"/>
        <xsl:text>.getTotalCount() == </xsl:text>
        <xsl:value-of select="@totalCount"/>
        <xsl:text>);
</xsl:text>
    </xsl:if>
    <xsl:text>assertTrue("</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>", _tmpBool);
</xsl:text>
    <xsl:if test="*">
        <xsl:text>if (_tmpBool) {
</xsl:text>
        <xsl:apply-templates mode="body">
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:apply-templates>
        <xsl:text>}
</xsl:text>
    </xsl:if>
    <xsl:text>}</xsl:text>
</xsl:template>



<xsl:template match="*[local-name()='if']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:text>
      if (</xsl:text>
      <xsl:apply-templates select="*[1]" mode="condition"/>
      <xsl:text>) {
          </xsl:text>
        <xsl:apply-templates select="*[position() &gt; 1 and local-name() != 'else']" mode="body">
            <xsl:with-param name="vardefs" select="$vardefs"/>
        </xsl:apply-templates>
        <xsl:text>}</xsl:text>
        <xsl:for-each select="*[local-name()='else']">
            <xsl:text> else {
          </xsl:text>
            <xsl:apply-templates mode="body">
               <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>}
        </xsl:for-each>
    <xsl:text>
    </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='try']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:variable name="exceptions" select="$domspec//exception[@id]"/>
    <xsl:variable name="catches" select="*[local-name() = 'catch']/*"/>
    <xsl:variable name="implException" select="$catches[local-name() = 'ImplementationException']"/>
    
    <xsl:text>
      try {
      </xsl:text>
      <xsl:apply-templates select="*[local-name() != 'catch']" mode="body">
      	<xsl:with-param name="vardefs" select="$vardefs"/>
      </xsl:apply-templates>
      <xsl:text>
      } </xsl:text>
      <!--  for each type of defined exception   -->
      <xsl:for-each select="$exceptions">
      	  <!--  if there is an ImplementationException or 
      	  		at least one element for the current exception  -->
      	  <xsl:if test="$implException or $catches[local-name() = current()/@name]">
      	  <xsl:text>catch (</xsl:text><xsl:value-of select="@name"/><xsl:text> ex) {
           switch (ex.code) {
      </xsl:text>
      			<xsl:variable name="exception" select="."/>
      			<xsl:for-each select="$catches[local-name() = $exception/@name]">
      				<xsl:variable name="catchCode" select="@code"/>
      				<!--  set the context to the one exception definition  -->
      				<xsl:for-each select="$exception">
      					<xsl:text>case </xsl:text>
      					<xsl:value-of select="following-sibling::group[1]/constant[@name = $catchCode]/@value"/>
      				</xsl:for-each>
      					<xsl:text> : 
       </xsl:text>
      					<xsl:apply-templates select="*" mode="body">
      						<xsl:with-param name="vardefs" select="$vardefs"/>
      					</xsl:apply-templates>
						<!--  if there are no children, add a break -->
      					<xsl:if test="count(*) = 0">
      							<xsl:text>break;
      </xsl:text>
      					</xsl:if>
      					<!--  if the last child is not a return, add a break  -->
      					<xsl:for-each select="*">
      						<xsl:if test="not(following-sibling::*) and local-name() != 'return'">
      							<xsl:text>break;
      </xsl:text>
      						</xsl:if>
      					</xsl:for-each>
      			</xsl:for-each>
      			<xsl:text>    default:
          throw ex;
          }
      } </xsl:text>
      		</xsl:if>
      </xsl:for-each>
      <!--  for any implementation exception  -->
      <xsl:for-each select="$implException">
      	<xsl:text>     catch (Exception ex) {
      	</xsl:text>
      	<xsl:apply-templates select="*" mode="body">
      		<xsl:with-param name="vardefs" select="$vardefs"/>
      	</xsl:apply-templates>
      	
      	<xsl:text>
      	} </xsl:text>
      </xsl:for-each>
      <xsl:text>
</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='while']" mode="body">
    <xsl:param name="vardefs"/>
    while (<xsl:apply-templates select="*[1]" mode="condition"/>) {
    <xsl:apply-templates select="*[position() &gt; 1]" mode="body">
        <xsl:with-param name="vardefs" select="$vardefs"/>
    </xsl:apply-templates>
    }
</xsl:template>

<xsl:template match="*[local-name()='for-each']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:variable name="indexvar" select="concat('index', generate-id(.))"/>
    <xsl:text>for (int </xsl:text>
    <xsl:value-of select="$indexvar"/>
    <xsl:text> = 0; </xsl:text>
    <xsl:value-of select="$indexvar"/>
    <xsl:text> &lt; </xsl:text>
    <xsl:variable name="varname" select="@collection"/>
    <xsl:value-of select="@collection"/>
    <xsl:variable name="vartype" select="$vardefs[@name = $varname]/@type"/>
    <xsl:variable name="member" select="@member"/>
    <xsl:choose>
        <xsl:when test="$vartype = 'Collection' or $vartype = 'List'">
            <xsl:text>.size(); </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>.getLength(); </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$indexvar"/>
    <xsl:text>++) {
          </xsl:text>
    <xsl:value-of select="$member"/>
    <xsl:text> = </xsl:text>
    <xsl:variable name="memberType" select="$vardefs[@name = $member]/@type"/>
    <xsl:choose>
    	<xsl:when test="$memberType = 'boolean'">
    		<xsl:text>((Boolean) </xsl:text>
    		<xsl:call-template name="produce-indexer">
    			<xsl:with-param name="indexvar" select="$indexvar"/>
    			<xsl:with-param name="vartype" select="$vartype"/>
    		</xsl:call-template>
    		<xsl:text>).booleanValue();
     </xsl:text>    		
    	</xsl:when>

    	<xsl:when test="$memberType = 'int' or $memberType='short' or $memberType = 'double'">
    		<xsl:text>((Number) </xsl:text>
    		<xsl:call-template name="produce-indexer">
    			<xsl:with-param name="indexvar" select="$indexvar"/>
    			<xsl:with-param name="vartype" select="$vartype"/>
    		</xsl:call-template>
    		<xsl:text>).</xsl:text>
    		<xsl:value-of select="$memberType"/>
    		<xsl:text>Value();
     </xsl:text>    		
    	</xsl:when>


    	<xsl:otherwise>
    		<xsl:text>(</xsl:text>
    		<xsl:call-template name="produce-type">
        		<xsl:with-param name="type" select="$memberType"/>
    		</xsl:call-template>
    		<xsl:text>) </xsl:text>
    		<xsl:call-template name="produce-indexer">
    			<xsl:with-param name="indexvar" select="$indexvar"/>
    			<xsl:with-param name="vartype" select="$vartype"/>
    		</xsl:call-template>
    		<xsl:text>;
    </xsl:text>
    	</xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="*" mode="body">
        <xsl:with-param name="vardefs" select="$vardefs"/>
    </xsl:apply-templates>
    <xsl:text>  }
      </xsl:text>
</xsl:template>

<xsl:template name="produce-indexer">
	<xsl:param name="indexvar"/>
	<xsl:param name="vartype"/>
    <xsl:value-of select="@collection"/>
    <xsl:choose>
        <xsl:when test="$vartype = 'Collection' or $vartype = 'List'">
            <xsl:text>.get(</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>.item(</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="$indexvar"/>
    <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='atEvents']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getAtEvents();
</xsl:template>


<xsl:template match="*[local-name()='capturedEvents']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getCapturedEvents();
</xsl:template>

<xsl:template match="*[local-name()='bubbledEvents']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getBubbledEvents();
</xsl:template>


<xsl:template match="*[local-name()='allEvents']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getAllEvents();
</xsl:template>

<xsl:template match="*[local-name()='allNotifications']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getAllNotifications();
</xsl:template>

<xsl:template match="*[local-name()='operation']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getOperation();
</xsl:template>

<xsl:template match="*[local-name()='key']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getKey();
</xsl:template>

<xsl:template match="*[local-name()='src' and @interface='UserDataNotification']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getSrc();
</xsl:template>

<xsl:template match="*[local-name()='dst']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getDst();
</xsl:template>

<xsl:template match="*[local-name()='allErrors']" mode="body">
    <xsl:value-of select="@var"/> = <xsl:value-of select="@obj"/>.getAllErrors();
</xsl:template>

<xsl:template match="*[local-name()='assertLowerSeverity']" mode="body">
    <xsl:value-of select="@obj"/>
    <xsl:text>.assertLowerSeverity(this, "</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:choose>
    	<xsl:when test="@severity = 'SEVERITY_WARNING'">", 1</xsl:when>
    	<xsl:when test="@severity = 'SEVERITY_FATAL_ERROR'">", 3</xsl:when>
    	<xsl:otherwise>", 2</xsl:otherwise>
    </xsl:choose>
    <xsl:text>);
     </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='data' and @interface='UserDataNotification']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:call-template name="retval-cast">
        <xsl:with-param name="variable" select="@var"/>
        <xsl:with-param name="vartype" select="$vardefs[@name = current()/@var]/@type"/>
        <xsl:with-param name="rettype" select="'DOMUserData'"/>
    </xsl:call-template>
    <xsl:value-of select="@obj"/>.getData();
</xsl:template>


<xsl:template name="produce-type">
    <xsl:param name="type"/>
    <xsl:choose>
        <xsl:when test="$type='DOMString'">String</xsl:when>
        <xsl:when test="contains($type, 'DOMObject')">Object</xsl:when>
        <xsl:when test="contains($type, 'DOMUserData')">Object</xsl:when>
        <xsl:when test="contains($type, 'LSInputStream')">java.io.InputStream</xsl:when>
        <xsl:when test="contains($type, 'LSOutputStream')">java.io.OutputStream</xsl:when>
        <xsl:when test="contains($type, 'LSReader')">java.io.Reader</xsl:when>
        <xsl:when test="contains($type, 'LSWriter')">java.io.Writer</xsl:when>
        <xsl:when test="contains($type, 'DOMImplementationRegistry')">org.w3c.dom.bootstrap.DOMImplementationRegistry</xsl:when>
        <xsl:when test="$type='Collection'">java.util.Collection</xsl:when>
        <xsl:when test="$type='List'">java.util.List</xsl:when>
        <xsl:when test="$type='EventMonitor'">org.w3c.domts.EventMonitor</xsl:when>
        <xsl:when test="$type='UserDataMonitor'">org.w3c.domts.UserDataMonitor</xsl:when>
        <xsl:when test="$type='UserDataNotification'">org.w3c.domts.UserDataNotification</xsl:when>
        <xsl:when test="$type='DOMErrorMonitor'">org.w3c.domts.DOMErrorMonitor</xsl:when>
        <xsl:when test="$type = 'unsigned long'">int</xsl:when>
        <xsl:when test="$type = 'long'">int</xsl:when>
        <xsl:when test="substring($type, 1, 9) = 'unsigned '">
            <xsl:value-of select="substring($type, 10)"/>
        </xsl:when> 
        <xsl:otherwise>
            <xsl:value-of select="$type"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="@type">
    <xsl:call-template name="produce-type">
        <xsl:with-param name="type" select="."/>
    </xsl:call-template>
</xsl:template>


<xsl:template match="*[local-name()='load' and not(@interface)]" mode="body">
    <xsl:param name="vardefs"/>

    <xsl:variable name="var" select="@var"/>
    <xsl:value-of select="@var"/>
    <xsl:text> = </xsl:text>
    <xsl:call-template name="retval-cast">
        <xsl:with-param name="variable" select="@var"/>
        <xsl:with-param name="vartype" select="$vardefs[@name = $var]/@type"/>
        <xsl:with-param name="rettype" select="Document"/>
    </xsl:call-template>
    <xsl:text>load("</xsl:text>
    <xsl:value-of select="@href"/>
    <xsl:choose>
    	<xsl:when test="@willBeModified = 'true'">
    		<xsl:text>", true);
      </xsl:text>
      	</xsl:when>
      	<xsl:otherwise> 
    		<xsl:text>", false);
      </xsl:text>
         </xsl:otherwise>
     </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='getResourceURI']" mode="body">
    <xsl:value-of select="@var"/>
    <xsl:text> = getResourceURI(</xsl:text>
    <xsl:value-of select="@href"/>
    <xsl:text>, "</xsl:text>
    <xsl:choose>
    	<xsl:when test="@scheme">
    		<xsl:value-of select="@scheme"/>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:text>file</xsl:text>
    	</xsl:otherwise>
    </xsl:choose>
    <xsl:text>", </xsl:text>
    <xsl:choose>
    	<xsl:when test="@contentType">
    		<xsl:text>"</xsl:text>
    		<xsl:value-of select="@contentType"/>
    		<xsl:text>"</xsl:text>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:text>null</xsl:text>
    	</xsl:otherwise>
    </xsl:choose>
    <xsl:text>);
      </xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='createTempURI']" mode="body">
    <xsl:value-of select="@var"/>
    <xsl:text> = createTempURI("</xsl:text>
    <xsl:choose>
    	<xsl:when test="@scheme">
    		<xsl:value-of select="@scheme"/>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:text>file</xsl:text>
    	</xsl:otherwise>
    </xsl:choose>
    <xsl:text>");
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='assertImplementationException']" mode="body">
    <xsl:param name="vardefs"/>
      {
         boolean success = false;
         try {
            <xsl:apply-templates mode="body">
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>    } catch (DOMException ex) {
              //   allow to fall through and fail test
         } catch (EventException ex) {
              //   allow to fall through and fail test
         } catch (Throwable ex) {
            success = true;
         }
         assertTrue("<xsl:value-of select="@id"/><xsl:text>", success);
      }
      </xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='assertDOMException']" mode="body">
    <xsl:param name="vardefs"/>
      {
         boolean success = false;
         try {
            <xsl:apply-templates select="*/*" mode="body">
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>    } catch (DOMException ex) {
            success = (ex.code == DOMException.<xsl:value-of select="name(*)"/>);
         }
         assertTrue("<xsl:value-of select="@id"/>", success);
      }
</xsl:template>

<xsl:template match="*[local-name()='assertLSException']" mode="body">
    <xsl:param name="vardefs"/>
      {
         boolean success = false;
         try {
            <xsl:apply-templates select="*/*" mode="body">
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>    } catch (LSException ex) {
            success = (ex.code == LSException.<xsl:value-of select="name(*)"/>);
         }
         assertTrue("<xsl:value-of select="@id"/>", success);
      }
</xsl:template>


<xsl:template match="*[local-name()='assertEventException']" mode="body">
    <xsl:param name="vardefs"/>
      {
         boolean success = false;
         try {
            <xsl:apply-templates select="*/*" mode="body">
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>    } catch (EventException ex) {
            success = (ex.code == EventException.<xsl:value-of select="name(*)"/>);
         }
         assertTrue("<xsl:value-of select="@id"/>", success);
      }
</xsl:template>

<xsl:template match="*[local-name()='assertXPathException']" mode="body">
    <xsl:param name="vardefs"/>
      {
         boolean success = false;
         try {
            <xsl:apply-templates select="*/*" mode="body">
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:apply-templates>    } catch (XPathException ex) {
            success = (ex.code == XPathException.<xsl:value-of select="name(*)"/>);
         }
         assertTrue("<xsl:value-of select="@id"/>", success);
      }
</xsl:template>

<xsl:template match="*[local-name()='getParameter']" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:variable name="var" select="@var"/>
    <xsl:value-of select="$var"/>
    <xsl:text> = </xsl:text>
    <xsl:variable name="vartype" select="$vardefs[@name = $var]/@type"/>
    <xsl:choose>
    	<xsl:when test="$vartype = 'boolean'">
    		<xsl:text>((Boolean) </xsl:text>
    		<xsl:value-of select="@obj"/>
    		<xsl:text>.getParameter(</xsl:text>
    		<xsl:value-of select="@name"/>
    		<xsl:text>)).booleanValue();
      </xsl:text>
      	</xsl:when>
      	
      	<xsl:otherwise>
      		<xsl:if test="$vartype != 'DOMUserData'">
      			<xsl:text>(</xsl:text>
				<xsl:call-template name="produce-type">
    				<xsl:with-param name="type" select="$vartype"/>
    			</xsl:call-template>
      			<xsl:text>) </xsl:text>
      		</xsl:if>
      		<xsl:value-of select="@obj"/>
      		<xsl:text>.getParameter(</xsl:text>
      		<xsl:value-of select="@name"/>
      		<xsl:text>);
      </xsl:text>
        </xsl:otherwise>
      </xsl:choose>      	
</xsl:template>


<xsl:template match="text()" mode="body"/>

<xsl:template match="*" mode="body">
    <xsl:param name="vardefs"/>
    <xsl:variable name="feature" select="local-name(.)"/>
    <xsl:variable name="interface" select="@interface"/>
    <xsl:variable name="method" select="$domspec/library/interface[not($interface) or @name = $interface]/method[@name = $feature]"/>
    <xsl:choose>
        <xsl:when test="$method">
            <xsl:call-template name="produce-method">
                <xsl:with-param name="method" select="$method"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="attribute" select="$domspec/library/interface[not($interface) or @name = $interface]/attribute[@name = $feature]"/>
            <xsl:choose>
                <xsl:when test="$attribute">
                    <xsl:call-template name="produce-attribute">
                        <xsl:with-param name="vardefs" select="$vardefs"/>
                    </xsl:call-template>
                </xsl:when>

                <xsl:otherwise>
                    <xsl:message>Unrecognized element <xsl:value-of select="local-name(.)"/></xsl:message>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
      </xsl:text>
</xsl:template>

<xsl:template name="cast">
    <xsl:param name="var"/>
    <xsl:param name="vartype"/>
    <xsl:param name="reqtype"/>
    <xsl:choose>
        <!--  variable is already appropriate type  -->
        <xsl:when test="$vartype = $reqtype">
            <xsl:value-of select="$var"/>
        </xsl:when>
        <xsl:when test="contains($vartype, 'short') and contains($reqtype, 'short')">
            <xsl:value-of select="$var"/>
        </xsl:when>
        <xsl:when test="$reqtype='DOMUserData' and $vartype='boolean'">
            <xsl:text>(new Boolean(</xsl:text><xsl:value-of select="$var"/><xsl:text>))</xsl:text>
        </xsl:when>

        <!--  if the vartype inherits from another interface, see if it matches the required type  -->
        <xsl:when test="$domspec/library/interface[@name = $vartype and @inherits]">
            <xsl:call-template name="cast">
                <xsl:with-param name="var" select="$var"/>
                <xsl:with-param name="vartype" select="$domspec/library/interface[@name = $vartype]/@inherits"/>
                <xsl:with-param name="reqtype" select="$reqtype"/>
            </xsl:call-template>
        </xsl:when>

        <!--  cast and hope for the best  -->       
        <xsl:otherwise>
            <xsl:text>((</xsl:text>
            <xsl:call-template name="produce-type">
                <xsl:with-param name="type" select="$reqtype"/>
            </xsl:call-template>
            <xsl:text>) </xsl:text>
            <xsl:text>/*</xsl:text><xsl:value-of select="$vartype"/><xsl:text> */</xsl:text>
            <xsl:value-of select="$var"/>
            <xsl:text>)</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template name="retval-cast">
    <xsl:param name="vartype"/>
    <xsl:param name="rettype"/>
    <xsl:param name="variable"/>
    <xsl:choose>
        <!--  left hand side variable not declared   -->
        <xsl:when test="string-length($vartype) = 0">
            <xsl:message>Variable <xsl:value-of select="$variable"/> not defined.</xsl:message>
        </xsl:when>
        <!--  variable is already appropriate type, do nothing  -->
        <xsl:when test="$vartype = $rettype"/>
        
        <!--  if the vartype inherits from another interface, see if it matches the required type  -->
        <xsl:when test="$domspec/library/interface[@name = $rettype and @inherits]">
            <xsl:call-template name="retval-cast">
                <xsl:with-param name="variable" select="$variable"/>
                <xsl:with-param name="vartype" select="$vartype"/>
                <xsl:with-param name="rettype" select="$domspec/library/interface[@name = $rettype]/@inherits"/>
            </xsl:call-template>
        </xsl:when>

        <!--  cast and hope for the best  -->       
        <xsl:otherwise>
            <xsl:text>(</xsl:text>
            <xsl:call-template name="produce-type">
            	<xsl:with-param name="type" select="$vartype"/>
            </xsl:call-template>
            <xsl:text>) </xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<xsl:template name="build-accessor">
    <xsl:param name="prefix"/>
    <xsl:param name="attribute"/>
    <xsl:value-of select="$prefix"/>
    <xsl:value-of select="translate(substring($attribute, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:value-of select="substring($attribute, 2)"/>
</xsl:template>

<xsl:template name="produce-param">
    <xsl:param name="vardefs"/>
    <xsl:param name="value"/>
    <xsl:param name="vartype"/>
    <xsl:param name="reqtype"/>

    <xsl:choose>
        <xsl:when test="$reqtype='DOMUserData' and $value='true'">
            <xsl:text>Boolean.TRUE</xsl:text>
        </xsl:when>
        <xsl:when test="$reqtype='DOMUserData' and $value='false'">
            <xsl:text>Boolean.FALSE</xsl:text>
        </xsl:when>
        <!--  if value is true, false or starts with a quote  -->
        <xsl:when test="$value = 'true' or $value = 'false' or $value = 'null' or substring($value, 1, 1) ='&quot;'">
            <!--  just copy the literal  -->
            <xsl:value-of select="$value"/>
        </xsl:when>
        <!--  if numeric literal  -->
        <xsl:when test="string(number($value)) != 'NaN'">
            <xsl:if test="contains($reqtype, 'short')">
                <xsl:text> (short) </xsl:text>
            </xsl:if>
            <xsl:value-of select="$value"/>
        </xsl:when>
        <!--  is a declared variable, make sure that it is cast correctly  -->
        <xsl:when test="$vartype">
            <xsl:call-template name="cast">
                <xsl:with-param name="var" select="$value"/>
                <xsl:with-param name="vartype" select="$vartype"/>
                <xsl:with-param name="reqtype" select="$reqtype"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text> /* undeclared */ </xsl:text><xsl:value-of select="$value"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template name="produce-specific-attribute">
    <xsl:param name="vardefs"/>
    <xsl:param name="attribute"/>
    <xsl:variable name="obj" select="@obj"/>
    <xsl:variable name="value" select="@value"/>
    <!--  check if attribute name starts with is  -->
    <xsl:variable name="startsWithIs" select="substring($attribute/@name, 1, 2) = 'is' and $attribute/@name != 'isMap' and contains('ABCDEFGHIJKLMNOPQRSTUVWXYZ', substring($attribute/@name, 3, 1))"/>
    <xsl:if test="@value">
        <xsl:call-template name="cast">
            <xsl:with-param name="var" select="$obj"/>
            <xsl:with-param name="vartype" select="$vardefs[@name = $obj]/@type"/>
            <xsl:with-param name="reqtype" select="$attribute/parent::interface/@name"/>
        </xsl:call-template>
	<xsl:choose>
	   <xsl:when test="$startsWithIs">ls ls /.
        	<xsl:call-template name="build-accessor">
            		<xsl:with-param name="prefix">.set</xsl:with-param>
            		<xsl:with-param name="attribute" select="substring($attribute/@name, 3)"/>
        	</xsl:call-template>
           </xsl:when>
	   <xsl:otherwise>
        	<xsl:call-template name="build-accessor">
            		<xsl:with-param name="prefix">.set</xsl:with-param>
            		<xsl:with-param name="attribute" select="$attribute/@name"/>
        	</xsl:call-template>
           </xsl:otherwise>
        </xsl:choose>
        <xsl:text>(</xsl:text>
            <xsl:call-template name="produce-param">
                <xsl:with-param name="value" select="@value"/>
                <xsl:with-param name="vartype" select="$vardefs[@name = $value]/@type"/>
                <xsl:with-param name="reqtype" select="$attribute/@type"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        <xsl:text>);</xsl:text>
    </xsl:if>
    <xsl:if test="@var">
        <xsl:value-of select="@var"/>
        <xsl:variable name="var" select="@var"/>
        <xsl:text> = </xsl:text>
        <xsl:call-template name="retval-cast">
            <xsl:with-param name="variable" select="$var"/>
            <xsl:with-param name="vartype" select="$vardefs[@name = $var]/@type"/>
            <xsl:with-param name="rettype" select="$attribute/@type"/>
        </xsl:call-template>
        <xsl:call-template name="cast">
            <xsl:with-param name="var" select="$obj"/>
            <xsl:with-param name="vartype" select="$vardefs[@name = $obj]/@type"/>
            <xsl:with-param name="reqtype" select="$attribute/parent::interface/@name"/>
        </xsl:call-template>
        <xsl:choose>
	     <xsl:when test="$startsWithIs">
        	<xsl:call-template name="build-accessor">
            		<xsl:with-param name="prefix">.is</xsl:with-param>
            		<xsl:with-param name="attribute" select="substring($attribute/@name, 3)"/>
        	</xsl:call-template>
             </xsl:when>
	     <xsl:otherwise>
        	<xsl:call-template name="build-accessor">
            		<xsl:with-param name="prefix">.get</xsl:with-param>
            		<xsl:with-param name="attribute" select="$attribute/@name"/>
        	</xsl:call-template>
	     </xsl:otherwise>
        </xsl:choose>
        <xsl:text>();</xsl:text>
    </xsl:if>
</xsl:template>


<xsl:template name="produce-specific-method">
    <xsl:param name="method"/>
    <xsl:param name="vardefs"/>
    <xsl:variable name="current" select="."/>
    <xsl:variable name="obj" select="@obj"/>
    <xsl:variable name="var" select="@var"/>


    <xsl:if test="@var">
        <xsl:value-of select="@var"/>
        <xsl:text> = </xsl:text>
        <xsl:call-template name="retval-cast">
            <xsl:with-param name="variable" select="$var"/>
            <xsl:with-param name="vartype" select="$vardefs[@name = $var]/@type"/>
            <xsl:with-param name="rettype" select="$method/returns/@type"/>
        </xsl:call-template>
    </xsl:if>
    <xsl:call-template name="cast">
        <xsl:with-param name="var" select="$obj"/>
        <xsl:with-param name="vartype" select="$vardefs[@name = $obj]/@type"/>
        <xsl:with-param name="reqtype" select="$method/parent::interface/@name"/>
    </xsl:call-template>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="$method/@name"/>
    <xsl:text>(</xsl:text>


    <xsl:for-each select="$method/parameters/param">
        <xsl:if test="position() &gt; 1">, </xsl:if>
        <xsl:variable name="paramDef" select="."/>
        <xsl:variable name="value" select="$current/@*[name() = $paramDef/@name]"/>
        <xsl:call-template name="produce-param">
            <xsl:with-param name="value" select="$value"/>
            <xsl:with-param name="vartype" select="$vardefs[@name = $value]/@type"/>
            <xsl:with-param name="reqtype" select="$paramDef/@type"/>
        </xsl:call-template>
    </xsl:for-each>
    <xsl:text>);</xsl:text>
</xsl:template>



<xsl:template name="produce-attribute">
    <xsl:param name="vardefs"/>
    <xsl:variable name="attribName" select="local-name(.)"/>
    <xsl:choose>
        <!--  if interface is specified -->
        <xsl:when test="@interface">
            <xsl:variable name="interface" select="@interface"/>            
            <xsl:call-template name="produce-specific-attribute">
                <xsl:with-param name="attribute" select="$domspec/library/interface[@name = $interface]/attribute[@name = $attribName]"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="produce-specific-attribute">
                <xsl:with-param name="attribute" select="$domspec/library/interface/attribute[@name = $attribName]"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
    
</xsl:template>

<xsl:template name="produce-method">
    <xsl:param name="vardefs"/>
    <xsl:variable name="methodName" select="local-name(.)"/>
    <xsl:choose>
        <!--  if interface is specified -->
        <xsl:when test="@interface">
            <xsl:variable name="interface" select="@interface"/>            
            <xsl:call-template name="produce-specific-method">
                <xsl:with-param name="method" select="$domspec/library/interface[@name = $interface]/method[@name = $methodName]"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:variable name="methods" select="$domspec/library/interface/method[@name = $methodName]"/>
            <xsl:call-template name="produce-specific-method">
                <xsl:with-param name="method" select="$methods[1]"/>
                <xsl:with-param name="vardefs" select="$vardefs"/>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="*[local-name()='validating']" mode="condition">
    _factory.isValidating()
</xsl:template>

<xsl:template match="*[local-name()='coalescing']" mode="condition">
    _factory.isCoalescing()
</xsl:template>

<xsl:template match="*[local-name()='expandEntityReferences']" mode="condition">
    _factory.isExpandEntityReferences()
</xsl:template>

<xsl:template match="*[local-name()='ignoringElementContentWhitespace']" mode="condition">
    _factory.isIgnoringElementContentWhitespace()
</xsl:template>

<xsl:template match="*[local-name()='ignoringComments']" mode="condition">
    _factory.isComments()
</xsl:template>

<xsl:template match="*[local-name()='namespaceAware']" mode="condition">
    _factory.isNamespaceAware()
</xsl:template>

<xsl:template match="*[local-name()='signed']" mode="condition">
    true
</xsl:template>

<xsl:template match="*[local-name()='not']" mode="condition">
    !(<xsl:apply-templates mode="condition"/>)
</xsl:template>

<xsl:template match="*[local-name()='and']" mode="condition">
    (<xsl:apply-templates select="*[1]" mode="condition"/>
    <xsl:for-each select="*[position() &gt; 1]">
        <xsl:text> &amp; </xsl:text>
        <xsl:apply-templates select="." mode="condition"/>
    </xsl:for-each>)
</xsl:template>

<xsl:template match="*[local-name()='or']" mode="condition">
    (<xsl:apply-templates select="*[1]" mode="condition"/>
    <xsl:for-each select="*[position() &gt; 1]">
        <xsl:text> | </xsl:text>
        <xsl:apply-templates select="." mode="condition"/>
    </xsl:for-each>)
</xsl:template>

<xsl:template match="*[local-name()='xor']" mode="condition">
    (<xsl:apply-templates select="*[1]" mode="condition"/>
    <xsl:for-each select="*[position() &gt; 1]">
        <xsl:text> ^ </xsl:text>
        <xsl:apply-templates select="." mode="condition"/>
    </xsl:for-each>)
</xsl:template>


<xsl:template match="*[local-name()='isTrue']" mode="condition">
    <xsl:value-of select="@value"/>
</xsl:template>

<xsl:template match="*[local-name()='isFalse']" mode="condition">
    !<xsl:value-of select="@value"/>
</xsl:template>

<xsl:template match="*[local-name()='same']" mode="condition">
    same(<xsl:value-of select="@expected"/>, <xsl:value-of select="@actual"/>)
</xsl:template>

<xsl:template match="*[local-name()='equals']" mode="condition">
    <xsl:choose>
        <xsl:when test="@ignoreCase='true'">
            <xsl:text>equalsIgnoreCase(</xsl:text>
        </xsl:when>
        <xsl:when test="@ignoreCase='auto'">
            <xsl:text>equalsAutoCase("</xsl:text>
            <xsl:choose>
            	<xsl:when test="@context">
            		<xsl:value-of select="@context"/>
            	</xsl:when>
            	<xsl:otherwise>
            		<xsl:text>element</xsl:text>
            	</xsl:otherwise>
            </xsl:choose>
            <xsl:text>", </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>equals(</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="@expected"/>
    <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="@actual"/>
    <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
    <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='notEquals']" mode="condition">
    <xsl:choose>
        <xsl:when test="@ignoreCase='true'">
            <xsl:text>!equalsIgnoreCase(</xsl:text>
        </xsl:when>
        <xsl:when test="@ignoreCase='auto'">
            <xsl:text>!equalsAutoCase("</xsl:text>
            <xsl:choose>
            	<xsl:when test="@context">
            		<xsl:value-of select="@context"/>
            	</xsl:when>
            	<xsl:otherwise>
            		<xsl:text>element</xsl:text>
            	</xsl:otherwise>
            </xsl:choose>
            <xsl:text>", </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>!equals(</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:value-of select="@expected"/>
    <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
	<xsl:text>, </xsl:text>     
    <xsl:value-of select="@actual"/>
    <xsl:if test="@bitmask"> &amp; <xsl:value-of select="@bitmask"/></xsl:if>
    <xsl:text>)</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='less']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@actual"/> &lt; <xsl:value-of select="@expected"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='lessOrEquals']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@actual"/> &lt;= <xsl:value-of select="@expected"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='greater']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@actual"/> &gt; <xsl:value-of select="@expected"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='greaterOrEquals']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@actual"/> &gt;= <xsl:value-of select="@expected"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='isNull']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@obj"/><xsl:text> == null)</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='notNull']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@obj"/><xsl:text> != null)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='instanceOf']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@obj"/> instanceOf <xsl:value-of select="@type"/><xsl:text>)</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='hasSize']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@obj"/>.size() == <xsl:value-of select="@expected"/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='contentType']" mode="condition">
    <xsl:text>("</xsl:text><xsl:value-of select="@type"/><xsl:text>".equals(getContentType()))</xsl:text>
</xsl:template>


<xsl:template match="*[local-name()='contains' and @interface='DOMString']" mode="condition">
    <xsl:text>(</xsl:text><xsl:value-of select="@obj"/>.indexOf(<xsl:value-of select="@str"/><xsl:text>) >= 0)</xsl:text>
</xsl:template>

<xsl:template match="*[local-name()='implementationAttribute']" mode="condition">
    <xsl:if test="@value='false'">!</xsl:if>
    <xsl:text>is</xsl:text>
    <xsl:value-of select="translate(substring(@name, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
    <xsl:value-of select="substring(@name, 2)"/>
    <xsl:text>()</xsl:text>
</xsl:template>



<xsl:template match="*[local-name()='hasFeature']" mode="condition">
    <xsl:if test="@obj">
        <xsl:value-of select="@obj"/>
        <xsl:text>.</xsl:text>
    </xsl:if>
    <xsl:text>hasFeature(</xsl:text>
    <xsl:value-of select="@feature"/>,
    <xsl:choose>
        <xsl:when test="@version">
            <xsl:value-of select="@version"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>null</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>)</xsl:text>
</xsl:template>

</xsl:stylesheet>
