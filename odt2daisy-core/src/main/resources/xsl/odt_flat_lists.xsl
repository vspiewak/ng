    <!--
	=====
	LISTS
	=====
      -->
    
    <!-- LIST ELEMENT -->
    <xsl:template name="list" match="text:list">

        <xsl:variable name="offset-list">
            <xsl:call-template name="find-offset-list">
                <xsl:with-param name="node" select="." />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="list-style-name">
            <xsl:call-template name="find-list-style-name">
                <xsl:with-param name="node" select="." />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="offset-numbering-list">
            <xsl:call-template name="find-offset-numbering-list">
                <xsl:with-param name="node" select="." />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="numbering-format">
                    <xsl:value-of select="/office:document/office:automatic-styles
                  /text:list-style[
                        @style:name = $list-style-name]
                        /text:list-level-style-number[@text:level = ($offset-list + 1)]
          /@style:num-format" />
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="string-length($numbering-format) > 0 and $offset-numbering-list > 0">
                <list type="ol" enum="{$numbering-format}" start="{$offset-numbering-list}">
                    <xsl:apply-templates />
                </list>
            </xsl:when>
            <xsl:when test="string-length($numbering-format) > 0">
                <list type="ol" enum="{$numbering-format}">
                    <xsl:apply-templates />
                </list>                
            </xsl:when>
            <xsl:otherwise>
                <list type="ul">
                    <xsl:apply-templates />
                </list>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- LI ELEMENT -->
    <xsl:template match="text:list-item">
        <li>
            <xsl:choose>
                <xsl:when test="name(child::*[1]) != 'text:list'">
                    <xsl:apply-templates  select="child::*" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="child::*" />
                </xsl:otherwise>
            </xsl:choose>
        </li>
    </xsl:template>


    <xsl:template name="find-offset-list">
       <xsl:param name="node" />
       <xsl:param name="acc" select="0" />
       <xsl:choose>
           <xsl:when test="name($node) = 'text:list' and $node[not(@text:style-name)]">
               <xsl:call-template name="find-offset-list">
                   <xsl:with-param name="node" select="$node/parent::*" />
                   <xsl:with-param name="acc" select="$acc+1" />
               </xsl:call-template>
           </xsl:when>
           <xsl:when test="name($node) = 'text:list'">
              <xsl:value-of select="$acc" />
           </xsl:when>
           <xsl:otherwise>
               <xsl:call-template name="find-offset-list">
                   <xsl:with-param name="node" select="$node/parent::*" />
                   <xsl:with-param name="acc" select="$acc" />
               </xsl:call-template>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

    <xsl:template name="find-list-style-name">
       <xsl:param name="node" />
       <xsl:choose>
           <xsl:when test="name($node) = 'text:list' and $node[not(@text:style-name)]">
               <xsl:call-template name="find-list-style-name">
                   <xsl:with-param name="node" select="$node/parent::*" />
               </xsl:call-template>
           </xsl:when>
           <xsl:when test="name($node) = 'text:list'">
              <xsl:value-of select="$node/@text:style-name" />
           </xsl:when>
           <xsl:otherwise>
               <xsl:call-template name="find-list-style-name">
                   <xsl:with-param name="node" select="$node/parent::*" />
               </xsl:call-template>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

        <xsl:template name="find-offset-numbering-list">
       <xsl:param name="node" />
       <xsl:param name="acc" select="0" />
       <xsl:choose>
           <xsl:when test="name($node) = 'text:list' and $node[@text:continue-numbering]">
               <xsl:call-template name="find-offset-numbering-list">
                   <xsl:with-param name="node" select="$node/preceding-sibling::text:list" />
                   <xsl:with-param name="acc" select="$acc+1" />
               </xsl:call-template>
           </xsl:when>
           <xsl:when test="name($node) = 'text:list' and $acc = 0">
              <xsl:value-of select="0" />
           </xsl:when>
           <xsl:when test="name($node) = 'text:list'">
              <xsl:value-of select="$acc+1" />
           </xsl:when>
           <xsl:otherwise>
               <xsl:call-template name="find-offset-numbering-list">
                   <xsl:with-param name="node" select="$node/preceding-sibling::text:list" />
                   <xsl:with-param name="acc" select="$acc" />
               </xsl:call-template>
           </xsl:otherwise>
       </xsl:choose>
    </xsl:template>

