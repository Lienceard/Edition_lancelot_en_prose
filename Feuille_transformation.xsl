<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei"
    version="2.0">
    <!-- Attention une sortie HTML => exclusion du préfixe tei des résultats -->
    
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/> <!-- pour éviter les espaces non voulus -->
    <xsl:template match="/">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '')"/>
            <!-- récupération du nom et du chemin du fichier courant -->
        </xsl:variable>
        
        <!-- les variables pour les chemins des fichiers .html -->
        
        <xsl:variable name="pathAllo">
            <xsl:value-of select="concat($witfile,'allograph','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathNorm">
            <xsl:value-of select="concat($witfile,'norm','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathIndexLieux">
            <xsl:value-of select="concat($witfile,'indexLieux','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathIndexPers">
            <xsl:value-of select="concat($witfile,'indexPers','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile, 'accueil','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathnoticems">
            <xsl:value-of select="concat($witfile, 'noticems','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathchap">
            <xsl:value-of select="concat($witfile, 'chap','.html')"/>
        </xsl:variable>
        
        <xsl:variable name="titre_manuscrit">
            <xsl:value-of select="concat(.//head/title, ' ', '(',.//head/origDate, ')', ' de ', .//name[@xml:id='Gauthier_Map'] )"/>
        </xsl:variable>       
       
        <xsl:result-document href="{$pathAccueil}"
            method="html" indent="yes">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    <p><xsl:value-of select="concat('Cette édition en ligne a été réalisée à partir du manuscrit ', $ms_bnf, ' conservé à la ', .//institution, '. ')"/>
                    <xsl:value-of select="concat( 'Une feuille de transformation XSL a été rédigée à partir ', 'd une ', $responsable, ' ', $ms_bnf, ', réalisés par ', .//editionStmt/respStmt//forename, ' ', .//editionStmt/respStmt//surname, '. ')"/>
                    Les choix éditoriaux ont été les suivants. Le terme "Chapitre" a été privilégié à celui de "rubrique" pour distinguer les parties du manuscrit transcrites et encodées.
                    Les transcriptions ont été segmentées en paragraphes afin de faciliter la compréhension du texte.</p>
                    
                    <div type="sommaire">
                        <h2>Sommaire</h2>
                        <ul>
                            <li><a href="{$pathnoticems}"><xsl:value-of select="concat('Notice du manucrit ', $ms_bnf)"/></a></li>
                            <li><a href="{$pathchap}"><xsl:call-template name="titre_chapitre"/></a></li>
                            <li><a href="{$pathAllo}">La transcription allographétique</a></li>
                            <li><a href="{$pathNorm}">La transcription normalisée</a></li>
                            <li><a href="{$pathIndexPers}">L'index des noms de personnages</a></li>
                            <li><a href="{$pathIndexLieux}">L'index de lieux</a></li>
                        </ul>
                    </div>
                   
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="{$pathnoticems}"
            method="html" indent="yes">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                    
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:value-of select="concat('Notice du manucrit ', $ms_bnf)"/></h2>
                   
                    <h3>L'identification :</h3>
                    <dl>
                        <dt><b>Institution de conservation :</b></dt><dd><xsl:value-of select="concat(.//country, ' - ', .//institution, ' (', .//settlement, ') ', .//repository )"/></dd>
                        <dt><b>Cote :</b></dt><dd><xsl:value-of select=".//msIdentifier/idno"/></dd>
                        <dt><b>Ancienne cote :</b></dt><dd><xsl:value-of select=".//altIdentifier[1]/idno"/></dd>
                    </dl>
                    
                    <h3>L'histoire de la conservation du manuscrit :</h3>
                    <p><xsl:value-of select=".//origin | .//provenance/p"/></p>
                    
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
                        <dt><b>Disposition du text :</b></dt><dd><xsl:value-of select=".//layout"/></dd>
                        <dt><b>Décorations :</b></dt><dd><xsl:value-of select="concat(.//decoDesc/decoNote[1]/@type, ', ', .//decoDesc/decoNote[2]/@type, ' ornées')"/></dd>
                        <dd>Les décorations sont davantages détaillées dans la présentation de chaque chapitre/rubrique du manuscrit qui précède les transcriptions.</dd>
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
        
        <xsl:result-document href="{$pathchap}"
            method="html" indent="yes">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                    
                </head>
                <body>
                   
                   <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    
                    <div>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </div>
                    
                    <h2><xsl:call-template name="titre_chapitre"/></h2>
                                   
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
        
        <xsl:result-document href="{$pathNorm}"
            method="html" indent="yes">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
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
                    
                    <h2><xsl:call-template name="titre_chapitre"/></h2>
                    
                    
                    <h3>La transcription normalisée</h3>
                    
                        <div>
                            <xsl:apply-templates select=".//div[@type='chapitre']" mode="reg"/>
                        </div>
                     
                        
                    
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="{$pathAllo}"
            method="html" indent="yes">       
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
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
                    
                    <h2><xsl:call-template name="titre_chapitre"/></h2>
                    
                    <h3>La transcription facsimilaire</h3>
                    <div>
                        
                        <xsl:apply-templates select=".//div[@type='chapitre']" mode="orig"/>
                       
                    </div>
                </body>
            </html>
        </xsl:result-document>
        
        <xsl:result-document href="{$pathIndexLieux}"
            method="html" indent="yes">          
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
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
        
        
        <xsl:result-document href="{$pathIndexPers}"
            method="html" indent="yes">          
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select=".//titleStmt/title"/>
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="$titre_manuscrit"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index des lieux</h2>
                    <div>
                        <ul><xsl:call-template name="indexPers"/></ul>
                    </div>     
                </body>
            </html>
        </xsl:result-document>
        
        </xsl:template>
    
    <!-- page d'accueil -->
    
    <!-- variables pour la note de l'éditeur -->
    
    <xsl:variable name="ms_bnf">
        <xsl:value-of select="replace(.//msDesc/@*[local-name()='id'] , 'ms', '')"/>
    </xsl:variable>
    <xsl:variable name="responsable">
        <xsl:value-of select="replace(.//editionStmt/respStmt/resp, 'et', 'et d un')"/>
    </xsl:variable>
    
    <!-- notice du manuscrit -->
    
    <!--les décorations -->
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
    
    <!-- les transcriptions alliographétiques et normalisées -->
    
    <xsl:template name="titre_chapitre">
        <xsl:if test=".//text/body//div[@type='chapitre']">
            <xsl:value-of select="concat(upper-case(.//div/div/@type), ' ', .//div/div/@n, ' : ','La ', replace(replace(.//div/div/@subtype, '#', ''), '_', ' de '))"/>
        </xsl:if>
        
    </xsl:template>
    
    <!-- les paragraphes dans les transcriptions -->
    
    <xsl:template match="text/body//p" mode="#all">
        <xsl:element name="p">
            <xsl:attribute name="n">
                <xsl:number count="p" format="1" level="multiple"/>
            </xsl:attribute>
            <xsl:apply-templates mode="#current"/>
        </xsl:element>
    </xsl:template>
    
    
    
    <xsl:template match="choice" mode="orig">
        <xsl:value-of select=".//orig/text() |
            .//abbr/text()| .//sic/text()"/>
    </xsl:template>
    
    
    <xsl:template match="choice" mode="reg">
        <xsl:value-of select=".//reg/text() |
            .//expan//text() | .//ex/text() |.//corr/text()"/>
    </xsl:template>
    
    <!-- L'index des personnages -->
    
    <xsl:template name="indexPers">
        <xsl:for-each select=".//listPerson//persName">
            <li>
                <xsl:value-of select="."/>
                <xsl:variable name="idPerson">
                    <xsl:value-of select="parent::person/@xml:id"/>
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <xsl:for-each select="ancestor::TEI//body//persName[replace(@ref, '#','')=$idPerson]">
                    <xsl:apply-templates mode="reg"/>
                    <xsl:text> (§.</xsl:text>
                    <xsl:choose>
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
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <!-- L'index des lieux -->
    
    <xsl:template name="indexLieux">
        <xsl:for-each select=".//listPlace//placeName">
            <li>
                <xsl:value-of select="."/>
                <xsl:variable name="idPlace">
                    <xsl:value-of select="parent::place/@xml:id"/>
                </xsl:variable>
                <xsl:text> : </xsl:text>
                <xsl:for-each select="ancestor::TEI//body//placeName[replace(@ref, '#','')=$idPlace]">
                    <xsl:apply-templates mode="reg"/>
                    <xsl:text> (§.</xsl:text>
                    <xsl:choose>
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
            </li>
        </xsl:for-each>
    </xsl:template>

    
</xsl:stylesheet>
    
