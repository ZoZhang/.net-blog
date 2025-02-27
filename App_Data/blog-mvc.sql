USE [master]
GO
/****** Object:  Database [Blog-MVC]    Script Date: 2020/12/27 22:52:07 ******/
CREATE DATABASE [Blog-MVC] 
GO
ALTER DATABASE [Blog-MVC] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Blog-MVC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Blog-MVC] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Blog-MVC] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Blog-MVC] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Blog-MVC] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Blog-MVC] SET ARITHABORT OFF 
GO
ALTER DATABASE [Blog-MVC] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Blog-MVC] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Blog-MVC] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Blog-MVC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Blog-MVC] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Blog-MVC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Blog-MVC] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Blog-MVC] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Blog-MVC] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Blog-MVC] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Blog-MVC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Blog-MVC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Blog-MVC] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Blog-MVC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Blog-MVC] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Blog-MVC] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Blog-MVC] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Blog-MVC] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Blog-MVC] SET  MULTI_USER 
GO
ALTER DATABASE [Blog-MVC] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Blog-MVC] SET DB_CHAINING OFF 
GO
USE [Blog-MVC]
GO
/****** Object:  Table [dbo].[article]    Script Date: 2020/12/27 22:52:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[article](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[content] [text] NOT NULL,
	[user_id] [int] NOT NULL,
	[category_id] [int] NOT NULL,
	[create_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 2020/12/27 22:52:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[is_menu] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[comments]    Script Date: 2020/12/27 22:52:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[comments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[article_id] [int] NOT NULL,
	[is_show] [bit] NOT NULL,
	[content] [text] NOT NULL,
	[create_at] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2020/12/27 22:52:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[password] [nvarchar](50) NOT NULL,
	[is_admin] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[article] ON 

INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (1, N'Quelques remarques et essais sur un Mac mini M1', N'<p style="text-align: justify;"><img src="https://www.journaldulapin.com/wp-content/uploads/2020/11/DXO_3403-850x643.jpg"><br></p><p style="text-align: justify;">J’ai un Mac mini M1 (que j’ai planté, d’ailleurs, j’en ai parlé ici) et donc j’ai effectué quelques tests sur la machine. Ne vous attendez pas à un test complet, je garde ?a pour Canard PC Hardware et les sites Mac l’ont fait avant moi. Par contre, j’ai essayé des trucs plus rares, testé des choses plus atypiques.<br><br>Malgré tout, parlons un peu de la machine. Il reprend la connectique du DTK et évidemment le format, mais est plus silencieux (le DTK était déjà pas mal discret) et extrêmement réactif. Pour tout dire, j’ai rarement eu une machine qui réagit de cette fa?on, si rapidement. C’est vraiment impressionnant, surtout sur une machine d’entrée de gamme dans l’absolu (c’est le modèle de base) qui consomme peu – 30 W en charge – et fait tout ?a en silence.</p><h1><br></h1>', 1, 1, CAST(N'2020-12-27T21:51:51.857' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (3, N'L''ENISA encourage à consolider la sécurité des dispositifs IoT', N'<p><img src="https://d1fmx1rbmqrxrr.cloudfront.net/zdnet/optim/i/edit/ne/2020/01/IoT__w630.jpg" alt="L''ENISA encourage à consolider la sécurité des dispositifs IoT"><br></p><p>La cha?ne d''approvisionnement autour de l''internet des objets est devenu le maillon faible de la cybersécurité, laissant potentiellement les organisations ouvertes aux cyberattaques via des vulnérabilités dont elles n''ont pas conscience. Mais un document récapitulatif récemment publié vise à garantir que la sécurité fasse partie du cycle de vie du développement des objets connectés.<br></p><p>Le&nbsp;<a href="https://www.enisa.europa.eu/publications/guidelines-for-securing-the-internet-of-things" target="_blank">rapport</a>&nbsp;de l''Agence européenne pour la cybersécurité (ENISA) présente des recommandations tout au long de la cha?ne d''approvisionnement de l''IoT pour aider les organisations à se protéger des vulnérabilités qui peuvent survenir lors de la construction d''objets connectés.</p><p>L''une des principales recommandations est que l''expertise en matière de cybersécurité soit davantage intégrée à tous les niveaux des organisations, y compris l''ingénierie, la gestion, le marketing et autres, afin que toute personne impliquée dans une partie quelconque de la cha?ne d''approvisionnement ait la possibilité d''identifier les risques potentiels – en espérant les repérer et les traiter à un stade précoce du cycle de développement du produit et en évitant qu''ils ne deviennent un problème majeur.</p><h2 style="margin-left: 0px;">Security by design</h2><p>Il est également recommandé d''adopter le principe de "Security by Design" à chaque étape du processus de développement de l''IoT, en mettant l''accent sur une planification et une gestion des risques minutieuse afin de garantir que tout problème de sécurité potentiel lié aux dispositifs est détecté à temps.</p><p>?&nbsp;Les premières décisions prises pendant la phase de conception ont généralement des répercussions sur les étapes ultérieures, en particulier lors de la maintenance&nbsp;?, indique le rapport</p>', 2, 2, CAST(N'2020-12-27T21:51:20.160' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (4, N'NordVPN propose un service grand public et un service pour les entreprises', N'<p><img src="https://d1fmx1rbmqrxrr.cloudfront.net/zdnet/optim/i/edit/ne/2020/01/Windows_5__w630.jpg" alt="NordVPN propose un service grand public et un service pour les entreprises"><br></p><p><a href="https://nordvpn.com/fr/special/?utm_medium=affiliate&amp;utm_term&amp;utm_content=zdnet_as-noel&amp;utm_campaign=off30&amp;utm_source=aff20765" target="_blank">NordVPN&nbsp;</a>reste en tête de notre liste 2020 des meilleurs VPN pour de nombreuses raisons, notamment son excellent rapport qualité-prix.</p><p>Le service possède plus de 5 500 serveurs dans 59 pays, ce qui fait le service VPN avec le meilleur ratio serveurs-pays. Forteresse chiffrée, en plus d''être rapide, son mode SmartPlay permet de faire avec facilité ce que tant d''autres VPN ont du mal à faire : du streaming vidéo.</p><p><img src="https://d1fmx1rbmqrxrr.cloudfront.net/zdnet/i/edit/ne/2020/01/nordvpn2.JPG"><br></p><p>L''interface de NordVPN est extrêmement simple à prendre en main, d''autant qu''elle est depuis la mi-2020 traduite en fran?ais.</p><p><a href="https://nordvpn.com/fr/special/?utm_medium=affiliate&amp;utm_term&amp;utm_content=zdnet_as-noel&amp;utm_campaign=off30&amp;utm_source=aff20765" target="_blank">NordVPN&nbsp;</a>n''impose aucun plafond de données et autorise l''utilisation de torrent et applications de peer-to-peer sans limite. Il fonctionne pour accéder à Netflix. On peut faire fonctionner six appareils simultanément sur un seul abonnement et le service reste compatible avec la plupart des usages pour des prix très intéressants.</p>', 2, 2, CAST(N'2020-12-27T21:50:55.147' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (5, N'iOS 14 : trois moyens garantis pour améliorer la durée de vie de la batterie', N'<p><img src="https://d1fmx1rbmqrxrr.cloudfront.net/zdnet/optim/i/edit/ne/2019/Pierre%20temp/Smartphone%20C__w630.jpg" alt="iOS 14 : trois moyens garantis pour améliorer la durée de vie de la batterie"><br></p><p><span style="color: rgb(37, 37, 37);">iOS 14 est sorti depuis six semaines, et a fait l''objet de quelques mises à jour, et les problèmes de batterie semblent toujours être en tête de liste des plaintes des utilisateurs de la dernière version du système d''exploitation mobile d''Apple. Le problème de décharge de la batterie est si grave qu''il est même visible sur les iPhones Pro Max avec les grosses batteries.</span></p><p><span style="color: rgb(37, 37, 37);">Le problème de la décharge de la batterie n''est pas vraiment un problème si vous avez accès à un chargeur ou à une banque d''alimentation (sauf pour l''usure à long terme de la batterie que le chargement excessif provoque), mais qu''en est-il des moments où vous êtes loin d''un chargeur ? Y a-t-il quelque chose que vous puissiez faire pour prolonger la précieuse durée de vie des batteries et la garder en-dehors de la zone rouge ? Affirmatif, répond la rédaction de ZDNet, qui vous livre un mode d''emploi pour vous tirer d''affaire facilement en cas de décharge de votre batterie.</span></p>', 2, 2, CAST(N'2020-12-27T21:42:25.120' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (6, N'Comment réconcilier l''éthique et les technologies', N'<p><img src="https://d1fmx1rbmqrxrr.cloudfront.net/zdnet/optim/i/edit/ne/2020/07/IA_Humain__w1200.jpg" alt="Comment réconcilier l''éthique et les technologies"><br></p><p>Le Forum économique mondial a publié un&nbsp;<a href="https://fr.weforum.org/whitepapers/ethics-by-design-an-organizational-approach-to-responsible-use-of-technology" target="_blank">nouveau rapport</a>&nbsp;détaillant la manière dont les organisations peuvent adopter une approche éthique pour concevoir la technologie et l''utiliser de manière responsable.</p><p>L''ouvrage,&nbsp;<i>Ethics by Design – An Organizational Approach to Responsible Use of Technology</i>, présente trois principes de conception qui peuvent être intégrés pour promouvoir un comportement éthique lorsqu''il s''agit de créer, de déployer et d''utiliser la technologie.</p><p>Ces principes consistent notamment à prêter attention en temps utile aux implications éthiques de la technologie en sensibilisant le public par la formation et les canaux de communication internes, à développer des "coups de pouce" organisationnels, comme des listes de contr?le, à utiliser des rappels de diligence raisonnable, et à intégrer la valeur et l''éthique dans la culture d''entreprise.</p>', 2, 2, CAST(N'2020-12-27T21:42:55.613' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (7, N'Sony : Un projet d''IA dédié à la... gastronomie', N'<p><img src="https://zdnet4.cbsistatic.com/hub/i/2020/12/16/98b4cc2f-ffaa-46eb-ae8f-f770e1094bc7/gastronomyui-for-pr.jpg" alt="Sony&nbsp;: Un projet d''IA dédié à la... gastronomie"><br></p><p><i>Interface graphique de l''application de création de recettes à l''aide de l''IA. Image&nbsp;: Sony AI.</i><br>Sony&nbsp;AI, la branche de recherche sur l''apprentissage machine et l''intelligence artificielle (IA) du conglomérat japonais, a lancé un nouveau projet consacré à la recherche et au développement en gastronomie.<br></p><p>Le projet se concentre sur trois domaines clés&nbsp;: une application d''IA pour la création de nouvelles recettes, une solution robotique pouvant aider les chefs en cuisine et une initiative de cocréation communautaire.</p><p>Sony&nbsp;AI explique qu''elle utilisera des sources de données – notamment des recettes et des données sur les ingrédients, comme le go?t, l''ar?me, la saveur, la structure moléculaire et les nutriments – pour développer l''application de création de recettes, dont elle espère qu''elle sera utilisée par les chefs lors de la conception des plats et des menus.<br></p>', 2, 1, CAST(N'2020-12-27T21:50:34.370' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (8, N'Nièvre : une voiture renverse trois personnes à la sortie de la messe', N'<p><img src="https://images.rtl.fr/~r/880v587/rtl/www/1371333-decize-dans-la-nievre.png" alt="Decize, dans la Nièvre"><br></p><p><span style="color: rgb(51, 51, 51);">Trois personnes ont été blessées ce dimanche 27 décembre à Decize, dans la Nièvre, par&nbsp;</span><span style="color: rgb(51, 51, 51);">une voiture qui a foncé dans une église</span><span style="color: rgb(51, 51, 51);">&nbsp;par accident, à la sortie de la messe. Deux des blessés n''ont été que légèrement atteints mais une troisième personne a été transférée à l''h?pital de Moulins avec une suspicion de commotion cérébrale.</span><br></p><p>L''incident a été provoqué par&nbsp;un conducteur agé de 84 ans, qui "a confondu les pédales de sa voiture et a accéléré au lieu d''appuyer sur le frein", a affirmé la gendarmerie. Mais&nbsp;les secours ont cru un temps à un attentat&nbsp;terroriste. "Des gens ont appelé pour dire qu''une voiture avait pénétré dans l''église et qu''il y avait des coups de feu"... En fait, le bruit des chaises écrasées par le véhicule.</p><p>"Heureusement", souligne-t-on à la gendarmerie, "que seule la moitié du portail était ouvert. La voiture a été ainsi contrainte à aller sur la gauche et à venir heurter un pilier, au lieu de remonter l''allée centrale". Le conducteur a été emmené à la brigade de gendarmerie où il a été entendu. Une enquête est en cours.</p>', 2, 1, CAST(N'2020-12-27T21:45:18.737' AS DateTime))
INSERT [dbo].[article] ([id], [title], [content], [user_id], [category_id], [create_at]) VALUES (9, N'Cyberpunk 2077, le naufrage du jeu vidéo le plus attendu de l’année', N'<p><img src="https://i.f1g.fr/media/eidos/704x396_cropupscale/2020/12/27/XVM2c667414-484b-11eb-925d-8c1667bae322.jpg"><br></p><p>Après huit ans de développement et trois reports, le jeu vidéo&nbsp;<i>Cyberpunk 2077</i>, sorti le 10&nbsp;décembre, se révèle à la limite de l’injouable sur PlayStation 4 et Xbox One.<span style="color: rgb(114, 114, 114);">&nbsp;Cyberpunk 2077</span><br></p><p>Ce devait être un triomphe. Le 10 décembre 2020 aurait d? être le jour de gloire du studio polonais CD Projekt. Après huit ans de développement et trois reports, son jeu vidéo&nbsp;Cyberpunk 2077&nbsp;sortait enfin sur PC et consoles. Auréolée du prestige de sa précédente production&nbsp;The Witcher 3, vendue à près de 30 millions d’exemplaires dans le monde, cette nouvelle création concentrait des attentes immenses: une gigantesque ville à explorer dans un futur dystopique, un scénario riche et complexe, des graphismes de toute beauté, une révolution dans la manière d’aborder les jeux de r?le.</p><p>Plus de 8 millions de personnes ont précommandé&nbsp;Cyberpunk 2077, parfois des mois à l’avance, sur la foi de ses promesses. Persuadés de tenir le plus grand succès commercial de l’année, les actionnaires ont fait gonfler la valeur boursière de CD Projekt en quelques mois. Non seulement la société s’est retrouvée au coude à coude avec&nbsp;<a href="https://www.lefigaro.fr/flash-eco/face-a-des-accusations-de-harcelement-ubisoft-remanie-sa-direction-20200712">le fran?ais Ubisoft</a>&nbsp;et ses 9 milliards d’euros de capitalisation, mais elle est devenue.</p>', 1, 1, CAST(N'2020-12-27T21:48:42.667' AS DateTime))
SET IDENTITY_INSERT [dbo].[article] OFF
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [title], [is_menu]) VALUES (1, N'Actualité', 1)
INSERT [dbo].[category] ([id], [title], [is_menu]) VALUES (2, N'Technique', 1)
INSERT [dbo].[category] ([id], [title], [is_menu]) VALUES (3, N'Test', 0)
SET IDENTITY_INSERT [dbo].[category] OFF
GO
SET IDENTITY_INSERT [dbo].[comments] ON 

INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (1, N'Manuko ', N'manuko@orange.fr', 1, 1, N'OK, merci pour l’info et bravo pour ton blog

', CAST(N'2020-12-27T11:22:14.427' AS DateTime))
INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (2, N'Pierre Dandumont ', N'pierredandumont@gmail.fr', 1, 1, N'Non, le partage c’est une mauvaise idée pour l’affichage.

', CAST(N'2020-12-27T20:58:27.810' AS DateTime))
INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (3, N'Bonobo', N'bonobo@wordpress.fr', 9, 1, N'Un grand merci pour ce test et votre professionnalisme

', CAST(N'2020-12-27T21:01:16.670' AS DateTime))
INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (4, N'Mcphilduc', N'philiduc@red.fr', 1, 0, N'C''est quoi ?a ?! c''est null partie', CAST(N'2020-12-27T21:05:57.520' AS DateTime))
INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (5, N'Phillippp', N'pillippp2@gmail.com', 7, 1, N'C''est cool~', CAST(N'2020-12-27T21:07:05.837' AS DateTime))
INSERT [dbo].[comments] ([id], [username], [email], [article_id], [is_show], [content], [create_at]) VALUES (6, N'Alan', N'alan@gmail.com', 6, 1, N'Génial pour votre blog!', CAST(N'2020-12-27T21:08:35.847' AS DateTime))
SET IDENTITY_INSERT [dbo].[comments] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([id], [email], [password], [is_admin]) VALUES (1, N'admin@blog.fr', N'admin', 1)
INSERT [dbo].[users] ([id], [email], [password], [is_admin]) VALUES (2, N'test@blog.fr', N'test', 0)
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Category_Title]    Script Date: 2020/12/27 22:52:07 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Category_Title] ON [dbo].[category]
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Users_Email]    Script Date: 2020/12/27 22:52:07 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Users_Email] ON [dbo].[users]
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[article]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[article]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[comments]  WITH CHECK ADD FOREIGN KEY([article_id])
REFERENCES [dbo].[article] ([id])
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Content' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'article', @level2type=N'COLUMN',@level2name=N'content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Creator' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'article', @level2type=N'COLUMN',@level2name=N'user_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Category ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'article', @level2type=N'COLUMN',@level2name=N'category_id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Create Date' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'article', @level2type=N'COLUMN',@level2name=N'create_at'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Article' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'article'
GO
USE [master]
GO
ALTER DATABASE [Blog-MVC] SET  READ_WRITE 
GO
