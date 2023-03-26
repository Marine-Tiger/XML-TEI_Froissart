<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>

    <!-- ### VARIABLES FICHIERS DE SORTIE ### -->

    <!-- variable pour le contenu du home  -->
    <xsl:variable name="home">
        <xsl:value-of select="concat('froisssart_home', '.html')"/>
    </xsl:variable>
    <!-- variable pour le contenu de la présentation des manuscrits témoins  -->
    <xsl:variable name="temoin">
        <xsl:value-of select="concat('froissart_temoin', '.html')"/>
    </xsl:variable>
    <!-- variable pour le contenu des principes d'encodage -->
    <xsl:variable name="principe">
        <xsl:value-of select="concat('froissart_principe', '.html')"/>
    </xsl:variable>
    <!-- variable pour le contenu du chapitre SHF-315  -->
    <xsl:variable name="shf315">
        <xsl:value-of select="concat('froissart_shf315', '.html')"/>
    </xsl:variable>
    <!-- variable pour le contenu du chapitre SHF-316  -->
    <xsl:variable name="shf316">
        <xsl:value-of select="concat('froissart_shf316', '.html')"/>
    </xsl:variable>
    <!-- variable pour le contenu de l'index -->
    <xsl:variable name="index">
        <xsl:value-of select="concat('froissart_index', '.html')"/>
    </xsl:variable>

    <!-- ##### VARIABLE HEADER HTML ##### -->
    <xsl:variable name="header">
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <link rel="icon" type="image" href="favicon.jpg"/>
            <link rel="stylesheet" href="style.css"/>
            <title> Les <xsl:value-of select="//titleStmt/title"/> Froissart </title>
            <img src="logo-ecole-nationale-des-chartes-bicentenaire.png" class="logo" alt="LOGO"/>
        </head>
    </xsl:variable>

    <!-- ##### VARIABLE BARRE DE NAVIGATION #####-->
    <xsl:variable name="navbar">
        <header>
            <nav>
                <a href="{$home}">Accueil</a>
                <div class="dropdown">
                    <button class="dropbtn">Projet</button>
                    <div class="dropdown-content">
                        <a href="{$temoin}">Manuscrits témoins</a>
                        <a href="{$principe}">Règles encodage</a>
                    </div>
                </div>
                <div class="dropdown">
                    <button class="dropbtn">Chapitres</button>
                    <div class="dropdown-content">
                        <a href="{$shf315}">SHF-315</a>
                        <a href="{$shf316}">SHF-316</a>
                    </div>
                </div>
                <a href="{$index}">Index</a>
            </nav>
        </header>
    </xsl:variable>
    

    <!-- ##### VARIABLE AVEC LE <FOOTER> #####-->
    <xsl:variable name="footer">
        <footer>
            <p><i><xsl:value-of select="//publicationStmt/p"/></i> @Marine Tiger, 2023</p>
        </footer>
    </xsl:variable>
    
    
    <!-- ##### TEMPLATES POUR LES NOTES #####-->
    
    <xsl:template match="//body/p//note">
        <a>
            <sup><xsl:number level="any" count="lem/note" format="1"/></sup>
        </a>
    </xsl:template>
    
    <xsl:template match="//body/p//note" mode="notes">
        <div class="footnote">
            <a>
                <sup>
                    <xsl:number level="any" count="lem/note" format="1"/>
                </sup>
            </a>
            <xsl:apply-templates mode="notes"/>
        </div>
    </xsl:template>
    
    <xsl:template match="//profileDesc//note" mode="notes">
        <div class="footnote">
            <a href="{./text()}">
                <sup>
                    <xsl:number level="any" count="profileDesc//note" format="1"/>
                </sup>
            </a>
            <xsl:apply-templates mode="notes"/>
        </div>
    </xsl:template>
    
    
    <!-- ##### MACTH DES TEMPLATES A LA RACINE ##### -->
    <xsl:template match="/">
        <xsl:call-template name="accueil"/>
        <xsl:call-template name="temoins"/>
        <xsl:call-template name="encodage"/>
        <xsl:call-template name="shf315"/>
        <xsl:call-template name="shf316"/>
        <xsl:call-template name="index"/>
    </xsl:template>

    <!-- ##### ACCUEIL #####-->
    <xsl:template name="accueil">
        <xsl:result-document href="{$home}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main>
                        <div class="titre">
                            <p>Edition critique des <i><xsl:value-of select=".//titleStmt/title"
                                    /></i> de <xsl:value-of select=".//titleStmt/author"/>
                            </p>
                        </div>
                        <div class="txt">
                            <p>Ce projet a pour but de proposer un encodage en XML-TEI de deux
                                extraits des <i>Chroniques</i> de Jehan Froissart, à partir de
                                l'édition numérique <a
                                    href="https://www.dhi.ac.uk/onlinefroissart/index.jsp">The
                                    Online Froissart</a>. L'apparat critique est composé de quatre
                                témoins encodés en <b>segmentation parrallèle</b>, ce qui permet de
                                faire apparaitre les témoins les uns à la suite des autres
                                directement dans le texte.<br/>
                                <br/>
                                <br/> Les <i>Chroniques</i> sont un récit en prose de plusieurs
                                évènement se déroulant durant la guerre de Cent Ans. Elles
                                commencent en 1322, et se terminent vers 1400. Le passage encodé est
                                tiré du livre I des Chroniques, et concerne deux chapitres. Ceux-ci
                                racontent comment, malgré la trêve de Malestroit signée le 19
                                janvier 1343 entre le roi de France Philippe VI et le roi
                                d'Angleterre Edouard III, plusieurs escarmouches et prises de villes
                                ont lieux entre les Anglais, Français et Ecossais, ce qui enrichient
                                certains brigants. </p>
                        </div>
                        <div class="img_accueil">
                            <img src="ms864.jpg"/>
                            <div class="legende"><i>Froissart remet son livre au Roi
                                    d'Angleterre</i>, miniature extraite du ms.864 conservé à la
                                bibliothèque municipale de Besançon</div>
                        </div>
                    </main>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


    <!-- ##### PAGE REGLES ENCODAGE ##### -->
    <xsl:template name="encodage">
        <xsl:result-document href="{$principe}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main>
                        <div class="titre">
                            <p>Règles d'encodage</p>
                        </div>
                        <div class="sstitre">
                            <p>Méthodologie d'encodage</p>
                        </div>
                        <div class="txt">
                            <p><xsl:value-of select=".//encodingDesc/editorialDecl"/> En effet, au
                                vu des dates très rapprochées et imprécises entre les quatre
                                témoins, il ne paraissait pas pertinent de choisir un témoin
                                prinicpal. De plus, le manuscrit de Besançon, qui paraît le plus
                                ancien, a plusieurs phrases manquantes comparé aux autres témoins.
                                <br/> La collation des témoins a été effectué grâce à <a
                                    href="https://collatex.net/">Collatex</a>. Ce logiciel permet de
                                produire un fichier XML dont les variances entre les témoins sont
                                faites mots par mots. Quelques difficultés de lecture peut
                                apparaître, notamment lorsqu'une phrase entière diffère d'un témoin
                                à l'autre. </p>
                        </div>
                        <div class="sstitre">
                            <p>Variations</p>
                        </div>
                        <div class="txt"> 
                            <p> Pour cet encodage, il a été décidé de notifier toutes les variations qui sont les suivantes:</p>
                        </div>
                        <ul class="variations">
                            <xsl:for-each select=".//encodingDesc//item">
                                <li><b><xsl:value-of select="./replace(@xml:id, '#', ' ')"/></b>: <xsl:apply-templates select="."/></li>
                                
                            </xsl:for-each>
                        </ul>
                    </main>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!--  ##### MANUSCRITS TEMOINS #####  -->
    <xsl:template name="temoins">
        <xsl:result-document href="{$temoin}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main>
                        <div class="titre">
                            <p>Manuscrits témoins</p>
                        </div>
                        <div id="grid">
                        <xsl:for-each  select=".//sourceDesc//witness[@xml:id]">
                            
                        
                        <div class="manuscrit"> 
                          
                                  <p id="nom">Manuscrit  
                                      <!-- pour s'adapter aux pronoms -->
                                      <xsl:choose>
                                          <xsl:when test="matches(.//settlement, 'A.+')">
                                              d'
                                          </xsl:when>
                                          <xsl:otherwise>de </xsl:otherwise>
                                      </xsl:choose>
                                      <xsl:apply-templates select=".//settlement"/>, <xsl:value-of select=".//country"/>
                                      (nommé "<b><xsl:value-of select="./replace(@xml:id, '#', ' ')"/></b>"  pour les variations)
                                  </p>
                                  
                                  <ul id="information">
                                      <li>Lieu de conservation: <xsl:value-of select=".//institution"/></li>
                                      <li>Cote: <xsl:value-of select=".//idno"/></li>
                                      <li>Département: <xsl:value-of select=".//repository"/></li>
                                      <li>Dates: <xsl:value-of select=".//origDate"/></li>
                                  </ul>
                                      <p id="description">Description physique</p>
                                      <ul>
                                          <li>Support: <xsl:value-of select=".//support"/>, <xsl:value-of select=".//extent/text()"/></li>
                                          <li>Dimensions: <xsl:value-of select=".//height"/> mm de longueur et <xsl:value-of select=".//width"/> mm de largeur</li>
                                          <xsl:if test=".//decoDesc | .//handDesc">
                                          <li>Informations supplémentaires: <xsl:value-of select=".//decoDesc | .//handDesc"/></li>
                                          </xsl:if>
                                      </ul>
                               
                           
                  
                        </div>
                        </xsl:for-each>
                        </div>  
                    </main>
                        
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
        
    </xsl:template>
    
    

    <!-- ##### PAGE SHF-315 ##### -->
    <xsl:template name="shf315">
        <xsl:result-document href="{$shf315}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main class="app_crit">
                        <div class="titre">
                            <p>Chapitre SHF 1-315</p>
                        </div>
                        <div class="app_titre">
                            <xsl:for-each select="TEI/text/body/p[@rend]">
                                <!--Seul moyen d'attraper à la fois le text et les app :
                             appeler l'ensemble des balises enfants du p ou le texte -->
                                <xsl:for-each select="./* | ./text()">
                                    
                                    <xsl:choose>
                                        <!--  Si c'est du texte, on le récupère   -->
                                        <xsl:when test="self::text()">
                                            <xsl:value-of select="self::text()"/>
                                        </xsl:when>
                                        
                                        <!--  en plus de récupérer le texte, il faut également récupérer les persName et placeName 
                                    qui ne sont pas dans un app -->
                                        <xsl:when test="local-name() = 'persName'">
                                            <xsl:apply-templates select="current()"/>
                                        </xsl:when>
                                        
                                        <xsl:when test="local-name() = 'placeName'">
                                            <xsl:apply-templates select="current()"/>
                                        </xsl:when>
                                        
                                        <xsl:when test=".">
                                            <xsl:call-template name="app"/>
                                        </xsl:when>
                                        
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:for-each>
                        </div>
                        <br/>
                            
                            <xsl:for-each select="TEI/text/body/p[@n='1-315']">
                                
                            <xsl:for-each select="./* | ./text()">

                                <xsl:choose>
                                    
                                    <xsl:when test="self::text()">
                                        <xsl:value-of select="self::text()"/>
                                    </xsl:when>
                                    
                                    <xsl:when test="local-name() = 'persName'">
                                            <xsl:apply-templates select="current()"/>
                                    </xsl:when>
                                    
                                    <xsl:when test="local-name() = 'placeName'">
                                        <xsl:apply-templates select="current()"/>
                                    </xsl:when>
                                    
                                    <xsl:when test=".">
                                        <xsl:call-template name="app"/>
                                    </xsl:when>
                                    
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:for-each>
                        <br/>
                        <div class="notes">
                            <xsl:apply-templates select=".//body/p[@n='1-315']//note" mode="notes"/>
                        </div>
                        <a  class="suivant" href="froissart_shf316.html">Chapitre suivant</a>
                    </main>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- ##### PAGE SHF-316 ##### -->
    <xsl:template name="shf316">
        <xsl:result-document href="{$shf316}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main class="app_crit">
                        <div class="titre">
                            <p>Chapitre SHF 1-316</p>
                        </div>
                            <br/>
                            <xsl:for-each select="TEI/text/body/p[@n='1-316']">
                                
                                <xsl:for-each select="./* | ./text()">
                                    
                                    <xsl:choose>
                                        
                                        <xsl:when test="self::text()">
                                            <xsl:value-of select="self::text()"/>
                                        </xsl:when>
                                        
                                        <xsl:when test="local-name() = 'persName'">
                                            <xsl:apply-templates select="current()"/>
                                        </xsl:when>
                                        
                                        <xsl:when test="local-name() = 'placeName'">
                                            <xsl:apply-templates select="current()"/>
                                        </xsl:when>
                                        
                                        <xsl:when test=".">
                                            <xsl:call-template name="app"/>
                                        </xsl:when>
                                        
                                    </xsl:choose>
                                </xsl:for-each>
                            </xsl:for-each>
                        <br/>
                        <div class="notes">
                            <xsl:apply-templates select=".//body/p[@n='1-316']//note" mode="notes"/>
                        </div>
                        <a class="precedent" href="froissart_shf315.html">Chapitre précédent</a>
                    </main>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    
    <!-- ##### INDEX ##### -->
    <xsl:template name="index">
        <xsl:result-document href="{$index}" method="html" indent="yes">
            <html lang="fr">
                <xsl:copy-of select="$header"/>
                <body>
                    <xsl:copy-of select="$navbar"/>
                    <main>
                        <div class="titre">
                            <p>Index</p>
                        </div>
                        <div class="index">
                            
                            <div class="nom_table">
                                <h2>Index des noms</h2>
                                <xsl:for-each select=".//person">
                                    <p class="pers_place">
                                        <!-- Pour normaliser les id -->
                                        <xsl:choose>
                                            <xsl:when test=".[@xml:id = 'J-ark']"> Seigneur d'Arkel </xsl:when>
                                            <xsl:when test=".[@xml:id = 'Roi-ec']"> Roi
                                                d'Ecosse</xsl:when>
                                            <xsl:when test=".[@xml:id = 'Roi-fr']"> Roi de
                                                France</xsl:when>
                                            <xsl:when test=".[@xml:id = 'Roi-eng']"> Roi
                                                d'Angleterre </xsl:when>
                                            <xsl:when test=".">
                                                <xsl:value-of select="./replace(@xml:id, '#', ' ')"
                                                />
                                            </xsl:when>
                                        </xsl:choose>
                                    </p>
                                    <hr/>
                                    <p class="intext">
                                        <xsl:for-each select="./persName">
                                            <xsl:choose>
                                                <xsl:when test=".">
                                                  <xsl:value-of select="."/>
                                                  <xsl:if test="position() != last()">, </xsl:if>
                                                </xsl:when>
                                            </xsl:choose>

                                        </xsl:for-each>
                                    </p>
                                    <div class="note_index">
                                        <xsl:if test="./note">
                                            <xsl:value-of select="./note"/>
                                        </xsl:if>
                                    </div>


                                </xsl:for-each>

                            </div>

                            
                            <div class="nom_table">
                                <h2>Index des lieux</h2>
                                <xsl:for-each select=".//place">
                                    <p class="pers_place">
                                        <!-- Pour normaliser les id -->
                                        <xsl:choose>
                                            <xsl:when test=".">
                                                <xsl:value-of select="./replace(@xml:id, '#', ' ')"
                                                />
                                            </xsl:when>
                                        </xsl:choose>
                                    </p>
                                    <hr/>

                                    <p class="intext">
                                        <xsl:for-each select="./placeName">
                                            <xsl:choose>
                                                <xsl:when test=".">
                                                  <xsl:value-of select="."/>
                                                  <xsl:if test="position() != last()">, </xsl:if>
                                                </xsl:when>
                                            </xsl:choose>

                                        </xsl:for-each>
                                    </p>
                                    <div class="note_index">
                                        <xsl:if test="./note">
                                            <xsl:value-of select="./note"/>
                                        </xsl:if>
                                    </div>


                                </xsl:for-each>

                            </div>

                        </div>
                    </main>
                    <xsl:copy-of select="$footer"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
   



<!-- ##### TEMPLATES VARIATIONS ####-->

   
    <!-- # APPARATS CRITIQUES <app> # -->
    <xsl:template match="//body//app" name="app">

        <!-- pour les <lem> -->
        <div class="app_dropdown">
            <xsl:choose>
                <xsl:when test="./lem">
                    <button class="app_dropbtn">
                        <xsl:for-each select="./lem">
                            <xsl:choose>
                                <!-- s'il y a une chaîne de caractères, on l'affiche -->
                                <xsl:when test="./matches(., '(\w+|,|\.)+')">
                                    <xsl:apply-templates select="."/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <p> </p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </button>
                    
                    <xsl:choose>
                        <!-- Quand le lem est suivi d'un rdg, afficher dans un dropdown l'ensemble de la balise et son contenu -->
                        <xsl:when test="./rdg">
                                <div class="app_dropdown-content">
                                    <xsl:call-template name="notinternal"/>
                                </div>
                        </xsl:when>
                        <!-- Quand le lem est suivi d'un rdgGrp, pour chaque rdgGrp, afficher les rdg dan un dropdown -->
                        <xsl:when test="./rdgGrp">
                            <xsl:for-each select="rdgGrp">
                                        <div class="app_dropdown-content">
                                            <xsl:call-template name="grp"/>
                                        </div>
                            </xsl:for-each>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                
                 <!--règles pour les lem contenant des app -->
                <xsl:when test="lem//app">
                    <xsl:for-each select="./lem">
                        <button class="app_dropbtn">
                            <xsl:choose>
                                <!-- s'il y a une chaîne de caractères, on l'affiche -->
                                <xsl:when test="./matches(., '(\w+|,|\.)+')">
                                    <xsl:apply-templates select="."/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <p> </p>
                                </xsl:otherwise>
                            </xsl:choose>
                        </button>
                    </xsl:for-each>

                    <xsl:choose>
                        <xsl:when test=".//rdg">
                            <div class="app_dropdown-content">
                                <xsl:call-template name="internal"/>
                            </div>
                        </xsl:when>

                        <xsl:when test=".//rdgGrp">
                            <div class="app_dropdown-content">
                                <xsl:call-template name="grp"/>
                            </div>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </div>
    </xsl:template>

   
    <!-- # <rdg> QUI NE SONT NI DANS UN <lem> IMBRIQUE NI DANS UN <rdgGrp> #-->
    <xsl:template match="body//app/rdg"
        name="notinternal">

        <!-- pour chaque <rdg> et chaque <rdg> contenant des balises <persName> et <placeName> -->
        <xsl:for-each select="rdg | rdg[.//placeName] | rdg[.//persName]">
               
                <xsl:choose>
                    <!-- s'il y a une chaîne de caractère on l'affiche -->
                    <xsl:when test="./matches(., '(\w+|,|\.)+')">
                            <xsl:value-of select="."/> 
                    </xsl:when>
                    <xsl:when test=".//persName | .//placeName">
                        <xsl:value-of select="rdg"/> 
                        <xsl:value-of select="persName | placeName"/>
                    </xsl:when>
                    <!-- si la variation est vide -->
                    <xsl:otherwise>∅</xsl:otherwise>
                </xsl:choose>
                
                <!-- permet d'afficher les id des témoins avec leurs variations -->
                <xsl:value-of select="./replace(@wit, '#', ' ')"/> 
                <xsl:choose>
                    <xsl:when test="position() != last()"> | </xsl:when>
                    <xsl:otherwise/>
                </xsl:choose>
                
            </xsl:for-each>
    </xsl:template>


    <!-- # <rdg> DANS UN <app> IMBRIQUE # -->
    <xsl:template match="body//app//rdg" name="internal">
        
        <xsl:for-each select="./rdg">
            
            <xsl:choose>
                <xsl:when test="./matches(., '(\w+|,|\.)+')">
                    <xsl:value-of select="."/> 
                </xsl:when>
                <xsl:when test=".//persName | .//placeName">
                    <xsl:value-of select="rdg"/> 
                    <xsl:value-of select="persName | placeName"/>
                </xsl:when>
                <xsl:otherwise>∅</xsl:otherwise>
            </xsl:choose>
            
            <xsl:value-of select="./replace(@wit, '#', ' ')"/> 
            <xsl:choose>
                <xsl:when test="position() != last()"> | </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each>
        
    </xsl:template>
    
   
    <!--  <rdgGrp> -->
    <xsl:template match="body//rdgGrp" name="grp">
        <xsl:for-each select="./rdg">
            
            <!-- si ils contiennent du texte ou un nom de personne/lieu, le recopier; sinon, symbole vide -->
            
            <xsl:choose>
                <xsl:when test="./matches(., '(\w+|,|\.)+')">
                    <xsl:value-of select="."/> 
                </xsl:when>
                <xsl:when test=".//persName | .//placeName">
                    <xsl:value-of select="rdg"/> 
                    <xsl:value-of select="persName | placeName"/>
                </xsl:when>
                <xsl:otherwise>∅</xsl:otherwise>
            </xsl:choose>
            
            <xsl:value-of select="./replace(@wit, '#', ' ')"/> 
            <xsl:choose>
                <xsl:when test="position() != last()"> | </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </xsl:for-each> 
    </xsl:template>
    
   
    

</xsl:stylesheet> 