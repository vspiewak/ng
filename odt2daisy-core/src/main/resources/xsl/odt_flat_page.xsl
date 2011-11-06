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
                xmlns:fn="http://odt2daisy.sf.net"
		extension-element-prefixes="saxon"
		exclude-result-prefixes="xs fn">


<xsl:output method="xml" indent="yes" encoding="UTF-8" />


<xsl:variable name="pagenum" select="0" saxon:assignable="yes" />
<xsl:variable name="enumType" select="'1'" saxon:assignable="yes" />
<xsl:variable name="pagevalue" select="0" saxon:assignable="yes" />
<xsl:variable name="renderPageNumber" select="false()" saxon:assignable="yes" />
<xsl:variable name="masterPageName" select="'Standard'" saxon:assignable="yes" />
<xsl:variable name="pageLayoutName" select="'name'" saxon:assignable="yes" />
<xsl:variable name="append" select="false" saxon:assignable="yes" />


<!--                                                           -->
<!-- ELEMENT/ATTRIBUTE BY DEFAULT                              -->
<!--                                                           -->
<xsl:template match="node() | @*">
    <xsl:copy>
       <xsl:apply-templates select="@* | node()" />
    </xsl:copy>

</xsl:template>


<!--                                                           -->
<!-- ELEMENT TEXT:SOFT-PAGE-BREAK                              -->
<!--                                                           -->
<xsl:template match="text:soft-page-break">
  <saxon:assign name="pagenum" select="$pagenum + 1" />
  
   <!-- print pagenum tag -->
   <xsl:call-template name="printPageNumberTag" />
</xsl:template>


<!-- remove duplicated TEXT:SOFT-PAGE-BREAK in table cells -->
<xsl:template match="table:table-row/table:table-cell[position() > 1]//text:soft-page-break" />

<!-- remove inside text:h (append in endTagHandlerEvent )-->
<xsl:template match="text:h/text:soft-page-break" />

<!--                                                           -->
<!-- ELEMENT TEXT:P / TEXT:H                                   -->
<!--                                                           -->
<xsl:template match="text:p | text:h">

   <!-- reset append flag -->
   <saxon:assign name="append" select="false()" />
 
   <!-- append if first element --> 
   <xsl:call-template name="isFirstElement" />

   <xsl:choose>
      
      <!-- case 1: page-number="value" -->
      <xsl:when test="number(//style:style[@style:name = current()/@text:style-name]/style:paragraph-properties/@style:page-number)">
         <saxon:assign name="pagenum" select="//style:style[@style:name = current()/@text:style-name]/style:paragraph-properties/@style:page-number" />
	 <saxon:assign name="pagenum" select="$pagenum - 1" />
         <saxon:assign name="append" select="true()" />
      </xsl:when>

      <!-- case 2: page-number='auto' -->
      <xsl:when test="//style:style[@style:name = current()/@text:style-name]/style:paragraph-properties/@style:page-number = 'auto'">
         <saxon:assign name="append" select="true()" />
      </xsl:when>

      <!-- case 3: break-before='page' -->
      <xsl:when test="//style:style[@style:name = current()/@text:style-name]/style:paragraph-properties/@fo:break-before='page'">
         <saxon:assign name="append" select="true()" />
      </xsl:when>

   </xsl:choose>

   <!-- update masterPageName -->
   <xsl:if test="//style:style[@style:name = current()/@text:style-name]/@style:master-page-name">
      <!--<xsl:message select="concat('change masterPageName: ',//style:style[@style:name = current()/@text:style-name]/@style:master-page-name)" />-->
      <saxon:assign name="masterPageName" select="//style:style[@style:name = current()/@text:style-name]/@style:master-page-name" />
   </xsl:if>
   
   <!-- append Page Number if necessary -->
   <xsl:if test="$append">
      <xsl:call-template name="appendPageNumberTag" />
   </xsl:if>

   <!-- continue process -->
   <xsl:element name="{name()}">
       <xsl:apply-templates select="@* | node()" />
   </xsl:element>

   <!-- launch end tag event -->
   <xsl:call-template name="endTagHandlerEvent" />

</xsl:template>
 

<!--                                                           -->
<!-- ELEMENT TABLE:TABLE                                       -->
<!--                                                           -->
<xsl:template match="table:table">

   <!-- reset append flag -->
   <saxon:assign name="append" select="false()" />
 
   <!-- append if first element --> 
   <xsl:call-template name="isFirstElement" />

   <xsl:choose>
      
      <!-- case 1: page-number="value" -->
      <xsl:when test="number(//style:style[@style:name = current()/@table:style-name]/style:table-properties/@style:page-number)">
         <saxon:assign name="pagenum" select="//style:style[@style:name = current()/@table:style-name]/style:table-properties/@style:page-number" /> 
         <saxon:assign name="pagenum" select="$pagenum - 1" />
         <saxon:assign name="append" select="true()" />
      </xsl:when>

      <!-- case 2: page-number='auto' -->
      <xsl:when test="//style:style[@style:name = current()/@table:style-name]/style:table-properties/@style:page-number = 'auto'">
         <saxon:assign name="append" select="true()" />
      </xsl:when>

      <!-- case 3: break-before='page' -->
      <xsl:when test="//style:style[@style:name = current()/@table:style-name]/style:table-properties/@fo:break-before='page'">
         <saxon:assign name="append" select="true()" />
      </xsl:when>

   </xsl:choose>

   <!-- update masterPageName -->
   <xsl:if test="//style:style[@style:name = current()/@table:style-name]/@style:master-page-name">
      <saxon:assign name="masterPageName" select="//style:style[@style:name = current()/@table:style-name]/@style:master-page-name" />
   </xsl:if>
   
   <!-- append Page Number if necessary -->
   <xsl:if test="$append">
      <xsl:call-template name="appendPageNumberTag" />
   </xsl:if>

   <!-- continue process -->
   <xsl:element name="{name()}">
       <xsl:apply-templates select="@* | node()" />
   </xsl:element>

   <!-- launch end tag event -->
   <xsl:call-template name="endTagHandlerEvent" />
   
</xsl:template>

<!--                                                           -->
<!-- TEMPLATE: appendPageNumberTag                             -->
<!--                                                           -->
<xsl:template name="appendPageNumberTag">

      <!-- incr pagenum -->
      <saxon:assign name="pagenum" select="$pagenum + 1" />

      <!-- update renderPageNumber -->
      <saxon:assign name="renderPageNumber" select="(count(//style:master-page[@style:name = $masterPageName]/style:header//text:page-number) + count(//style:master-page[@style:name = $masterPageName]/style:footer//text:page-number))  > 0" />

      <!-- update pageLayoutName -->
      <saxon:assign name="pageLayoutName" select="//style:master-page[@style:name = $masterPageName]/@style:page-layout-name" />
      
      <!-- update enumType -->
      <saxon:assign name="enumType" select="//style:page-layout[@style:name = $pageLayoutName]/style:page-layout-properties/@style:num-format" />

      <!-- patch for overwritten num-format -->
      <xsl:if test="//style:master-page[@style:name = $masterPageName]//text:page-number/@style:num-format">
          <!--<xsl:message select="'overwrite'" />-->
          <saxon:assign name="enumType" select="//style:master-page[@style:name = $masterPageName]//text:page-number/@style:num-format" />
      </xsl:if>

      <!-- print pagenum tag -->
      <xsl:call-template name="printPageNumberTag" />
      
</xsl:template>


<!--                                                           -->
<!-- TEMPLATE: isFirstElement                                  -->
<!--                                                           -->
<xsl:template name="isFirstElement">
   <xsl:if test="current()/preceding-sibling::*[1]/name() = 'text:sequence-decls'">
      <saxon:assign name="append" select="true()" />
   </xsl:if>
</xsl:template>


<!--                                                           -->
<!-- TEMPLATE: printPageNumberTag                              -->
<!--                                                           -->
<xsl:template name="printPageNumberTag">

   <!--
   <xsl:message select="concat('DEBUG: current position: ', position())" />
   <xsl:message select="concat('DEBUG: last position: ', last())" />

   <xsl:variable name="progress" select="(position() * 100) div last()" />

   <xsl:message select="concat('name: ', ../local-name())" />
   <xsl:message select="concat('name: ', 1 + count(//office:text/*))" />
 
   <xsl:if test="../local-name() = 'text'">
      <xsl:message select="concat('DEBUG: progress: ', format-number($progress, '#.00'), '%')" />
   </xsl:if>
   -->

   <saxon:assign name="pagevalue">
      <xsl:number value="$pagenum" format="{$enumType}" />
   </saxon:assign>

   <xsl:message select="concat('pagenum num:',$pagenum,'
enum:',$enumType,' value:',$pagevalue,' render:',$renderPageNumber,' masterPage:',$masterPageName,' pageLayoutName:',$pageLayoutName)"/>

   <pagenum num="{$pagenum}" enum="{$enumType}" value="{$pagevalue}" render="{$renderPageNumber}"/> 

</xsl:template>

<!-- TEMPLATE end tag event -->
<xsl:template name="endTagHandlerEvent">

  <!-- append pagenum before text:h -->
  <xsl:if test="following-sibling::*[1][name()='text:h']/text:soft-page-break">
       <saxon:assign name="pagenum" select="$pagenum + 1" />
       <!-- print pagenum tag -->
       <xsl:call-template name="printPageNumberTag" />
  </xsl:if>
</xsl:template>

<!--                                                          -->
<!-- FUNCTION                                                 -->
<!--                                                          -->
<xsl:function name="fn:toRoman" as="xs:string">
  <xsl:param name="value" as="xs:integer"/>
  <xsl:number value="$value" format="i"/>
</xsl:function>

<xsl:function name="fn:toLetter" as="xs:string">
  <xsl:param name="value" as="xs:integer"/>
  <xsl:number value="$value" format="a"/>
</xsl:function>
<xsl:function name="fn:formatNumber" as="xs:string">
  <xsl:param name="value" as="xs:integer"/>
  <xsl:param name="format" as="xs:string"/>
  <xsl:number value="$value" format="$format"/>
</xsl:function>

</xsl:stylesheet>
