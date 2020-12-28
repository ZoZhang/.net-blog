## Blog MVC - ASP .Net
Un simple blog développe par l'ASP .Net

### Requis
* [x] SQL Server 2008
* [x] ASP .NET Framework 6

### Utilisation

#### Connexion de base de donée
*Téléchargement && Importè dans SQL Server:* https://github.com/ZoZhang/asp/blog/App_Data/blog-mvc.sql

*Changement:* `connectionStrings` dans le fichier `Web.config`

#### Test en ligne
*Utilisateur:* test@blog.fr / test
*Administrator:* admin@blog.fr / admin

[https://projet-blog-mvc.azurewebsites.net/](https://projet-blog-mvc.azurewebsites.net/)

### Fonctionnalités

#### Frontend
* [x] Authentification (Utilisateur)
* [x] Publication d'un article dans une catégorie choisi avec l'éditeur de texte WYSIWYG.
* [x] Ajout une catégorie et peut être un menu sur la navigation
* [x] Commentez un article 

#### Backend
* [x] Authentification (Administrator) 
* [x] Publication d'un article dans une catégorie choisi avec l'éditeur de texte WYSIWYG.
* [x] Ajout une catégorie et peut être un menu sur la navigation
* [x] Gérez touts les articles et les catégorie
* [x] Contrôle les commentaires affichés sur l'article

### Bibliothèque
* [x] [jQuery](https://jquery.com/) - bibliothèque JavaScript
* [x] [Layer](https://layer.layui.com/) - bibliothèque JavaScript
* [x] [Bootstrap](https://getbootstrap.com/) - CSS Framework
* [x] [Font Awesome](https://fontawesome.com/) - une police d'écriture et un outil d'icônes
* [x] [Simditor](https://github.com/mycolorway/simditor) - WYSIWYG text editor. 

### Démonstration

#### Page connexion (utilisateur && administrateur)
![Screenshot-20201227221822](https://i.imgur.com/tklPpNy.png)

#### Gestion d'article (utilisateur && administrateur)
![screenshot-localhost-44320-Article-1609104100466](https://i.imgur.com/hLuuBAX.png)

![screenshot-localhost-44320-Article-addArticle-1609104110873](https://i.imgur.com/LFTxyCQ.png)

#### Gestion catégorie (utilisateur && administrateur)
![screenshot-localhost-44320-Category-1609104039460](https://i.imgur.com/sTZrTmj.png)

#### Gestion utilisateur (administrateur unique)
![screenshot-localhost-44320-Admin-1609103995605](https://i.imgur.com/kxV1KwR.png)

#### Gestion commentaires (administrateur unique)
![screenshot-localhost-44320-Comments-1609103955912](https://i.imgur.com/jKhFVbR.png)

#### Page d'accueil
![screenshot-localhost-44320-1609103291254](https://i.imgur.com/jFCGSye.jpg)

#### Page d'article du détail
![Screenshot-20201227221710](https://i.imgur.com/22wgeho.png)

#### Page de catégorie
![Screenshot-20201227221747](https://i.imgur.com/BgwVApP.png)




