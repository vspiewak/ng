    <!--
     ============
     INLINES TAGS
     ============
  -->
    <xsl:template match="text:p">
        <xsl:param name="source" />
        <xsl:call-template name="para">
            <xsl:with-param name="source" select="$source"/>
        </xsl:call-template>
    </xsl:template>
    <xsl:template match="text:span">
        <xsl:if test="string(.) or count(./*) > 0">
            <xsl:variable name="fontStyle"
                      select="/office:document/office:automatic-styles/
                      style:style[@style:name=(current()/@text:style-name)]
        /style:text-properties/@fo:font-style"/>
            <xsl:variable name="fontWeight"
                      select="/office:document/office:automatic-styles/
                      style:style[@style:name=(current()/
                      @text:style-name)]/style:text-properties/
        @fo:font-weight"/>
            <xsl:variable name="fontName"
                      select="/office:document/office:automatic-styles/
                      style:style[@style:name=(current()/
                      @text:style-name)]/style:properties/
        @style:font-name"/>
            <xsl:variable name="textPosition"
                      select="/office:document/office:automatic-styles/
                      style:style[@style:name=(current()/
                      @text:style-name)]/style:text-properties/
        @style:text-position"/>
            <xsl:variable name="parentStyleName"
                      select="/office:document/office:styles/
                      style:style[@style:name=(current()/
        @text:style-name)]/@style:parent-style-name"/>
        
        <!-- With this template, we matches derived of derived (of derived ...) of Citation Styles -->
        <!--<xsl:variable name="isCitation">
            <xsl:call-template name="hasParentStyle">
                <xsl:with-param name="style-name" select="@text:style-name" />
                <xsl:with-param name="match-style-name" select="'Citation'" />
            </xsl:call-template>
        </xsl:variable>-->
            <xsl:choose>
            
            <!-- QUOTATION INLINE ELEMENT (can match derived of derived of Quotation)-->
            <!-- <xsl:when test="$isCitation=1">
                <q>
                    <xsl:call-template name="addLangAttrSpan" />
                    <xsl:apply-templates/>
                </q>
            </xsl:when>-->
            
            <!-- QUOTATION INLINE ELEMENT -->
                <xsl:when test="@text:style-name='Citation' 
            or $parentStyleName='Citation'
            or @text:style-name='_5b_DAISY_5d__20_Quotation'
            or $parentStyleName='_5b_DAISY_5d__20_Quotation'">
                    <q>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </q>
                </xsl:when>
            
            <!-- ABBREVIATION INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Abbreviation'
            or $parentStyleName='_5b_DAISY_5d__20_Abbreviation'">
                    <abbr>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </abbr>
                </xsl:when>
            
            <!-- ACRONYM INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Acronym'
            or $parentStyleName='_5b_DAISY_5d__20_Acronym'">
                    <acronym pronounce="no">
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </acronym>
                </xsl:when>
            
            <!-- ACRONYM PRONOUNCE INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Acronym_20__28_Pronounce_29_'
            or $parentStyleName='_5b_DAISY_5d__20_Acronym_20__28_Pronounce_29_'">
                    <acronym pronounce="yes">
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </acronym>
                </xsl:when>
            
            <!-- COMPUTER CODE INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Computer_20_Code'
            or $parentStyleName='_5b_DAISY_5d__20_Computer_20_Code'">
                    <code>
                        <xsl:apply-templates/>
                    </code>
                </xsl:when>
            
            <!-- KEYBOARD INPUT INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Keyboard_20_Input'
            or $parentStyleName='_5b_DAISY_5d__20_Keyboard_20_Input'">
                    <kbd>
                        <xsl:apply-templates/>
                    </kbd>
                </xsl:when>
            
            <!-- PRODNOTE INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Prodnote'
            or $parentStyleName='_5b_DAISY_5d__20_Prodnote'">
                    <prodnote render="required">
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </prodnote>
                </xsl:when>
            
            <!-- PRODNOTE OPTIONAL INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Prodnote_20__28_Optional_29_'
            or $parentStyleName='_5b_DAISY_5d__20_Prodnote_20__28_Optional_29_'">
                    <prodnote render="optional">
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </prodnote>
                </xsl:when>
            
            <!-- SAMPLE INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Sample'
            or $parentStyleName='_5b_DAISY_5d__20_Sample'">
                    <samp>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </samp>
                </xsl:when>
            
            <!-- SENTENCE INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Sentence'
            or $parentStyleName='_5b_DAISY_5d__20_Sentence'">
                    <sent>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </sent>
                </xsl:when>
            
            <!-- SPAN INLINE ELEMENT -->
                <xsl:when test="@text:style-name='_5b_DAISY_5d__20_Span'
            or $parentStyleName='_5b_DAISY_5d__20_Span'">
                    <span>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </span>
                </xsl:when>
            
            <!-- STRONG EMPHASIS INLINE ELEMENT -->
                <xsl:when test="@text:style-name='Strong_20_Emphasis'
            or $parentStyleName='Strong_20_Emphasis'">
                    <strong>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </strong>
                </xsl:when>
            
            <!-- EMPHASIS INLINE ELEMENT -->
                <xsl:when test="@text:style-name='Emphasis'
            or $parentStyleName='Emphasis'">
                    <em>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </em>
                </xsl:when>
            
            <!-- SUBSCRIPT INLINE ELEMENT -->
                <xsl:when test="contains($textPosition,'sub')">
                    <sub>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </sub>
                </xsl:when>
            
            <!-- SUPERSCRIPT INLINE ELEMENT -->
                <xsl:when test="contains($textPosition,'sup')">
                    <sup>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </sup>
                </xsl:when>
                <xsl:when test="$fontWeight='bold'">
                    <strong>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </strong>
                </xsl:when>
                <xsl:when test="$fontStyle='italic'">
                    <em>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates/>
                    </em>
                </xsl:when>
                <xsl:otherwise>
                    <span>
                        <xsl:call-template name="addLangAttrSpan" />
                        <xsl:apply-templates />
                    </span>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

