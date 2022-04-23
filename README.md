# Édition numérique de la Première partie du roman en prose du Lancelot du lac (1301-14000) de Gauthier Map.

## Le projet
Cette édition a été réalisée à partir du manuscrit Français 16999 conservé à la Bibliothèque nationale de France.
Dans un premier temps, les feuillets 101r et 101v du manuscrit ont été transcrits et encodés en XML-TEI 
pour un devoir d'édition à visée paléographique dans le cadre du cours d'XML-TEI de Mme Ségolène Albouy à l'École nationale des chartes.
L'encodage a été réalisé en vue d'une édition critique moderne qui respecte la mise en forme du manuscrit et facilite la lecture des passages transcrits.
Dans un second temps, des corrections ont été apportées à l'encodage d'origine du fichier XML-TEI. 
Grâce à l'XSLT, le fichier XML-TEI corrigé, a été transformé en fichiers HTML. Ce sont les pages HMTL de l'édition numérique. Une feuille XSL spécifie les règles de transformation. 

## L'organisation du dépôt
Dans le dossier "correction_devoir_TEI", les fichiers de l'édition d'origine sont accompagnés des corrections de la professeur : 
- La transcription et l'encodage en XML-TEI sont dans le fichier "LC-edition-paleo.xml" ;
- La DTD, déclarant les entités qui ont permis d'encoder les caractères spéciaux et de proproser les normalisations graphiques, est dans le fichier "LC-DTD.dtd" ;
- L'ODD décrivant les choix de transcription et d'encodage est dans le fichier "LC-ODD.xml" ;
- Le schéma Relax NG définissant les règles de validation est dans le fichier "LC-ODD.rng" qui est dans le dossier "out".

Dans le dossier "devoir_XSLT", sont rangés les fichiers corrigés de l'édition d'origine :
- L'encodage en XML-TEI corrigé est dans le fichier "LC-edition-paleo-version2.xml" ;
- La DTD n'a pas été modifiée. Elle est dans le fichier "LC-DTD.dtd";
- L'ODD a été corrigée. Elle est dans le fichier "LC-ODD.xml" ;
- Le schema Relax NG est dans le fichier "LC-ODD.rng" qui est dans le dossier "out" ;
- La feuille transformation XSL est dans le fichier "feuille_transformation.xsl" ;
- Les pages HTML de l'édition numérique sont les fichiers finissant par ".html". 
