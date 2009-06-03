<!-- manpage-normal.xsl:
     special settings for manpages rendered from asciidoc+docbook
     handles anything we want to keep away from docbook-xsl 1.72.0 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		version="1.0">

<!-- these params silence some output from xmlto -->
<xsl:param name="man.output.quietly" select="1"/>
<xsl:param name="refentry.meta.get.quietly" select="1"/>

<!-- convert asciidoc callouts to man page format;
     docbook.backslash and docbook.dot params
     must be supplied by another XSL file or other means -->
<xsl:template match="co">
	<xsl:value-of select="concat(
			      $docbook.backslash,'fB(',
			      substring-after(@id,'-'),')',
			      $docbook.backslash,'fR')"/>
</xsl:template>
<xsl:template match="calloutlist">
	<xsl:value-of select="$docbook.dot"/>
	<xsl:text>sp&#10;</xsl:text>
	<xsl:apply-templates/>
	<xsl:text>&#10;</xsl:text>
</xsl:template>
<xsl:template match="callout">
	<xsl:value-of select="concat(
			      $docbook.backslash,'fB',
			      substring-after(@arearefs,'-'),
			      '. ',$docbook.backslash,'fR')"/>
	<xsl:apply-templates/>
	<xsl:value-of select="$docbook.dot"/>
	<xsl:text>br&#10;</xsl:text>
</xsl:template>

<!-- these are the normal values for the roff control characters -->
<xsl:param name="docbook.backslash">\</xsl:param>
<xsl:param name="docbook.dot"	>.</xsl:param>

</xsl:stylesheet>
