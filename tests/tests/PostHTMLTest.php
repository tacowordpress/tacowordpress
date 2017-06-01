<?php

class PostHTMLTest extends PHPUnit\Framework\TestCase
{
    public static $admin_username = 'admin';
    public static $admin_password = 'admin';
    public static $cookie_file_path = './cookie.txt';

    private $person;
    private $sauce;

    private static function cleanup() {
        if (file_exists(static::$cookie_file_path)) {
            unlink(static::$cookie_file_path);
        }

        // Cleanup
        Person::deleteAll();
        HotSauce::deleteAll();
        wp_cache_flush();
    }


    public function setUp() {
        static::cleanup();

        // Create record
        $this->person = new Person;
        $this->person->first_name = 'John';
        $this->person->middle_name = 'Foo & Bar';
        $this->person->last_name = "D'oh!";
        $this->person->post_title = "John Foo & Bar D'oh!";
        $this->person->save();

        // Create record
        $this->sauce = new HotSauce;
        $this->sauce->scovilles = 1000;
        $this->sauce->post_title = "Lauren’s Secret Vermilion Hot Sauce";
        $this->sauce->save();
    }

    public function tearDown() {
        unset($this->person);
        unset($this->sauce);
    }

    public static function tearDownAfterClass() {
        static::cleanup();
    }


    public function testAddPostFieldRendering()
    {
        $path = 'wp-admin/post-new.php?post_type=person';
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Sidebar
        $this->assertEquals('Persons', $doc->find('.menu-icon-person .wp-menu-name')->text());
        $this->assertEquals(4, $doc->find('#menu-posts-person ul li')->length);

        // Page title
        $this->assertEquals('Add New Person', $doc->find('h1:first')->text());

        // Person metabox
        $metabox = $doc->find('#person_person');
        $this->assertEquals(1, $metabox->length);
        $this->assertEquals('Person', $metabox->find('h2')->text());
        $this->assertEquals(1, $metabox->find('label[for=first_name]')->length);
        $this->assertEquals('Your first name *', $metabox->find('label[for=first_name]:first')->text());
        $this->assertEquals(1, $metabox->find('input[type=text][name=first_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][placeholder="1st name"]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=last_name]')->length);
        $this->assertEquals('Your last name', $metabox->find('label[for=last_name]:first')->text());
        $this->assertEquals(1, $metabox->find('input[type=email][name=email]')->length);
        $this->assertEquals(1, $metabox->find('input[type=number][name=age]')->length);
        $this->assertEquals(1, $metabox->find('textarea[name=quote]')->length);
        $this->assertEquals(1, $metabox->find('input[type=color][name=favorite_color]')->length);
        $this->assertEquals(1, $metabox->find('input[type=checkbox][name=is_professional]')->length);
        $this->assertEquals(1, $metabox->find('select[name=favorite_sauce]')->length);
        $this->assertEquals(4, $metabox->find('select[name=favorite_sauce] option')->length);
        $this->assertEquals('', $metabox->find('select[name=favorite_sauce] option:first')->val());
        $this->assertEquals('Select', $metabox->find('select[name=favorite_sauce] option:first')->text());
        $this->assertEquals('spicy', $metabox->find('select[name=favorite_sauce] option:last')->val());
        $this->assertEquals('Spicy', $metabox->find('select[name=favorite_sauce] option:last')->text());
        $this->assertEquals(1, $metabox->find('input[type=text][name=photo_path].upload')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=resume_pdf_path].upload')->length);
        $this->assertEquals(1, $metabox->find('input[type=url][name=website_url]')->length);
        $this->assertEquals('', $metabox->find('input[type=text][name=first_name]')->val());
        $this->assertEquals('', $metabox->find('input[type=text][name=last_name]')->val());
        $this->assertEquals('', $metabox->find('input[type=email][name=email]')->val());
        $this->assertEquals('', $metabox->find('input[type=number][name=age]')->val());
        $this->assertEquals('', $metabox->find('textarea[name=quote]')->val());
        $this->assertEquals('', $metabox->find('input[type=color][name=favorite_color]')->val());
        $this->assertEquals('', $metabox->find('select[name=favorite_sauce]')->val());
        $this->assertEquals(0, $metabox->find('input[type=checkbox][is_professional][checked=checked]')->length);
        $this->assertEquals('', $metabox->find('input[type=text][name=photo_path]')->val());
        $this->assertEquals('', $metabox->find('input[type=text][name=resume_pdf_path]')->val());
        $this->assertEquals('', $metabox->find('input[type=url][name=website_url]')->val());
        $this->assertEquals('', $metabox->find('input[type=link][name=website_link]')->val());

        // Taxonomies
        $this->assertEquals(1, $doc->find('#taxonomy-irs')->length);
        $this->assertEquals('Irs', $doc->find('#taxonomy-irs')->parent()->parent()->find('h2:first')->text());
        $this->assertEquals(1, $doc->find('#irs-all')->length);
        $this->assertEquals(0, $doc->find('#irs-checklist li')->length, 'no terms to start');
    }


    public function testEditPostFieldRendering()
    {
        // Get HTML
        $path = 'wp-admin/post.php?post='.$this->person->ID.'&action=edit';
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Page title
        $this->assertEquals('Edit Person', $doc->find('h1:first')->text());
        $this->assertEquals('Add New', $doc->find('h1:first')->siblings('a')->text());
        $this->assertEquals("John Foo & Bar D'oh!", $doc->find('input[name=post_title]')->val());

        // Person metabox
        $metabox = $doc->find('#person_person');
        $this->assertEquals(1, $metabox->length);
        $this->assertEquals('Person', $metabox->find('h2')->text());
        $this->assertEquals(1, $metabox->find('input[type=text][name=first_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=middle_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=last_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=email][name=email]')->length);
        $this->assertEquals(1, $metabox->find('input[type=number][name=age]')->length);
        $this->assertEquals('John', $metabox->find('input[type=text][name=first_name]')->val());
        $this->assertEquals("Foo & Bar", $metabox->find('input[type=text][name=middle_name]')->val());
        $this->assertEquals("D'oh!", $metabox->find('input[type=text][name=last_name]')->val());
        $this->assertEquals('', $metabox->find('input[type=email][name=email]')->val());
        $this->assertEquals('', $metabox->find('input[type=number][name=age]')->val());
        $this->assertEquals('', $metabox->find('textarea[name=quote]')->val());
        $this->assertEquals('', $metabox->find('input[type=color][name=favorite_color]')->val());
        $this->assertEquals('', $metabox->find('select[name=favorite_sauce]')->val());
        $this->assertEquals(0, $metabox->find('input[type=checkbox][is_professional][checked=checked]')->length);
        $this->assertEquals('', $metabox->find('input[type=text][name=photo_path]')->val());
        $this->assertEquals('', $metabox->find('input[type=text][name=resume_pdf_path]')->val());
        $this->assertEquals('', $metabox->find('input[type=url][name=website_url]')->val());
        $this->assertEquals('', $metabox->find('input[type=link][name=website_link]')->val());

        // Taxonomies
        $this->assertEquals(1, $doc->find('#taxonomy-irs')->length);
        $this->assertEquals('Irs', $doc->find('#taxonomy-irs')->parent()->parent()->find('h2:first')->text());
        $this->assertEquals(1, $doc->find('#irs-all')->length);
        $this->assertEquals(0, $doc->find('[data-wp-lists="list:irs"] li')->length, 'no terms to start');

        // Update person
        $this->person->email = 'johndoe@example.com';
        $this->person->age = 30;
        $this->person->quote = 'The thing about quotes on the internet is that you cannot confirm their validity.';
        $this->person->favorite_color = '#0099ff';
        $this->person->is_professional = 1;
        $this->person->favorite_sauce = 'medium';
        $this->person->photo_path = '/wp-content/uploads/sample.jpg';
        $this->person->resume_pdf_path = '/wp-content/uploads/sample.pdf';
        $this->person->website_url = 'https://google.com/';
        $this->person->website_link = '{"href":"https://www.google.com","title":"Hello world!","target":"_blank"}';
        $this->person->save();

        // Get HTML again
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Person metabox
        $metabox = $doc->find('#person_person');
        $this->assertEquals(1, $metabox->length);
        $this->assertEquals('Person', $metabox->find('h2')->text());
        $this->assertEquals(1, $metabox->find('input[type=text][name=first_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=text][name=last_name]')->length);
        $this->assertEquals(1, $metabox->find('input[type=email][name=email]')->length);
        $this->assertEquals(1, $metabox->find('input[type=number][name=age]')->length);
        $this->assertEquals('The thing about quotes on the internet is that you cannot confirm their validity.', $metabox->find('textarea[name=quote]')->val());
        $this->assertEquals('John', $metabox->find('input[type=text][name=first_name]')->val());
        $this->assertEquals("Foo & Bar", $metabox->find('input[type=text][name=middle_name]')->val());
        $this->assertEquals("D'oh!", $metabox->find('input[type=text][name=last_name]')->val());
        $this->assertEquals('johndoe@example.com', $metabox->find('input[type=email][name=email]')->val());
        $this->assertEquals(30, $metabox->find('input[type=number][name=age]')->val());
        $this->assertEquals('#0099ff', $metabox->find('input[type=color][name=favorite_color]')->val());
        $this->assertEquals('medium', $metabox->find('select[name=favorite_sauce]')->val());
        $this->assertEquals(1, $metabox->find('input[type=checkbox][name=is_professional][checked=checked]')->length);
        $this->assertEquals('/wp-content/uploads/sample.jpg', $metabox->find('input[type=text][name=photo_path]')->val());
        $this->assertEquals('/wp-content/uploads/sample.pdf', $metabox->find('input[type=text][name=resume_pdf_path]')->val());
        $this->assertEquals('https://google.com/', $metabox->find('input[type=url][name=website_url]')->val());
        $this->assertEquals('https://www.google.com', json_decode($metabox->find('input[type=link][name=website_link]')->val())->href);

        // Update person with terms
        $this->person->setTerms(array('term1'), 'irs');
        $this->person->save();

        // Get HTML again
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Taxonomies after update
        $this->assertEquals(1, $doc->find('#taxonomy-irs')->length);
        $this->assertEquals('Irs', $doc->find('#taxonomy-irs')->parent()->parent()->find('h2:first')->text());
        $this->assertEquals(1, $doc->find('#irs-all')->length);
        $this->assertEquals(1, $doc->find('[data-wp-lists="list:irs"]')->length);
        $this->assertEquals('term1', trim($doc->find('[data-wp-lists="list:irs"] li:first')->text()));
        $this->assertEquals(1, $doc->find('[data-wp-lists="list:irs"] li:first input[type=checkbox][checked=checked]')->length);

        // Save special characters
        $this->person->post_title = '<script>alert("lol");</script>';
        $this->person->first_name = 'This person is <b>bold</b>';
        $this->person->middle_name = 'Double "quote" closed';
        $this->person->last_name = 'Double "quote open';
        $this->person->save();

        // Get HTML again
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        $this->assertEquals('alert("lol");', $doc->find('input[name=post_title]')->val(), 'wp_insert_post strips HTML tags from post_title');
        $this->assertEquals('This person is <b>bold</b>', $doc->find('input[name=first_name]')->val());
        $this->assertContains('value="This person is &lt;b&gt;bold&lt;/b&gt;"', $html, 'output is escaped in text fields');
        $this->assertEquals('Double "quote" closed', $doc->find('input[name=middle_name]')->val());
        $this->assertContains('value="Double &quot;quote&quot; closed"', $html);
        $this->assertEquals('Double "quote open', $doc->find('input[name=last_name]')->val());
        $this->assertContains('value="Double &quot;quote open"', $html);

        $this->assertContains('<option value="closed_double">&quot;Closed double&quot;</option>', $html);
        $this->assertContains('<option value="unclosed_double">&quot;Unclosed double</option>', $html);
        $this->assertContains('<option value="closed_single">\'Closed single\'</option>', $html);
        $this->assertContains('<option value="unclosed_single">\'Unclosed single</option>', $html);
        $this->assertContains('<option value="closed_html">&lt;b&gt;Closed HTML&lt;/b&gt;</option>', $html);
        $this->assertContains('<option value="unclosed_html">&lt;b&gt;Unclosed HTML</option>', $html);
    }


    /*
     *  Test custom metaboxes
     */
    public function testMetaBoxes()
    {
        // Get HTML
        $path = 'wp-admin/post.php?post='.$this->sauce->ID.'&action=edit';

        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        // Hot Sauce Info Metabox
        $metabox1 = $doc->find('#hot-sauce_hot_sauce_info');
        $this->assertEquals(1, $metabox1->length);
        $this->assertEquals('Hot Sauce Info', $metabox1->find('h2')->text());
        $this->assertEquals(1, $metabox1->find('input[type=number][name=scovilles]')->length);
        $this->assertEquals(1000, $metabox1->find('input[type=number][name=scovilles]')->val());

        $metabox2 = $doc->find('#hot-sauce_file_info');
        $this->assertEquals(1, $metabox2->length);
        $this->assertEquals('File Info', $metabox2->find('h2')->text());
        $this->assertEquals(1, $metabox2->find('input.upload[type=text][name=image_path]')->length);
        $this->assertEquals(1, $metabox2->find('input.upload[type=text][name=file_path]')->length);
    }


    /*
     *  Test list view
     */
    public function testList() {
        // Get HTML
        $path = 'wp-admin/edit.php?post_type=hot-sauce';
        $html = $this->getHTML($path);
        $doc = phpQuery::newDocument($html);

        $posts = $doc->find('.posts');
        $this->assertEquals(1, $posts->length);

        // Check columns
        $this->assertEquals(1,              $posts->find('th#title')->length);
        $this->assertEquals(1,              $posts->find('th#date')->length);
        $this->assertEquals(1,              $posts->find('th#scovilles')->length);

        $this->assertEquals('Title',        $posts->find('th#title')->find('span:first')->text());
        $this->assertEquals('Date',         $posts->find('th#date')->find('span:first')->text());
        $this->assertEquals('Scovilles',    $posts->find('th#scovilles')->find('span:first')->text());

        $sauce_row = $posts->find('#the-list #post-' . $this->sauce->ID);
        $this->assertEquals(1, $sauce_row->length);
        $this->assertEquals('Lauren’s Secret Vermilion Hot Sauce', $sauce_row->find('td.title a.row-title')->text());
        $this->assertContains('Published',                          $sauce_row->find('td.date')->text());
        $this->assertEquals('1000',                                 $sauce_row->find('td.scovilles')->text());
    }


    public function getHTML($path)
    {
        $url = 'http://taco-phpunit-test.vera/'.$path;
        $credentials = array(
            'log'=>static::$admin_username,
            'pwd'=>static::$admin_password,
            'rememberme'=>'forever',
            'wp-submit'=>'Log In',
        );
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL=>'http://taco-phpunit-test.vera/wp-login.php',
            CURLOPT_RETURNTRANSFER=>true,
            CURLOPT_FOLLOWLOCATION=>true,
            CURLOPT_USERAGENT=>'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6',
            CURLOPT_COOKIEJAR=>static::$cookie_file_path,
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