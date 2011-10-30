<?xml version="1.0" encoding="UTF-8"?>
<!-- DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER                   -->
<!--                                                                                -->
<!-- Copyright 2008, 2010 Vincent SPIEWAK <vspiewak@gmail.com>. All rights reserved -->
<!--                                                                                -->
<!-- Use is subject to license terms.                                               -->
<!--                                                                                -->
<!-- This program is free software; you can redistribute it and/or modify           -->
<!-- it under the terms of the GNU General Public License as published by           -->
<!-- the Free Software Foundation; version 2 of the License.                        -->
<!--                                                                                -->
<!-- This program is distributed in the hope that it will be useful,                -->
<!-- but WITHOUT ANY WARRANTY; without even the implied warranty of                 -->
<!-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                  -->
<!-- GNU General Public License for more details.                                   -->
<!--                                                                                -->
<xsl:stylesheet version="2.0" 
                xmlns:fn="http://www.versusoft.com/"
		xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:dtb="http://www.daisy.org/z3986/2005/dtbook/"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
                xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
                xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
                xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
                xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
                xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:dc="http://purl.org/dc/elements/1.1/"
                xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
                xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
                xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
                xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
                xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
                xmlns:math="http://www.w3.org/1998/Math/MathML"
                xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
                xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
                xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
                xmlns:ooo="http://openoffice.org/2004/office"
                xmlns:ooow="http://openoffice.org/2004/writer"
                xmlns:oooc="http://openoffice.org/2004/calc"
                xmlns:dom="http://www.w3.org/2001/xml-events"
                xmlns:xforms="http://www.w3.org/2002/xforms"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema"
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                xmlns:rpt="http://openoffice.org/2005/report"
		xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
                xmlns:xhtml="http://www.w3.org/1999/xhtml"
                xmlns:grddl="http://www.w3.org/2003/g/data-view#"
                xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
                office:version="1.2"
                grddl:transformation="http://docs.oasis-open.org/office/1.2/xslt/odf2rdf.xsl"
                office:mimetype="application/vnd.oasis.opendocument.text"
		xmlns:saxon="http://saxon.sf.net/"
		extension-element-prefixes="saxon"
		exclude-result-prefixes="xs fn">

<xsl:output method="xml" indent="yes" encoding="UTF-8" />
<!--<xsl:output method="text" indent="yes" encoding="UTF-8" name="pic"
/>-->

<xsl:param name="PICTURE_BASEDIR" select="'images/'" />

<xsl:variable name="PICTURE_FOLDER" select="'Pictures/'" />
<xsl:variable name="PICTURE_OUTPUT" select="'images.datas.xml'" />
<xsl:variable name="pic_count" select="0" saxon:assignable="yes" />

<!--                                                           -->
<!-- ELEMENT/ATTRIBUTE BY DEFAULT                              -->
<!--                                                           -->
<xsl:template match="node() | @*">
    <xsl:copy>
       <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
</xsl:template>

<xsl:template match="draw:image">

   <!-- continue process -->
   <xsl:element name="{name()}">

     <xsl:choose>

       <xsl:when test="starts-with(@xlink:href,$PICTURE_FOLDER)">
	 
	 <saxon:assign name="pic_count" select="$pic_count + 1" />
	 <xsl:variable name="filename" select="substring(@xlink:href, string-length($PICTURE_FOLDER) + 1)" />
	 <xsl:variable name="ext" select="tokenize($filename, '\.')[last()]" />
	 <xsl:variable name="newsrc" select="concat($PICTURE_BASEDIR, $pic_count,'.',$ext)" />

	 <xsl:attribute name="xlink:href" select="$newsrc" />
	 <xsl:attribute name="xlink:oldhref" select="@xlink:href" />

       </xsl:when>

       <xsl:otherwise>
	 <xsl:attribute name="xlink:href" select="@xlink:href" />
       </xsl:otherwise>

     </xsl:choose>
   
       <xsl:apply-templates select="@*[name() != 'xlink:href'] | node()" />

   </xsl:element>
</xsl:template>

</xsl:stylesheet>
