<?php

class DatabaseTest extends PHPUnit_Framework_TestCase {

  public static function setUpBeforeClass() {
    self::_installWordPress();
    self::_bootstrapWordPress();
  }

  private static function _installWordPress($version_number='4.1') {
    // Which version are we testing?
    $version = 'wordpress-'.$version_number;

    // Load the database config first so we can perform the install
    require_once __DIR__.'/db-config.php';

    // Install WordPress
    // Prior to this, you need to create the taco_phpunit_test database
    // and grant the user in db-config.php with permissions on it.
    // http://stackoverflow.com/questions/6346674/pdo-support-for-multiple-queries-pdo-mysql-pdo-mysqlnd
    $install_sql_fpath = __DIR__.'/sql/'.$version.'/install.sql';
    $install_sql = file_get_contents($install_sql_fpath);

    $pdo_connection = sprintf('mysql:host=%s;dbname=%s', DB_HOST, DB_NAME);
    try {
      $pdo = new PDO($pdo_connection, DB_USER, DB_PASSWORD);
      $pdo->setAttribute(PDO::ATTR_EMULATE_PREPARES, 0);
      $result = $pdo->exec($install_sql);
      $pdo = null;
    } catch(PDOException $e) {
      echo $e->getMessage();
      die;
    }
  }

  private static function _bootstrapWordPress($version_number='4.1') {
    // Which version are we testing?
    $version = 'wordpress-'.$version_number;

    $install_dir = __DIR__.'/lib/'.$version;
    chdir($install_dir);
    include('wp-load.php');
  }

  public function testConnection() {
    global $wpdb;
    $this->assertTrue(is_object($wpdb));
  }
}