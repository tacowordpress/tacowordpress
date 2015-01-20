<?php

class HTMLTest extends PHPUnit_Framework_TestCase
{
    public $admin_username = 'admin';
    public $admin_password = 'admin';
    public $cookie_file_path = './cookie.txt';

    public function setUp()
    {
        if(file_exists($this->cookie_file_path)) {
            unlink($this->cookie_file_path);
        }
    }


    public function tearDown()
    {
        if(file_exists($this->cookie_file_path)) {
            unlink($this->cookie_file_path);
        }
    }
    

    public function testAddPostFieldRendering()
    {
        $path = 'wp-admin/post-new.php?post_type=person';
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Sidebar
        $this->assertEquals('Persons', $doc->find('.menu-icon-person .wp-menu-name')->text());
        $this->assertEquals(4, $doc->find('#menu-posts-person ul li')->length());

        // Page title
        $this->assertEquals('Add New Person', $doc->find('h2:first')->text());

        // Person metabox
        $metabox = $doc->find('#person_person');
        $this->assertEquals(1, $metabox->length);
        $this->assertEquals('Person', $metabox->find('h3')->text());
        $this->assertEquals(1, $metabox->find('input[type=text][name=first_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=last_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=email][name=email]')->length);
        $this->assertEquals(1, $metabox->find('input[type=number][name=age]')->length);
        $this->assertEquals('', $metabox->find('input[type=text][name=first_name]')->val());
        $this->assertEquals('', $metabox->find('input[type=text][name=last_name]')->val());
        $this->assertEquals('', $metabox->find('input[type=email][name=email]')->val());
        $this->assertEquals('', $metabox->find('input[type=number][name=age]')->val());

        // Taxonomies
        $this->assertEquals(1, $doc->find('#taxonomy-irs')->length());
        $this->assertEquals('Irs', $doc->find('#taxonomy-irs')->parent()->parent()->find('h3:first')->text());
        $this->assertEquals(1, $doc->find('#irs-all')->length());
        $this->assertEquals(0, $doc->find('#irs-checklist li')->length(), 'no terms to start');
    }


    public function getHTML($path)
    {
        $url = 'http://taco-phpunit-test.dev/'.$path;
        $credentials = array(
            'log'=>$this->admin_username,
            'pwd'=>$this->admin_password,
            'rememberme'=>'forever',
            'wp-submit'=>'Log In',
        );
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL=>'http://taco-phpunit-test.dev/wp-login.php',
            CURLOPT_RETURNTRANSFER=>true,
            CURLOPT_FOLLOWLOCATION=>true,
            CURLOPT_USERAGENT=>'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6',
            CURLOPT_COOKIEJAR=>$this->cookie_file_path,
            CURLOPT_POST=>true,
            CURLOPT_POSTFIELDS=>array_merge(
                $credentials,
                array('redirect_to'=>$url)
            ),
        ));
        $html = curl_exec($curl);
        return $html;
    }
}