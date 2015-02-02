<?php

class TermTest extends PHPUnit_Framework_TestCase
{
    public function testSave()
    {
        // Cleanup
        Keyword::deleteAll();

        // Insert
        $keyword = new Keyword;
        $keyword->name = 'Habanero';
        $keyword->description = 'Habaneros are reasonably hot';
        $keyword->external_url = 'https://en.wikipedia.org/wiki/Habanero';
        $term_id = $keyword->save();
        $this->assertTrue(is_int($term_id));

        // Load from insert
        $keyword = new Keyword;
        $this->assertTrue($keyword->load($term_id));
        $this->assertEquals('Habanero', $keyword->name);
        $this->assertEquals('Habaneros are reasonably hot', $keyword->description);
        $this->assertEquals('https://en.wikipedia.org/wiki/Habanero', $keyword->external_url);

        // Update from insert
        $keyword->name = 'Habaneros';
        $keyword->description = 'Habaneros are orange in color and reasonably hot';
        $keyword->external_url = 'https://google.com/#q=habanero';
        $this->assertEquals($term_id, $keyword->save());
        $this->assertEquals('Habaneros', $keyword->name);
        $this->assertEquals('Habaneros are orange in color and reasonably hot', $keyword->description);
        $this->assertEquals('https://google.com/#q=habanero', $keyword->external_url);
    }


    public function testDelete()
    {
        // Cleanup
        Keyword::deleteAll();

        // Insert
        $keyword = new Keyword;
        $keyword->name = 'Habanero';
        $keyword->description = 'Habaneros are reasonably hot';
        $keyword->external_url = 'https://en.wikipedia.org/wiki/Habanero';
        $term_id = $keyword->save();

        // Delete
        $keyword = new Keyword;
        $this->assertTrue($keyword->load($term_id));
        $this->assertTrue($keyword->delete());

        // Load shouldn't work
        $keyword = new Keyword;
        $this->assertFalse($keyword->load($term_id));
    }


    public function testDeleteAll()
    {
        // Cleanup
        Keyword::deleteAll();

        for ($i=0; $i<10; $i++) {
            $keyword = new Keyword;
            $keyword->name = sprintf('keyword %d', $i);
            $keyword->save();
        }

        $this->assertEquals(10, count(Keyword::getAll()));
        $this->assertEquals(10, Keyword::deleteAll());
        $this->assertEquals(0, count(Keyword::getAll()));
    }


    public function testGetByNumberMetaField()
    {
        $field_key = 'heat_level';

        // Cleanup
        Keyword::deleteAll();

        // Create posts
        for ($i=0; $i<10; $i++) {
            $keyword = new Keyword;
            $keyword->name = sprintf('keyword %d', $i);
            $keyword->$field_key = $i;
            $keyword->save();
        }

        $all = Keyword::getAll();

        // Verify instance
        $this->assertInstanceOf('Keyword', current(Keyword::getBy($field_key, 1)));

        // Less than
        $keywords = Keyword::getBy($field_key, 1, '<');
        $this->assertEquals(1, count($keywords));

        // Less than or equal to
        $keywords = Keyword::getBy($field_key, 1, '<=');
        $this->assertEquals(2, count($keywords));

        // Equal to implicit
        $keywords = Keyword::getBy($field_key, 1);
        $this->assertEquals(1, count($keywords));

        // Equal to explicit
        $keywords = Keyword::getBy($field_key, 1, '=');
        $this->assertEquals(1, count($keywords));

        // Greater than
        $keywords = Keyword::getBy($field_key, 1, '>');
        $this->assertEquals(8, count($keywords));

        // Greater than or equal to
        $keywords = Keyword::getBy($field_key, 1, '>=');
        $this->assertEquals(9, count($keywords));

        // Limit
        $keywords = Keyword::getBy($field_key, 1, '>', false, array('number'=>3));
        $this->assertEquals(3, count($keywords));

        // Order ASC
        $keywords = Keyword::getBy($field_key, 1, '>', false, array('orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals(2, current($keywords)->$field_key);

        $keywords = Keyword::getBy($field_key, 1, '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals(2, current($keywords)->$field_key);
        $this->assertEquals(4, end($keywords)->$field_key);

        // Order DESC
        $keywords = Keyword::getBy($field_key, 1, '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals(9, current($keywords)->$field_key);
        $this->assertEquals(7, end($keywords)->$field_key);
    }


    public function testGetByStringMetaField()
    {
        $field_key = 'external_url';

        // Cleanup
        Keyword::deleteAll();

        // Create posts
        for ($i=0; $i<100; $i++) {
            $keyword = new Keyword;
            $keyword->name = sprintf('keyword %d', $i);
            $keyword->$field_key = $i;
            $keyword->save();
        }

        // Verify instance
        $this->assertInstanceOf('Keyword', current(Keyword::getBy($field_key, 1)));

        // Less than
        $keywords = Keyword::getBy($field_key, '1', '<');
        $this->assertEquals(1, count($keywords));

        // Less than or equal to
        $keywords = Keyword::getBy($field_key, '1', '<=');
        $this->assertEquals(2, count($keywords));

        // Equal to implicit
        $keywords = Keyword::getBy($field_key, '1');
        $this->assertEquals(1, count($keywords));

        // Equal to explicit
        $keywords = Keyword::getBy($field_key, '1', '=');
        $this->assertEquals(1, count($keywords));

        // Greater than
        $keywords = Keyword::getBy($field_key, '1', '>');
        $this->assertEquals(98, count($keywords));

        // Greater than or equal to
        $keywords = Keyword::getBy($field_key, '1', '>=');
        $this->assertEquals(99, count($keywords));

        // Limit
        $keywords = Keyword::getBy($field_key, '1', '>', false, array('number'=>3));
        $this->assertEquals(3, count($keywords));

        // Order ASC
        $keywords = Keyword::getBy($field_key, '1', '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals('10', current($keywords)->$field_key);
        $this->assertEquals('12', end($keywords)->$field_key);

        // Order DESC
        $keywords = Keyword::getBy($field_key, '1', '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals('99', current($keywords)->$field_key);
        $this->assertEquals('97', end($keywords)->$field_key);
    }


    public function testGetByCoreField()
    {
        $field_key = 'name';

        // Cleanup
        Keyword::deleteAll();

        // Create posts
        for ($i=65; $i<=90; $i++) {
            $keyword = new Keyword;
            $keyword->$field_key = chr($i);
            $keyword->save();
        }

        // Verify instance
        $this->assertInstanceOf('Keyword', current(Keyword::getBy($field_key, 'B')));

        // Less than
        $keywords = Keyword::getBy($field_key, 'B', '<');
        $this->assertEquals(1, count($keywords));

        // Less than or equal to
        $keywords = Keyword::getBy($field_key, 'B', '<=');
        $this->assertEquals(2, count($keywords));

        // Equal to implicit
        $keywords = Keyword::getBy($field_key, 'B');
        $this->assertEquals(1, count($keywords));

        // Equal to explicit
        $keywords = Keyword::getBy($field_key, 'B', '=');
        $this->assertEquals(1, count($keywords));

        // Greater than
        $keywords = Keyword::getBy($field_key, 'B', '>');
        $this->assertEquals(24, count($keywords));

        // Greater than or equal to
        $keywords = Keyword::getBy($field_key, 'B', '>=');
        $this->assertEquals(25, count($keywords));

        // Limit
        $keywords = Keyword::getBy($field_key, 'B', '>', false, array('number'=>3));
        $this->assertEquals(3, count($keywords));

        // Order ASC
        $keywords = Keyword::getBy($field_key, 'B', '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals('C', current($keywords)->$field_key);
        $this->assertEquals('E', end($keywords)->$field_key);

        // Order DESC
        $keywords = Keyword::getBy($field_key, 'B', '>', false, array('number'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals('Z', current($keywords)->$field_key);
        $this->assertEquals('X', end($keywords)->$field_key);
    }


    public function testGetOneBy()
    {
        $field_key = 'external_url';

        // Cleanup
        Keyword::deleteAll();

        // Create posts
        for ($i=0; $i<100; $i++) {
            $keyword = new Keyword;
            $keyword->name = sprintf('keyword %d', $i);
            $keyword->$field_key = $i;
            $keyword->save();
        }

        // Less than
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1, '<'));

        // Less than or equal to
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1, '<='));

        // Equal to implicit
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1));

        // Equal to explicit
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1, '='));

        // Greater than
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1, '>'));

        // Greater than or equal to
        $this->assertInstanceOf('Keyword', Keyword::getOneBy($field_key, 1, '>='));

        // Order ASC
        $args = array('orderby'=>$field_key, 'order'=>'ASC');
        $keyword = Keyword::getOneBy($field_key, '1', '>', false, $args);
        $this->assertInstanceOf('Keyword', $keyword);
        $this->assertEquals('10', $keyword->$field_key);

        // Order DESC
        $args = array('orderby'=>$field_key, 'order'=>'DESC');
        $keyword = Keyword::getOneBy($field_key, '1', '>', false, $args);
        $this->assertInstanceOf('Keyword', $keyword);
        $this->assertEquals('99', $keyword->$field_key);
    }


    public function testGetAll()
    {
        // Cleanup
        Keyword::deleteAll();

        for ($i=0; $i<100; $i++) {
            $keyword = new Keyword;
            $keyword->heat_level = $i;
            $keyword->name = md5($i);
            $keyword->save();
        }

        $keywords = Keyword::getAll();
        $this->assertEquals(100, count($keywords));

        $keywords = array_values(\Taco\Util\Collection::sortBy($keywords, 'heat_level', SORT_NUMERIC));
        foreach ($keywords as $k => $keyword) {
            $this->assertInstanceOf('Keyword', $keyword);
            $this->assertEquals($k, $keyword->heat_level);
            $this->assertEquals(md5($k), $keyword->name);
        }
    }


    public function testFind()
    {
        $keyword = new Keyword;
        $keyword->name = 'Find me';
        $term_id = $keyword->save();

        $keyword = Keyword::find($term_id);
        $this->assertEquals('Find me', $keyword->name);
        $this->assertEquals($term_id, $keyword->term_id);
    }


    public function testGetPairs()
    {
        // Cleanup
        Keyword::deleteAll();

        $core_field_key = 'name';
        $numeric_field_key = 'heat_level';
        $string_field_key = 'external_url';

        // Cleanup
        Keyword::deleteAll();

        // Create posts
        $expected_pairs = array();
        for ($i=0; $i<50; $i++) {
            $keyword = new Keyword;
            $keyword->$core_field_key = sprintf('%s=%d;%s=%d', $numeric_field_key, $i, $string_field_key, $i);
            $keyword->$string_field_key = $i;
            $keyword->$numeric_field_key = $i;
            $term_id = $keyword->save();
            $expected_pairs[$term_id] = sprintf('%s=%d;%s=%d', $numeric_field_key, $i, $string_field_key, $i);
        }

        // getPairs
        $pairs = Keyword::getPairs();
        $this->assertEquals(50, count($pairs));
        $this->assertEquals($expected_pairs, $pairs);

        // limit
        $pairs = Keyword::getPairs(false, array('number'=>5));
        $this->assertEquals(5, count($pairs));

        // getPairs by core field
        $core_expected_pairs = array_slice($expected_pairs, 0, 1, true) + array_slice($expected_pairs, 10, 5, true) + array_slice($expected_pairs, 1, 1, true);
        $pairs = Keyword::getPairsBy($core_field_key, 15, '<');
        asort($pairs);
        asort($core_expected_pairs);
        echo '<pre>'; var_dump($core_expected_pairs, $pairs); echo '</pre>';
        $this->assertEquals($core_expected_pairs, $pairs);

        // getPairsBy meta field numeric
        $pairs = Keyword::getPairsBy($numeric_field_key, 20, '<');
        $this->assertEquals(20, count($pairs));
        $this->assertEquals(array_slice($expected_pairs, 0, 20, true), $pairs);

        // getPairsBy meta field string
        $string_meta_expected_pairs = array_slice($expected_pairs, 0, 1, true) + array_slice($expected_pairs, 10, 5, true) + array_slice($expected_pairs, 1, 1, true);
        $pairs = Keyword::getPairsBy($string_field_key, 15, '<');
        asort($pairs);
        asort($string_meta_expected_pairs);
        $this->assertEquals($string_meta_expected_pairs, $pairs);
    }
}