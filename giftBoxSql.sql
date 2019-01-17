-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Sam 10 Novembre 2018 à 12:03
-- Version du serveur :  5.7.24-0ubuntu0.18.04.1
-- Version de PHP :  7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `giftBox`
--

-- --------------------------------------------------------

--
-- Structure de la table `cagnotte`
--

CREATE TABLE `cagnotte` (
  `id` int(11) NOT NULL,
  `prix` float NOT NULL,
  `nom` varchar(30) NOT NULL,
  `prenom` varchar(30) NOT NULL,
  `message` varchar(50) NOT NULL,
  `id_cof` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `cagnotte`
--

INSERT INTO `cagnotte` (`id`, `prix`, `nom`, `prenom`, `message`, `id_cof`) VALUES
(4, 10, 'mouad', 'mounach', 'happy', 30),
(5, 100, 'mo', 'mo', 'moo', 30),
(6, 1000, 'mounach', 'mouad', 'hahahahahaha', 32);

-- --------------------------------------------------------

--
-- Structure de la table `categorie`
--

CREATE TABLE `categorie` (
  `id` int(11) NOT NULL,
  `nom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `categorie`
--

INSERT INTO `categorie` (`id`, `nom`) VALUES
(1, 'Attention'),
(2, 'Activité'),
(3, 'Restauration'),
(4, 'Hébergement');

-- --------------------------------------------------------

--
-- Structure de la table `coffret`
--

CREATE TABLE `coffret` (
  `id` int(11) NOT NULL,
  `nom` varchar(20) NOT NULL,
  `prix` float DEFAULT NULL,
  `etat` varchar(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `message` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `coffret`
--

INSERT INTO `coffret` (`id`, `nom`, `prix`, `etat`, `id_user`, `date`, `url`, `message`) VALUES
(4, 'coffret ayoub', 0, 'en cours', 4, NULL, NULL, NULL),
(5, 'my coff', 0, 'en cours', 4, NULL, NULL, NULL),
(6, 'hahahaha', 0, 'en cours', 4, NULL, NULL, NULL),
(12, 'cadeau', 0, 'en cours', 5, '2018-11-17', NULL, NULL),
(13, 'hahahaha', 0, 'en cours', 5, '2018-11-24', NULL, NULL),
(14, 'claque', 56, 'en cours', 5, '2018-11-26', NULL, NULL),
(30, 'mouad', 34, 'payer', 1, '2018-11-01', '5be6b1a6aff2b2.52779674', 'happy birthday'),
(31, 'lskjg', 40, 'payer', 1, '2018-11-08', '5be6b459d7cfb6.72838119', NULL),
(32, 'lkdsjg', 34, 'payer', 1, '2018-11-30', '5be6b5697f6256.48303217', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `coff_pres`
--

CREATE TABLE `coff_pres` (
  `id` int(11) NOT NULL,
  `id_prestation` int(11) NOT NULL,
  `id_coffret` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `coff_pres`
--

INSERT INTO `coff_pres` (`id`, `id_prestation`, `id_coffret`) VALUES
(6, 35, 14),
(7, 52, 14),
(8, 48, 14),
(43, 28, 30),
(44, 30, 30),
(45, 28, 31),
(46, 31, 31),
(47, 28, 32),
(48, 30, 32);

--
-- Déclencheurs `coff_pres`
--
DELIMITER $$
CREATE TRIGGER `prix` AFTER INSERT ON `coff_pres` FOR EACH ROW BEGIN
UPDATE coffret SET prix = (SELECT SUM(prix) FROM prestation INNER JOIN coff_pres ON prestation.id = coff_pres.id_prestation WHERE coff_pres.id_coffret = new.id_coffret) WHERE coffret.id = new.id_coffret;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `prix2` AFTER DELETE ON `coff_pres` FOR EACH ROW BEGIN
UPDATE coffret SET prix = (SELECT SUM(prix) FROM prestation INNER JOIN coff_pres ON prestation.id = coff_pres.id_prestation WHERE coff_pres.id_coffret = old.id_coffret)
WHERE coffret.id = old.id_coffret;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `prestation`
--

CREATE TABLE `prestation` (
  `id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `description` varchar(300) NOT NULL,
  `prix` float NOT NULL,
  `img` varchar(50) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `id_cat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `prestation`
--

INSERT INTO `prestation` (`id`, `nom`, `description`, `prix`, `img`, `status`, `id_cat`) VALUES
(28, 'Champagne', 'Bouteille de champagne + flutes + jeux à gratter', 20, 'champagne.jpg', 1, 1),
(29, 'Musique', 'Partitions de piano à 4 mains', 25, 'musique.jpg', 1, 1),
(30, 'Exposition', 'Visite guidée de l’exposition ‘REGARDER’ à la galerie Poirel', 14, 'poirelregarder.jpg', 1, 2),
(31, 'Goûter', 'Goûter au FIFNL', 20, 'gouter.jpg', 1, 3),
(32, 'Projection', 'Projection courts-métrages au FIFNL', 10, 'film.jpg', 1, 2),
(33, 'Bouquet', 'Bouquet de roses et Mots de Marion Renaud', 16, 'rose.jpg', 1, 1),
(34, 'Diner Stanislas', 'Diner à La Table du Bon Roi Stanislas (Apéritif /Entrée / Plat / Vin / Dessert / Café / Digestif)', 60, 'bonroi.jpg', 1, 3),
(35, 'Origami', 'Baguettes magiques en Origami en buvant un thé', 12, 'origami.jpg', 1, 3),
(36, 'Livres', 'Livre bricolage avec petits-enfants + Roman', 24, 'bricolage.jpg', 1, 1),
(37, 'Diner  Grand Rue ', 'Diner au Grand’Ru(e) (Apéritif / Entrée / Plat / Vin / Dessert / Café)', 59, 'grandrue.jpg', 1, 3),
(38, 'Visite guidée', 'Visite guidée personnalisée de Saint-Epvre jusqu’à Stanislas', 11, 'place.jpg', 1, 2),
(39, 'Bijoux', 'Bijoux de manteau + Sous-verre pochette de disque + Lait après-soleil', 29, 'bijoux.jpg', 1, 1),
(40, 'Opéra', 'Concert commenté à l’Opéra', 15, 'opera.jpg', 1, 2),
(41, 'Thé Hotel de la reine', 'Thé de debriefing au bar de l’Hotel de la reine', 5, 'hotelreine.gif', 1, 3),
(42, 'Jeu connaissance', 'Jeu pour faire connaissance', 6, 'connaissance.jpg', 1, 2),
(43, 'Diner', 'Diner (Apéritif / Plat / Vin / Dessert / Café)', 40, 'diner.jpg', 1, 3),
(44, 'Cadeaux individuels', 'Cadeaux individuels sur le thème de la soirée', 13, 'cadeaux.jpg', 1, 1),
(45, 'Animation', 'Activité animée par un intervenant extérieur', 9, 'animateur.jpg', 1, 2),
(46, 'Jeu contacts', 'Jeu pour échange de contacts', 5, 'contact.png', 1, 2),
(47, 'Cocktail', 'Cocktail de fin de soirée', 12, 'cocktail.jpg', 1, 3),
(48, 'Star Wars', 'Star Wars - Le Réveil de la Force. Séance cinéma 3D', 12, 'starwars.jpg', 1, 2),
(49, 'Concert', 'Un concert à Nancy', 17, 'concert.jpg', 1, 2),
(50, 'Appart Hotel', 'Appart’hôtel Coeur de Ville, en plein centre-ville', 56, 'apparthotel.jpg', 1, 4),
(51, 'Hôtel d\'Haussonville', 'Hôtel d\'Haussonville, au coeur de la Vieille ville à deux pas de la place Stanislas', 169, 'hotel_haussonville_logo.jpg', 1, 4),
(52, 'Boite de nuit', 'Discothèque, Boîte tendance avec des soirées à thème & DJ invités', 32, 'boitedenuit.jpg', 1, 2),
(53, 'Planètes Laser', 'Laser game : Gilet électronique et pistolet laser comme matériel, vous voilà équipé.', 15, 'laser.jpg', 1, 2),
(54, 'Fort Aventure', 'Découvrez Fort Aventure à Bainville-sur-Madon, un site Accropierre unique en Lorraine ! Des Parcours Acrobatiques pour petits et grands, Jeu Mission Aventure, Crypte de Crapahute, Tyrolienne, Saut à l\'élastique inversé, Toboggan géant... et bien plus encore.', 25, 'fort.jpg', 1, 2);

--
-- Déclencheurs `prestation`
--
DELIMITER $$
CREATE TRIGGER `supprimerCoff_pres` BEFORE DELETE ON `prestation` FOR EACH ROW BEGIN
delete from coff_pres where id_prestation = old.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `fullname` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(200) NOT NULL,
  `level` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `user`
--

INSERT INTO `user` (`id`, `fullname`, `username`, `password`, `level`) VALUES
(1, 'mouad mounach', 'mouad', '$2y$10$iw7V/h5cBR.TexeQgcnJdu2NTwhq.VPkvB9ncvMDZO/WIqYjoMFtW', 100),
(2, 'admin', 'admin', '$2y$10$Wh6Ao.tDGzoNRG9ZPGgpju/ivWrr.dTe6z94Vz0ck3on4D7tStpSy', 200),
(3, 'oktay', 'oktay', '$2y$10$JAMWAqF6TYL5bM7BjBwfEebXSEFJppLwGijRXTpt6Zt0qehS7P0vG', 100),
(4, 'ayoub', 'ayoub', '$2y$10$OGB67EpKBNGxuGxJYIMdfua/ebDfTe3O06s0/Mohu4Ca4HTJtWoU2', 100),
(5, 'mounach', 'mounach', '$2y$10$jxpjbyhlKlk7hBDi6.2hY.JfcVC7SQAZAWwa2WwBP065mlycatTo6', 100);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `cagnotte`
--
ALTER TABLE `cagnotte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cagnotte_coffret_FK` (`id_cof`);

--
-- Index pour la table `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `coffret`
--
ALTER TABLE `coffret`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coffret_user_FK` (`id_user`);

--
-- Index pour la table `coff_pres`
--
ALTER TABLE `coff_pres`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Concerner_coffret0_FK` (`id_coffret`),
  ADD KEY `Concerner_prestation_FK` (`id_prestation`);

--
-- Index pour la table `prestation`
--
ALTER TABLE `prestation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `prestation_categorie_FK` (`id_cat`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `cagnotte`
--
ALTER TABLE `cagnotte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `categorie`
--
ALTER TABLE `categorie`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `coffret`
--
ALTER TABLE `coffret`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT pour la table `coff_pres`
--
ALTER TABLE `coff_pres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT pour la table `prestation`
--
ALTER TABLE `prestation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;
--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `cagnotte`
--
ALTER TABLE `cagnotte`
  ADD CONSTRAINT `cagnotte_coffret_FK` FOREIGN KEY (`id_cof`) REFERENCES `coffret` (`id`);

--
-- Contraintes pour la table `coffret`
--
ALTER TABLE `coffret`
  ADD CONSTRAINT `coffret_user_FK` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `coff_pres`
--
ALTER TABLE `coff_pres`
  ADD CONSTRAINT `Concerner_coffret0_FK` FOREIGN KEY (`id_coffret`) REFERENCES `coffret` (`id`),
  ADD CONSTRAINT `Concerner_prestation_FK` FOREIGN KEY (`id_prestation`) REFERENCES `prestation` (`id`);

--
-- Contraintes pour la table `prestation`
--
ALTER TABLE `prestation`
  ADD CONSTRAINT `prestation_categorie_FK` FOREIGN KEY (`id_cat`) REFERENCES `categorie` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
