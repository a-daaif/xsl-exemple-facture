<xsl:stylesheet version="1.0" xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" indent="yes"/>
    <xsl:decimal-format decimal-separator="," grouping-separator=" " name="frm"/>
    <xsl:template match="/">
        <html>
            <head>

            </head>
            <body>
                <table border="1" cellspacing="6" cellpadding="6" width="100%">
                    <tr>
                        <th>N°</th>
                        <th>Designation</th>
                        <th>Prix</th>
                        <th>Quantité</th>
                        <th>Sous total</th>
                    </tr>
                    <xsl:for-each select="facture/produit">
                        <tr>
                            <td>
                                <xsl:value-of select="position()"/>
                            </td>
                            <td>
                                <xsl:value-of select="designation"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="format-number(prix, '# ##0,00','frm')"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="quantite"/>
                            </td>
                            <td align="right">
                                <xsl:value-of select="prix * quantite"/>
                            </td>
                        </tr>
                    </xsl:for-each>
                    <tr>
                        <td colspan="4" align="right">Total</td>
                        <td align="right">
                            <strong>
                                <xsl:call-template name="total">
                                    <xsl:with-param name="produits" select="facture/produit"/>
                                    <xsl:with-param name="initial" select="0"/>
                                </xsl:call-template>
                            </strong>
                        </td>
                    </tr>
                </table>
            </body>
        </html>

    </xsl:template>
    <xsl:template name="total">
        <xsl:param name="produits"/>
        <xsl:param name="initial"/>

        <xsl:variable name="produit" select="$produits[1]"></xsl:variable>
        <xsl:choose>
            <xsl:when test="count($produits) > 0">
                <xsl:call-template name="total">
                    <xsl:with-param name="produits" select="$produits[position() != 1]"/>
                    <xsl:with-param name="initial" select="$initial + ($produit/prix * $produit/quantite)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="format-number($initial, '# ##0,00', 'frm')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>