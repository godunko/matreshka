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
This transform generates HTML pages for use with JSUnit.


Usage:

saxon -o someTest.html someTest.xml test-to-jsunit.xsl


-->



<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="test-to-ecmascript.xsl"/>
    <xsl:param name="testpath">../level1/core/</xsl:param>
    <xsl:param name="hideHTML">no</xsl:param>
    <xsl:param name="hideSVG">no</xsl:param>
    <xsl:param name="target-uri-base"/>

<xsl:output 
	method="html" 
	doctype-public="-//W3C//DTD HTML 4.01//EN" 
	doctype-system="http://www.w3.org/TR/html4/strict.dtd"
	encoding="UTF-8"/>

<xsl:template match="/">
    <xsl:apply-templates mode="jsunit"/>
</xsl:template>

<xsl:template match="*[local-name() = 'test']" mode="jsunit">
    <xsl:variable name="loads" select="*[local-name() = 'load' and not(@interface)]"/>
    <html>
        <head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
			<title><xsl:value-of select="concat($target-uri-base, @name)"/></title>
			<link href="http://www.w3.org/StyleSheets/activity-home.css" rel="stylesheet" type="text/css" />
            <script type="text/javascript" src="../../jsunit/app/jsUnitCore.js"></script>
            <script type="text/javascript" src="DOMTestCase.js"></script>
            <script type="text/javascript">
// expose test function names
function exposeTestFunctionNames()
{
return ['<xsl:value-of select="@name"/>'];
}

var docsLoaded = -1000000;
var builder = null;

//
//   This function is called by the testing framework before
//      running the test suite.
//
//   If there are no configuration exceptions, asynchronous
//        document loading is started.  Otherwise, the status
//        is set to complete and the exception is immediately
//        raised when entering the body of the test.
//
function setUpPage() {
   setUpPageStatus = 'running';
   try {
     //
     //   creates test document builder, may throw exception
     //
     builder = createConfiguredBuilder();
<xsl:for-each select="*[local-name() = 'hasFeature' and not(preceding-sibling::*[local-name()='var'])]">
    <xsl:text>       checkFeature(</xsl:text>
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
</xsl:for-each>
<xsl:for-each select="*[local-name() = 'implementationAttribute']">
    <xsl:text>       setImplementationAttribute("</xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:text>", </xsl:text><xsl:value-of select="@value"/><xsl:text>);
</xsl:text>
</xsl:for-each>
      <xsl:text>
      docsLoaded = 0;
      </xsl:text>
      <xsl:for-each select="$loads">
        <xsl:text>
      var </xsl:text><xsl:value-of select="@var"/><xsl:text>Ref = null;
      if (typeof(this.</xsl:text><xsl:value-of select="@var"/><xsl:text>) != 'undefined') {
        </xsl:text>
        <xsl:value-of select="@var"/><xsl:text>Ref = this.</xsl:text><xsl:value-of select="@var"/><xsl:text>;
      }
      </xsl:text>
      <xsl:text>docsLoaded += preload(</xsl:text><xsl:value-of select="@var"/><xsl:text>Ref, "</xsl:text>
          <xsl:value-of select="@var"/><xsl:text>", "</xsl:text><xsl:value-of select="@href"/><xsl:text>");
        </xsl:text>
       </xsl:for-each>
       if (docsLoaded == <xsl:value-of select="count($loads)"/>) {
          setUpPageStatus = 'complete';
       }
    } catch(ex) {
    	catchInitializationError(builder, ex);
        setUpPageStatus = 'complete';
    }
}



//
//   This method is called on the completion of 
//      each asychronous load started in setUpTests.
//
//   When every synchronous loaded document has completed,
//      the page status is changed which allows the
//      body of the test to be executed.
function loadComplete() {
    if (++docsLoaded == <xsl:value-of select="count($loads)"/>) {
        setUpPageStatus = 'complete';
    }
}

<xsl:apply-templates select="."/>
</script>
        </head>
        <body>
            <h2>Test <xsl:value-of select="concat($target-uri-base, @name)"/></h2>
            
            <p>
            	<xsl:apply-templates select="." mode="html_source"/>
            </p>
            <xsl:call-template name="copyright"/>
            <xsl:for-each select="$loads">
            	<xsl:choose>
            		<!--  theses files don't have [X]HTML equivalents   -->
            		<xsl:when test="@href = 'staff'"/>
            		<xsl:when test="@href = 'staff2'"/>
            		<xsl:when test="@href = 'nodtdstaff'"/>
            		<xsl:when test="@href = 'staffNS'"/>
            		<xsl:when test="@href = 'datatype_normalization'"/>
            		<xsl:when test="@href = 'test0'"/>
            		<xsl:when test="@href = 'book'"/>
            		
            		<xsl:otherwise>
                		<iframe name="{@var}">
                			<xsl:attribute name="src">files/<xsl:value-of select="@href"/>.<xsl:if test="$hideHTML != 'no'">x</xsl:if>html</xsl:attribute>
                		</iframe>
                		<br/>
                	</xsl:otherwise>
                </xsl:choose>
            </xsl:for-each>
        </body>
    </html>
</xsl:template>


<xsl:template match="*[local-name() = 'suite']" mode="jsunit">
    <html>
        <head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
            <title><xsl:value-of select="concat($target-uri-base, @name)"/></title>
			<link href="http://www.w3.org/StyleSheets/activity-home.css" rel="stylesheet" type="text/css" />
            <script type="text/javascript" src="../../jsunit/app/jsUnitCore.js"></script>
            <script type="text/javascript" src="DOMTestCase.js"></script>
            <script type="text/javascript" src="DOMTestSuite.js"></script>
            <script type="text/javascript">
            
function suite() {
  var newsuite = new top.jsUnitTestSuite();
  var suiteBuilder = createConfiguredBuilder();
  var isHTML = (suiteBuilder.contentType == "text/html") || (suiteBuilder.contentType == "application/xhtml+xml");
  <xsl:for-each select="*[local-name() = 'suite.member']">
  	<xsl:apply-templates select="document(@href,.)" mode="suite.member"/>
  </xsl:for-each>
  return newsuite;
}
</script>            
            
        </head>
        <body onload="onImplementationChange()">
        	<h1><xsl:value-of select="*[local-name() = 'metadata']/*[local-name() = 'title']"/></h1>
            <form id="configuration" action="../../jsunit/testRunner.html" onsubmit="fixTestPagePath()">
            <table width="100%" border="1" summary="Configuration">
                <tr><td>                    
                    <table width="100%" summary="Tests">
                        <tr>
                            <td>Test: </td>
                            <td>
                                <select name="testpage" size="1">
                                    <option selected="selected" value="{@name}.html"><xsl:value-of select="@name"/></option>
                                    <xsl:for-each select="*[local-name() = 'suite.member']">
                                    	<xsl:sort select="@href"/>
                                    	<!-- have to call template recursively to strip out path  -->
                                    	<xsl:call-template name="emit-option">
                                    		<xsl:with-param name="href" select="@href"/>
                                    	</xsl:call-template>
                                    </xsl:for-each>
                                </select>
                            </td>
                            <td align="right">
                                <input type="submit" value="Load JSUnit"></input>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
                <tr>
                    <td>
                    <table border="1" width="100%" summary="Configuration">
                    <tr><th>Implementation</th><th>Configuration</th><th>Content Type</th></tr>
                    <tr>
                    <td valign="top">
                            <input type="radio" name="implementation" id="iframeImpl" value="iframe" checked="checked" onclick="onImplementationChange()"/> iframe<br/>
                            <input type="radio" name="implementation" id="dom3lsImpl" value="dom3ls" onclick="onImplementationChange()"/> DOM 3 Load/Save<br/> 
                            	Features: <input type="text" name="dom3lsFeatures" disabled="disabled"/><br/>
                            <input type="radio" name="implementation" id="xmlhttprequest" value="xmlhttprequest" onclick="onImplementationChange()"/> XMLHttpRequest<br/>
                            <input type="radio" name="implementation" id="mozillaXMLImpl" value="mozillaXML" onclick="onImplementationChange()"/> Mozilla XML<br/>
                            <input type="radio" name="implementation" id="msxml3Impl" value="msxml3" onclick="onImplementationChange()"/> MSXML 3.0<br/>
                            <input type="radio" name="implementation" id="msxml4Impl" value="msxml4" onclick="onImplementationChange()"/> MSXML 4.0<br/>
                            <input type="radio" name="implementation" id="svgpluginImpl" value="svgplugin" onclick="onImplementationChange()"/> SVG Plugin<br/>
                    </td>
                    <td valign="top">
							<input onclick="setAsynchronous(true)" name="asynchronous" type="checkbox" checked="checked" disabled="disabled"/> Asynchronous<br/>
							<input type="checkbox" 
                                    name="expandEntityReferences" 
                                    value="true" 
                                    disabled="disabled"
                                    onclick="setImplementationAttribute('expandEntityReferences', true)"/> Expanding Entities<br/>
                            <input type="checkbox" name="ignoringElementContentWhitespace" value="true" disabled="disabled" onclick="setImplementationAttribute('ignoringElementContentWhitespace', true)"/> Ignoring whitespace<br/>
							<input type="checkbox" name="validating" value="true"  disabled="disabled" onclick="setImplementationAttribute('validating', true)"/> Validating<br/>
							<input type="checkbox" name="coalescing" value="true"  disabled="disabled" onclick="setImplementationAttribute('coalescing', true)"/> Coalescing<br/>
							<input type="checkbox" name="namespaceAware" value="true"  disabled="disabled" onclick="setImplementationAttribute('namespaceAware', true)"/> Namespace aware<br/>
							<input type="checkbox" name="ignoringComments" value="true" disabled="disabled" checked="checked" onclick="setImplementationAttribute('ignoringComments', true)"/> Ignoring comments<br/>
							<input type="checkbox" name="skipIncompatibleTests" value="true" checked="checked"/> Skip incompatible tests<br/>
                            <input type="checkbox" name="autorun" checked="checked" value="true"/> Autorun<br/>
                            <input type="checkbox" name="submitCheckbox" onclick="updateTestSubmission()"/> Submit results<br/>
                            Acceptor: http://<input type="text" name="submitresults" value="" disabled="disabled" size="35"/><br/>
							Result ID: <input type="text" name="resultid" value="" disabled="disabled"/><br/>
                    </td>
                    <td valign="top">
                            <xsl:choose>
                            		<xsl:when test="$hideHTML = 'no'">
                            			<input type="radio" name="contentType" id="contentTypeXML" value="text/xml" onclick="setContentType('text/xml')"/>XML<br/>
                            			<input type="radio" name="contentType" id="contentTypeHTML" value="text/html" checked="checked" onclick="setContentType('text/html')"/>HTML<br/>
                            		</xsl:when>
                            		<xsl:otherwise>
                            			<input type="radio" name="contentType" id="contentTypeXML" value="text/xml" checked="checked" onclick="setContentType('text/xml')"/>XML<br/>
                                </xsl:otherwise>
                            </xsl:choose>
                            <input type="radio" name="contentType" id="contentTypeXHTML" value="application/xhtml+xml" onclick="setContentType('application/xhtml+xml')"/>XHTML<br/>
                            <xsl:if test="$hideSVG = 'no'">
                            	<input type="radio" name="contentType" id="contentTypeSVG" value="image/svg+xml" onclick="setContentType('image/svg+xml')"/>SVG<br/>
                            </xsl:if>
                    </td>
                </tr>
                </table>
                </td>
                </tr>
            </table>
            </form>
            <xsl:call-template name="copyright"/>
        </body>
    </html>
</xsl:template>

<xsl:template name="emit-option">
	<xsl:param name="href"/>
	<xsl:choose>
		<xsl:when test="contains($href, '/')">
			<xsl:call-template name="emit-option">
				<xsl:with-param name="href" select="substring-after($href, '/')"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<option value="{substring-before($href,'.xml')}.html"><xsl:value-of select="substring-before($href, '.')"/></option>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:text>
</xsl:text>
</xsl:template>
	

<xsl:template match="*" mode="suite.member"/>
<xsl:template match="text()" mode="suite.member"/>

<xsl:template match="*[local-name() = 'test' or local-name() = 'suite']" mode="suite.member">
  	<xsl:variable name="preconditions" select="*[local-name()='implementationAttribute' or local-name()='hasFeature' and not(preceding-sibling::*[local-name()='var'])]"/>
  	<xsl:variable name="testURL" select="concat($testpath, concat(@name, '.html'))"/>
  	<xsl:variable name="nonHTMLLoads" select="*[local-name() = 'load' and (@href = 'nodtdstaff' or @href='datatype_normalization' or substring(@href, 1, 5) = 'staff')]"/>
  	<xsl:choose>
  		<xsl:when test="$preconditions or $nonHTMLLoads">
  			<xsl:text>  if (!suiteBuilder.skipIncompatibleTests || (</xsl:text>
  		<xsl:if test="$nonHTMLLoads">!isHTML </xsl:if>
  		<xsl:for-each select="$preconditions">
  			<xsl:if test="position() &gt; 1 or $nonHTMLLoads"> &amp;&amp; </xsl:if>
  			<xsl:choose>
  				<xsl:when test="local-name() = 'hasFeature'">
					<xsl:text>suiteBuilder.hasFeature(</xsl:text>
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
					<xsl:text>) </xsl:text>
  				</xsl:when>
  				<xsl:when test="local-name() = 'implementationAttribute'">
					<xsl:text>suiteBuilder.canSetImplementationAttribute("</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>", </xsl:text>
					<xsl:value-of select="@value"/>
					<xsl:text>) </xsl:text>
  				</xsl:when>
  			</xsl:choose>
  		</xsl:for-each>
  	   		<xsl:text>)) {
  	   	newsuite.addTestPage("</xsl:text><xsl:value-of select="$testURL"/><xsl:text>");
  }
</xsl:text>
  		</xsl:when>
  		<xsl:otherwise>
  			<xsl:text>  newsuite.addTestPage("</xsl:text><xsl:value-of select="$testURL"/><xsl:text>");  
</xsl:text>
  		</xsl:otherwise>
  	</xsl:choose>
</xsl:template>


<xsl:template name="copyright-comment">
<xsl:comment>
Copyright © 2001-2005 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C® Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
</xsl:comment>
</xsl:template>

<xsl:template name="copyright">
<p>
Copyright © 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the <a href="http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231">W3C® Software License</a> in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
</p>
</xsl:template>


<xsl:template match="*[local-name()='metadata']" mode="html_source">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;metadata&gt;</xsl:text>
    <br/>
    <xsl:apply-templates select="*" mode="html_metadata">
          <xsl:with-param name="indent" select="concat('&#160;&#160;&#160;&#160;&#160;',$indent)"/>
    </xsl:apply-templates>
    <xsl:text>&lt;/metadata&gt;</xsl:text>
    <br/>
</xsl:template>

<xsl:template match="*" mode="html_metadata">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="local-name()"/>
    <xsl:apply-templates select="@*" mode="html_source"/>
    <xsl:choose>
    	<xsl:when test="*|text()">
    		<xsl:text>&gt;</xsl:text>
    		<xsl:apply-templates select="*|text()" mode="html-metadata"/>
    		<xsl:text>&lt;/</xsl:text>
    		<xsl:value-of select="local-name()"/>
    		<xsl:text>&gt;
</xsl:text>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:text>/&gt;
</xsl:text>    	
    	</xsl:otherwise>
    </xsl:choose>
    <br/>
</xsl:template>
        

<xsl:template match="*" mode="html_source">
    <xsl:param name="indent"/>
    <!--  indent the element   -->
    <xsl:value-of select="$indent"/>
    <!--  start the element   -->
    <xsl:text>&lt;</xsl:text>
    <!--  output the tag name   -->
    <xsl:value-of select="local-name()"/>
    <!--  output any attributes  -->
    <xsl:apply-templates select="@*" mode="html_source"/>

    <xsl:choose>
        <!--  if there are any child elements  -->

        <xsl:when test="*|comment()">
            <!--   then close the start tag  -->
            <xsl:text>&gt;</xsl:text>
            <br/>
            <!--    emit the child elements   -->
            <xsl:apply-templates select="*|comment()|text()" mode="html_source">
                <xsl:with-param name="indent" select="concat('&#160;&#160;&#160;&#160;&#160;',$indent)"/>
            </xsl:apply-templates>
            <!--  write the end tag   -->
            <xsl:value-of select="$indent"/>
            <xsl:text>&lt;/</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&gt;</xsl:text>
            <br/>
        </xsl:when>

        <xsl:otherwise>
            <!--  close an empty tag   -->
            <xsl:text>/&gt;</xsl:text>
            <br/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="@id" mode="html_source">
    <xsl:text> </xsl:text>
    <a id="{.}">
        <xsl:text>id='</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>'</xsl:text>
    </a>
</xsl:template>


<xsl:template match="@resource" mode="html_source">
    <xsl:text> resource='</xsl:text>
    <xsl:choose>
		<xsl:when test="contains(.,'#xpointer(id(')">
            <a>
                <xsl:attribute name="href">
		            <xsl:value-of select="substring-before(.,'#xpointer')"/>
			        <xsl:text>#</xsl:text>
			        <xsl:variable name="after" select="substring-after(.,&quot;#xpointer(id(&apos;&quot;)"/>
			        <xsl:value-of select="substring-before($after,&quot;')&quot;)"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </a>
		</xsl:when>

        <xsl:otherwise>
            <a href="{.}">
                <xsl:value-of select="."/>
            </a>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>'</xsl:text>
</xsl:template>

<xsl:template match="@*" mode="html_source">
    <xsl:text> </xsl:text>
    <xsl:value-of select="local-name()"/>
    <xsl:text>='</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>'</xsl:text>
</xsl:template>

<xsl:template match="comment()" mode="html_source">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;!--</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>--&gt;</xsl:text>
    <br/>
</xsl:template>

<xsl:template match="text()" mode="html_metadata">
	<xsl:value-of select="."/>
</xsl:template>

<xsl:template match="text()" mode="html_source">
</xsl:template>



</xsl:stylesheet>
