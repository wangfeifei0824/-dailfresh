-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: dailyfresh
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add 用户',6,'add_user'),(17,'Can change 用户',6,'change_user'),(18,'Can delete 用户',6,'delete_user'),(19,'Can add 地址',7,'add_address'),(20,'Can change 地址',7,'change_address'),(21,'Can delete 地址',7,'delete_address'),(22,'Can add 商品SPU',8,'add_goods'),(23,'Can change 商品SPU',8,'change_goods'),(24,'Can delete 商品SPU',8,'delete_goods'),(25,'Can add 商品图片',9,'add_goodsimage'),(26,'Can change 商品图片',9,'change_goodsimage'),(27,'Can delete 商品图片',9,'delete_goodsimage'),(28,'Can add 商品',10,'add_goodssku'),(29,'Can change 商品',10,'change_goodssku'),(30,'Can delete 商品',10,'delete_goodssku'),(31,'Can add goods type',11,'add_goodstype'),(32,'Can change goods type',11,'change_goodstype'),(33,'Can delete goods type',11,'delete_goodstype'),(34,'Can add 首页轮播商品',12,'add_indexgoodsbanner'),(35,'Can change 首页轮播商品',12,'change_indexgoodsbanner'),(36,'Can delete 首页轮播商品',12,'delete_indexgoodsbanner'),(37,'Can add 主页促销活动',13,'add_indexpromotionbanner'),(38,'Can change 主页促销活动',13,'change_indexpromotionbanner'),(39,'Can delete 主页促销活动',13,'delete_indexpromotionbanner'),(40,'Can add 主页分类展示商品',14,'add_indextypegoodsbanner'),(41,'Can change 主页分类展示商品',14,'change_indextypegoodsbanner'),(42,'Can delete 主页分类展示商品',14,'delete_indextypegoodsbanner'),(43,'Can add 订单商品',15,'add_ordergoods'),(44,'Can change 订单商品',15,'change_ordergoods'),(45,'Can delete 订单商品',15,'delete_ordergoods'),(46,'Can add 订单',16,'add_orderinfo'),(47,'Can change 订单',16,'change_orderinfo'),(48,'Can delete 订单',16,'delete_orderinfo');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_address`
--

DROP TABLE IF EXISTS `df_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `zip_code` varchar(6) DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_address_user_id_5e6a5c8a_fk_df_user_id` (`user_id`),
  CONSTRAINT `df_address_user_id_5e6a5c8a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_address`
--

LOCK TABLES `df_address` WRITE;
/*!40000 ALTER TABLE `df_address` DISABLE KEYS */;
INSERT INTO `df_address` VALUES (1,'2019-01-07 06:42:09.607550','2019-01-07 06:42:09.607550',0,'飞飞','深圳市','','13821909697',1,17),(2,'2019-01-08 10:51:35.534746','2019-01-08 10:51:35.534746',0,'飞飞','深圳市','000','13821909697',1,1);
/*!40000 ALTER TABLE `df_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods`
--

DROP TABLE IF EXISTS `df_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `detail` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods`
--

LOCK TABLES `df_goods` WRITE;
/*!40000 ALTER TABLE `df_goods` DISABLE KEYS */;
INSERT INTO `df_goods` VALUES (1,'2019-01-08 04:53:26.471766','2019-01-08 04:53:26.471766',0,'草莓','<p><span style=\"color: #666666; font-family: \'Microsoft Yahei\'; font-size: 12px;\">草莓采摘园位于北京大兴区 庞各庄镇四各庄村 ，每年1月-6月面向北京以及周围城市提供新鲜草莓采摘和精品礼盒装草莓，草莓品种多样丰富，个大香甜。所有草莓均严格按照有机标准培育，不使用任何化肥和农药。草莓在采摘期间免洗可以直接食用。欢迎喜欢草莓的市民前来采摘，也欢迎各大单位选购精品有机草莓礼盒，有机草莓礼盒是亲朋馈赠、福利送礼的最佳选择。</span></p>'),(2,'2019-01-08 05:12:37.236999','2019-01-08 05:12:37.236999',0,'大虾','<p><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">大虾是产于水中可食用的一种动物。虾是</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E7%94%B2%E5%A3%B3%E7%BA%B2/1060304\" target=\"_blank\" data-lemmaid=\"1060304\">甲壳纲</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">动物，与蟹和龙虾相关。在中间有扁而有弹性的半透明的身体，并且有像扇子般的尾巴。大虾也是网络用语，指那些善用网络，具有一定网络技术的人，是&ldquo;大侠&rdquo;的谐音，很好吃。</span></p>'),(3,'2019-01-08 05:15:46.012847','2019-01-08 05:15:46.012847',0,'羊肉','<p><span style=\"color: #666666; font-family: \'Microsoft Yahei\'; font-size: 12px;\">恒都内蒙古乌兰浩特黑头羊 羔羊排 1000g/袋商品编号：3332179商品毛重：1.22kg商品产地：中国大陆保存状态：冷冻品种：其它重量：1kg以上饲养方式：散养国产/进口：国产包装：简装原产地：中国（内蒙古）烹饪建议：炒菜，烧烤</span></p>'),(4,'2019-01-08 05:16:48.244143','2019-01-08 05:16:48.245143',0,'鸡蛋','<p><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">鸡蛋又名鸡卵、鸡子，是</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E6%AF%8D%E9%B8%A1/9722995\" target=\"_blank\" data-lemmaid=\"9722995\">母鸡</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">所产的卵。其外有一层硬壳，内则有</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E6%B0%94%E5%AE%A4\" target=\"_blank\">气室</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%8D%B5%E7%99%BD\" target=\"_blank\">卵白</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">及</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%8D%B5%E9%BB%84/1293739\" target=\"_blank\" data-lemmaid=\"1293739\">卵黄</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">部分。富含</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E8%83%86%E5%9B%BA%E9%86%87/471445\" target=\"_blank\" data-lemmaid=\"471445\">胆固醇</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">，营养丰富，一个鸡蛋重约50克，含蛋白质6-7克，脂肪5-6克。鸡蛋</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E8%9B%8B%E7%99%BD%E8%B4%A8/309120\" target=\"_blank\" data-lemmaid=\"309120\">蛋白质</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">的</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E6%B0%A8%E5%9F%BA%E9%85%B8/303574\" target=\"_blank\" data-lemmaid=\"303574\">氨基酸</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">比例很适合人体生理需要、易为</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E6%9C%BA%E4%BD%93/5903144\" target=\"_blank\" data-lemmaid=\"5903144\">机体</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">吸收，利用率高达98%以上，营养价值很高，是人类常食用的</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E9%A3%9F%E7%89%A9/85041\" target=\"_blank\" data-lemmaid=\"85041\">食物</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">之一。</span></p>'),(5,'2019-01-08 05:19:30.486922','2019-01-08 05:19:30.486922',0,'泡菜','<p><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">泡菜古称葅，是指为了利于长时间存放而经过发酵的蔬菜。一般来说，只要是</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E7%BA%A4%E7%BB%B4/3242959\" target=\"_blank\" data-lemmaid=\"3242959\">纤维</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">丰富的蔬菜或水果，都可以被制成泡菜；像是</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%8D%B7%E5%BF%83%E8%8F%9C/2073007\" target=\"_blank\" data-lemmaid=\"2073007\">卷心菜</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、大白菜、</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E7%BA%A2%E8%90%9D%E5%8D%9C/1739137\" target=\"_blank\" data-lemmaid=\"1739137\">红萝卜</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、白萝卜、</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%A4%A7%E8%92%9C/159179\" target=\"_blank\" data-lemmaid=\"159179\">大蒜</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、青葱、小黄瓜、洋葱、高丽菜等。蔬菜在经过腌渍及调味之后，有种特殊的风味，很多人会当作是一种常见的</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E9%85%8D%E8%8F%9C/5546266\" target=\"_blank\" data-lemmaid=\"5546266\">配菜</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">食用。所以现代人在食材取得无虞的生活环境中，还是会制做泡菜。</span></p>'),(6,'2019-01-08 05:20:33.609537','2019-01-08 05:20:33.609537',0,'蛋糕','<p><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">蛋糕是一种古老的</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E8%A5%BF%E7%82%B9/7481859\" target=\"_blank\" data-lemmaid=\"7481859\">西点</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">，一般是由烤箱制作的，蛋糕是用</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E9%B8%A1%E8%9B%8B/6405\" target=\"_blank\" data-lemmaid=\"6405\">鸡蛋</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、白糖、</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%B0%8F%E9%BA%A6%E7%B2%89/10274079\" target=\"_blank\" data-lemmaid=\"10274079\">小麦粉</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">为主要原料。以</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E7%89%9B%E5%A5%B6/28828\" target=\"_blank\" data-lemmaid=\"28828\">牛奶</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、果汁、</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E5%A5%B6%E7%B2%89/409704\" target=\"_blank\" data-lemmaid=\"409704\">奶粉</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、香粉、色拉油、水，</span><a style=\"color: #136ec2; text-decoration-line: none; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\" href=\"https://baike.baidu.com/item/%E8%B5%B7%E9%85%A5%E6%B2%B9/8737310\" target=\"_blank\" data-lemmaid=\"8737310\">起酥油</a><span style=\"color: #333333; font-family: arial, 宋体, sans-serif; font-size: 14px; text-indent: 28px;\">、泡打粉为辅料。经过搅拌、调制、烘烤后制成一种像海绵的点心。狠狠好吃</span></p>'),(7,'2019-01-09 12:08:55.002722','2019-01-09 12:08:55.002722',0,'火龙果','<p><span style=\"font-size: 10px;\">品牌： 京东生鲜</span></p>\r\n<p><span style=\"font-size: 10px;\">商品名称：京东生鲜越南进口 红心火龙果3个装 单果约500g商品编号：3048509商品毛重：1.94kg商品产地：越南重量：1kg-2kg国产/进口：进口分类：红心火龙果包装：简装原产地：越南</span></p>'),(8,'2019-01-09 12:09:34.072615','2019-01-09 12:09:34.072615',0,'香蕉','<p><span style=\"font-size: 10px;\">品牌： 维叶（Weiye）</span></p>\r\n<p><span style=\"font-size: 10px;\">商品名称：维叶新鲜水果香蕉约17-23条天宝水果生鲜青蕉 香蕉17-23条商品编号：25148496689店铺： 维叶新鲜蔬果旗舰店商品毛重：750.0kg货号：香蕉17-23条国产/进口：国产</span></p>');
/*!40000 ALTER TABLE `df_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_image`
--

DROP TABLE IF EXISTS `df_goods_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_goods_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_goods_image_sku_id_f8dc96ea_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_image`
--

LOCK TABLES `df_goods_image` WRITE;
/*!40000 ALTER TABLE `df_goods_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_goods_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_sku`
--

DROP TABLE IF EXISTS `df_goods_sku`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unite` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_sku_goods_id_31622280_fk_df_goods_id` (`goods_id`),
  KEY `df_goods_sku_type_id_576de3b4_fk_goods_goodstype_id` (`type_id`),
  CONSTRAINT `df_goods_sku_goods_id_31622280_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`),
  CONSTRAINT `df_goods_sku_type_id_576de3b4_fk_goods_goodstype_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_sku`
--

LOCK TABLES `df_goods_sku` WRITE;
/*!40000 ALTER TABLE `df_goods_sku` DISABLE KEYS */;
INSERT INTO `df_goods_sku` VALUES (1,'2019-01-08 05:02:04.579959','2019-01-08 05:02:04.579959',0,'大兴大鹏草莓','草莓浆果柔软多汁，味美爽口，适合速冻保鲜贮藏。草莓速冻后，可以保持原有的色、香、味，既便于贮藏，又便于外销。',16.80,'500g','goodssku/goods003.jpg',1,0,1,1,2),(2,'2019-01-08 05:23:02.655427','2019-01-08 05:23:02.655427',0,'青岛野生大虾','纯正野生大虾，你的不二选择',47.99,'500g','goodssku/goods018.jpg',1,0,1,2,3),(3,'2019-01-08 05:25:05.020074','2019-01-08 05:25:05.020074',0,'羔羊排 烧烤食材','纯正羔羊，自然放牧，味道鲜美',59.00,'盘','goodssku/57a9a823N2c38934e.jpg',1,0,1,3,4),(4,'2019-01-08 05:27:47.586426','2019-01-08 05:27:47.586426',0,'大哥 散养鸡蛋','散养鸡蛋，味道鲜美，值得一品',108.99,'蓝','goodssku/5927942eN14545b4d.jpg',1,0,1,4,5),(5,'2019-01-08 05:29:02.322368','2019-01-08 05:29:02.322368',0,'韩国风味泡菜','韩国菜，味道就是一般般',17.50,'盘','goodssku/57a9a823N2c38934e_7UZJDOO.jpg',1,0,1,5,6),(6,'2019-01-08 05:30:06.985505','2019-01-08 05:30:06.985505',0,'奶油水果蛋糕','鲜奶蛋糕，美味十足',150.00,'个','goodssku/59eaf320N10e96d9e.jpg',1,0,1,6,7),(7,'2019-01-09 12:12:14.989395','2019-01-09 12:12:14.989395',0,'天宝香蕉','贝贝小南瓜2.5kg 甜粉糯 可做宝宝辅食~',30.00,'750g','goodssku/5b514c51N8170488f.jpg',1,1,1,7,2),(8,'2019-01-09 12:13:33.246282','2019-01-09 12:13:33.246282',0,'越南进口火龙果','越南直采 精选大果】果肉更足，享受饱满的甜蜜诱惑！红果富含花青素，天然抗氧化营养库！泰国金枕榴莲火爆促销中，点我直达，萨瓦迪卡。',33.00,'个','goodssku/57ab290aN34f76b37.jpg',1,3,1,7,2);
/*!40000 ALTER TABLE `df_goods_sku` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_goods_type`
--

DROP TABLE IF EXISTS `df_goods_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `logo` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_goods_type`
--

LOCK TABLES `df_goods_type` WRITE;
/*!40000 ALTER TABLE `df_goods_type` DISABLE KEYS */;
INSERT INTO `df_goods_type` VALUES (2,'2019-01-07 12:01:56.643392','2019-01-07 12:01:56.643392',0,'新鲜水果','fruit','goodstype/banner01.jpg'),(3,'2019-01-07 12:03:27.120427','2019-01-07 12:03:27.120427',0,'海鲜水产','seafood','goodstype/banner02.jpg'),(4,'2019-01-07 12:04:22.396208','2019-01-07 12:04:22.396208',0,'猪牛羊肉','meet','goodstype/banner03.jpg'),(5,'2019-01-07 12:04:52.804922','2019-01-07 12:04:52.804922',0,'禽类蛋品','egg','goodstype/banner04.jpg'),(6,'2019-01-07 12:05:57.963461','2019-01-07 12:05:57.963461',0,'新鲜蔬菜','vegetables','goodstype/banner05.jpg'),(7,'2019-01-07 12:06:24.335892','2019-01-07 12:06:24.335892',0,'速冻食品','ice','goodstype/banner06.jpg');
/*!40000 ALTER TABLE `df_goods_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_banner`
--

DROP TABLE IF EXISTS `df_index_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_index_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_index_banner_sku_id_57f2798e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_banner`
--

LOCK TABLES `df_index_banner` WRITE;
/*!40000 ALTER TABLE `df_index_banner` DISABLE KEYS */;
INSERT INTO `df_index_banner` VALUES (1,'2019-01-08 05:38:04.919069','2019-01-08 05:38:04.919069',0,'indexgoodsbanner/slide02.jpg',1,1),(2,'2019-01-08 05:38:22.251039','2019-01-08 05:38:22.251039',0,'indexgoodsbanner/slide04.jpg',2,2),(3,'2019-01-08 05:38:39.046930','2019-01-08 05:38:39.046930',0,'indexgoodsbanner/slide03.jpg',3,3),(4,'2019-01-08 05:39:06.557097','2019-01-08 05:39:06.557097',0,'indexgoodsbanner/slide02_dz6rAL5.jpg',4,6);
/*!40000 ALTER TABLE `df_index_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_promotion`
--

DROP TABLE IF EXISTS `df_index_promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_index_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(256) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_promotion`
--

LOCK TABLES `df_index_promotion` WRITE;
/*!40000 ALTER TABLE `df_index_promotion` DISABLE KEYS */;
INSERT INTO `df_index_promotion` VALUES (1,'2019-01-08 05:51:05.280135','2019-01-08 05:51:05.280135',0,'吃货暑价趴','#','indexpromotionbanner/adv01.jpg',1),(2,'2019-01-08 05:51:49.019142','2019-01-08 05:51:49.019142',0,'零食保健0元抢','#','indexpromotionbanner/adv02.jpg',2);
/*!40000 ALTER TABLE `df_index_promotion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_index_type_goods`
--

DROP TABLE IF EXISTS `df_index_type_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_index_type_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` (`sku_id`),
  KEY `df_index_type_goods_type_id_35192ffd_fk_goods_goodstype_id` (`type_id`),
  CONSTRAINT `df_index_type_goods_sku_id_0a8a17db_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`),
  CONSTRAINT `df_index_type_goods_type_id_35192ffd_fk_goods_goodstype_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_index_type_goods`
--

LOCK TABLES `df_index_type_goods` WRITE;
/*!40000 ALTER TABLE `df_index_type_goods` DISABLE KEYS */;
INSERT INTO `df_index_type_goods` VALUES (1,'2019-01-08 05:08:48.242761','2019-01-08 05:08:48.242761',0,1,1,1,2),(2,'2019-01-08 05:34:23.603260','2019-01-08 05:34:23.603260',0,1,1,2,3),(3,'2019-01-08 05:34:47.119244','2019-01-08 05:34:47.120245',0,1,1,3,4),(4,'2019-01-08 05:34:57.630109','2019-01-08 05:34:57.630109',0,1,1,4,5),(5,'2019-01-08 05:35:08.741970','2019-01-08 05:35:08.741970',0,1,1,5,6),(6,'2019-01-08 05:35:18.779512','2019-01-08 05:35:18.779512',0,1,1,6,7),(7,'2019-01-09 12:18:23.293302','2019-01-09 12:18:23.293302',0,1,2,8,2),(8,'2019-01-09 12:18:42.690657','2019-01-09 12:18:42.690657',0,0,1,7,2);
/*!40000 ALTER TABLE `df_index_type_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_order_goods`
--

DROP TABLE IF EXISTS `df_order_goods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` varchar(256) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` (`order_id`),
  KEY `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` (`sku_id`),
  CONSTRAINT `df_order_goods_order_id_6958ee23_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`),
  CONSTRAINT `df_order_goods_sku_id_b7d6e04e_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_order_goods`
--

LOCK TABLES `df_order_goods` WRITE;
/*!40000 ALTER TABLE `df_order_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_order_goods` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_order_info`
--

DROP TABLE IF EXISTS `df_order_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_order_info` (
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `transit_price` decimal(10,2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `df_order_info_addr_id_70c3726e_fk_df_address_id` (`addr_id`),
  KEY `df_order_info_user_id_ac1e5bf5_fk_df_user_id` (`user_id`),
  CONSTRAINT `df_order_info_addr_id_70c3726e_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`),
  CONSTRAINT `df_order_info_user_id_ac1e5bf5_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_order_info`
--

LOCK TABLES `df_order_info` WRITE;
/*!40000 ALTER TABLE `df_order_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_order_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_user`
--

DROP TABLE IF EXISTS `df_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_user`
--

LOCK TABLES `df_user` WRITE;
/*!40000 ALTER TABLE `df_user` DISABLE KEYS */;
INSERT INTO `df_user` VALUES (1,'pbkdf2_sha256$36000$Vmez4nt9D8Lq$MiYzZe7Qwk6zx6d7k3A9ddRHDB4c5+RWSTRAAVyAmi0=','2019-01-09 00:50:38.163069',1,'fei','','','',1,1,'2019-01-03 12:12:38.565650','2019-01-03 12:12:38.609814','2019-01-03 12:12:38.609814',0),(17,'pbkdf2_sha256$36000$cyFSMcZnYvMM$BU6pLeHDJ64umRX084S2M72AXgphjB5hxMVvgRKz/Oc=','2019-01-07 09:23:46.387794',0,'feifei1','','','1402704486@qq.com',0,1,'2019-01-05 05:20:42.320340','2019-01-05 05:20:42.360723','2019-01-05 05:20:42.360723',0);
/*!40000 ALTER TABLE `df_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_user_groups`
--

DROP TABLE IF EXISTS `df_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_user_groups_user_id_group_id_80e5ab91_uniq` (`user_id`,`group_id`),
  KEY `df_user_groups_group_id_36f24e94_fk_auth_group_id` (`group_id`),
  CONSTRAINT `df_user_groups_group_id_36f24e94_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `df_user_groups_user_id_a816b098_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_user_groups`
--

LOCK TABLES `df_user_groups` WRITE;
/*!40000 ALTER TABLE `df_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `df_user_user_permissions`
--

DROP TABLE IF EXISTS `df_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `df_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `df_user_user_permissions_user_id_permission_id_b22997de_uniq` (`user_id`,`permission_id`),
  KEY `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` (`permission_id`),
  CONSTRAINT `df_user_user_permiss_permission_id_40a6cb2d_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `df_user_user_permissions_user_id_b5f6551b_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `df_user_user_permissions`
--

LOCK TABLES `df_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `df_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `df_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_df_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2019-01-07 11:50:46.546252','1','新鲜水果',1,'[{\"added\": {}}]',11,1),(2,'2019-01-07 12:01:56.736995','2','新鲜水果',1,'[{\"added\": {}}]',11,1),(3,'2019-01-07 12:03:27.153565','3','海鲜水产',1,'[{\"added\": {}}]',11,1),(4,'2019-01-07 12:04:22.430192','4','猪牛羊肉',1,'[{\"added\": {}}]',11,1),(5,'2019-01-07 12:04:52.833503','5','禽类蛋品',1,'[{\"added\": {}}]',11,1),(6,'2019-01-07 12:05:58.002488','6','新鲜蔬菜',1,'[{\"added\": {}}]',11,1),(7,'2019-01-07 12:06:24.384014','7','速冻食品',1,'[{\"added\": {}}]',11,1),(8,'2019-01-08 04:53:26.624769','1','草莓',1,'[{\"added\": {}}]',8,1),(9,'2019-01-08 05:02:04.700541','1','大兴大鹏草莓',1,'[{\"added\": {}}]',10,1),(10,'2019-01-08 05:08:48.858311','1','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(11,'2019-01-08 05:12:37.290838','2','大虾',1,'[{\"added\": {}}]',8,1),(12,'2019-01-08 05:15:46.021358','3','羊肉',1,'[{\"added\": {}}]',8,1),(13,'2019-01-08 05:16:48.273165','4','鸡蛋',1,'[{\"added\": {}}]',8,1),(14,'2019-01-08 05:19:30.539956','5','泡菜',1,'[{\"added\": {}}]',8,1),(15,'2019-01-08 05:20:33.618542','6','蛋糕',1,'[{\"added\": {}}]',8,1),(16,'2019-01-08 05:23:02.697452','2','青岛野生大虾',1,'[{\"added\": {}}]',10,1),(17,'2019-01-08 05:25:05.089620','3','羔羊排 烧烤食材',1,'[{\"added\": {}}]',10,1),(18,'2019-01-08 05:27:47.628960','4','大哥 散养鸡蛋',1,'[{\"added\": {}}]',10,1),(19,'2019-01-08 05:29:02.362254','5','韩国风味泡菜',1,'[{\"added\": {}}]',10,1),(20,'2019-01-08 05:30:07.028145','6','奶油水果蛋糕',1,'[{\"added\": {}}]',10,1),(21,'2019-01-08 05:30:32.364022','3','羔羊排 烧烤食材',2,'[{\"changed\": {\"fields\": [\"unite\"]}}]',10,1),(22,'2019-01-08 05:34:23.633899','2','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(23,'2019-01-08 05:34:47.138263','3','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(24,'2019-01-08 05:34:57.641118','4','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(25,'2019-01-08 05:35:08.757485','5','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(26,'2019-01-08 05:35:18.783515','6','IndexTypeGoodsBanner object',1,'[{\"added\": {}}]',14,1),(27,'2019-01-08 05:38:04.943086','1','IndexGoodsBanner object',1,'[{\"added\": {}}]',12,1),(28,'2019-01-08 05:38:22.272054','2','IndexGoodsBanner object',1,'[{\"added\": {}}]',12,1),(29,'2019-01-08 05:38:39.140038','3','IndexGoodsBanner object',1,'[{\"added\": {}}]',12,1),(30,'2019-01-08 05:39:06.591118','4','IndexGoodsBanner object',1,'[{\"added\": {}}]',12,1),(31,'2019-01-08 05:51:05.345189','1','吃货暑价趴',1,'[{\"added\": {}}]',13,1),(32,'2019-01-08 05:51:49.070009','2','零食保健0元抢',1,'[{\"added\": {}}]',13,1),(33,'2019-01-09 12:08:55.717308','7','火龙果',1,'[{\"added\": {}}]',8,1),(34,'2019-01-09 12:09:34.147246','8','香蕉',1,'[{\"added\": {}}]',8,1),(35,'2019-01-09 12:09:50.475965','7','火龙果',2,'[{\"changed\": {\"fields\": [\"detail\"]}}]',8,1),(36,'2019-01-09 12:12:15.101499','7','天宝香蕉',1,'[{\"added\": {}}]',10,1),(37,'2019-01-09 12:13:33.266294','8','越南进口火龙果',1,'[{\"added\": {}}]',10,1),(38,'2019-01-09 12:18:00.720367','1','新鲜水果',2,'[]',14,1),(39,'2019-01-09 12:18:23.327879','7','新鲜水果',1,'[{\"added\": {}}]',14,1),(40,'2019-01-09 12:18:42.712673','8','新鲜水果',1,'[{\"added\": {}}]',14,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(8,'goods','goods'),(9,'goods','goodsimage'),(10,'goods','goodssku'),(11,'goods','goodstype'),(12,'goods','indexgoodsbanner'),(13,'goods','indexpromotionbanner'),(14,'goods','indextypegoodsbanner'),(15,'order','ordergoods'),(16,'order','orderinfo'),(5,'sessions','session'),(7,'user','address'),(6,'user','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2019-01-03 12:06:49.181579'),(2,'contenttypes','0002_remove_content_type_name','2019-01-03 12:06:50.818806'),(3,'auth','0001_initial','2019-01-03 12:06:55.364173'),(4,'auth','0002_alter_permission_name_max_length','2019-01-03 12:06:56.618048'),(5,'auth','0003_alter_user_email_max_length','2019-01-03 12:06:56.660580'),(6,'auth','0004_alter_user_username_opts','2019-01-03 12:06:56.734634'),(7,'auth','0005_alter_user_last_login_null','2019-01-03 12:06:56.774660'),(8,'auth','0006_require_contenttypes_0002','2019-01-03 12:06:56.823698'),(9,'auth','0007_alter_validators_add_error_messages','2019-01-03 12:06:56.885740'),(10,'auth','0008_alter_user_username_max_length','2019-01-03 12:06:56.953409'),(11,'user','0001_initial','2019-01-03 12:07:14.102322'),(12,'admin','0001_initial','2019-01-03 12:07:17.227868'),(13,'admin','0002_logentry_remove_auto_add','2019-01-03 12:07:17.286415'),(14,'goods','0001_initial','2019-01-03 12:07:34.280892'),(15,'order','0001_initial','2019-01-03 12:07:36.976485'),(16,'order','0002_auto_20190103_2006','2019-01-03 12:07:43.746223'),(17,'sessions','0001_initial','2019-01-03 12:07:44.647790'),(18,'goods','0002_auto_20190103_2035','2019-01-03 12:35:41.199483');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4czr0t0q93lemyekj3xhgu9dosbk4vsf','MmRhOWVjOWNiNDRjYjczNzI2ODI4OTFhOTM4ZWMwNDM5ZjRlZmZmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzlmODM1MWY2MjQ3NzJlMThjMDVjNTNiMzhmOWM2MzVlNmMxMDRhZSJ9','2019-01-19 08:30:08.413242'),('7m4hcj1ylt44a3n7qbyk1gsubvq97iwj','MTg1YjA5OTc3NTIzMWMxNzVhZjA1ZDVkNzFjNDI3MmFiYWU2Nzg2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MjA1MWUwOTRiMzUwOGVjZDI3MWM4OTNiMDNjODNjNjAzMWY5MDQyIn0=','2019-01-17 12:13:22.257211'),('ci9k2gfvs42pehbvrvfn8o4apaerdw3v','MmRhOWVjOWNiNDRjYjczNzI2ODI4OTFhOTM4ZWMwNDM5ZjRlZmZmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzlmODM1MWY2MjQ3NzJlMThjMDVjNTNiMzhmOWM2MzVlNmMxMDRhZSJ9','2019-01-19 09:07:11.368446'),('cnxd22xqii72lkshnqcqjc1f3dbfess2','MmRhOWVjOWNiNDRjYjczNzI2ODI4OTFhOTM4ZWMwNDM5ZjRlZmZmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzlmODM1MWY2MjQ3NzJlMThjMDVjNTNiMzhmOWM2MzVlNmMxMDRhZSJ9','2019-01-19 08:35:45.900584'),('f14uyameijzsg9a8woxe5cdexwnwkvz2','MmRhOWVjOWNiNDRjYjczNzI2ODI4OTFhOTM4ZWMwNDM5ZjRlZmZmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzlmODM1MWY2MjQ3NzJlMThjMDVjNTNiMzhmOWM2MzVlNmMxMDRhZSJ9','2019-01-19 08:57:03.336700'),('olpadel3gp1e44x7bykru4dvoxg3doof','MmRhOWVjOWNiNDRjYjczNzI2ODI4OTFhOTM4ZWMwNDM5ZjRlZmZmNDp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNzlmODM1MWY2MjQ3NzJlMThjMDVjNTNiMzhmOWM2MzVlNmMxMDRhZSJ9','2019-01-19 08:48:44.284227');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-09 20:59:10
