<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--  relative to transform   -->

    <xsl:param name="interfaces-docname">../build/dom1-interfaces.xml</xsl:param>
    <xsl:param name="package">DOM_TS</xsl:param>
    <xsl:param name="target-uri-base">http://www.w3.org/2001/DOM-Test-Suite/tests/Level-1/</xsl:param>
<xsl:output method="text" encoding="UTF-8"/>
<xsl:variable name="domspec" select="document($interfaces-docname)"/>

<xsl:template match="/">
    <xsl:apply-templates/>
</xsl:template>

<!--   when encountering a test   -->
<xsl:template match="*[local-name()='test']">
package <xsl:value-of select="$package"/>.<xsl:value-of select="@name"/> is

   type Test is new <xsl:value-of select="$package"/>.Test with null record;
   function Create return Test;
   procedure Run (Self : in out Test);

end <xsl:value-of select="$package"/>.<xsl:value-of select="@name"/>;

package body <xsl:value-of select="$package"/>.<xsl:value-of select="@name"/> is

   function Create return Test is
   begin
      return Result : Test;
   end Create;

   procedure Run (Self : in out Test) is
<xsl:text>      </xsl:text>
<xsl:apply-templates mode="body" select="*[local-name() = 'var']">
    <xsl:with-param name="vardefs" select="*[local-name() = 'var']"/>
</xsl:apply-templates>
   begin
<xsl:apply-templates mode="body" select="*[local-name() != 'var']">
    <xsl:with-param name="vardefs" select="*[local-name() = 'var']"/>
</xsl:apply-templates>
   end Run;

end <xsl:value-of select="$package"/>.<xsl:value-of select="@name"/>;
</xsl:template>

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


<!--    

    test framework constructs

-->
<xsl:template match="*[local-name()='var']" mode="body">
    <xsl:variable name="varname" select="@name"/>
    <xsl:value-of select="$varname"/><xsl:text> : </xsl:text>
    <xsl:call-template name="produce-type">
      <xsl:with-param name="type" select="@type"/>
    </xsl:call-template>
    
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



<xsl:template name="produce-type">
    <xsl:param name="type"/>
    <xsl:choose>
        <xsl:when test="$type='Document'">XML.DOM.Documents.DOM_Document</xsl:when>
        <xsl:when test="$type='NodeList'">XML.DOM.Node_Lists.Node_List</xsl:when>
        <xsl:when test="$type='Node'">XML.DOM.Nodes.Node</xsl:when>
        <xsl:when test="$type='DOMString'">XML.DOM.DOM_String</xsl:when>
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

</xsl:stylesheet>
