    <!--
  ======
  TABLES
  ======
    -->
    <xsl:template match="table:table" name="table">
        
        <!-- get Parant Style Name of first para cell -->
        <xsl:variable name="parentStyleNameFirstCell"
                      select="/office:document/office:automatic-styles/
                      style:style[
                      @style:name=(current()/table:table-row[1]/table:table-cell/text:p/@text:style-name)
        ]/@style:parent-style-name"/>
        <xsl:variable name="styleNameFirstCell"
                      select="current()/table:table-row[1]/table:table-cell/text:p/@text:style-name"/>
        
        <!-- TABLE ELEMENT -->
        <table>
            <xsl:choose>
                
                <!-- if table have headings -->
                <xsl:when test="$parentStyleNameFirstCell = 'Table_20_Heading' or $styleNameFirstCell = 'Table_20_Heading'">
                    
                    <!-- THEAD ELEMENT -->
                    <thead>
                        <xsl:apply-templates select="current()/table:table-row[ position() = 1 ]">
                            <xsl:with-param name="heading" select="true()" />
                        </xsl:apply-templates>
                    </thead>
                    
                    <!-- TBODY ELEMENT -->
                    <tbody>
                        <xsl:apply-templates select="current()/table:table-row[ position() > 1 ]" />
                    </tbody>
                </xsl:when>

                <!-- if table have headings (with table:table-header-rows) -->
                <xsl:when test="current()/table:table-header-rows">

                    <!-- THEAD ELEMENT -->
                    <thead>
                        <xsl:apply-templates select="current()/table:table-header-rows/table:table-row">
                            <xsl:with-param name="heading" select="true()" />
                        </xsl:apply-templates>
                    </thead>

                    <!-- TBODY ELEMENT -->
                    <tbody>
                        <xsl:apply-templates select="current()/table:table-row" />
                    </tbody>
                </xsl:when>

                <!-- simple table -->
                <xsl:otherwise>
                    <xsl:apply-templates />
                </xsl:otherwise>
            </xsl:choose>
        </table>
    </xsl:template>
    
    
    
    <!-- TR ELEMENT -->
    <xsl:template match="table:table-row" name="table-row">
        <xsl:param name="heading" select="false()" />
        <tr>
            <xsl:apply-templates>
                <xsl:with-param name="heading" select="$heading" />
            </xsl:apply-templates>
        </tr>
    </xsl:template>
    <xsl:template match="table:table-cell" name="table-cell">
        <xsl:param name="heading" select="false()" />
        <xsl:choose>
            
            <!-- TH ELEMENT -->
            <!-- if it is an heading table -->
            <xsl:when test="$heading">
                <th>
                    <xsl:apply-templates />
                </th>
            </xsl:when>
            
            <!-- if it a normal cell -->
            <xsl:otherwise>
                
                <!-- TD ELEMENT -->
                <xsl:element name="td">
                    <xsl:if test="@table:number-columns-spanned">
                        <xsl:attribute name="colspan">
                            <xsl:value-of select="@table:number-columns-spanned" />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="@table:number-rows-spanned">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="@table:number-rows-spanned" />
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates />
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    

