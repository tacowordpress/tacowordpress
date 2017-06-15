# Taco
WordPress custom post types that feel like CRUD models

[See the wiki for complete documentation.](https://github.com/tacowordpress/tacowordpress/wiki)


## Setup

1. Add Taco and [Util](https://github.com/tacowordpress/util) to `composer.json`
  ```json
  {
    "require": {
      "tacowordpress/tacowordpress": "dev-master"
    }
  }
  ```

2. Include Composer’s autoload in `wp-config.php`
  ```php
  // Composer autoloader
  // Add to the top of wp-config.php
  require_once realpath(__DIR__.'/../vendor/autoload.php');
  ```

3. Initialize Taco in `functions.php`
  ```php
  // Initialize Taco
  \Taco\Loader::init();
  ```


## Usage

Once you have Taco setup, you can start creating your custom post types. Follow the [getting started](https://github.com/tacowordpress/tacowordpress/wiki/1.1-Getting-started) instructions for a simple example.


## PHPUnit tests
If you want to contribute, you should create corresponding PHPUnit tests for your functionality or fix. You will need to create a database and configure db-config.php with your database credentials. Then pull down the latest Composer updates which includes PHPUnit, and run the PHPUnit tests:

    $ composer update
    $ cd tests
    $ ../vendor/bin/phpunit

If you want to login to the WordPress admin UI for the test suite, you need to:

1. Create a hosts entry:

        127.0.0.1 taco-phpunit-test.vera

2. Create an Apache vhosts entry, modifying the path as necessary. If you are having trouble, make sure that your vhost file is being loaded by Apache.

        <VirtualHost *:80>
          DocumentRoot "/path/to/taco/tests/lib/wordpress"
          ServerName taco-phpunit-test.vera
          <Directory /path/to/taco/tests/lib/wordpress>
            AllowOverride All
            Order allow,deny
            Allow from all
          </Directory>
        </VirtualHost>

3. Visit http://taco-phpunit-test.vera/wp-admin/

        u: admin
        p: admin

# Changelog
### v1.0
* Updating to work with PHP 7
### v0.9
* Tagging last version of Taco to run on PHP 5
 
 ..
