CREATE TABLE IF NOT EXISTS `instagram` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(169) DEFAULT NULL,
  `shortcode` varchar(40) DEFAULT NULL,
  `instagram_id` varchar(29) DEFAULT NULL,
  `download` bit(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;