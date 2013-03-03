<?xml version="1.0"?>
<!--
Copyright &#xA9; 2001-2004 World Wide Web Consortium, 
(Massachusetts Institute of Technology, European Research Consortium 
for Informatics and Mathematics, Keio University). All 
Rights Reserved. This work is distributed under the W3C&#xAE; Software License [1] in the 
hope that it will be useful, but WITHOUT ANY WARRANTY; without even 
the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 

[1] http://www.w3.org/Consortium/Legal/2002/copyright-software-20021231
-->

<!--   
This transform generates an HTML pretty print representation
of a test file


-->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" 
		doctype-public="-//W3C//DTD HTML 4.01//EN" 
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		encoding="US-ASCII"/>



<xsl:template match="/">
    <html>
        <head>
			<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>        
            <xsl:apply-templates mode="head"/>
        </head>
        <body>
        	<pre>
            <xsl:apply-templates select="*|comment()" mode="body">
                <xsl:with-param name="indent"></xsl:with-param>
            </xsl:apply-templates>
            </pre>
        </body>
    </html>
</xsl:template>

<xsl:template match="*[local-name() = 'test']" mode="head">
    <title>Test <xsl:value-of select="@name"/></title>
</xsl:template>

<xsl:template match="*[local-name() = 'suite']" mode="head">
    <title>Test Suite <xsl:value-of select="@name"/></title>
</xsl:template>

<xsl:template match="text()" mode="head"/>


<xsl:template match="*[local-name()='metadata']" mode="body">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;metadata&gt;
</xsl:text>
    <xsl:apply-templates select="*" mode="metadata">
          <xsl:with-param name="indent" select="concat('&#160;&#160;&#160;&#160;&#160;',$indent)"/>
    </xsl:apply-templates>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;/metadata&gt;
</xsl:text>
</xsl:template>

<xsl:template match="*" mode="metadata">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;</xsl:text>
    <xsl:value-of select="local-name()"/>
    <xsl:apply-templates select="@*" mode="body"/>
    <xsl:choose>
        <xsl:when test="string-length(normalize-space(text())) &gt; 50">
            <xsl:text>&gt;
</xsl:text>
            <xsl:value-of select="text()"/>
            <xsl:text>
</xsl:text>
    		<xsl:value-of select="$indent"/>            
            <xsl:text>&lt;/</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&gt;</xsl:text>
        </xsl:when>
        <xsl:when test="string-length(normalize-space(text())) &gt; 0">
            <xsl:text>&gt;</xsl:text>
            <xsl:value-of select="normalize-space(text())"/>
            <xsl:text>&lt;/</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&gt;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>/&gt;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:text>
</xsl:text>
</xsl:template>
        

<xsl:template match="*" mode="body">
    <xsl:param name="indent"/>
    <!--  indent the element   -->
    <xsl:value-of select="$indent"/>
    <!--  start the element   -->
    <xsl:text>&lt;</xsl:text>
    <!--  output the tag name   -->
    <xsl:value-of select="local-name()"/>
    <!--  output any attributes  -->
    <xsl:apply-templates select="@*" mode="body"/>
    <xsl:if test="local-name() = 'test' or local-name() = 'suite'">
    	<xsl:text>
      xmlns='</xsl:text>
    	<xsl:value-of select="namespace-uri()"/>
    	<xsl:text>'</xsl:text>
    </xsl:if>
    

    <xsl:choose>
        <!--  if there are any child elements  -->

        <xsl:when test="*|comment()">
            <!--   then close the start tag  -->
            <xsl:text>&gt;
</xsl:text>
            <!--    emit the child elements   -->
            <xsl:apply-templates select="*|comment()|text()" mode="body">
                <xsl:with-param name="indent" select="concat('&#160;&#160;&#160;&#160;&#160;',$indent)"/>
            </xsl:apply-templates>
            <!--  write the end tag   -->
            <xsl:value-of select="$indent"/>
            <xsl:text>&lt;/</xsl:text>
            <xsl:value-of select="local-name()"/>
            <xsl:text>&gt;</xsl:text>
        </xsl:when>

        <xsl:otherwise>
            <!--  close an empty tag   -->
            <xsl:text>/&gt;
</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<xsl:template match="@id" mode="body">
    <xsl:text> </xsl:text>
    <a id="{.}">
        <xsl:text>id='</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>'</xsl:text>
    </a>
</xsl:template>

<xsl:template match="@resource" mode="body">
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

<xsl:template match="@*" mode="body">
    <xsl:text> </xsl:text>
    <xsl:value-of select="name()"/>
    <xsl:text>='</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>'</xsl:text>
</xsl:template>

<xsl:template match="comment()" mode="body">
    <xsl:param name="indent"/>
    <xsl:value-of select="$indent"/>
    <xsl:text>&lt;!--</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>--&gt;
</xsl:text>
</xsl:template>

<xsl:template match="text()" mode="body"/>

</xsl:stylesheet>
