# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.6.32)
# Database: taco_phpunit_test
# Generation Time: 2017-05-31 22:12:10 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table taco_phpunit_test_commentmeta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_commentmeta`;

CREATE TABLE `taco_phpunit_test_commentmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `comment_id` (`comment_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table taco_phpunit_test_comments
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_comments`;

CREATE TABLE `taco_phpunit_test_comments` (
  `comment_ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `comment_post_ID` bigint(20) unsigned NOT NULL DEFAULT '0',
  `comment_author` tinytext NOT NULL,
  `comment_author_email` varchar(100) NOT NULL DEFAULT '',
  `comment_author_url` varchar(200) NOT NULL DEFAULT '',
  `comment_author_IP` varchar(100) NOT NULL DEFAULT '',
  `comment_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `comment_content` text NOT NULL,
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `comment_approved` varchar(20) NOT NULL DEFAULT '1',
  `comment_agent` varchar(255) NOT NULL DEFAULT '',
  `comment_type` varchar(20) NOT NULL DEFAULT '',
  `comment_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`comment_ID`),
  KEY `comment_post_ID` (`comment_post_ID`),
  KEY `comment_approved_date_gmt` (`comment_approved`,`comment_date_gmt`),
  KEY `comment_date_gmt` (`comment_date_gmt`),
  KEY `comment_parent` (`comment_parent`),
  KEY `comment_author_email` (`comment_author_email`(10))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_comments` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_comments` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_comments` (`comment_ID`, `comment_post_ID`, `comment_author`, `comment_author_email`, `comment_author_url`, `comment_author_IP`, `comment_date`, `comment_date_gmt`, `comment_content`, `comment_karma`, `comment_approved`, `comment_agent`, `comment_type`, `comment_parent`, `user_id`)
VALUES
	(1,1,'Mr WordPress','','https://wordpress.org/','','2014-11-12 02:15:27','2014-11-12 02:15:27','Hi, this is a comment.\nTo delete a comment, just log in and view the post&#039;s comments. There you will have the option to edit or delete them.',0,'1','','',0,0);

/*!40000 ALTER TABLE `taco_phpunit_test_comments` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_links
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_links`;

CREATE TABLE `taco_phpunit_test_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL DEFAULT '',
  `link_name` varchar(255) NOT NULL DEFAULT '',
  `link_image` varchar(255) NOT NULL DEFAULT '',
  `link_target` varchar(25) NOT NULL DEFAULT '',
  `link_description` varchar(255) NOT NULL DEFAULT '',
  `link_visible` varchar(20) NOT NULL DEFAULT 'Y',
  `link_owner` bigint(20) unsigned NOT NULL DEFAULT '1',
  `link_rating` int(11) NOT NULL DEFAULT '0',
  `link_updated` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `link_rel` varchar(255) NOT NULL DEFAULT '',
  `link_notes` mediumtext NOT NULL,
  `link_rss` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_visible`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table taco_phpunit_test_options
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_options`;

CREATE TABLE `taco_phpunit_test_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) DEFAULT NULL,
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_options` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_options` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_options` (`option_id`, `option_name`, `option_value`, `autoload`)
VALUES
	(1,'siteurl','http://taco-phpunit-test.vera','yes'),
	(2,'home','http://taco-phpunit-test.vera','yes'),
	(3,'blogname','Taco PHPUnit Test','yes'),
	(4,'blogdescription','Just another WordPress site','yes'),
	(5,'users_can_register','0','yes'),
	(6,'admin_email','admin@localhost','yes'),
	(7,'start_of_week','1','yes'),
	(8,'use_balanceTags','0','yes'),
	(9,'use_smilies','1','yes'),
	(10,'require_name_email','1','yes'),
	(11,'comments_notify','1','yes'),
	(12,'posts_per_rss','10','yes'),
	(13,'rss_use_excerpt','0','yes'),
	(14,'mailserver_url','mail.example.com','yes'),
	(15,'mailserver_login','login@example.com','yes'),
	(16,'mailserver_pass','password','yes'),
	(17,'mailserver_port','110','yes'),
	(18,'default_category','1','yes'),
	(19,'default_comment_status','open','yes'),
	(20,'default_ping_status','open','yes'),
	(21,'default_pingback_flag','0','yes'),
	(22,'posts_per_page','10','yes'),
	(23,'date_format','F j, Y','yes'),
	(24,'time_format','g:i a','yes'),
	(25,'links_updated_date_format','F j, Y g:i a','yes'),
	(26,'comment_moderation','0','yes'),
	(27,'moderation_notify','1','yes'),
	(28,'permalink_structure','/%postname%/','yes'),
	(30,'hack_file','0','yes'),
	(31,'blog_charset','UTF-8','yes'),
	(32,'moderation_keys','','no'),
	(33,'active_plugins','a:3:{i:0;s:27:\"taco_person/taco_person.php\";i:1;s:33:\"taco_hot_sauce/taco_hot_sauce.php\";i:2;s:29:\"taco_keyword/taco_keyword.php\";}','yes'),
	(34,'category_base','','yes'),
	(35,'ping_sites','http://rpc.pingomatic.com/','yes'),
	(37,'comment_max_links','2','yes'),
	(38,'gmt_offset','0','yes'),
	(39,'default_email_category','1','yes'),
	(40,'recently_edited','','no'),
	(41,'template','app','yes'),
	(42,'stylesheet','app','yes'),
	(43,'comment_whitelist','1','yes'),
	(44,'blacklist_keys','','no'),
	(45,'comment_registration','0','yes'),
	(46,'html_type','text/html','yes'),
	(47,'use_trackback','0','yes'),
	(48,'default_role','subscriber','yes'),
	(49,'db_version','38590','yes'),
	(50,'uploads_use_yearmonth_folders','1','yes'),
	(51,'upload_path','','yes'),
	(52,'blog_public','0','yes'),
	(53,'default_link_category','2','yes'),
	(54,'show_on_front','posts','yes'),
	(55,'tag_base','','yes'),
	(56,'show_avatars','1','yes'),
	(57,'avatar_rating','G','yes'),
	(58,'upload_url_path','','yes'),
	(59,'thumbnail_size_w','150','yes'),
	(60,'thumbnail_size_h','150','yes'),
	(61,'thumbnail_crop','1','yes'),
	(62,'medium_size_w','300','yes'),
	(63,'medium_size_h','300','yes'),
	(64,'avatar_default','mystery','yes'),
	(65,'large_size_w','1024','yes'),
	(66,'large_size_h','1024','yes'),
	(67,'image_default_link_type','file','yes'),
	(68,'image_default_size','','yes'),
	(69,'image_default_align','','yes'),
	(70,'close_comments_for_old_posts','0','yes'),
	(71,'close_comments_days_old','14','yes'),
	(72,'thread_comments','1','yes'),
	(73,'thread_comments_depth','5','yes'),
	(74,'page_comments','0','yes'),
	(75,'comments_per_page','50','yes'),
	(76,'default_comments_page','newest','yes'),
	(77,'comment_order','asc','yes'),
	(78,'sticky_posts','a:0:{}','yes'),
	(79,'widget_categories','a:2:{i:2;a:4:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:12:\"hierarchical\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),
	(80,'widget_text','a:0:{}','yes'),
	(81,'widget_rss','a:0:{}','yes'),
	(82,'uninstall_plugins','a:0:{}','no'),
	(83,'timezone_string','','yes'),
	(84,'page_for_posts','0','yes'),
	(85,'page_on_front','0','yes'),
	(86,'default_post_format','0','yes'),
	(87,'link_manager_enabled','0','yes'),
	(88,'initial_db_version','29630','yes'),
	(89,'taco_phpunit_test_user_roles','a:5:{s:13:\"administrator\";a:2:{s:4:\"name\";s:13:\"Administrator\";s:12:\"capabilities\";a:61:{s:13:\"switch_themes\";b:1;s:11:\"edit_themes\";b:1;s:16:\"activate_plugins\";b:1;s:12:\"edit_plugins\";b:1;s:10:\"edit_users\";b:1;s:10:\"edit_files\";b:1;s:14:\"manage_options\";b:1;s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:6:\"import\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:8:\"level_10\";b:1;s:7:\"level_9\";b:1;s:7:\"level_8\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;s:12:\"delete_users\";b:1;s:12:\"create_users\";b:1;s:17:\"unfiltered_upload\";b:1;s:14:\"edit_dashboard\";b:1;s:14:\"update_plugins\";b:1;s:14:\"delete_plugins\";b:1;s:15:\"install_plugins\";b:1;s:13:\"update_themes\";b:1;s:14:\"install_themes\";b:1;s:11:\"update_core\";b:1;s:10:\"list_users\";b:1;s:12:\"remove_users\";b:1;s:13:\"promote_users\";b:1;s:18:\"edit_theme_options\";b:1;s:13:\"delete_themes\";b:1;s:6:\"export\";b:1;}}s:6:\"editor\";a:2:{s:4:\"name\";s:6:\"Editor\";s:12:\"capabilities\";a:34:{s:17:\"moderate_comments\";b:1;s:17:\"manage_categories\";b:1;s:12:\"manage_links\";b:1;s:12:\"upload_files\";b:1;s:15:\"unfiltered_html\";b:1;s:10:\"edit_posts\";b:1;s:17:\"edit_others_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:10:\"edit_pages\";b:1;s:4:\"read\";b:1;s:7:\"level_7\";b:1;s:7:\"level_6\";b:1;s:7:\"level_5\";b:1;s:7:\"level_4\";b:1;s:7:\"level_3\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:17:\"edit_others_pages\";b:1;s:20:\"edit_published_pages\";b:1;s:13:\"publish_pages\";b:1;s:12:\"delete_pages\";b:1;s:19:\"delete_others_pages\";b:1;s:22:\"delete_published_pages\";b:1;s:12:\"delete_posts\";b:1;s:19:\"delete_others_posts\";b:1;s:22:\"delete_published_posts\";b:1;s:20:\"delete_private_posts\";b:1;s:18:\"edit_private_posts\";b:1;s:18:\"read_private_posts\";b:1;s:20:\"delete_private_pages\";b:1;s:18:\"edit_private_pages\";b:1;s:18:\"read_private_pages\";b:1;}}s:6:\"author\";a:2:{s:4:\"name\";s:6:\"Author\";s:12:\"capabilities\";a:10:{s:12:\"upload_files\";b:1;s:10:\"edit_posts\";b:1;s:20:\"edit_published_posts\";b:1;s:13:\"publish_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_2\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;s:22:\"delete_published_posts\";b:1;}}s:11:\"contributor\";a:2:{s:4:\"name\";s:11:\"Contributor\";s:12:\"capabilities\";a:5:{s:10:\"edit_posts\";b:1;s:4:\"read\";b:1;s:7:\"level_1\";b:1;s:7:\"level_0\";b:1;s:12:\"delete_posts\";b:1;}}s:10:\"subscriber\";a:2:{s:4:\"name\";s:10:\"Subscriber\";s:12:\"capabilities\";a:2:{s:4:\"read\";b:1;s:7:\"level_0\";b:1;}}}','yes'),
	(90,'widget_search','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),
	(91,'widget_recent-posts','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),
	(92,'widget_recent-comments','a:2:{i:2;a:2:{s:5:\"title\";s:0:\"\";s:6:\"number\";i:5;}s:12:\"_multiwidget\";i:1;}','yes'),
	(93,'widget_archives','a:2:{i:2;a:3:{s:5:\"title\";s:0:\"\";s:5:\"count\";i:0;s:8:\"dropdown\";i:0;}s:12:\"_multiwidget\";i:1;}','yes'),
	(94,'widget_meta','a:2:{i:2;a:1:{s:5:\"title\";s:0:\"\";}s:12:\"_multiwidget\";i:1;}','yes'),
	(95,'sidebars_widgets','a:3:{s:19:\"wp_inactive_widgets\";a:0:{}s:18:\"orphaned_widgets_1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:13:\"array_version\";i:3;}','yes'),
	(96,'cron','a:4:{i:1420683331;a:3:{s:16:\"wp_version_check\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:17:\"wp_update_plugins\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}s:16:\"wp_update_themes\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:10:\"twicedaily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:43200;}}}i:1420683340;a:1:{s:19:\"wp_scheduled_delete\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:3:{s:8:\"schedule\";s:5:\"daily\";s:4:\"args\";a:0:{}s:8:\"interval\";i:86400;}}}i:1462916219;a:1:{s:26:\"wp_split_shared_term_batch\";a:1:{s:32:\"40cd750bba9870f18aada2478b24840a\";a:2:{s:8:\"schedule\";b:0;s:4:\"args\";a:0:{}}}}s:7:\"version\";i:2;}','yes'),
	(103,'_transient_random_seed','f18210dead325325e08af2d53c7cc3ad','yes'),
	(99,'_site_transient_update_plugins','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1496265667;s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:0:{}}','no'),
	(1863,'_site_transient_timeout_theme_roots','1496270487','no'),
	(102,'_site_transient_update_themes','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1496268687;s:7:\"checked\";a:1:{s:3:\"app\";s:0:\"\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}}','no'),
	(139,'irs_children','a:0:{}','yes'),
	(1846,'keyword_children','a:0:{}','yes'),
	(143,'keyword_3','a:1:{s:12:\"external_url\";s:30:\"https://google.com/#q=habanero\";}','yes'),
	(147,'keyword_4','a:1:{s:12:\"external_url\";s:38:\"https://en.wikipedia.org/wiki/Habanero\";}','yes'),
	(181,'keyword_15','a:1:{s:10:\"heat_level\";i:0;}','yes'),
	(183,'keyword_16','a:1:{s:10:\"heat_level\";i:1;}','yes'),
	(185,'keyword_17','a:1:{s:10:\"heat_level\";i:2;}','yes'),
	(187,'keyword_18','a:1:{s:10:\"heat_level\";i:3;}','yes'),
	(189,'keyword_19','a:1:{s:10:\"heat_level\";i:4;}','yes'),
	(191,'keyword_20','a:1:{s:10:\"heat_level\";i:5;}','yes'),
	(193,'keyword_21','a:1:{s:10:\"heat_level\";i:6;}','yes'),
	(121,'db_upgraded','','yes'),
	(125,'logged_in_key','Kbs8Dgd1(,39H9Pn_LMua0_%kOOq$l]fN>OwMzkr[iidHO@^) t;e9vHJOTq9t42','yes'),
	(126,'logged_in_salt','YI#0kEb}6aaMZ8K|EMc+p>@W(Lf{j!i!Nhh)C0L=.KH*hFnG*1.U/5V1Yht-TS&Y','yes'),
	(127,'nonce_key',']0TfQm}Ts:!e@G$EC1ZP(/AJwbIFX49>bt>RS-p(<c1Ru&9S!6^3xI-vj8GsT)rF','yes'),
	(128,'nonce_salt','dP1wg7WKC;Gy&{<FGm?hyD(IGjb/^j(AU_WLK{TXu8ppW; n+^<Q2bOgg!bN&[U%','yes'),
	(111,'recently_activated','a:0:{}','yes'),
	(112,'theme_mods_twentyfourteen','a:1:{s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1415759126;s:4:\"data\";a:4:{s:19:\"wp_inactive_widgets\";a:0:{}s:9:\"sidebar-1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}s:9:\"sidebar-2\";a:0:{}s:9:\"sidebar-3\";a:0:{}}}}','yes'),
	(113,'current_theme','App','yes'),
	(114,'theme_mods_app','a:1:{i:0;b:0;}','yes'),
	(115,'theme_switched','','yes'),
	(122,'rewrite_rules','a:131:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:21:\"^index.php/wp-json/?$\";s:22:\"index.php?rest_route=/\";s:24:\"^index.php/wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:37:\"hot-sauce/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:47:\"hot-sauce/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:67:\"hot-sauce/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"hot-sauce/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"hot-sauce/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:43:\"hot-sauce/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:26:\"hot-sauce/([^/]+)/embed/?$\";s:42:\"index.php?hot-sauce=$matches[1]&embed=true\";s:30:\"hot-sauce/([^/]+)/trackback/?$\";s:36:\"index.php?hot-sauce=$matches[1]&tb=1\";s:38:\"hot-sauce/([^/]+)/page/?([0-9]{1,})/?$\";s:49:\"index.php?hot-sauce=$matches[1]&paged=$matches[2]\";s:45:\"hot-sauce/([^/]+)/comment-page-([0-9]{1,})/?$\";s:49:\"index.php?hot-sauce=$matches[1]&cpage=$matches[2]\";s:34:\"hot-sauce/([^/]+)(?:/([0-9]+))?/?$\";s:48:\"index.php?hot-sauce=$matches[1]&page=$matches[2]\";s:26:\"hot-sauce/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:36:\"hot-sauce/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:56:\"hot-sauce/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"hot-sauce/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"hot-sauce/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:32:\"hot-sauce/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:34:\"person/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:44:\"person/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:64:\"person/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"person/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"person/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:40:\"person/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:23:\"person/([^/]+)/embed/?$\";s:39:\"index.php?person=$matches[1]&embed=true\";s:27:\"person/([^/]+)/trackback/?$\";s:33:\"index.php?person=$matches[1]&tb=1\";s:35:\"person/([^/]+)/page/?([0-9]{1,})/?$\";s:46:\"index.php?person=$matches[1]&paged=$matches[2]\";s:42:\"person/([^/]+)/comment-page-([0-9]{1,})/?$\";s:46:\"index.php?person=$matches[1]&cpage=$matches[2]\";s:31:\"person/([^/]+)(?:/([0-9]+))?/?$\";s:45:\"index.php?person=$matches[1]&page=$matches[2]\";s:23:\"person/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:33:\"person/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:53:\"person/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"person/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"person/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:29:\"person/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:48:\"keyword/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?keyword=$matches[1]&feed=$matches[2]\";s:43:\"keyword/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?keyword=$matches[1]&feed=$matches[2]\";s:24:\"keyword/([^/]+)/embed/?$\";s:40:\"index.php?keyword=$matches[1]&embed=true\";s:36:\"keyword/([^/]+)/page/?([0-9]{1,})/?$\";s:47:\"index.php?keyword=$matches[1]&paged=$matches[2]\";s:18:\"keyword/([^/]+)/?$\";s:29:\"index.php?keyword=$matches[1]\";s:44:\"irs/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?irs=$matches[1]&feed=$matches[2]\";s:39:\"irs/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?irs=$matches[1]&feed=$matches[2]\";s:20:\"irs/([^/]+)/embed/?$\";s:36:\"index.php?irs=$matches[1]&embed=true\";s:32:\"irs/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?irs=$matches[1]&paged=$matches[2]\";s:14:\"irs/([^/]+)/?$\";s:25:\"index.php?irs=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','yes'),
	(1853,'secure_auth_salt','KCThIr:uC.V;taBZIh?i-?HCL@mmR&@<$o^z[un`>_D4*35{zc[xp-OIYjO 5^qn','no'),
	(1854,'_site_transient_update_core','O:8:\"stdClass\":4:{s:7:\"updates\";a:1:{i:0;O:8:\"stdClass\":10:{s:8:\"response\";s:6:\"latest\";s:8:\"download\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.7.5.zip\";s:6:\"locale\";s:5:\"en_US\";s:8:\"packages\";O:8:\"stdClass\":5:{s:4:\"full\";s:59:\"https://downloads.wordpress.org/release/wordpress-4.7.5.zip\";s:10:\"no_content\";s:70:\"https://downloads.wordpress.org/release/wordpress-4.7.5-no-content.zip\";s:11:\"new_bundled\";s:71:\"https://downloads.wordpress.org/release/wordpress-4.7.5-new-bundled.zip\";s:7:\"partial\";b:0;s:8:\"rollback\";b:0;}s:7:\"current\";s:5:\"4.7.5\";s:7:\"version\";s:5:\"4.7.5\";s:11:\"php_version\";s:5:\"5.2.4\";s:13:\"mysql_version\";s:3:\"5.0\";s:11:\"new_bundled\";s:3:\"4.7\";s:15:\"partial_version\";s:0:\"\";}}s:12:\"last_checked\";i:1496268680;s:15:\"version_checked\";s:5:\"4.7.5\";s:12:\"translations\";a:0:{}}','no'),
	(1864,'_site_transient_theme_roots','a:1:{s:3:\"app\";s:7:\"/themes\";}','no'),
	(1857,'_site_transient_timeout_browser_f7a03887aa1b9d822dad7ce6e5049e3a','1496870468','no'),
	(1858,'_site_transient_browser_f7a03887aa1b9d822dad7ce6e5049e3a','a:9:{s:8:\"platform\";s:9:\"Macintosh\";s:4:\"name\";s:6:\"Chrome\";s:7:\"version\";s:13:\"58.0.3029.110\";s:10:\"update_url\";s:28:\"http://www.google.com/chrome\";s:7:\"img_src\";s:49:\"http://s.wordpress.org/images/browsers/chrome.png\";s:11:\"img_src_ssl\";s:48:\"https://wordpress.org/images/browsers/chrome.png\";s:15:\"current_version\";s:2:\"18\";s:7:\"upgrade\";b:0;s:8:\"insecure\";b:0;}','no'),
	(1859,'can_compress_scripts','0','no'),
	(1860,'theme_mods_taco-theme','a:3:{i:0;b:0;s:18:\"custom_css_post_id\";i:-1;s:16:\"sidebars_widgets\";a:2:{s:4:\"time\";i:1496268696;s:4:\"data\";a:2:{s:19:\"wp_inactive_widgets\";a:0:{}s:18:\"orphaned_widgets_1\";a:6:{i:0;s:8:\"search-2\";i:1;s:14:\"recent-posts-2\";i:2;s:17:\"recent-comments-2\";i:3;s:10:\"archives-2\";i:4;s:12:\"categories-2\";i:5;s:6:\"meta-2\";}}}}','yes'),
	(123,'auth_key','fEv6C|F{EVaN;]D:ts:/ +C;@Q9T?B*IW8^g]V6%i+6pcnV>VaNHkiTXbGsd5W(#','yes'),
	(124,'auth_salt','&r<p2*#DqOd~sScy.d4Ju+!{sfx,6NZ!w(yrc=ZX/m:@dm<{C<;RDdJ9$#/(?yJ!','yes'),
	(135,'widget_pages','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),
	(136,'widget_calendar','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),
	(137,'widget_tag_cloud','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),
	(138,'widget_nav_menu','a:1:{s:12:\"_multiwidget\";i:1;}','yes'),
	(195,'keyword_22','a:1:{s:10:\"heat_level\";i:7;}','yes'),
	(197,'keyword_23','a:1:{s:10:\"heat_level\";i:8;}','yes'),
	(199,'keyword_24','a:1:{s:10:\"heat_level\";i:9;}','yes'),
	(221,'keyword_25','a:1:{s:12:\"external_url\";i:0;}','yes'),
	(223,'keyword_26','a:1:{s:12:\"external_url\";i:1;}','yes'),
	(225,'keyword_27','a:1:{s:12:\"external_url\";i:2;}','yes'),
	(227,'keyword_28','a:1:{s:12:\"external_url\";i:3;}','yes'),
	(229,'keyword_29','a:1:{s:12:\"external_url\";i:4;}','yes'),
	(231,'keyword_30','a:1:{s:12:\"external_url\";i:5;}','yes'),
	(233,'keyword_31','a:1:{s:12:\"external_url\";i:6;}','yes'),
	(235,'keyword_32','a:1:{s:12:\"external_url\";i:7;}','yes'),
	(237,'keyword_33','a:1:{s:12:\"external_url\";i:8;}','yes'),
	(239,'keyword_34','a:1:{s:12:\"external_url\";i:9;}','yes'),
	(241,'keyword_35','a:1:{s:12:\"external_url\";i:10;}','yes'),
	(243,'keyword_36','a:1:{s:12:\"external_url\";i:11;}','yes'),
	(245,'keyword_37','a:1:{s:12:\"external_url\";i:12;}','yes'),
	(247,'keyword_38','a:1:{s:12:\"external_url\";i:13;}','yes'),
	(249,'keyword_39','a:1:{s:12:\"external_url\";i:14;}','yes'),
	(251,'keyword_40','a:1:{s:12:\"external_url\";i:15;}','yes'),
	(253,'keyword_41','a:1:{s:12:\"external_url\";i:16;}','yes'),
	(255,'keyword_42','a:1:{s:12:\"external_url\";i:17;}','yes'),
	(257,'keyword_43','a:1:{s:12:\"external_url\";i:18;}','yes'),
	(259,'keyword_44','a:1:{s:12:\"external_url\";i:19;}','yes'),
	(261,'keyword_45','a:1:{s:12:\"external_url\";i:20;}','yes'),
	(263,'keyword_46','a:1:{s:12:\"external_url\";i:21;}','yes'),
	(265,'keyword_47','a:1:{s:12:\"external_url\";i:22;}','yes'),
	(267,'keyword_48','a:1:{s:12:\"external_url\";i:23;}','yes'),
	(269,'keyword_49','a:1:{s:12:\"external_url\";i:24;}','yes'),
	(271,'keyword_50','a:1:{s:12:\"external_url\";i:25;}','yes'),
	(273,'keyword_51','a:1:{s:12:\"external_url\";i:26;}','yes'),
	(275,'keyword_52','a:1:{s:12:\"external_url\";i:27;}','yes'),
	(277,'keyword_53','a:1:{s:12:\"external_url\";i:28;}','yes'),
	(279,'keyword_54','a:1:{s:12:\"external_url\";i:29;}','yes'),
	(281,'keyword_55','a:1:{s:12:\"external_url\";i:30;}','yes'),
	(283,'keyword_56','a:1:{s:12:\"external_url\";i:31;}','yes'),
	(285,'keyword_57','a:1:{s:12:\"external_url\";i:32;}','yes'),
	(287,'keyword_58','a:1:{s:12:\"external_url\";i:33;}','yes'),
	(289,'keyword_59','a:1:{s:12:\"external_url\";i:34;}','yes'),
	(291,'keyword_60','a:1:{s:12:\"external_url\";i:35;}','yes'),
	(293,'keyword_61','a:1:{s:12:\"external_url\";i:36;}','yes'),
	(295,'keyword_62','a:1:{s:12:\"external_url\";i:37;}','yes'),
	(297,'keyword_63','a:1:{s:12:\"external_url\";i:38;}','yes'),
	(299,'keyword_64','a:1:{s:12:\"external_url\";i:39;}','yes'),
	(301,'keyword_65','a:1:{s:12:\"external_url\";i:40;}','yes'),
	(303,'keyword_66','a:1:{s:12:\"external_url\";i:41;}','yes'),
	(305,'keyword_67','a:1:{s:12:\"external_url\";i:42;}','yes'),
	(307,'keyword_68','a:1:{s:12:\"external_url\";i:43;}','yes'),
	(309,'keyword_69','a:1:{s:12:\"external_url\";i:44;}','yes'),
	(311,'keyword_70','a:1:{s:12:\"external_url\";i:45;}','yes'),
	(313,'keyword_71','a:1:{s:12:\"external_url\";i:46;}','yes'),
	(315,'keyword_72','a:1:{s:12:\"external_url\";i:47;}','yes'),
	(317,'keyword_73','a:1:{s:12:\"external_url\";i:48;}','yes'),
	(319,'keyword_74','a:1:{s:12:\"external_url\";i:49;}','yes'),
	(321,'keyword_75','a:1:{s:12:\"external_url\";i:50;}','yes'),
	(323,'keyword_76','a:1:{s:12:\"external_url\";i:51;}','yes'),
	(325,'keyword_77','a:1:{s:12:\"external_url\";i:52;}','yes'),
	(327,'keyword_78','a:1:{s:12:\"external_url\";i:53;}','yes'),
	(329,'keyword_79','a:1:{s:12:\"external_url\";i:54;}','yes'),
	(331,'keyword_80','a:1:{s:12:\"external_url\";i:55;}','yes'),
	(333,'keyword_81','a:1:{s:12:\"external_url\";i:56;}','yes'),
	(335,'keyword_82','a:1:{s:12:\"external_url\";i:57;}','yes'),
	(337,'keyword_83','a:1:{s:12:\"external_url\";i:58;}','yes'),
	(339,'keyword_84','a:1:{s:12:\"external_url\";i:59;}','yes'),
	(341,'keyword_85','a:1:{s:12:\"external_url\";i:60;}','yes'),
	(343,'keyword_86','a:1:{s:12:\"external_url\";i:61;}','yes'),
	(345,'keyword_87','a:1:{s:12:\"external_url\";i:62;}','yes'),
	(347,'keyword_88','a:1:{s:12:\"external_url\";i:63;}','yes'),
	(349,'keyword_89','a:1:{s:12:\"external_url\";i:64;}','yes'),
	(351,'keyword_90','a:1:{s:12:\"external_url\";i:65;}','yes'),
	(353,'keyword_91','a:1:{s:12:\"external_url\";i:66;}','yes'),
	(355,'keyword_92','a:1:{s:12:\"external_url\";i:67;}','yes'),
	(357,'keyword_93','a:1:{s:12:\"external_url\";i:68;}','yes'),
	(359,'keyword_94','a:1:{s:12:\"external_url\";i:69;}','yes'),
	(361,'keyword_95','a:1:{s:12:\"external_url\";i:70;}','yes'),
	(363,'keyword_96','a:1:{s:12:\"external_url\";i:71;}','yes'),
	(365,'keyword_97','a:1:{s:12:\"external_url\";i:72;}','yes'),
	(367,'keyword_98','a:1:{s:12:\"external_url\";i:73;}','yes'),
	(369,'keyword_99','a:1:{s:12:\"external_url\";i:74;}','yes'),
	(371,'keyword_100','a:1:{s:12:\"external_url\";i:75;}','yes'),
	(373,'keyword_101','a:1:{s:12:\"external_url\";i:76;}','yes'),
	(375,'keyword_102','a:1:{s:12:\"external_url\";i:77;}','yes'),
	(377,'keyword_103','a:1:{s:12:\"external_url\";i:78;}','yes'),
	(379,'keyword_104','a:1:{s:12:\"external_url\";i:79;}','yes'),
	(381,'keyword_105','a:1:{s:12:\"external_url\";i:80;}','yes'),
	(383,'keyword_106','a:1:{s:12:\"external_url\";i:81;}','yes'),
	(385,'keyword_107','a:1:{s:12:\"external_url\";i:82;}','yes'),
	(387,'keyword_108','a:1:{s:12:\"external_url\";i:83;}','yes'),
	(389,'keyword_109','a:1:{s:12:\"external_url\";i:84;}','yes'),
	(391,'keyword_110','a:1:{s:12:\"external_url\";i:85;}','yes'),
	(393,'keyword_111','a:1:{s:12:\"external_url\";i:86;}','yes'),
	(395,'keyword_112','a:1:{s:12:\"external_url\";i:87;}','yes'),
	(397,'keyword_113','a:1:{s:12:\"external_url\";i:88;}','yes'),
	(399,'keyword_114','a:1:{s:12:\"external_url\";i:89;}','yes'),
	(401,'keyword_115','a:1:{s:12:\"external_url\";i:90;}','yes'),
	(403,'keyword_116','a:1:{s:12:\"external_url\";i:91;}','yes'),
	(405,'keyword_117','a:1:{s:12:\"external_url\";i:92;}','yes'),
	(407,'keyword_118','a:1:{s:12:\"external_url\";i:93;}','yes'),
	(409,'keyword_119','a:1:{s:12:\"external_url\";i:94;}','yes'),
	(411,'keyword_120','a:1:{s:12:\"external_url\";i:95;}','yes'),
	(413,'keyword_121','a:1:{s:12:\"external_url\";i:96;}','yes'),
	(415,'keyword_122','a:1:{s:12:\"external_url\";i:97;}','yes'),
	(417,'keyword_123','a:1:{s:12:\"external_url\";i:98;}','yes'),
	(419,'keyword_124','a:1:{s:12:\"external_url\";i:99;}','yes'),
	(699,'keyword_151','a:1:{s:12:\"external_url\";i:0;}','yes'),
	(701,'keyword_152','a:1:{s:12:\"external_url\";i:1;}','yes'),
	(703,'keyword_153','a:1:{s:12:\"external_url\";i:2;}','yes'),
	(705,'keyword_154','a:1:{s:12:\"external_url\";i:3;}','yes'),
	(707,'keyword_155','a:1:{s:12:\"external_url\";i:4;}','yes'),
	(709,'keyword_156','a:1:{s:12:\"external_url\";i:5;}','yes'),
	(711,'keyword_157','a:1:{s:12:\"external_url\";i:6;}','yes'),
	(713,'keyword_158','a:1:{s:12:\"external_url\";i:7;}','yes'),
	(715,'keyword_159','a:1:{s:12:\"external_url\";i:8;}','yes'),
	(717,'keyword_160','a:1:{s:12:\"external_url\";i:9;}','yes'),
	(719,'keyword_161','a:1:{s:12:\"external_url\";i:10;}','yes'),
	(721,'keyword_162','a:1:{s:12:\"external_url\";i:11;}','yes'),
	(723,'keyword_163','a:1:{s:12:\"external_url\";i:12;}','yes'),
	(725,'keyword_164','a:1:{s:12:\"external_url\";i:13;}','yes'),
	(727,'keyword_165','a:1:{s:12:\"external_url\";i:14;}','yes'),
	(729,'keyword_166','a:1:{s:12:\"external_url\";i:15;}','yes'),
	(731,'keyword_167','a:1:{s:12:\"external_url\";i:16;}','yes'),
	(733,'keyword_168','a:1:{s:12:\"external_url\";i:17;}','yes'),
	(735,'keyword_169','a:1:{s:12:\"external_url\";i:18;}','yes'),
	(737,'keyword_170','a:1:{s:12:\"external_url\";i:19;}','yes'),
	(739,'keyword_171','a:1:{s:12:\"external_url\";i:20;}','yes'),
	(741,'keyword_172','a:1:{s:12:\"external_url\";i:21;}','yes'),
	(743,'keyword_173','a:1:{s:12:\"external_url\";i:22;}','yes'),
	(745,'keyword_174','a:1:{s:12:\"external_url\";i:23;}','yes'),
	(747,'keyword_175','a:1:{s:12:\"external_url\";i:24;}','yes'),
	(749,'keyword_176','a:1:{s:12:\"external_url\";i:25;}','yes'),
	(751,'keyword_177','a:1:{s:12:\"external_url\";i:26;}','yes'),
	(753,'keyword_178','a:1:{s:12:\"external_url\";i:27;}','yes'),
	(755,'keyword_179','a:1:{s:12:\"external_url\";i:28;}','yes'),
	(757,'keyword_180','a:1:{s:12:\"external_url\";i:29;}','yes'),
	(759,'keyword_181','a:1:{s:12:\"external_url\";i:30;}','yes'),
	(761,'keyword_182','a:1:{s:12:\"external_url\";i:31;}','yes'),
	(763,'keyword_183','a:1:{s:12:\"external_url\";i:32;}','yes'),
	(765,'keyword_184','a:1:{s:12:\"external_url\";i:33;}','yes'),
	(767,'keyword_185','a:1:{s:12:\"external_url\";i:34;}','yes'),
	(769,'keyword_186','a:1:{s:12:\"external_url\";i:35;}','yes'),
	(771,'keyword_187','a:1:{s:12:\"external_url\";i:36;}','yes'),
	(773,'keyword_188','a:1:{s:12:\"external_url\";i:37;}','yes'),
	(775,'keyword_189','a:1:{s:12:\"external_url\";i:38;}','yes'),
	(777,'keyword_190','a:1:{s:12:\"external_url\";i:39;}','yes'),
	(779,'keyword_191','a:1:{s:12:\"external_url\";i:40;}','yes'),
	(781,'keyword_192','a:1:{s:12:\"external_url\";i:41;}','yes'),
	(783,'keyword_193','a:1:{s:12:\"external_url\";i:42;}','yes'),
	(785,'keyword_194','a:1:{s:12:\"external_url\";i:43;}','yes'),
	(787,'keyword_195','a:1:{s:12:\"external_url\";i:44;}','yes'),
	(789,'keyword_196','a:1:{s:12:\"external_url\";i:45;}','yes'),
	(791,'keyword_197','a:1:{s:12:\"external_url\";i:46;}','yes'),
	(793,'keyword_198','a:1:{s:12:\"external_url\";i:47;}','yes'),
	(795,'keyword_199','a:1:{s:12:\"external_url\";i:48;}','yes'),
	(797,'keyword_200','a:1:{s:12:\"external_url\";i:49;}','yes'),
	(799,'keyword_201','a:1:{s:12:\"external_url\";i:50;}','yes'),
	(801,'keyword_202','a:1:{s:12:\"external_url\";i:51;}','yes'),
	(803,'keyword_203','a:1:{s:12:\"external_url\";i:52;}','yes'),
	(805,'keyword_204','a:1:{s:12:\"external_url\";i:53;}','yes'),
	(807,'keyword_205','a:1:{s:12:\"external_url\";i:54;}','yes'),
	(809,'keyword_206','a:1:{s:12:\"external_url\";i:55;}','yes'),
	(811,'keyword_207','a:1:{s:12:\"external_url\";i:56;}','yes'),
	(813,'keyword_208','a:1:{s:12:\"external_url\";i:57;}','yes'),
	(815,'keyword_209','a:1:{s:12:\"external_url\";i:58;}','yes'),
	(817,'keyword_210','a:1:{s:12:\"external_url\";i:59;}','yes'),
	(819,'keyword_211','a:1:{s:12:\"external_url\";i:60;}','yes'),
	(821,'keyword_212','a:1:{s:12:\"external_url\";i:61;}','yes'),
	(823,'keyword_213','a:1:{s:12:\"external_url\";i:62;}','yes'),
	(825,'keyword_214','a:1:{s:12:\"external_url\";i:63;}','yes'),
	(827,'keyword_215','a:1:{s:12:\"external_url\";i:64;}','yes'),
	(829,'keyword_216','a:1:{s:12:\"external_url\";i:65;}','yes'),
	(831,'keyword_217','a:1:{s:12:\"external_url\";i:66;}','yes'),
	(833,'keyword_218','a:1:{s:12:\"external_url\";i:67;}','yes'),
	(835,'keyword_219','a:1:{s:12:\"external_url\";i:68;}','yes'),
	(837,'keyword_220','a:1:{s:12:\"external_url\";i:69;}','yes'),
	(839,'keyword_221','a:1:{s:12:\"external_url\";i:70;}','yes'),
	(841,'keyword_222','a:1:{s:12:\"external_url\";i:71;}','yes'),
	(843,'keyword_223','a:1:{s:12:\"external_url\";i:72;}','yes'),
	(845,'keyword_224','a:1:{s:12:\"external_url\";i:73;}','yes'),
	(847,'keyword_225','a:1:{s:12:\"external_url\";i:74;}','yes'),
	(849,'keyword_226','a:1:{s:12:\"external_url\";i:75;}','yes'),
	(851,'keyword_227','a:1:{s:12:\"external_url\";i:76;}','yes'),
	(853,'keyword_228','a:1:{s:12:\"external_url\";i:77;}','yes'),
	(855,'keyword_229','a:1:{s:12:\"external_url\";i:78;}','yes'),
	(857,'keyword_230','a:1:{s:12:\"external_url\";i:79;}','yes'),
	(859,'keyword_231','a:1:{s:12:\"external_url\";i:80;}','yes'),
	(861,'keyword_232','a:1:{s:12:\"external_url\";i:81;}','yes'),
	(863,'keyword_233','a:1:{s:12:\"external_url\";i:82;}','yes'),
	(865,'keyword_234','a:1:{s:12:\"external_url\";i:83;}','yes'),
	(867,'keyword_235','a:1:{s:12:\"external_url\";i:84;}','yes'),
	(869,'keyword_236','a:1:{s:12:\"external_url\";i:85;}','yes'),
	(871,'keyword_237','a:1:{s:12:\"external_url\";i:86;}','yes'),
	(873,'keyword_238','a:1:{s:12:\"external_url\";i:87;}','yes'),
	(875,'keyword_239','a:1:{s:12:\"external_url\";i:88;}','yes'),
	(877,'keyword_240','a:1:{s:12:\"external_url\";i:89;}','yes'),
	(879,'keyword_241','a:1:{s:12:\"external_url\";i:90;}','yes'),
	(881,'keyword_242','a:1:{s:12:\"external_url\";i:91;}','yes'),
	(883,'keyword_243','a:1:{s:12:\"external_url\";i:92;}','yes'),
	(885,'keyword_244','a:1:{s:12:\"external_url\";i:93;}','yes'),
	(887,'keyword_245','a:1:{s:12:\"external_url\";i:94;}','yes'),
	(889,'keyword_246','a:1:{s:12:\"external_url\";i:95;}','yes'),
	(891,'keyword_247','a:1:{s:12:\"external_url\";i:96;}','yes'),
	(893,'keyword_248','a:1:{s:12:\"external_url\";i:97;}','yes'),
	(895,'keyword_249','a:1:{s:12:\"external_url\";i:98;}','yes'),
	(897,'keyword_250','a:1:{s:12:\"external_url\";i:99;}','yes'),
	(1099,'keyword_251','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:0;}','yes'),
	(1101,'keyword_252','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:1;}','yes'),
	(1103,'keyword_253','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:2;}','yes'),
	(1105,'keyword_254','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:3;}','yes'),
	(1107,'keyword_255','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:4;}','yes'),
	(1109,'keyword_256','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:5;}','yes'),
	(1111,'keyword_257','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:6;}','yes'),
	(1113,'keyword_258','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:7;}','yes'),
	(1115,'keyword_259','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:8;}','yes'),
	(1117,'keyword_260','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:9;}','yes'),
	(1139,'keyword_261','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:1;}','yes'),
	(1141,'keyword_262','a:2:{s:12:\"external_url\";s:17:\"https://yahoo.com\";s:10:\"heat_level\";i:2;}','yes'),
	(1143,'keyword_263','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:3;}','yes'),
	(1145,'keyword_264','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:4;}','yes'),
	(1155,'keyword_265','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:0;}','yes'),
	(1157,'keyword_266','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:1;}','yes'),
	(1159,'keyword_267','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:2;}','yes'),
	(1161,'keyword_268','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:3;}','yes'),
	(1163,'keyword_269','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:4;}','yes'),
	(1165,'keyword_270','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:5;}','yes'),
	(1167,'keyword_271','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:6;}','yes'),
	(1169,'keyword_272','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:7;}','yes'),
	(1171,'keyword_273','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:8;}','yes'),
	(1173,'keyword_274','a:2:{s:12:\"external_url\";s:18:\"https://google.com\";s:10:\"heat_level\";i:9;}','yes'),
	(1195,'keyword_275','a:1:{s:10:\"heat_level\";i:0;}','yes'),
	(1197,'keyword_276','a:1:{s:10:\"heat_level\";i:1;}','yes'),
	(1199,'keyword_277','a:1:{s:10:\"heat_level\";i:2;}','yes'),
	(1201,'keyword_278','a:1:{s:10:\"heat_level\";i:3;}','yes'),
	(1203,'keyword_279','a:1:{s:10:\"heat_level\";i:4;}','yes'),
	(1205,'keyword_280','a:1:{s:10:\"heat_level\";i:5;}','yes'),
	(1207,'keyword_281','a:1:{s:10:\"heat_level\";i:6;}','yes'),
	(1209,'keyword_282','a:1:{s:10:\"heat_level\";i:7;}','yes'),
	(1211,'keyword_283','a:1:{s:10:\"heat_level\";i:8;}','yes'),
	(1213,'keyword_284','a:1:{s:10:\"heat_level\";i:9;}','yes'),
	(1215,'keyword_285','a:1:{s:10:\"heat_level\";i:10;}','yes'),
	(1217,'keyword_286','a:1:{s:10:\"heat_level\";i:11;}','yes'),
	(1219,'keyword_287','a:1:{s:10:\"heat_level\";i:12;}','yes'),
	(1221,'keyword_288','a:1:{s:10:\"heat_level\";i:13;}','yes'),
	(1223,'keyword_289','a:1:{s:10:\"heat_level\";i:14;}','yes'),
	(1225,'keyword_290','a:1:{s:10:\"heat_level\";i:15;}','yes'),
	(1227,'keyword_291','a:1:{s:10:\"heat_level\";i:16;}','yes'),
	(1229,'keyword_292','a:1:{s:10:\"heat_level\";i:17;}','yes'),
	(1231,'keyword_293','a:1:{s:10:\"heat_level\";i:18;}','yes'),
	(1233,'keyword_294','a:1:{s:10:\"heat_level\";i:19;}','yes'),
	(1235,'keyword_295','a:1:{s:10:\"heat_level\";i:20;}','yes'),
	(1237,'keyword_296','a:1:{s:10:\"heat_level\";i:21;}','yes'),
	(1239,'keyword_297','a:1:{s:10:\"heat_level\";i:22;}','yes'),
	(1241,'keyword_298','a:1:{s:10:\"heat_level\";i:23;}','yes'),
	(1243,'keyword_299','a:1:{s:10:\"heat_level\";i:24;}','yes'),
	(1245,'keyword_300','a:1:{s:10:\"heat_level\";i:25;}','yes'),
	(1247,'keyword_301','a:1:{s:10:\"heat_level\";i:26;}','yes'),
	(1249,'keyword_302','a:1:{s:10:\"heat_level\";i:27;}','yes'),
	(1251,'keyword_303','a:1:{s:10:\"heat_level\";i:28;}','yes'),
	(1253,'keyword_304','a:1:{s:10:\"heat_level\";i:29;}','yes'),
	(1255,'keyword_305','a:1:{s:10:\"heat_level\";i:30;}','yes'),
	(1257,'keyword_306','a:1:{s:10:\"heat_level\";i:31;}','yes'),
	(1259,'keyword_307','a:1:{s:10:\"heat_level\";i:32;}','yes'),
	(1261,'keyword_308','a:1:{s:10:\"heat_level\";i:33;}','yes'),
	(1263,'keyword_309','a:1:{s:10:\"heat_level\";i:34;}','yes'),
	(1265,'keyword_310','a:1:{s:10:\"heat_level\";i:35;}','yes'),
	(1267,'keyword_311','a:1:{s:10:\"heat_level\";i:36;}','yes'),
	(1269,'keyword_312','a:1:{s:10:\"heat_level\";i:37;}','yes'),
	(1271,'keyword_313','a:1:{s:10:\"heat_level\";i:38;}','yes'),
	(1273,'keyword_314','a:1:{s:10:\"heat_level\";i:39;}','yes'),
	(1275,'keyword_315','a:1:{s:10:\"heat_level\";i:40;}','yes'),
	(1277,'keyword_316','a:1:{s:10:\"heat_level\";i:41;}','yes'),
	(1279,'keyword_317','a:1:{s:10:\"heat_level\";i:42;}','yes'),
	(1281,'keyword_318','a:1:{s:10:\"heat_level\";i:43;}','yes'),
	(1283,'keyword_319','a:1:{s:10:\"heat_level\";i:44;}','yes'),
	(1285,'keyword_320','a:1:{s:10:\"heat_level\";i:45;}','yes'),
	(1287,'keyword_321','a:1:{s:10:\"heat_level\";i:46;}','yes'),
	(1289,'keyword_322','a:1:{s:10:\"heat_level\";i:47;}','yes'),
	(1291,'keyword_323','a:1:{s:10:\"heat_level\";i:48;}','yes'),
	(1293,'keyword_324','a:1:{s:10:\"heat_level\";i:49;}','yes'),
	(1295,'keyword_325','a:1:{s:10:\"heat_level\";i:50;}','yes'),
	(1297,'keyword_326','a:1:{s:10:\"heat_level\";i:51;}','yes'),
	(1299,'keyword_327','a:1:{s:10:\"heat_level\";i:52;}','yes'),
	(1301,'keyword_328','a:1:{s:10:\"heat_level\";i:53;}','yes'),
	(1303,'keyword_329','a:1:{s:10:\"heat_level\";i:54;}','yes'),
	(1305,'keyword_330','a:1:{s:10:\"heat_level\";i:55;}','yes'),
	(1307,'keyword_331','a:1:{s:10:\"heat_level\";i:56;}','yes'),
	(1309,'keyword_332','a:1:{s:10:\"heat_level\";i:57;}','yes'),
	(1311,'keyword_333','a:1:{s:10:\"heat_level\";i:58;}','yes'),
	(1313,'keyword_334','a:1:{s:10:\"heat_level\";i:59;}','yes'),
	(1315,'keyword_335','a:1:{s:10:\"heat_level\";i:60;}','yes'),
	(1317,'keyword_336','a:1:{s:10:\"heat_level\";i:61;}','yes'),
	(1319,'keyword_337','a:1:{s:10:\"heat_level\";i:62;}','yes'),
	(1321,'keyword_338','a:1:{s:10:\"heat_level\";i:63;}','yes'),
	(1323,'keyword_339','a:1:{s:10:\"heat_level\";i:64;}','yes'),
	(1325,'keyword_340','a:1:{s:10:\"heat_level\";i:65;}','yes'),
	(1327,'keyword_341','a:1:{s:10:\"heat_level\";i:66;}','yes'),
	(1329,'keyword_342','a:1:{s:10:\"heat_level\";i:67;}','yes'),
	(1331,'keyword_343','a:1:{s:10:\"heat_level\";i:68;}','yes'),
	(1333,'keyword_344','a:1:{s:10:\"heat_level\";i:69;}','yes'),
	(1335,'keyword_345','a:1:{s:10:\"heat_level\";i:70;}','yes'),
	(1337,'keyword_346','a:1:{s:10:\"heat_level\";i:71;}','yes'),
	(1339,'keyword_347','a:1:{s:10:\"heat_level\";i:72;}','yes'),
	(1341,'keyword_348','a:1:{s:10:\"heat_level\";i:73;}','yes'),
	(1343,'keyword_349','a:1:{s:10:\"heat_level\";i:74;}','yes'),
	(1345,'keyword_350','a:1:{s:10:\"heat_level\";i:75;}','yes'),
	(1347,'keyword_351','a:1:{s:10:\"heat_level\";i:76;}','yes'),
	(1349,'keyword_352','a:1:{s:10:\"heat_level\";i:77;}','yes'),
	(1351,'keyword_353','a:1:{s:10:\"heat_level\";i:78;}','yes'),
	(1353,'keyword_354','a:1:{s:10:\"heat_level\";i:79;}','yes'),
	(1355,'keyword_355','a:1:{s:10:\"heat_level\";i:80;}','yes'),
	(1357,'keyword_356','a:1:{s:10:\"heat_level\";i:81;}','yes'),
	(1359,'keyword_357','a:1:{s:10:\"heat_level\";i:82;}','yes'),
	(1361,'keyword_358','a:1:{s:10:\"heat_level\";i:83;}','yes'),
	(1363,'keyword_359','a:1:{s:10:\"heat_level\";i:84;}','yes'),
	(1365,'keyword_360','a:1:{s:10:\"heat_level\";i:85;}','yes'),
	(1367,'keyword_361','a:1:{s:10:\"heat_level\";i:86;}','yes'),
	(1369,'keyword_362','a:1:{s:10:\"heat_level\";i:87;}','yes'),
	(1371,'keyword_363','a:1:{s:10:\"heat_level\";i:88;}','yes'),
	(1373,'keyword_364','a:1:{s:10:\"heat_level\";i:89;}','yes'),
	(1375,'keyword_365','a:1:{s:10:\"heat_level\";i:90;}','yes'),
	(1377,'keyword_366','a:1:{s:10:\"heat_level\";i:91;}','yes'),
	(1379,'keyword_367','a:1:{s:10:\"heat_level\";i:92;}','yes'),
	(1381,'keyword_368','a:1:{s:10:\"heat_level\";i:93;}','yes'),
	(1383,'keyword_369','a:1:{s:10:\"heat_level\";i:94;}','yes'),
	(1385,'keyword_370','a:1:{s:10:\"heat_level\";i:95;}','yes'),
	(1387,'keyword_371','a:1:{s:10:\"heat_level\";i:96;}','yes'),
	(1389,'keyword_372','a:1:{s:10:\"heat_level\";i:97;}','yes'),
	(1391,'keyword_373','a:1:{s:10:\"heat_level\";i:98;}','yes'),
	(1393,'keyword_374','a:1:{s:10:\"heat_level\";i:99;}','yes'),
	(1598,'keyword_376','a:2:{s:12:\"external_url\";i:0;s:10:\"heat_level\";i:0;}','yes'),
	(1600,'keyword_377','a:2:{s:12:\"external_url\";i:1;s:10:\"heat_level\";i:1;}','yes'),
	(1602,'keyword_378','a:2:{s:12:\"external_url\";i:2;s:10:\"heat_level\";i:2;}','yes'),
	(1604,'keyword_379','a:2:{s:12:\"external_url\";i:3;s:10:\"heat_level\";i:3;}','yes'),
	(1606,'keyword_380','a:2:{s:12:\"external_url\";i:4;s:10:\"heat_level\";i:4;}','yes'),
	(1608,'keyword_381','a:2:{s:12:\"external_url\";i:5;s:10:\"heat_level\";i:5;}','yes'),
	(1610,'keyword_382','a:2:{s:12:\"external_url\";i:6;s:10:\"heat_level\";i:6;}','yes'),
	(1612,'keyword_383','a:2:{s:12:\"external_url\";i:7;s:10:\"heat_level\";i:7;}','yes'),
	(1614,'keyword_384','a:2:{s:12:\"external_url\";i:8;s:10:\"heat_level\";i:8;}','yes'),
	(1616,'keyword_385','a:2:{s:12:\"external_url\";i:9;s:10:\"heat_level\";i:9;}','yes'),
	(1618,'keyword_386','a:2:{s:12:\"external_url\";i:10;s:10:\"heat_level\";i:10;}','yes'),
	(1620,'keyword_387','a:2:{s:12:\"external_url\";i:11;s:10:\"heat_level\";i:11;}','yes'),
	(1622,'keyword_388','a:2:{s:12:\"external_url\";i:12;s:10:\"heat_level\";i:12;}','yes'),
	(1624,'keyword_389','a:2:{s:12:\"external_url\";i:13;s:10:\"heat_level\";i:13;}','yes'),
	(1626,'keyword_390','a:2:{s:12:\"external_url\";i:14;s:10:\"heat_level\";i:14;}','yes'),
	(1628,'keyword_391','a:2:{s:12:\"external_url\";i:15;s:10:\"heat_level\";i:15;}','yes'),
	(1630,'keyword_392','a:2:{s:12:\"external_url\";i:16;s:10:\"heat_level\";i:16;}','yes'),
	(1632,'keyword_393','a:2:{s:12:\"external_url\";i:17;s:10:\"heat_level\";i:17;}','yes'),
	(1634,'keyword_394','a:2:{s:12:\"external_url\";i:18;s:10:\"heat_level\";i:18;}','yes'),
	(1636,'keyword_395','a:2:{s:12:\"external_url\";i:19;s:10:\"heat_level\";i:19;}','yes'),
	(1638,'keyword_396','a:2:{s:12:\"external_url\";i:20;s:10:\"heat_level\";i:20;}','yes'),
	(1640,'keyword_397','a:2:{s:12:\"external_url\";i:21;s:10:\"heat_level\";i:21;}','yes'),
	(1642,'keyword_398','a:2:{s:12:\"external_url\";i:22;s:10:\"heat_level\";i:22;}','yes'),
	(1644,'keyword_399','a:2:{s:12:\"external_url\";i:23;s:10:\"heat_level\";i:23;}','yes'),
	(1646,'keyword_400','a:2:{s:12:\"external_url\";i:24;s:10:\"heat_level\";i:24;}','yes'),
	(1648,'keyword_401','a:2:{s:12:\"external_url\";i:25;s:10:\"heat_level\";i:25;}','yes'),
	(1650,'keyword_402','a:2:{s:12:\"external_url\";i:26;s:10:\"heat_level\";i:26;}','yes'),
	(1652,'keyword_403','a:2:{s:12:\"external_url\";i:27;s:10:\"heat_level\";i:27;}','yes'),
	(1654,'keyword_404','a:2:{s:12:\"external_url\";i:28;s:10:\"heat_level\";i:28;}','yes'),
	(1656,'keyword_405','a:2:{s:12:\"external_url\";i:29;s:10:\"heat_level\";i:29;}','yes'),
	(1658,'keyword_406','a:2:{s:12:\"external_url\";i:30;s:10:\"heat_level\";i:30;}','yes'),
	(1660,'keyword_407','a:2:{s:12:\"external_url\";i:31;s:10:\"heat_level\";i:31;}','yes'),
	(1662,'keyword_408','a:2:{s:12:\"external_url\";i:32;s:10:\"heat_level\";i:32;}','yes'),
	(1664,'keyword_409','a:2:{s:12:\"external_url\";i:33;s:10:\"heat_level\";i:33;}','yes'),
	(1666,'keyword_410','a:2:{s:12:\"external_url\";i:34;s:10:\"heat_level\";i:34;}','yes'),
	(1668,'keyword_411','a:2:{s:12:\"external_url\";i:35;s:10:\"heat_level\";i:35;}','yes'),
	(1670,'keyword_412','a:2:{s:12:\"external_url\";i:36;s:10:\"heat_level\";i:36;}','yes'),
	(1672,'keyword_413','a:2:{s:12:\"external_url\";i:37;s:10:\"heat_level\";i:37;}','yes'),
	(1674,'keyword_414','a:2:{s:12:\"external_url\";i:38;s:10:\"heat_level\";i:38;}','yes'),
	(1676,'keyword_415','a:2:{s:12:\"external_url\";i:39;s:10:\"heat_level\";i:39;}','yes'),
	(1678,'keyword_416','a:2:{s:12:\"external_url\";i:40;s:10:\"heat_level\";i:40;}','yes'),
	(1680,'keyword_417','a:2:{s:12:\"external_url\";i:41;s:10:\"heat_level\";i:41;}','yes'),
	(1682,'keyword_418','a:2:{s:12:\"external_url\";i:42;s:10:\"heat_level\";i:42;}','yes'),
	(1684,'keyword_419','a:2:{s:12:\"external_url\";i:43;s:10:\"heat_level\";i:43;}','yes'),
	(1686,'keyword_420','a:2:{s:12:\"external_url\";i:44;s:10:\"heat_level\";i:44;}','yes'),
	(1688,'keyword_421','a:2:{s:12:\"external_url\";i:45;s:10:\"heat_level\";i:45;}','yes'),
	(1690,'keyword_422','a:2:{s:12:\"external_url\";i:46;s:10:\"heat_level\";i:46;}','yes'),
	(1692,'keyword_423','a:2:{s:12:\"external_url\";i:47;s:10:\"heat_level\";i:47;}','yes'),
	(1694,'keyword_424','a:2:{s:12:\"external_url\";i:48;s:10:\"heat_level\";i:48;}','yes'),
	(1696,'keyword_425','a:2:{s:12:\"external_url\";i:49;s:10:\"heat_level\";i:49;}','yes'),
	(1847,'finished_splitting_shared_terms','0','yes'),
	(1848,'site_icon','0','yes'),
	(1849,'medium_large_size_w','768','yes'),
	(1850,'medium_large_size_h','0','yes'),
	(1851,'_transient_doing_cron','1496266237.6518609523773193359375','yes'),
	(1852,'secure_auth_key','~:`O5WDk;FPqM2o8.%I_L; 7Gi2&%A~Z#ECi=jaxf3O?tU5`TySv6OP!JYRKF4Z2','no'),
	(1861,'_site_transient_timeout_available_translations','1496277041','no'),
	(1862,'_site_transient_available_translations','a:108:{s:2:\"af\";a:8:{s:8:\"language\";s:2:\"af\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-27 04:32:49\";s:12:\"english_name\";s:9:\"Afrikaans\";s:11:\"native_name\";s:9:\"Afrikaans\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/af.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"af\";i:2;s:3:\"afr\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:10:\"Gaan voort\";}}s:3:\"ary\";a:8:{s:8:\"language\";s:3:\"ary\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:42:35\";s:12:\"english_name\";s:15:\"Moroccan Arabic\";s:11:\"native_name\";s:31:\"العربية المغربية\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.4/ary.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ar\";i:3;s:3:\"ary\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:16:\"المتابعة\";}}s:2:\"ar\";a:8:{s:8:\"language\";s:2:\"ar\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:49:08\";s:12:\"english_name\";s:6:\"Arabic\";s:11:\"native_name\";s:14:\"العربية\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/ar.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ar\";i:2;s:3:\"ara\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:16:\"المتابعة\";}}s:2:\"as\";a:8:{s:8:\"language\";s:2:\"as\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-22 18:59:07\";s:12:\"english_name\";s:8:\"Assamese\";s:11:\"native_name\";s:21:\"অসমীয়া\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/as.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"as\";i:2;s:3:\"asm\";i:3;s:3:\"asm\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:0:\"\";}}s:2:\"az\";a:8:{s:8:\"language\";s:2:\"az\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-06 00:09:27\";s:12:\"english_name\";s:11:\"Azerbaijani\";s:11:\"native_name\";s:16:\"Azərbaycan dili\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/az.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"az\";i:2;s:3:\"aze\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:5:\"Davam\";}}s:3:\"azb\";a:8:{s:8:\"language\";s:3:\"azb\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-09-12 20:34:31\";s:12:\"english_name\";s:17:\"South Azerbaijani\";s:11:\"native_name\";s:29:\"گؤنئی آذربایجان\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/azb.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"az\";i:3;s:3:\"azb\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:3:\"bel\";a:8:{s:8:\"language\";s:3:\"bel\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-09 11:39:31\";s:12:\"english_name\";s:10:\"Belarusian\";s:11:\"native_name\";s:29:\"Беларуская мова\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.4/bel.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"be\";i:2;s:3:\"bel\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:20:\"Працягнуць\";}}s:5:\"bg_BG\";a:8:{s:8:\"language\";s:5:\"bg_BG\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-16 13:06:08\";s:12:\"english_name\";s:9:\"Bulgarian\";s:11:\"native_name\";s:18:\"Български\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/bg_BG.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"bg\";i:2;s:3:\"bul\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"Напред\";}}s:5:\"bn_BD\";a:8:{s:8:\"language\";s:5:\"bn_BD\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-04 16:58:43\";s:12:\"english_name\";s:7:\"Bengali\";s:11:\"native_name\";s:15:\"বাংলা\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/bn_BD.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"bn\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:23:\"এগিয়ে চল.\";}}s:2:\"bo\";a:8:{s:8:\"language\";s:2:\"bo\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-09-05 09:44:12\";s:12:\"english_name\";s:7:\"Tibetan\";s:11:\"native_name\";s:21:\"བོད་ཡིག\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/bo.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"bo\";i:2;s:3:\"tib\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:24:\"མུ་མཐུད།\";}}s:5:\"bs_BA\";a:8:{s:8:\"language\";s:5:\"bs_BA\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-09-04 20:20:28\";s:12:\"english_name\";s:7:\"Bosnian\";s:11:\"native_name\";s:8:\"Bosanski\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/bs_BA.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"bs\";i:2;s:3:\"bos\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:7:\"Nastavi\";}}s:2:\"ca\";a:8:{s:8:\"language\";s:2:\"ca\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-12 09:29:39\";s:12:\"english_name\";s:7:\"Catalan\";s:11:\"native_name\";s:7:\"Català\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/ca.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ca\";i:2;s:3:\"cat\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continua\";}}s:3:\"ceb\";a:8:{s:8:\"language\";s:3:\"ceb\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-03-02 17:25:51\";s:12:\"english_name\";s:7:\"Cebuano\";s:11:\"native_name\";s:7:\"Cebuano\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/ceb.zip\";s:3:\"iso\";a:2:{i:2;s:3:\"ceb\";i:3;s:3:\"ceb\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:7:\"Padayun\";}}s:5:\"cs_CZ\";a:8:{s:8:\"language\";s:5:\"cs_CZ\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-12 08:46:26\";s:12:\"english_name\";s:5:\"Czech\";s:11:\"native_name\";s:12:\"Čeština‎\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/cs_CZ.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"cs\";i:2;s:3:\"ces\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:11:\"Pokračovat\";}}s:2:\"cy\";a:8:{s:8:\"language\";s:2:\"cy\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:49:29\";s:12:\"english_name\";s:5:\"Welsh\";s:11:\"native_name\";s:7:\"Cymraeg\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/cy.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"cy\";i:2;s:3:\"cym\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Parhau\";}}s:5:\"da_DK\";a:8:{s:8:\"language\";s:5:\"da_DK\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-05 09:50:06\";s:12:\"english_name\";s:6:\"Danish\";s:11:\"native_name\";s:5:\"Dansk\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/da_DK.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"da\";i:2;s:3:\"dan\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Fortsæt\";}}s:5:\"de_CH\";a:8:{s:8:\"language\";s:5:\"de_CH\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:40:03\";s:12:\"english_name\";s:20:\"German (Switzerland)\";s:11:\"native_name\";s:17:\"Deutsch (Schweiz)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/de_CH.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"de\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Weiter\";}}s:5:\"de_DE\";a:8:{s:8:\"language\";s:5:\"de_DE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-18 13:57:42\";s:12:\"english_name\";s:6:\"German\";s:11:\"native_name\";s:7:\"Deutsch\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/de_DE.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"de\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Weiter\";}}s:12:\"de_DE_formal\";a:8:{s:8:\"language\";s:12:\"de_DE_formal\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-28 14:35:15\";s:12:\"english_name\";s:15:\"German (Formal)\";s:11:\"native_name\";s:13:\"Deutsch (Sie)\";s:7:\"package\";s:71:\"https://downloads.wordpress.org/translation/core/4.7.4/de_DE_formal.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"de\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Weiter\";}}s:14:\"de_CH_informal\";a:8:{s:8:\"language\";s:14:\"de_CH_informal\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:39:59\";s:12:\"english_name\";s:30:\"German (Switzerland, Informal)\";s:11:\"native_name\";s:21:\"Deutsch (Schweiz, Du)\";s:7:\"package\";s:73:\"https://downloads.wordpress.org/translation/core/4.7.4/de_CH_informal.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"de\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Weiter\";}}s:3:\"dzo\";a:8:{s:8:\"language\";s:3:\"dzo\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-06-29 08:59:03\";s:12:\"english_name\";s:8:\"Dzongkha\";s:11:\"native_name\";s:18:\"རྫོང་ཁ\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/dzo.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"dz\";i:2;s:3:\"dzo\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:0:\"\";}}s:2:\"el\";a:8:{s:8:\"language\";s:2:\"el\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-11 20:10:39\";s:12:\"english_name\";s:5:\"Greek\";s:11:\"native_name\";s:16:\"Ελληνικά\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/el.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"el\";i:2;s:3:\"ell\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:16:\"Συνέχεια\";}}s:5:\"en_ZA\";a:8:{s:8:\"language\";s:5:\"en_ZA\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:53:43\";s:12:\"english_name\";s:22:\"English (South Africa)\";s:11:\"native_name\";s:22:\"English (South Africa)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/en_ZA.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"en\";i:2;s:3:\"eng\";i:3;s:3:\"eng\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:5:\"en_CA\";a:8:{s:8:\"language\";s:5:\"en_CA\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:49:34\";s:12:\"english_name\";s:16:\"English (Canada)\";s:11:\"native_name\";s:16:\"English (Canada)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/en_CA.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"en\";i:2;s:3:\"eng\";i:3;s:3:\"eng\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:5:\"en_NZ\";a:8:{s:8:\"language\";s:5:\"en_NZ\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:54:30\";s:12:\"english_name\";s:21:\"English (New Zealand)\";s:11:\"native_name\";s:21:\"English (New Zealand)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/en_NZ.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"en\";i:2;s:3:\"eng\";i:3;s:3:\"eng\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:5:\"en_GB\";a:8:{s:8:\"language\";s:5:\"en_GB\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-28 03:10:25\";s:12:\"english_name\";s:12:\"English (UK)\";s:11:\"native_name\";s:12:\"English (UK)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/en_GB.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"en\";i:2;s:3:\"eng\";i:3;s:3:\"eng\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:5:\"en_AU\";a:8:{s:8:\"language\";s:5:\"en_AU\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-27 00:40:28\";s:12:\"english_name\";s:19:\"English (Australia)\";s:11:\"native_name\";s:19:\"English (Australia)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/en_AU.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"en\";i:2;s:3:\"eng\";i:3;s:3:\"eng\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continue\";}}s:2:\"eo\";a:8:{s:8:\"language\";s:2:\"eo\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-04 18:08:49\";s:12:\"english_name\";s:9:\"Esperanto\";s:11:\"native_name\";s:9:\"Esperanto\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/eo.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"eo\";i:2;s:3:\"epo\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Daŭrigi\";}}s:5:\"es_AR\";a:8:{s:8:\"language\";s:5:\"es_AR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:41:31\";s:12:\"english_name\";s:19:\"Spanish (Argentina)\";s:11:\"native_name\";s:21:\"Español de Argentina\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_AR.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_ES\";a:8:{s:8:\"language\";s:5:\"es_ES\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-10 16:26:52\";s:12:\"english_name\";s:15:\"Spanish (Spain)\";s:11:\"native_name\";s:8:\"Español\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_ES.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"es\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_VE\";a:8:{s:8:\"language\";s:5:\"es_VE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-23 23:02:31\";s:12:\"english_name\";s:19:\"Spanish (Venezuela)\";s:11:\"native_name\";s:21:\"Español de Venezuela\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_VE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_CL\";a:8:{s:8:\"language\";s:5:\"es_CL\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-28 20:09:49\";s:12:\"english_name\";s:15:\"Spanish (Chile)\";s:11:\"native_name\";s:17:\"Español de Chile\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/es_CL.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_PE\";a:8:{s:8:\"language\";s:5:\"es_PE\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-09-09 09:36:22\";s:12:\"english_name\";s:14:\"Spanish (Peru)\";s:11:\"native_name\";s:17:\"Español de Perú\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/es_PE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_CO\";a:8:{s:8:\"language\";s:5:\"es_CO\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:54:37\";s:12:\"english_name\";s:18:\"Spanish (Colombia)\";s:11:\"native_name\";s:20:\"Español de Colombia\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_CO.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_GT\";a:8:{s:8:\"language\";s:5:\"es_GT\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:54:37\";s:12:\"english_name\";s:19:\"Spanish (Guatemala)\";s:11:\"native_name\";s:21:\"Español de Guatemala\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_GT.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"es_MX\";a:8:{s:8:\"language\";s:5:\"es_MX\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:42:28\";s:12:\"english_name\";s:16:\"Spanish (Mexico)\";s:11:\"native_name\";s:19:\"Español de México\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/es_MX.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"es\";i:2;s:3:\"spa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:2:\"et\";a:8:{s:8:\"language\";s:2:\"et\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-27 16:37:11\";s:12:\"english_name\";s:8:\"Estonian\";s:11:\"native_name\";s:5:\"Eesti\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/et.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"et\";i:2;s:3:\"est\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Jätka\";}}s:2:\"eu\";a:8:{s:8:\"language\";s:2:\"eu\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-12 06:40:28\";s:12:\"english_name\";s:6:\"Basque\";s:11:\"native_name\";s:7:\"Euskara\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/eu.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"eu\";i:2;s:3:\"eus\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Jarraitu\";}}s:5:\"fa_IR\";a:8:{s:8:\"language\";s:5:\"fa_IR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-02-02 15:21:03\";s:12:\"english_name\";s:7:\"Persian\";s:11:\"native_name\";s:10:\"فارسی\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/fa_IR.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"fa\";i:2;s:3:\"fas\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:10:\"ادامه\";}}s:2:\"fi\";a:8:{s:8:\"language\";s:2:\"fi\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:42:25\";s:12:\"english_name\";s:7:\"Finnish\";s:11:\"native_name\";s:5:\"Suomi\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/fi.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"fi\";i:2;s:3:\"fin\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:5:\"Jatka\";}}s:5:\"fr_CA\";a:8:{s:8:\"language\";s:5:\"fr_CA\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-02-03 21:08:25\";s:12:\"english_name\";s:15:\"French (Canada)\";s:11:\"native_name\";s:19:\"Français du Canada\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/fr_CA.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"fr\";i:2;s:3:\"fra\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuer\";}}s:5:\"fr_BE\";a:8:{s:8:\"language\";s:5:\"fr_BE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:40:32\";s:12:\"english_name\";s:16:\"French (Belgium)\";s:11:\"native_name\";s:21:\"Français de Belgique\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/fr_BE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"fr\";i:2;s:3:\"fra\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuer\";}}s:5:\"fr_FR\";a:8:{s:8:\"language\";s:5:\"fr_FR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-05 12:10:24\";s:12:\"english_name\";s:15:\"French (France)\";s:11:\"native_name\";s:9:\"Français\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/fr_FR.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"fr\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuer\";}}s:2:\"gd\";a:8:{s:8:\"language\";s:2:\"gd\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-08-23 17:41:37\";s:12:\"english_name\";s:15:\"Scottish Gaelic\";s:11:\"native_name\";s:9:\"Gàidhlig\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/gd.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"gd\";i:2;s:3:\"gla\";i:3;s:3:\"gla\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:15:\"Lean air adhart\";}}s:5:\"gl_ES\";a:8:{s:8:\"language\";s:5:\"gl_ES\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:40:27\";s:12:\"english_name\";s:8:\"Galician\";s:11:\"native_name\";s:6:\"Galego\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/gl_ES.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"gl\";i:2;s:3:\"glg\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:2:\"gu\";a:8:{s:8:\"language\";s:2:\"gu\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-21 14:17:42\";s:12:\"english_name\";s:8:\"Gujarati\";s:11:\"native_name\";s:21:\"ગુજરાતી\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/gu.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"gu\";i:2;s:3:\"guj\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:31:\"ચાલુ રાખવું\";}}s:3:\"haz\";a:8:{s:8:\"language\";s:3:\"haz\";s:7:\"version\";s:5:\"4.4.2\";s:7:\"updated\";s:19:\"2015-12-05 00:59:09\";s:12:\"english_name\";s:8:\"Hazaragi\";s:11:\"native_name\";s:15:\"هزاره گی\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.4.2/haz.zip\";s:3:\"iso\";a:1:{i:3;s:3:\"haz\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:10:\"ادامه\";}}s:5:\"he_IL\";a:8:{s:8:\"language\";s:5:\"he_IL\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-29 21:21:10\";s:12:\"english_name\";s:6:\"Hebrew\";s:11:\"native_name\";s:16:\"עִבְרִית\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/he_IL.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"he\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"המשך\";}}s:5:\"hi_IN\";a:8:{s:8:\"language\";s:5:\"hi_IN\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-01 10:53:22\";s:12:\"english_name\";s:5:\"Hindi\";s:11:\"native_name\";s:18:\"हिन्दी\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/hi_IN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"hi\";i:2;s:3:\"hin\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"जारी\";}}s:2:\"hr\";a:8:{s:8:\"language\";s:2:\"hr\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-28 13:34:22\";s:12:\"english_name\";s:8:\"Croatian\";s:11:\"native_name\";s:8:\"Hrvatski\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/hr.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"hr\";i:2;s:3:\"hrv\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:7:\"Nastavi\";}}s:5:\"hu_HU\";a:8:{s:8:\"language\";s:5:\"hu_HU\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:48:39\";s:12:\"english_name\";s:9:\"Hungarian\";s:11:\"native_name\";s:6:\"Magyar\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/hu_HU.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"hu\";i:2;s:3:\"hun\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:10:\"Folytatás\";}}s:2:\"hy\";a:8:{s:8:\"language\";s:2:\"hy\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-12-03 16:21:10\";s:12:\"english_name\";s:8:\"Armenian\";s:11:\"native_name\";s:14:\"Հայերեն\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/hy.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"hy\";i:2;s:3:\"hye\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:20:\"Շարունակել\";}}s:5:\"id_ID\";a:8:{s:8:\"language\";s:5:\"id_ID\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-02 14:01:52\";s:12:\"english_name\";s:10:\"Indonesian\";s:11:\"native_name\";s:16:\"Bahasa Indonesia\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/id_ID.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"id\";i:2;s:3:\"ind\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Lanjutkan\";}}s:5:\"is_IS\";a:8:{s:8:\"language\";s:5:\"is_IS\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-13 13:55:54\";s:12:\"english_name\";s:9:\"Icelandic\";s:11:\"native_name\";s:9:\"Íslenska\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/is_IS.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"is\";i:2;s:3:\"isl\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Áfram\";}}s:5:\"it_IT\";a:8:{s:8:\"language\";s:5:\"it_IT\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-08 04:57:54\";s:12:\"english_name\";s:7:\"Italian\";s:11:\"native_name\";s:8:\"Italiano\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/it_IT.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"it\";i:2;s:3:\"ita\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Continua\";}}s:2:\"ja\";a:8:{s:8:\"language\";s:2:\"ja\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-02 05:13:51\";s:12:\"english_name\";s:8:\"Japanese\";s:11:\"native_name\";s:9:\"日本語\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/ja.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"ja\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"続ける\";}}s:5:\"ka_GE\";a:8:{s:8:\"language\";s:5:\"ka_GE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-05 06:17:00\";s:12:\"english_name\";s:8:\"Georgian\";s:11:\"native_name\";s:21:\"ქართული\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/ka_GE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ka\";i:2;s:3:\"kat\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:30:\"გაგრძელება\";}}s:3:\"kab\";a:8:{s:8:\"language\";s:3:\"kab\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:39:13\";s:12:\"english_name\";s:6:\"Kabyle\";s:11:\"native_name\";s:9:\"Taqbaylit\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/kab.zip\";s:3:\"iso\";a:2:{i:2;s:3:\"kab\";i:3;s:3:\"kab\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Kemmel\";}}s:2:\"km\";a:8:{s:8:\"language\";s:2:\"km\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-12-07 02:07:59\";s:12:\"english_name\";s:5:\"Khmer\";s:11:\"native_name\";s:27:\"ភាសាខ្មែរ\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/km.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"km\";i:2;s:3:\"khm\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"បន្ត\";}}s:5:\"ko_KR\";a:8:{s:8:\"language\";s:5:\"ko_KR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-18 05:09:08\";s:12:\"english_name\";s:6:\"Korean\";s:11:\"native_name\";s:9:\"한국어\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/ko_KR.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ko\";i:2;s:3:\"kor\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"계속\";}}s:3:\"ckb\";a:8:{s:8:\"language\";s:3:\"ckb\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:48:25\";s:12:\"english_name\";s:16:\"Kurdish (Sorani)\";s:11:\"native_name\";s:13:\"كوردی‎\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/ckb.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ku\";i:3;s:3:\"ckb\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:30:\"به‌رده‌وام به‌\";}}s:2:\"lo\";a:8:{s:8:\"language\";s:2:\"lo\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-12 09:59:23\";s:12:\"english_name\";s:3:\"Lao\";s:11:\"native_name\";s:21:\"ພາສາລາວ\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/lo.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"lo\";i:2;s:3:\"lao\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:18:\"ຕໍ່​ໄປ\";}}s:5:\"lt_LT\";a:8:{s:8:\"language\";s:5:\"lt_LT\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-30 09:46:13\";s:12:\"english_name\";s:10:\"Lithuanian\";s:11:\"native_name\";s:15:\"Lietuvių kalba\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/lt_LT.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"lt\";i:2;s:3:\"lit\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Tęsti\";}}s:2:\"lv\";a:8:{s:8:\"language\";s:2:\"lv\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-17 20:40:40\";s:12:\"english_name\";s:7:\"Latvian\";s:11:\"native_name\";s:16:\"Latviešu valoda\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/lv.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"lv\";i:2;s:3:\"lav\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Turpināt\";}}s:5:\"mk_MK\";a:8:{s:8:\"language\";s:5:\"mk_MK\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:54:41\";s:12:\"english_name\";s:10:\"Macedonian\";s:11:\"native_name\";s:31:\"Македонски јазик\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/mk_MK.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"mk\";i:2;s:3:\"mkd\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:16:\"Продолжи\";}}s:5:\"ml_IN\";a:8:{s:8:\"language\";s:5:\"ml_IN\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-27 03:43:32\";s:12:\"english_name\";s:9:\"Malayalam\";s:11:\"native_name\";s:18:\"മലയാളം\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/ml_IN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ml\";i:2;s:3:\"mal\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:18:\"തുടരുക\";}}s:2:\"mn\";a:8:{s:8:\"language\";s:2:\"mn\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-12 07:29:35\";s:12:\"english_name\";s:9:\"Mongolian\";s:11:\"native_name\";s:12:\"Монгол\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/mn.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"mn\";i:2;s:3:\"mon\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:24:\"Үргэлжлүүлэх\";}}s:2:\"mr\";a:8:{s:8:\"language\";s:2:\"mr\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-24 06:52:11\";s:12:\"english_name\";s:7:\"Marathi\";s:11:\"native_name\";s:15:\"मराठी\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/mr.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"mr\";i:2;s:3:\"mar\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:25:\"सुरु ठेवा\";}}s:5:\"ms_MY\";a:8:{s:8:\"language\";s:5:\"ms_MY\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-05 09:45:10\";s:12:\"english_name\";s:5:\"Malay\";s:11:\"native_name\";s:13:\"Bahasa Melayu\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/ms_MY.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ms\";i:2;s:3:\"msa\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Teruskan\";}}s:5:\"my_MM\";a:8:{s:8:\"language\";s:5:\"my_MM\";s:7:\"version\";s:6:\"4.1.18\";s:7:\"updated\";s:19:\"2015-03-26 15:57:42\";s:12:\"english_name\";s:17:\"Myanmar (Burmese)\";s:11:\"native_name\";s:15:\"ဗမာစာ\";s:7:\"package\";s:65:\"https://downloads.wordpress.org/translation/core/4.1.18/my_MM.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"my\";i:2;s:3:\"mya\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:54:\"ဆက်လက်လုပ်ဆောင်ပါ။\";}}s:5:\"nb_NO\";a:8:{s:8:\"language\";s:5:\"nb_NO\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:42:31\";s:12:\"english_name\";s:19:\"Norwegian (Bokmål)\";s:11:\"native_name\";s:13:\"Norsk bokmål\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/nb_NO.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"nb\";i:2;s:3:\"nob\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Fortsett\";}}s:5:\"ne_NP\";a:8:{s:8:\"language\";s:5:\"ne_NP\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:48:31\";s:12:\"english_name\";s:6:\"Nepali\";s:11:\"native_name\";s:18:\"नेपाली\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/ne_NP.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ne\";i:2;s:3:\"nep\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:43:\"जारी राख्नुहोस्\";}}s:12:\"nl_NL_formal\";a:8:{s:8:\"language\";s:12:\"nl_NL_formal\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-02-16 13:24:21\";s:12:\"english_name\";s:14:\"Dutch (Formal)\";s:11:\"native_name\";s:20:\"Nederlands (Formeel)\";s:7:\"package\";s:71:\"https://downloads.wordpress.org/translation/core/4.7.4/nl_NL_formal.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"nl\";i:2;s:3:\"nld\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Doorgaan\";}}s:5:\"nl_NL\";a:8:{s:8:\"language\";s:5:\"nl_NL\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-11 15:57:29\";s:12:\"english_name\";s:5:\"Dutch\";s:11:\"native_name\";s:10:\"Nederlands\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/nl_NL.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"nl\";i:2;s:3:\"nld\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Doorgaan\";}}s:5:\"nl_BE\";a:8:{s:8:\"language\";s:5:\"nl_BE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-15 08:29:44\";s:12:\"english_name\";s:15:\"Dutch (Belgium)\";s:11:\"native_name\";s:20:\"Nederlands (België)\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/nl_BE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"nl\";i:2;s:3:\"nld\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Doorgaan\";}}s:5:\"nn_NO\";a:8:{s:8:\"language\";s:5:\"nn_NO\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:40:57\";s:12:\"english_name\";s:19:\"Norwegian (Nynorsk)\";s:11:\"native_name\";s:13:\"Norsk nynorsk\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/nn_NO.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"nn\";i:2;s:3:\"nno\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Hald fram\";}}s:3:\"oci\";a:8:{s:8:\"language\";s:3:\"oci\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-02 13:47:38\";s:12:\"english_name\";s:7:\"Occitan\";s:11:\"native_name\";s:7:\"Occitan\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/oci.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"oc\";i:2;s:3:\"oci\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Contunhar\";}}s:5:\"pa_IN\";a:8:{s:8:\"language\";s:5:\"pa_IN\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-16 05:19:43\";s:12:\"english_name\";s:7:\"Punjabi\";s:11:\"native_name\";s:18:\"ਪੰਜਾਬੀ\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/pa_IN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"pa\";i:2;s:3:\"pan\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:25:\"ਜਾਰੀ ਰੱਖੋ\";}}s:5:\"pl_PL\";a:8:{s:8:\"language\";s:5:\"pl_PL\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-23 09:31:28\";s:12:\"english_name\";s:6:\"Polish\";s:11:\"native_name\";s:6:\"Polski\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/pl_PL.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"pl\";i:2;s:3:\"pol\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Kontynuuj\";}}s:2:\"ps\";a:8:{s:8:\"language\";s:2:\"ps\";s:7:\"version\";s:6:\"4.1.18\";s:7:\"updated\";s:19:\"2015-03-29 22:19:48\";s:12:\"english_name\";s:6:\"Pashto\";s:11:\"native_name\";s:8:\"پښتو\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.1.18/ps.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ps\";i:2;s:3:\"pus\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:19:\"دوام ورکړه\";}}s:5:\"pt_BR\";a:8:{s:8:\"language\";s:5:\"pt_BR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-17 15:02:48\";s:12:\"english_name\";s:19:\"Portuguese (Brazil)\";s:11:\"native_name\";s:20:\"Português do Brasil\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/pt_BR.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"pt\";i:2;s:3:\"por\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:5:\"pt_PT\";a:8:{s:8:\"language\";s:5:\"pt_PT\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-15 10:57:32\";s:12:\"english_name\";s:21:\"Portuguese (Portugal)\";s:11:\"native_name\";s:10:\"Português\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/pt_PT.zip\";s:3:\"iso\";a:1:{i:1;s:2:\"pt\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuar\";}}s:3:\"rhg\";a:8:{s:8:\"language\";s:3:\"rhg\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-03-16 13:03:18\";s:12:\"english_name\";s:8:\"Rohingya\";s:11:\"native_name\";s:8:\"Ruáinga\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/rhg.zip\";s:3:\"iso\";a:1:{i:3;s:3:\"rhg\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:0:\"\";}}s:5:\"ro_RO\";a:8:{s:8:\"language\";s:5:\"ro_RO\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-15 14:53:36\";s:12:\"english_name\";s:8:\"Romanian\";s:11:\"native_name\";s:8:\"Română\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/ro_RO.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ro\";i:2;s:3:\"ron\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Continuă\";}}s:5:\"ru_RU\";a:8:{s:8:\"language\";s:5:\"ru_RU\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-20 10:13:53\";s:12:\"english_name\";s:7:\"Russian\";s:11:\"native_name\";s:14:\"Русский\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/ru_RU.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ru\";i:2;s:3:\"rus\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:20:\"Продолжить\";}}s:3:\"sah\";a:8:{s:8:\"language\";s:3:\"sah\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-21 02:06:41\";s:12:\"english_name\";s:5:\"Sakha\";s:11:\"native_name\";s:14:\"Сахалыы\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/sah.zip\";s:3:\"iso\";a:2:{i:2;s:3:\"sah\";i:3;s:3:\"sah\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"Салҕаа\";}}s:5:\"si_LK\";a:8:{s:8:\"language\";s:5:\"si_LK\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-12 06:00:52\";s:12:\"english_name\";s:7:\"Sinhala\";s:11:\"native_name\";s:15:\"සිංහල\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/si_LK.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"si\";i:2;s:3:\"sin\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:44:\"දිගටම කරගෙන යන්න\";}}s:5:\"sk_SK\";a:8:{s:8:\"language\";s:5:\"sk_SK\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-10 13:48:29\";s:12:\"english_name\";s:6:\"Slovak\";s:11:\"native_name\";s:11:\"Slovenčina\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/sk_SK.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"sk\";i:2;s:3:\"slk\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"Pokračovať\";}}s:5:\"sl_SI\";a:8:{s:8:\"language\";s:5:\"sl_SI\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-02-08 17:57:45\";s:12:\"english_name\";s:9:\"Slovenian\";s:11:\"native_name\";s:13:\"Slovenščina\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/sl_SI.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"sl\";i:2;s:3:\"slv\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:8:\"Nadaljuj\";}}s:2:\"sq\";a:8:{s:8:\"language\";s:2:\"sq\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-24 08:35:30\";s:12:\"english_name\";s:8:\"Albanian\";s:11:\"native_name\";s:5:\"Shqip\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/sq.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"sq\";i:2;s:3:\"sqi\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"Vazhdo\";}}s:5:\"sr_RS\";a:8:{s:8:\"language\";s:5:\"sr_RS\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:41:03\";s:12:\"english_name\";s:7:\"Serbian\";s:11:\"native_name\";s:23:\"Српски језик\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/sr_RS.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"sr\";i:2;s:3:\"srp\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:14:\"Настави\";}}s:5:\"sv_SE\";a:8:{s:8:\"language\";s:5:\"sv_SE\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-03 00:34:10\";s:12:\"english_name\";s:7:\"Swedish\";s:11:\"native_name\";s:7:\"Svenska\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/sv_SE.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"sv\";i:2;s:3:\"swe\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:9:\"Fortsätt\";}}s:3:\"szl\";a:8:{s:8:\"language\";s:3:\"szl\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-09-24 19:58:14\";s:12:\"english_name\";s:8:\"Silesian\";s:11:\"native_name\";s:17:\"Ślōnskŏ gŏdka\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/szl.zip\";s:3:\"iso\";a:1:{i:3;s:3:\"szl\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:13:\"Kōntynuować\";}}s:5:\"ta_IN\";a:8:{s:8:\"language\";s:5:\"ta_IN\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-27 03:22:47\";s:12:\"english_name\";s:5:\"Tamil\";s:11:\"native_name\";s:15:\"தமிழ்\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/ta_IN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ta\";i:2;s:3:\"tam\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:24:\"தொடரவும்\";}}s:2:\"te\";a:8:{s:8:\"language\";s:2:\"te\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:47:39\";s:12:\"english_name\";s:6:\"Telugu\";s:11:\"native_name\";s:18:\"తెలుగు\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/te.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"te\";i:2;s:3:\"tel\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:30:\"కొనసాగించు\";}}s:2:\"th\";a:8:{s:8:\"language\";s:2:\"th\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2017-01-26 15:48:43\";s:12:\"english_name\";s:4:\"Thai\";s:11:\"native_name\";s:9:\"ไทย\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/th.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"th\";i:2;s:3:\"tha\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:15:\"ต่อไป\";}}s:2:\"tl\";a:8:{s:8:\"language\";s:2:\"tl\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-12-30 02:38:08\";s:12:\"english_name\";s:7:\"Tagalog\";s:11:\"native_name\";s:7:\"Tagalog\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.2/tl.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"tl\";i:2;s:3:\"tgl\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:10:\"Magpatuloy\";}}s:5:\"tr_TR\";a:8:{s:8:\"language\";s:5:\"tr_TR\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-15 09:03:35\";s:12:\"english_name\";s:7:\"Turkish\";s:11:\"native_name\";s:8:\"Türkçe\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/tr_TR.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"tr\";i:2;s:3:\"tur\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:5:\"Devam\";}}s:5:\"tt_RU\";a:8:{s:8:\"language\";s:5:\"tt_RU\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-11-20 20:20:50\";s:12:\"english_name\";s:5:\"Tatar\";s:11:\"native_name\";s:19:\"Татар теле\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/tt_RU.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"tt\";i:2;s:3:\"tat\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:17:\"дәвам итү\";}}s:3:\"tah\";a:8:{s:8:\"language\";s:3:\"tah\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-03-06 18:39:39\";s:12:\"english_name\";s:8:\"Tahitian\";s:11:\"native_name\";s:10:\"Reo Tahiti\";s:7:\"package\";s:62:\"https://downloads.wordpress.org/translation/core/4.7.2/tah.zip\";s:3:\"iso\";a:3:{i:1;s:2:\"ty\";i:2;s:3:\"tah\";i:3;s:3:\"tah\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:0:\"\";}}s:5:\"ug_CN\";a:8:{s:8:\"language\";s:5:\"ug_CN\";s:7:\"version\";s:5:\"4.7.2\";s:7:\"updated\";s:19:\"2016-12-05 09:23:39\";s:12:\"english_name\";s:6:\"Uighur\";s:11:\"native_name\";s:9:\"Uyƣurqə\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.2/ug_CN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ug\";i:2;s:3:\"uig\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:26:\"داۋاملاشتۇرۇش\";}}s:2:\"uk\";a:8:{s:8:\"language\";s:2:\"uk\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-17 03:13:31\";s:12:\"english_name\";s:9:\"Ukrainian\";s:11:\"native_name\";s:20:\"Українська\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/uk.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"uk\";i:2;s:3:\"ukr\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:20:\"Продовжити\";}}s:2:\"ur\";a:8:{s:8:\"language\";s:2:\"ur\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-27 07:08:07\";s:12:\"english_name\";s:4:\"Urdu\";s:11:\"native_name\";s:8:\"اردو\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/ur.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"ur\";i:2;s:3:\"urd\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:19:\"جاری رکھیں\";}}s:5:\"uz_UZ\";a:8:{s:8:\"language\";s:5:\"uz_UZ\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-13 09:55:38\";s:12:\"english_name\";s:5:\"Uzbek\";s:11:\"native_name\";s:11:\"O‘zbekcha\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/uz_UZ.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"uz\";i:2;s:3:\"uzb\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:11:\"Davom etish\";}}s:2:\"vi\";a:8:{s:8:\"language\";s:2:\"vi\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-04-10 15:33:37\";s:12:\"english_name\";s:10:\"Vietnamese\";s:11:\"native_name\";s:14:\"Tiếng Việt\";s:7:\"package\";s:61:\"https://downloads.wordpress.org/translation/core/4.7.4/vi.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"vi\";i:2;s:3:\"vie\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:12:\"Tiếp tục\";}}s:5:\"zh_CN\";a:8:{s:8:\"language\";s:5:\"zh_CN\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-01-26 15:54:45\";s:12:\"english_name\";s:15:\"Chinese (China)\";s:11:\"native_name\";s:12:\"简体中文\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/zh_CN.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"zh\";i:2;s:3:\"zho\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"继续\";}}s:5:\"zh_TW\";a:8:{s:8:\"language\";s:5:\"zh_TW\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-05-08 04:16:08\";s:12:\"english_name\";s:16:\"Chinese (Taiwan)\";s:11:\"native_name\";s:12:\"繁體中文\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/zh_TW.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"zh\";i:2;s:3:\"zho\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"繼續\";}}s:5:\"zh_HK\";a:8:{s:8:\"language\";s:5:\"zh_HK\";s:7:\"version\";s:5:\"4.7.4\";s:7:\"updated\";s:19:\"2017-03-28 12:03:30\";s:12:\"english_name\";s:19:\"Chinese (Hong Kong)\";s:11:\"native_name\";s:16:\"香港中文版	\";s:7:\"package\";s:64:\"https://downloads.wordpress.org/translation/core/4.7.4/zh_HK.zip\";s:3:\"iso\";a:2:{i:1;s:2:\"zh\";i:2;s:3:\"zho\";}s:7:\"strings\";a:1:{s:8:\"continue\";s:6:\"繼續\";}}}','no');

/*!40000 ALTER TABLE `taco_phpunit_test_options` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_postmeta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_postmeta`;

CREATE TABLE `taco_phpunit_test_postmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `post_id` (`post_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_postmeta` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_postmeta` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_postmeta` (`meta_id`, `post_id`, `meta_key`, `meta_value`)
VALUES
	(1,2,'_wp_page_template','default'),
	(2,4,'is_active','1');

/*!40000 ALTER TABLE `taco_phpunit_test_postmeta` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_posts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_posts`;

CREATE TABLE `taco_phpunit_test_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(255) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_name` (`post_name`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_posts` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_posts` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`)
VALUES
	(1,1,'2014-11-12 02:15:27','2014-11-12 02:15:27','Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!','Hello world!','','publish','open','open','','hello-world','','','2014-11-12 02:15:27','2014-11-12 02:15:27','',0,'http://taco-phpunit-test.vera/?p=1',0,'post','',1),
	(2,1,'2014-11-12 02:15:27','2014-11-12 02:15:27','This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:\n\n<blockquote>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my blog. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</blockquote>\n\n...or something like this:\n\n<blockquote>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</blockquote>\n\nAs a new WordPress user, you should go to <a href=\"http://taco-phpunit-test.vera/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!','Sample Page','','publish','open','open','','sample-page','','','2014-11-12 02:15:27','2014-11-12 02:15:27','',0,'http://taco-phpunit-test.vera/?page_id=2',0,'page','',0),
	(3,1,'2014-11-12 02:15:40','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2014-11-12 02:15:40','0000-00-00 00:00:00','',0,'http://taco-phpunit-test.vera/?p=3',0,'post','',0),
	(4,1,'2014-11-12 02:16:08','2014-11-12 02:16:08','','Default','','publish','open','open','','default','','','2014-11-12 02:16:08','2014-11-12 02:16:08','',0,'http://taco-phpunit-test.vera/?p=4',0,'theme-option','',0),
	(490,0,'2016-05-10 21:35:15','2016-05-10 21:35:15','','Jane','','publish','open','open','','jane','','','2016-05-10 21:35:15','2016-05-10 21:35:15','',0,'http://taco-phpunit-test.vera/person/jane/',0,'person','',0);

/*!40000 ALTER TABLE `taco_phpunit_test_posts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_term_relationships
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_term_relationships`;

CREATE TABLE `taco_phpunit_test_term_relationships` (
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_taxonomy_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `term_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`object_id`,`term_taxonomy_id`),
  KEY `term_taxonomy_id` (`term_taxonomy_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_term_relationships` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_term_relationships` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`)
VALUES
	(1,1,0);

/*!40000 ALTER TABLE `taco_phpunit_test_term_relationships` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_term_taxonomy
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_term_taxonomy`;

CREATE TABLE `taco_phpunit_test_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `taxonomy` varchar(32) NOT NULL DEFAULT '',
  `description` longtext NOT NULL,
  `parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_term_taxonomy` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_term_taxonomy` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`)
VALUES
	(1,1,'category','',0,1),
	(2,2,'irs','',0,0),
	(475,475,'keyword','',0,0),
	(474,474,'keyword','',0,0),
	(473,473,'keyword','',0,0),
	(472,472,'keyword','',0,0),
	(471,471,'keyword','',0,0),
	(470,470,'keyword','',0,0),
	(469,469,'keyword','',0,0),
	(426,426,'keyword','',0,0),
	(427,427,'keyword','',0,0),
	(428,428,'keyword','',0,0),
	(429,429,'keyword','',0,0),
	(430,430,'keyword','',0,0),
	(431,431,'keyword','',0,0),
	(432,432,'keyword','',0,0),
	(433,433,'keyword','',0,0),
	(434,434,'keyword','',0,0),
	(435,435,'keyword','',0,0),
	(436,436,'keyword','',0,0),
	(437,437,'keyword','',0,0),
	(438,438,'keyword','',0,0),
	(439,439,'keyword','',0,0),
	(440,440,'keyword','',0,0),
	(441,441,'keyword','',0,0),
	(442,442,'keyword','',0,0),
	(443,443,'keyword','',0,0),
	(444,444,'keyword','',0,0),
	(445,445,'keyword','',0,0),
	(446,446,'keyword','',0,0),
	(447,447,'keyword','',0,0),
	(448,448,'keyword','',0,0),
	(449,449,'keyword','',0,0),
	(450,450,'keyword','',0,0),
	(451,451,'keyword','',0,0),
	(452,452,'keyword','',0,0),
	(453,453,'keyword','',0,0),
	(454,454,'keyword','',0,0),
	(455,455,'keyword','',0,0),
	(456,456,'keyword','',0,0),
	(457,457,'keyword','',0,0),
	(458,458,'keyword','',0,0),
	(459,459,'keyword','',0,0),
	(460,460,'keyword','',0,0),
	(461,461,'keyword','',0,0),
	(462,462,'keyword','',0,0),
	(463,463,'keyword','',0,0),
	(464,464,'keyword','',0,0),
	(465,465,'keyword','',0,0),
	(466,466,'keyword','',0,0),
	(467,467,'keyword','',0,0),
	(468,468,'keyword','',0,0);

/*!40000 ALTER TABLE `taco_phpunit_test_term_taxonomy` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_termmeta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_termmeta`;

CREATE TABLE `taco_phpunit_test_termmeta` (
  `meta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`meta_id`),
  KEY `term_id` (`term_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table taco_phpunit_test_terms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_terms`;

CREATE TABLE `taco_phpunit_test_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `slug` varchar(200) NOT NULL DEFAULT '',
  `term_group` bigint(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_terms` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_terms` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_terms` (`term_id`, `name`, `slug`, `term_group`)
VALUES
	(1,'Uncategorized','uncategorized',0);

/*!40000 ALTER TABLE `taco_phpunit_test_terms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_usermeta
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_usermeta`;

CREATE TABLE `taco_phpunit_test_usermeta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `meta_key` varchar(255) DEFAULT NULL,
  `meta_value` longtext,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`),
  KEY `meta_key` (`meta_key`(191))
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_usermeta` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_usermeta` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_usermeta` (`umeta_id`, `user_id`, `meta_key`, `meta_value`)
VALUES
	(1,1,'nickname','admin'),
	(2,1,'first_name',''),
	(3,1,'last_name',''),
	(4,1,'description',''),
	(5,1,'rich_editing','true'),
	(6,1,'comment_shortcuts','false'),
	(7,1,'admin_color','fresh'),
	(8,1,'use_ssl','0'),
	(9,1,'show_admin_bar_front','true'),
	(10,1,'taco_phpunit_test_capabilities','a:1:{s:13:\"administrator\";b:1;}'),
	(11,1,'taco_phpunit_test_user_level','10'),
	(12,1,'dismissed_wp_pointers','wp350_media,wp360_revisions,wp360_locks,wp390_widgets'),
	(13,1,'show_welcome_panel','0'),
	(15,1,'taco_phpunit_test_dashboard_quick_press_last_post_id','3'),
	(16,1,'closedpostboxes_dashboard','a:0:{}'),
	(17,1,'metaboxhidden_dashboard','a:4:{i:0;s:19:\"dashboard_right_now\";i:1;s:18:\"dashboard_activity\";i:2;s:21:\"dashboard_quick_press\";i:3;s:17:\"dashboard_primary\";}'),
	(18,1,'session_tokens','a:3:{s:64:\"125bc8e9fb66d2a48093623b551ca6487680a5050e23258fd6e9164d3340f11e\";a:4:{s:10:\"expiration\";i:1496438466;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:121:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36\";s:5:\"login\";i:1496265666;}s:64:\"2343162283221f70c7d4d58a40059331ee3cb503fb167ef11dc84d2f2661e355\";a:4:{s:10:\"expiration\";i:1496439065;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:121:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36\";s:5:\"login\";i:1496266265;}s:64:\"90911041996afee6e97b288cb0d84f781b830a6d33793690ca7da5a7bd67405d\";a:4:{s:10:\"expiration\";i:1496441479;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:121:\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36\";s:5:\"login\";i:1496268679;}}'),
	(20,1,'locale',''),
	(19,1,'default_password_nag','');

/*!40000 ALTER TABLE `taco_phpunit_test_usermeta` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taco_phpunit_test_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taco_phpunit_test_users`;

CREATE TABLE `taco_phpunit_test_users` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(255) NOT NULL DEFAULT '',
  `user_nicename` varchar(50) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_url` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_activation_key` varchar(255) NOT NULL DEFAULT '',
  `user_status` int(11) NOT NULL DEFAULT '0',
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`),
  KEY `user_email` (`user_email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `taco_phpunit_test_users` WRITE;
/*!40000 ALTER TABLE `taco_phpunit_test_users` DISABLE KEYS */;

INSERT INTO `taco_phpunit_test_users` (`ID`, `user_login`, `user_pass`, `user_nicename`, `user_email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`)
VALUES
	(1,'admin','$P$BVuggYPf038CrG5uQ0d4QHK/aHBU9x1','admin','admin@127.0.0.1','','2015-01-01 00:00:00','',0,'admin');

/*!40000 ALTER TABLE `taco_phpunit_test_users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
