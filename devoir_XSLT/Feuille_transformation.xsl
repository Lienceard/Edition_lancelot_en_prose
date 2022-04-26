<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    
    <!-- une sortie en HTML -->
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <!-- Gestion des espaces -->
    <xsl:strip-space elements="*"/> <!-- pour éviter les espaces non voulus -->
    <xsl:preserve-space elements="p said placeName persName orig reg"/> <!-- pour préserver les espaces contenus dans certains éléments  -->
    
    <xsl:template match="/">
        <!-- variable qui stock le chemin du fichier courant -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
            <!-- récupération du nom et du chemin du fichier courant -->
        </xsl:variable>
        
        <!-- les variables pour les chemins des fichiers .html -->
        <!-- variable pour la page d'accueil -->
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile, 'accueil','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de la notice du manuscrit -->
        <xsl:variable name="pathnoticems">
            <xsl:value-of select="concat($witfile, 'noticems','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de présentation du chapitre -->
        <xsl:variable name="pathchap">
            <xsl:value-of select="concat($witfile, 'chap','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de la transcrition facsimilaire -->
        <xsl:variable name="pathAllo">
            <xsl:value-of select="concat($witfile,'allograph','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de la transcrition normalisée -->
        <xsl:variable name="pathNorm">
            <xsl:value-of select="concat($witfile,'norm','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de l'index des personnages -->
        <xsl:variable name="pathIndexPers">
            <xsl:value-of select="concat($witfile,'indexPers','.html')"/>
        </xsl:variable>
        <!-- variable pour la page de l'index des lieux -->
        <xsl:variable name="pathIndexLieux">
            <xsl:value-of select="concat($witfile,'indexLieux','.html')"/>
        </xsl:variable>
        
        <!-- variable le titre du manuscrit  -->
        
        <xsl:variable name="titre_manuscrit">
            <xsl:value-of select="concat(.//head/title, ' ', '(',.//head/origDate, ')', ' de ', .//name[@xml:id='Gauthier_Map'] )"/>
        </xsl:variable>  
        
        <!-- variable pour le titre du chapitre -->
        
        <xsl:variable name="titre_chapitre">
            <xsl:value-of select="concat(upper-case(.//body/div/div/@type), ' ', .//div/div/@n, ' : ','La ', replace(replace(.//div/div/@subtype, '#', ''), '_', ' de '))"/>
        </xsl:variable>
        
        <!-- les variables pour la page d'accueil -->
        
        <xsl:variable name="ms_bnf">
            <xsl:value-of select="replace(.//msDesc/@*[local-name()='id'] , 'ms', '')"/>
        </xsl:variable>
        <xsl:variable name="responsable">
            <xsl:value-of select="replace(.//editionStmt/respStmt/resp, 'et', 'et d une')"/>
        </xsl:variable>   
          
        
        <!-- la page d'accueil -->
       
        <xsl:result-document href="{$pathAccueil}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    <p><xsl:value-of select="concat('Cette édition en ligne a été réalisée à partir du manuscrit ', 'Français ', $ms_bnf, ' conservé à la ', .//institution, '. ')"/>
                    <xsl:value-of select="concat( 'Une feuille de transformation XSL a été rédigée à partir ', 'd une ', $responsable, ' Français ', $ms_bnf, ', réalisés par ', .//editionStmt/respStmt//forename, ' ', .//editionStmt/respStmt//surname, '. ')"/>
                        Les choix de transcription et d'encodage sont expliqués plus en détails dans une <a href="https://github.com/Lienceard/Edition_lancelot_en_prose/blob/main/devoir_XSLT/LC-ODD.html">ODD</a>. Le terme "Chapitre" a été privilégié à celui de "rubrique" pour distinguer les parties du manuscrit transcrites et encodées.
                    Les transcriptions ont été segmentées en paragraphes afin de faciliter la compréhension du texte. </p>
                    
                    <div type="sommaire">
                        <h2>Sommaire</h2>
                        <ul>
                            <li><a href="{$pathnoticems}"><xsl:value-of select="concat('Notice du manucrit ', 'Français ', $ms_bnf)"/></a></li>
                            <li><a href="{$pathchap}"><xsl:value-of select="$titre_chapitre"/></a></li>
                            <li><a href="{$pathAllo}">La transcription allographétique</a></li>
                            <li><a href="{$pathNorm}">La transcription normalisée</a></li>
                            <li><a href="{$pathIndexPers}">L'index des personnages</a></li>
                            <li><a href="{$pathIndexLieux}">L'index des lieux</a></li>
                        </ul>
                    </div>
                   
                </body>
            </html>
        </xsl:result-document>
        
        <!-- la page de la notice du manuscrit -->
        
        <xsl:result-document href="{$pathnoticems}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:value-of select="concat('Notice du manucrit ', $ms_bnf)"/></h2>
                   
                    <h3>L'identification :</h3>
                    <dl>
                        <dt><b>Institution de conservation :</b></dt><dd><xsl:value-of select="concat(.//msIdentifier/country, ' - ', .//msIdentifier/institution, ' (', .//msIdentifier/settlement, ') ', ' - ', .//msIdentifier/repository )"/></dd>
                        <dt><b>Cote :</b></dt><dd><xsl:value-of select=".//msIdentifier/idno"/></dd>
                        <dt><b>Ancienne cote :</b></dt><dd><xsl:value-of select=".//altIdentifier[1]/idno"/></dd>
                    </dl>
                    
                    <h3>L'histoire de la conservation du manuscrit :</h3>
                    <p><xsl:value-of select=".//history/origin | .//history/provenance/p"/></p>
                    
                    <h3>Les mentions de responsabilité :</h3>
                    
                    <dl>
                        <dt><b>Auteur :</b></dt>
                        <dd><xsl:value-of select=".//msItem/respStmt[1]/name[1]"/></dd>
                        <dt><b>Enlumineur :</b></dt>
                        <dd><xsl:value-of select="concat(.//msItem/respStmt[2]/name, ' est un ', replace(.//msItem/respStmt[2]/note[1], 'Enlumineur', 'enlumineur'))"/></dd>
                    </dl>
                    
                    <h3>La description physique :</h3>
                        
                    <dl>
                        <dt><b>Langue :</b></dt><dd><xsl:value-of select=".//textLang"/></dd>
                        <dt><b>Support :</b></dt><dd><xsl:value-of select=".//support"/></dd>
                        <dt><b>Format :</b></dt><dd><xsl:value-of select="concat(.//width/@unit, ' x ', .//height/@unit)"/></dd>
                        <dt><b>Foliation :</b></dt><dd><xsl:value-of select=".//foliation"/></dd>
                        <dt><b>Disposition du text :</b></dt><dd><xsl:value-of select="concat('Le text est ', .//layout)"/>  Par conséquent, certains mots sont coupés. La coupure des mots a été rétablie (voire corrigée), et indiquée par des tirets "-" dans la transcription normalisée.</dd>
                        <dt><b>Décorations :</b></dt><dd><xsl:value-of select="concat(.//decoDesc/decoNote[1]/@type, ', ', .//decoDesc/decoNote[2]/@type, ' ornées')"/></dd>
                        <dd>Les décorations sont davantages détaillées dans la présentation de chaque chapitre du manuscrit qui précède les transcriptions.</dd>
                        <dt><b>Reliure :</b></dt><dd><xsl:value-of select=".//decoNote[@type='reliure'] |.//decoNote[@type='armoiries']"/></dd>
                        <dt><b>Etat de conservation :</b></dt><dd><xsl:value-of select=".//condition"/></dd>
                    </dl>
                    
                    <h3>La différentes parties :</h3>
                    
                    <dl>
                        <dt><xsl:value-of select="concat('(', .//msContents/msItem/locus/@from, ' à ', .//msContents/msItem/locus/@to, ') ', .//msContents/msItem/locus)"/></dt>
                        <dt><b>Incipit :</b></dt><dd><xsl:value-of select="concat(' ''', .//incipit, '''')"/></dd>
                        <dt><b>Explicit :</b></dt><dd><xsl:value-of select="concat(' ''', .//explicit, '''')"/></dd>
                    </dl>
                               
                </body> 
            </html>
        </xsl:result-document>
        
        <!-- la page de la présentation du chapitre -->
        
        <xsl:result-document href="{$pathchap}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    
                </head>
                <body>
                   
                   <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:value-of select="$titre_chapitre"/></h2>
                                   
                    <p><xsl:value-of select="concat('La rubrique : ', '''', .//rubric, '''')"/></p>
       
                    <p><xsl:value-of select="concat('La transcriptions allographétique et celle normalisée du chapitre démarrent au ', replace(.//msContents/msItem/msItem/locus, 'f.', 'folio'))"/></p>
                    
                    <p>Transcription des folios : <a href="{.//pb[@n='101r']/@facs}" ><xsl:value-of select=".//msContents/msItem/msItem/locus/@from"/></a>, <a href="{.//pb[@n='101v']/@facs}"><xsl:value-of select=".//msContents/msItem/msItem/locus/@to"/></a></p>
                                        
                    <h4>Les décorations :</h4>
                    
                    <div>
                       <xsl:apply-templates select=".//decoDesc"/>
                        
                    </div>
                    
                        
                               
                </body>
            </html>
        </xsl:result-document>
        
        <!-- la page de la transcription facsimilaire -->
        
        <xsl:result-document href="{$pathAllo}"
            method="html" indent="yes">       
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                    <script>
                        p {
                        margin-bottom: 2em; // on ajoute un espace après chaque paragraphe
                        }
                    </script>
                </head>
                <body>
                    
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:value-of select="$titre_chapitre"/></h2>
                    
                    <h3>La transcription facsimilaire</h3>
                    <div>
                        
                        <xsl:apply-templates select=".//div[@type='chapitre']" mode="orig"/>                  
                        
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <!-- la page de la transcription normalisée -->
        
        <xsl:result-document href="{$pathNorm}"
            method="html" indent="yes">
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                   <script>
                       p {
                       margin-bottom: 2em; // on ajoute un espace après chaque paragraphe
                       }
                   </script>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                       <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:value-of select="$titre_chapitre"/></h2>
                    
                    
                    <h3>La transcription normalisée</h3>
                    
                        <div>
                            <xsl:apply-templates select=".//div[@type='chapitre']" mode="reg"/>
                        </div>
                    
                </body>
            </html>
        </xsl:result-document>
        
        <!-- la page de l'index des personnages -->
        
        
        <xsl:result-document href="{$pathIndexPers}"
            method="html" indent="yes">          
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index des personnages</h2>
                    <div>
                        <ul><xsl:call-template name="indexPers"/></ul>
                    </div>
                    
                   
                </body>
            </html>
        </xsl:result-document>
        
        <!-- la page de l'index des lieux -->
        
        <xsl:result-document href="{$pathIndexLieux}"
            method="html" indent="yes">          
            <html>
                <head>
                    <xsl:call-template name="meta-header"/>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index des lieux</h2>
                    <div>
                        <ul><xsl:call-template name="indexLieux"/></ul>
                    </div>  
                    
                </body>
            </html>
        </xsl:result-document>
        
        </xsl:template>
    
    <!-- les métadonnées des pages html -->
    
    <xsl:template name="meta-header">
        <xsl:variable name="titre">
            <xsl:value-of select="//titleStmt/title"/>
        </xsl:variable>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta charset="UTF-8"/>
        <meta name="author" content="Lien Céard"/>
        <meta name="description"
            content="Édition numérique de la {$titre}"/>
        <meta name="keywords" content="XSLT,XML,TEI"/>
        <title>
            <xsl:value-of select="$titre"/>
        </title>
    </xsl:template>
    
    
    <!--les décorations pour la notice du chapitre -->
    <xsl:template match="decoDesc/decoNote/p">
        <xsl:copy>
                <xsl:choose>
                    <xsl:when test=".//list">
                        Mots clefs : 
                        <xsl:for-each select=".//item">
                            <xsl:value-of select="."/>
                            <xsl:choose>
                                <xsl:when test="position()!= last()">, </xsl:when>
                                <xsl:otherwise>.</xsl:otherwise>
                            </xsl:choose> 
                        </xsl:for-each> 
                    </xsl:when>
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                </xsl:choose> 
        </xsl:copy>
    </xsl:template>
    
    
    <!-- Créer les paragraphes dans les transcriptions -->
    
    <xsl:template match="text/body//p" mode="#all">
        <xsl:element name="p">
            <xsl:attribute name="n">
                <xsl:number count="p" format="1" level="multiple"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
<!-- Création des hyperliens renvoyant à l'index des personnages -->    
    
    <xsl:template match="text/body//p//persName" mode="#all">
        <!-- il faut stocker le chemin du fichier dans une variable pour pouvoir les utiliser -->
                <xsl:variable name="witfile">
                    <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
                </xsl:variable>
                <xsl:variable name="pathIndexPers">
                    <xsl:value-of select="concat($witfile,'indexPers','.html')"/>
                </xsl:variable>
        <!-- Lorqu'on rencontre un persName, on crée un hyperlien renvoyant vers l'index des personnages-->
                <xsl:element name="a">
                    <xsl:attribute name="href">
                        <xsl:value-of select="$pathIndexPers"/>
                    </xsl:attribute>
                    <xsl:apply-templates mode="#current"/>
                </xsl:element>
            </xsl:template>
    
    <!-- Création des hyperliens renvoyant à l'index des lieux -->    
    
    <xsl:template match="text/body//p//placeName" mode="#all">
        <!-- il faut stocker le chemin du fichier dans une variable pour pouvoir les utiliser -->
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
        </xsl:variable>
        <xsl:variable name="pathIndexLieux">
            <xsl:value-of select="concat($witfile,'indexLieux','.html')"/>
        </xsl:variable>
        <!-- Lorqu'on rencontre un placeName, on crée un hyperlien renvoyant vers l'index des lieux-->
        <xsl:element name="a">
            <xsl:attribute name="href">
                <xsl:value-of select="$pathIndexLieux"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
   
   <!-- Affichage de la transcription facsimilaire -->
    
    <xsl:template match="choice" mode="orig">
        <xsl:value-of select=".//orig/text() |
            .//abbr/text()| .//sic/text()"/>
    </xsl:template>
    
    <!-- Affichage de la transcription normalisée -->
    
    <xsl:template match="choice" mode="reg">
        <xsl:value-of select=".//reg/text() |
            .//expan//text() | .//ex/text() |.//corr/text()"/>
    </xsl:template>
    
    <!-- Création de l'index des personnages -->
    
    <xsl:template name="indexPers">
        <xsl:for-each select=".//listPerson//persName">
            <li>
                <i><xsl:value-of select="."/></i>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <xsl:value-of select="ancestor::person/note"/>
                <p>Occurrences rencontrées :
                <xsl:for-each select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]">
                    <xsl:apply-templates mode="reg"/>
                    <xsl:text> (§.</xsl:text>
                    <xsl:choose>
                        <!-- Gestion des "persName" contenus dans des "said"-->
                        <xsl:when test="ancestor::said">
                            <xsl:value-of select="count(ancestor::p/preceding-sibling::p) + 1"/>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="count(parent::p/preceding-sibling::p) + 1"/></xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>)</xsl:text>
                    <xsl:choose>
                        <xsl:when test="position()!= last()">, </xsl:when>
                        <xsl:otherwise>.</xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                    </p>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Création de l'index des lieux -->
    
    <xsl:template name="indexLieux">
        <xsl:for-each select=".//listPlace//placeName">
            <li>
                <i><xsl:value-of select="."/></i>
                <xsl:variable name="idPlace">
                    <xsl:value-of select="parent::place/@xml:id"/>
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <xsl:value-of select="ancestor::place/note"/>
                <p>Occurrences rencontrées :
                <xsl:for-each select="ancestor::TEI//body//placeName[replace(@ref, '#','')=$idPlace]">
                    <xsl:apply-templates mode="reg"/>
                    <xsl:text> (§.</xsl:text>
                    <xsl:choose>
                        <!-- Gestion des "placeName" contenus dans des "said"-->
                        <xsl:when test="ancestor::said">
                            <xsl:value-of select="count(ancestor::p/preceding-sibling::p) + 1"/>
                        </xsl:when>
                        <xsl:otherwise><xsl:value-of select="count(parent::p/preceding-sibling::p) + 1"/></xsl:otherwise>
                    </xsl:choose>
                   <xsl:text>)</xsl:text>
                    <xsl:choose>
                        <xsl:when test="position()!= last()">, </xsl:when>
                        <xsl:otherwise>.</xsl:otherwise>
                    </xsl:choose>
                    </xsl:for-each>
                    </p>
            </li>
        </xsl:for-each>
    </xsl:template>

    
</xsl:stylesheet>
    
