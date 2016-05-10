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
	(1,'siteurl','http://taco-phpunit-test.dev','yes'),
	(2,'home','http://taco-phpunit-test.dev','yes'),
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
	(49,'db_version','36686','yes'),
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
	(99,'_site_transient_update_plugins','O:8:\"stdClass\":5:{s:12:\"last_checked\";i:1420670640;s:7:\"checked\";a:1:{s:27:\"taco_person/taco_person.php\";s:0:\"\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}s:9:\"no_update\";a:0:{}}','yes'),
	(102,'_site_transient_update_themes','O:8:\"stdClass\":4:{s:12:\"last_checked\";i:1420670382;s:7:\"checked\";a:1:{s:3:\"app\";s:0:\"\";}s:8:\"response\";a:0:{}s:12:\"translations\";a:0:{}}','yes'),
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
	(122,'rewrite_rules','a:129:{s:11:\"^wp-json/?$\";s:22:\"index.php?rest_route=/\";s:14:\"^wp-json/(.*)?\";s:33:\"index.php?rest_route=/$matches[1]\";s:47:\"category/(.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:42:\"category/(.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:52:\"index.php?category_name=$matches[1]&feed=$matches[2]\";s:23:\"category/(.+?)/embed/?$\";s:46:\"index.php?category_name=$matches[1]&embed=true\";s:35:\"category/(.+?)/page/?([0-9]{1,})/?$\";s:53:\"index.php?category_name=$matches[1]&paged=$matches[2]\";s:17:\"category/(.+?)/?$\";s:35:\"index.php?category_name=$matches[1]\";s:44:\"tag/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:39:\"tag/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?tag=$matches[1]&feed=$matches[2]\";s:20:\"tag/([^/]+)/embed/?$\";s:36:\"index.php?tag=$matches[1]&embed=true\";s:32:\"tag/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?tag=$matches[1]&paged=$matches[2]\";s:14:\"tag/([^/]+)/?$\";s:25:\"index.php?tag=$matches[1]\";s:45:\"type/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:40:\"type/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?post_format=$matches[1]&feed=$matches[2]\";s:21:\"type/([^/]+)/embed/?$\";s:44:\"index.php?post_format=$matches[1]&embed=true\";s:33:\"type/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?post_format=$matches[1]&paged=$matches[2]\";s:15:\"type/([^/]+)/?$\";s:33:\"index.php?post_format=$matches[1]\";s:34:\"person/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:44:\"person/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:64:\"person/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"person/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:59:\"person/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:40:\"person/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:23:\"person/([^/]+)/embed/?$\";s:39:\"index.php?person=$matches[1]&embed=true\";s:27:\"person/([^/]+)/trackback/?$\";s:33:\"index.php?person=$matches[1]&tb=1\";s:35:\"person/([^/]+)/page/?([0-9]{1,})/?$\";s:46:\"index.php?person=$matches[1]&paged=$matches[2]\";s:42:\"person/([^/]+)/comment-page-([0-9]{1,})/?$\";s:46:\"index.php?person=$matches[1]&cpage=$matches[2]\";s:31:\"person/([^/]+)(?:/([0-9]+))?/?$\";s:45:\"index.php?person=$matches[1]&page=$matches[2]\";s:23:\"person/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:33:\"person/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:53:\"person/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"person/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:48:\"person/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:29:\"person/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:37:\"hot-sauce/[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:47:\"hot-sauce/[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:67:\"hot-sauce/[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"hot-sauce/[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:62:\"hot-sauce/[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:43:\"hot-sauce/[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:26:\"hot-sauce/([^/]+)/embed/?$\";s:42:\"index.php?hot-sauce=$matches[1]&embed=true\";s:30:\"hot-sauce/([^/]+)/trackback/?$\";s:36:\"index.php?hot-sauce=$matches[1]&tb=1\";s:38:\"hot-sauce/([^/]+)/page/?([0-9]{1,})/?$\";s:49:\"index.php?hot-sauce=$matches[1]&paged=$matches[2]\";s:45:\"hot-sauce/([^/]+)/comment-page-([0-9]{1,})/?$\";s:49:\"index.php?hot-sauce=$matches[1]&cpage=$matches[2]\";s:34:\"hot-sauce/([^/]+)(?:/([0-9]+))?/?$\";s:48:\"index.php?hot-sauce=$matches[1]&page=$matches[2]\";s:26:\"hot-sauce/[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:36:\"hot-sauce/[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:56:\"hot-sauce/[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"hot-sauce/[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:51:\"hot-sauce/[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:32:\"hot-sauce/[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:44:\"irs/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?irs=$matches[1]&feed=$matches[2]\";s:39:\"irs/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?irs=$matches[1]&feed=$matches[2]\";s:20:\"irs/([^/]+)/embed/?$\";s:36:\"index.php?irs=$matches[1]&embed=true\";s:32:\"irs/([^/]+)/page/?([0-9]{1,})/?$\";s:43:\"index.php?irs=$matches[1]&paged=$matches[2]\";s:14:\"irs/([^/]+)/?$\";s:25:\"index.php?irs=$matches[1]\";s:48:\"keyword/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?keyword=$matches[1]&feed=$matches[2]\";s:43:\"keyword/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:46:\"index.php?keyword=$matches[1]&feed=$matches[2]\";s:24:\"keyword/([^/]+)/embed/?$\";s:40:\"index.php?keyword=$matches[1]&embed=true\";s:36:\"keyword/([^/]+)/page/?([0-9]{1,})/?$\";s:47:\"index.php?keyword=$matches[1]&paged=$matches[2]\";s:18:\"keyword/([^/]+)/?$\";s:29:\"index.php?keyword=$matches[1]\";s:12:\"robots\\.txt$\";s:18:\"index.php?robots=1\";s:48:\".*wp-(atom|rdf|rss|rss2|feed|commentsrss2)\\.php$\";s:18:\"index.php?feed=old\";s:20:\".*wp-app\\.php(/.*)?$\";s:19:\"index.php?error=403\";s:18:\".*wp-register.php$\";s:23:\"index.php?register=true\";s:32:\"feed/(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:27:\"(feed|rdf|rss|rss2|atom)/?$\";s:27:\"index.php?&feed=$matches[1]\";s:8:\"embed/?$\";s:21:\"index.php?&embed=true\";s:20:\"page/?([0-9]{1,})/?$\";s:28:\"index.php?&paged=$matches[1]\";s:41:\"comments/feed/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:36:\"comments/(feed|rdf|rss|rss2|atom)/?$\";s:42:\"index.php?&feed=$matches[1]&withcomments=1\";s:17:\"comments/embed/?$\";s:21:\"index.php?&embed=true\";s:44:\"search/(.+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:39:\"search/(.+)/(feed|rdf|rss|rss2|atom)/?$\";s:40:\"index.php?s=$matches[1]&feed=$matches[2]\";s:20:\"search/(.+)/embed/?$\";s:34:\"index.php?s=$matches[1]&embed=true\";s:32:\"search/(.+)/page/?([0-9]{1,})/?$\";s:41:\"index.php?s=$matches[1]&paged=$matches[2]\";s:14:\"search/(.+)/?$\";s:23:\"index.php?s=$matches[1]\";s:47:\"author/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:42:\"author/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:50:\"index.php?author_name=$matches[1]&feed=$matches[2]\";s:23:\"author/([^/]+)/embed/?$\";s:44:\"index.php?author_name=$matches[1]&embed=true\";s:35:\"author/([^/]+)/page/?([0-9]{1,})/?$\";s:51:\"index.php?author_name=$matches[1]&paged=$matches[2]\";s:17:\"author/([^/]+)/?$\";s:33:\"index.php?author_name=$matches[1]\";s:69:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:64:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:80:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&feed=$matches[4]\";s:45:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/embed/?$\";s:74:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&embed=true\";s:57:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:81:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]&paged=$matches[4]\";s:39:\"([0-9]{4})/([0-9]{1,2})/([0-9]{1,2})/?$\";s:63:\"index.php?year=$matches[1]&monthnum=$matches[2]&day=$matches[3]\";s:56:\"([0-9]{4})/([0-9]{1,2})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:51:\"([0-9]{4})/([0-9]{1,2})/(feed|rdf|rss|rss2|atom)/?$\";s:64:\"index.php?year=$matches[1]&monthnum=$matches[2]&feed=$matches[3]\";s:32:\"([0-9]{4})/([0-9]{1,2})/embed/?$\";s:58:\"index.php?year=$matches[1]&monthnum=$matches[2]&embed=true\";s:44:\"([0-9]{4})/([0-9]{1,2})/page/?([0-9]{1,})/?$\";s:65:\"index.php?year=$matches[1]&monthnum=$matches[2]&paged=$matches[3]\";s:26:\"([0-9]{4})/([0-9]{1,2})/?$\";s:47:\"index.php?year=$matches[1]&monthnum=$matches[2]\";s:43:\"([0-9]{4})/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:38:\"([0-9]{4})/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?year=$matches[1]&feed=$matches[2]\";s:19:\"([0-9]{4})/embed/?$\";s:37:\"index.php?year=$matches[1]&embed=true\";s:31:\"([0-9]{4})/page/?([0-9]{1,})/?$\";s:44:\"index.php?year=$matches[1]&paged=$matches[2]\";s:13:\"([0-9]{4})/?$\";s:26:\"index.php?year=$matches[1]\";s:27:\".?.+?/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\".?.+?/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\".?.+?/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\".?.+?/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\".?.+?/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"(.?.+?)/embed/?$\";s:41:\"index.php?pagename=$matches[1]&embed=true\";s:20:\"(.?.+?)/trackback/?$\";s:35:\"index.php?pagename=$matches[1]&tb=1\";s:40:\"(.?.+?)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:35:\"(.?.+?)/(feed|rdf|rss|rss2|atom)/?$\";s:47:\"index.php?pagename=$matches[1]&feed=$matches[2]\";s:28:\"(.?.+?)/page/?([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&paged=$matches[2]\";s:35:\"(.?.+?)/comment-page-([0-9]{1,})/?$\";s:48:\"index.php?pagename=$matches[1]&cpage=$matches[2]\";s:24:\"(.?.+?)(?:/([0-9]+))?/?$\";s:47:\"index.php?pagename=$matches[1]&page=$matches[2]\";s:27:\"[^/]+/attachment/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:37:\"[^/]+/attachment/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:57:\"[^/]+/attachment/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:52:\"[^/]+/attachment/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:33:\"[^/]+/attachment/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";s:16:\"([^/]+)/embed/?$\";s:37:\"index.php?name=$matches[1]&embed=true\";s:20:\"([^/]+)/trackback/?$\";s:31:\"index.php?name=$matches[1]&tb=1\";s:40:\"([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:35:\"([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:43:\"index.php?name=$matches[1]&feed=$matches[2]\";s:28:\"([^/]+)/page/?([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&paged=$matches[2]\";s:35:\"([^/]+)/comment-page-([0-9]{1,})/?$\";s:44:\"index.php?name=$matches[1]&cpage=$matches[2]\";s:24:\"([^/]+)(?:/([0-9]+))?/?$\";s:43:\"index.php?name=$matches[1]&page=$matches[2]\";s:16:\"[^/]+/([^/]+)/?$\";s:32:\"index.php?attachment=$matches[1]\";s:26:\"[^/]+/([^/]+)/trackback/?$\";s:37:\"index.php?attachment=$matches[1]&tb=1\";s:46:\"[^/]+/([^/]+)/feed/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/(feed|rdf|rss|rss2|atom)/?$\";s:49:\"index.php?attachment=$matches[1]&feed=$matches[2]\";s:41:\"[^/]+/([^/]+)/comment-page-([0-9]{1,})/?$\";s:50:\"index.php?attachment=$matches[1]&cpage=$matches[2]\";s:22:\"[^/]+/([^/]+)/embed/?$\";s:43:\"index.php?attachment=$matches[1]&embed=true\";}','yes'),
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
	(1850,'medium_large_size_h','0','yes');

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
  `post_password` varchar(20) NOT NULL DEFAULT '',
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
	(1,1,'2014-11-12 02:15:27','2014-11-12 02:15:27','Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!','Hello world!','','publish','open','open','','hello-world','','','2014-11-12 02:15:27','2014-11-12 02:15:27','',0,'http://taco-phpunit-test.dev/?p=1',0,'post','',1),
	(2,1,'2014-11-12 02:15:27','2014-11-12 02:15:27','This is an example page. It\'s different from a blog post because it will stay in one place and will show up in your site navigation (in most themes). Most people start with an About page that introduces them to potential site visitors. It might say something like this:\n\n<blockquote>Hi there! I\'m a bike messenger by day, aspiring actor by night, and this is my blog. I live in Los Angeles, have a great dog named Jack, and I like pi&#241;a coladas. (And gettin\' caught in the rain.)</blockquote>\n\n...or something like this:\n\n<blockquote>The XYZ Doohickey Company was founded in 1971, and has been providing quality doohickeys to the public ever since. Located in Gotham City, XYZ employs over 2,000 people and does all kinds of awesome things for the Gotham community.</blockquote>\n\nAs a new WordPress user, you should go to <a href=\"http://taco-phpunit-test.dev/wp-admin/\">your dashboard</a> to delete this page and create new pages for your content. Have fun!','Sample Page','','publish','open','open','','sample-page','','','2014-11-12 02:15:27','2014-11-12 02:15:27','',0,'http://taco-phpunit-test.dev/?page_id=2',0,'page','',0),
	(3,1,'2014-11-12 02:15:40','0000-00-00 00:00:00','','Auto Draft','','auto-draft','open','open','','','','','2014-11-12 02:15:40','0000-00-00 00:00:00','',0,'http://taco-phpunit-test.dev/?p=3',0,'post','',0),
	(4,1,'2014-11-12 02:16:08','2014-11-12 02:16:08','','Default','','publish','open','open','','default','','','2014-11-12 02:16:08','2014-11-12 02:16:08','',0,'http://taco-phpunit-test.dev/?p=4',0,'theme-option','',0),
	(490,0,'2016-05-10 21:35:15','2016-05-10 21:35:15','','Jane','','publish','open','open','','jane','','','2016-05-10 21:35:15','2016-05-10 21:35:15','',0,'http://taco-phpunit-test.dev/person/jane/',0,'person','',0);

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
	(18,1,'session_tokens','a:2:{s:64:\"17a6f08dd3002047dbb59e0eb69128a51664f3ec95ac03c39a778667bcf4825f\";a:4:{s:10:\"expiration\";i:1464125704;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:90:\"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6\";s:5:\"login\";i:1462916104;}s:64:\"a6bf41697af8693a98cefe8a8ecbcd1a8b344566ed70ce952ae33647b0fda944\";a:4:{s:10:\"expiration\";i:1464125704;s:2:\"ip\";s:9:\"127.0.0.1\";s:2:\"ua\";s:90:\"Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6\";s:5:\"login\";i:1462916104;}}');

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
	(1,'admin','$P$B2hbz2XjeYE3ZGBIn4yFMhVyqj3Kwh1','admin','admin@127.0.0.1','','2015-01-01 00:00:00','',0,'admin');

/*!40000 ALTER TABLE `taco_phpunit_test_users` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
