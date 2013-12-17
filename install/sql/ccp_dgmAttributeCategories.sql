
DROP TABLE IF EXISTS `ccp_dgmAttributeCategories`;
CREATE TABLE `ccp_dgmAttributeCategories` (
  `categoryID` tinyint(3) unsigned NOT NULL,
  `categoryName` varchar(100) DEFAULT NULL,
  `categoryDescription` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


LOCK TABLES `ccp_dgmAttributeCategories` WRITE;
INSERT INTO `ccp_dgmAttributeCategories` VALUES (1,'Fitting','Fitting capabilities of a ship'),(2,'Shield','Shield attributes of ships'),(3,'Armor','Armor attributes of ships'),(4,'Structure','Structure attributes of ships'),(5,'Capacitor','Capacitor attributes for ships'),(6,'Targeting','Targeting Attributes for ships'),(7,'Miscellaneous','Misc. attributes'),(8,'Required Skills','Skill requirements'),(9,'NULL','Attributes already checked and not going into a category'),(10,'Drones','All you need to know about drones'),(12,'AI','Attribs for the AI configuration');
UNLOCK TABLES;

