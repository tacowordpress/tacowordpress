# Taco
WordPress custom post types that feel like CRUD models


## Usage

1. Include Composer's autoload in wp-config.php before the 'stop editing' message
2. Add this to the top of functions.php

        \Taco\Loader::init();

# Adding a new message to the readme file on a new branch called new_branch

## PHPUnit tests
First, you will need to create a database and configure db-config.php to match your database credentials. Then run:

    $ composer update --dev
    $ vendor/bin/phpunit tests

If you want to login to the WordPress admin UI for the test suite, you need to:

1. Create a hosts entry:

        taco-phpunit-test 127.0.0.1

2. Create a vhosts entry, modifying the path as necessary:

        <VirtualHost *:80>
          DocumentRoot "/path/to/taco/tests/lib/wordpress"
          ServerName taco-phpunit-test.dev
          <Directory /path/to/taco/tests/lib/wordpress>
            AllowOverride All
            Order allow,deny
            Allow from all
          </Directory>
        </VirtualHost>

3. Visit http://taco-phpunit-test.dev/wp-admin/

        u: admin
        p: admin