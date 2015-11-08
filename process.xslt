<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright 2015 Al Nikolov -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="text"/>
	<xsl:template match="/">
		<xsl:value-of select="concat(ocds/ocid, ' ', ocds/id, ' ', ocds/date)"/>
	</xsl:template>
</xsl:stylesheet>
