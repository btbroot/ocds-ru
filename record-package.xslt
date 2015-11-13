<?xml version="1.0" encoding="UTF-8"?>

<!-- 
 Copyright 2015 Al Nikolov

 This file is part of ocds-ru suite.

    ocds-ru is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    ocds-ru is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with ocds-ru.  If not, see <http://www.gnu.org/licenses/>.
-->

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:date="http://exslt.org/dates-and-times"
	xmlns:str="http://exslt.org/strings"
>
	<xsl:param name="uri">file:///</xsl:param>
	<xsl:param name="releases"/>
	<xsl:param name="ocid"/>
	<xsl:template match="/">
		<record-package>
			<!-- Required -->
			<uri><xsl:value-of select="$uri"/></uri>
			<publisher>
				<!-- Required -->
				<name>Al Nikolov</name>
				<!-- Optional -->
				<!-- <scheme> -->
				<!-- <id> -->
				<!-- <uri> -->
			</publisher>
			<publishedDate><xsl:value-of select="date:date-time()"/></publishedDate>
			<packages type="array">
				<element>file:///</element>
			</packages>
			<records type="array">
				<element>
					<!-- Required -->
					<ocid><xsl:value-of select="$ocid"/></ocid>
					<releases type="array">
						<xsl:for-each select="str:split($releases)">
							<element><xsl:copy-of select="document(current())/*/*"/></element>
						</xsl:for-each>
					</releases>
					<!-- Optional -->
					<!-- <compiledRelease> -->
					<!-- <versionedRelease> -->
				</element>
			</records>
			<!-- Optional -->
			<license>http://creativecommons.org/publicdomain/mark/1.0/deed.ru</license>
			<publicationPolicy>https://github.com/btbroot/ocds-ru/blob/master/README.md</publicationPolicy>
		</record-package>
	</xsl:template>
</xsl:stylesheet>
