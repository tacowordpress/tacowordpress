<?php

class PostTest extends PHPUnit_Framework_TestCase
{

    public function testRegisterPostType()
    {
        $post_types = get_post_types();
        $this->assertContains('person', $post_types, 'Single word post type registered');
        $this->assertContains('hot-sauce', $post_types, 'Multiword post type registered');
    }

    public function testSave()
    {
        // Cleanup
        Person::deleteAll();

        // Insert
        $person = new Person;
        $person->first_name = 'John';
        $person->last_name = 'Doe';
        $person->email = 'johndoe@test.com';
        $person->post_title = 'John Doe';
        $post_id = $person->save();
        $this->assertTrue(is_int($post_id));

        // Load from insert
        $person = new Person;
        $this->assertTrue($person->load($post_id));
        $this->assertEquals('John', $person->first_name);
        $this->assertEquals('Doe', $person->last_name);
        $this->assertEquals('johndoe@test.com', $person->email);
        $this->assertEquals('John Doe', $person->post_title);

        // Update from insert
        $person->first_name = 'Jane';
        $person->last_name = 'Dough';
        $person->email = 'janedough@test.com';
        $person->post_title = 'Jane Dough';
        $this->assertEquals($post_id, $person->save());
        $this->assertEquals('Jane', $person->first_name);
        $this->assertEquals('Dough', $person->last_name);
        $this->assertEquals('janedough@test.com', $person->email);
        $this->assertEquals('Jane Dough', $person->post_title);
    }


    public function testDeleteToTrash()
    {
        // Cleanup
        Person::deleteAll();

        // Insert
        $person = new Person;
        $person->first_name = 'John';
        $person->last_name = 'Doe';
        $person->email = 'johndoe@test.com';
        $person->post_title = 'John Doe';
        $post_id = $person->save();

        // Delete to trash
        $person = new Person;
        $this->assertTrue($person->load($post_id));
        $this->assertTrue(is_object($person->delete()));

        // Load shouldn't work
        $person = new Person;
        $this->assertFalse($person->load($post_id));
    }


    public function testDeleteBypassTrash()
    {
        // Cleanup
        Person::deleteAll();

        // Insert
        $person = new Person;
        $person->first_name = 'John';
        $person->last_name = 'Doe';
        $person->email = 'johndoe@test.com';
        $person->post_title = 'John Doe';
        $post_id = $person->save();

        // Delete to trash
        $person = new Person;
        $this->assertTrue($person->load($post_id));
        $this->assertTrue(is_object($person->delete(true)));

        // Load shouldn't work
        $person = new Person;
        $this->assertFalse($person->load($post_id));
    }


    public function testDeleteAll() {
        // Cleanup
        Person::deleteAll();

        for ($i=0; $i<10; $i++) {
            $person = new Person;
            $person->age = $i;
            $person->save();
        }

        $this->assertEquals(10, count(Person::getAll()));
        $this->assertEquals(10, Person::deleteAll());
        $this->assertEquals(0, count(Person::getAll()));
    }


    public function testGetByNumberMetaField()
    {
        $field_key = 'age';

        // Cleanup
        Person::deleteAll();

        // Create posts
        for ($i=0; $i<10; $i++) {
            $person = new Person;
            $person->$field_key = $i;
            $person->save();
        }

        // Verify instance
        $this->assertInstanceOf('Person', current(Person::getBy($field_key, 1)));

        // Less than
        $persons = Person::getBy($field_key, 1, '<');
        $this->assertEquals(1, count($persons));

        // Less than or equal to
        $persons = Person::getBy($field_key, 1, '<=');
        $this->assertEquals(2, count($persons));

        // Equal to implicit
        $persons = Person::getBy($field_key, 1);
        $this->assertEquals(1, count($persons));

        // Equal to explicit
        $persons = Person::getBy($field_key, 1, '=');
        $this->assertEquals(1, count($persons));

        // Greater than
        $persons = Person::getBy($field_key, 1, '>');
        $this->assertEquals(8, count($persons));

        // Greater than or equal to
        $persons = Person::getBy($field_key, 1, '>=');
        $this->assertEquals(9, count($persons));

        // Limit
        $persons = Person::getBy($field_key, 1, '>', array('numberposts'=>3));
        $this->assertEquals(3, count($persons));

        // Order ASC
        $persons = Person::getBy($field_key, 1, '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals(2, current($persons)->$field_key);
        $this->assertEquals(4, end($persons)->$field_key);

        // Order DESC
        $persons = Person::getBy($field_key, 1, '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals(9, current($persons)->$field_key);
        $this->assertEquals(7, end($persons)->$field_key);
    }


    public function testGetByStringMetaField()
    {
        $field_key = 'first_name';

        // Cleanup
        Person::deleteAll();

        // Create posts
        for ($i=0; $i<100; $i++) {
            $person = new Person;
            $person->$field_key = $i;
            $person->save();
        }

        // Verify instance
        $this->assertInstanceOf('Person', current(Person::getBy($field_key, 1)));

        // Less than
        $persons = Person::getBy($field_key, '1', '<');
        $this->assertEquals(1, count($persons));

        // Less than or equal to
        $persons = Person::getBy($field_key, '1', '<=');
        $this->assertEquals(2, count($persons));

        // Equal to implicit
        $persons = Person::getBy($field_key, '1');
        $this->assertEquals(1, count($persons));

        // Equal to explicit
        $persons = Person::getBy($field_key, '1', '=');
        $this->assertEquals(1, count($persons));

        // Greater than
        $persons = Person::getBy($field_key, '1', '>');
        $this->assertEquals(98, count($persons));

        // Greater than or equal to
        $persons = Person::getBy($field_key, '1', '>=');
        $this->assertEquals(99, count($persons));

        // Limit
        $persons = Person::getBy($field_key, '1', '>', array('numberposts'=>3));
        $this->assertEquals(3, count($persons));

        // Order ASC
        $persons = Person::getBy($field_key, '1', '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals('10', current($persons)->$field_key);
        $this->assertEquals('12', end($persons)->$field_key);

        // Order DESC
        $persons = Person::getBy($field_key, '1', '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals('99', current($persons)->$field_key);
        $this->assertEquals('97', end($persons)->$field_key);
    }


    public function testGetByCoreField()
    {
        $field_key = 'post_title';

        // Cleanup
        Person::deleteAll();

        // Create posts
        for ($i=65; $i<=90; $i++) {
            $person = new Person;
            $person->$field_key = chr($i);
            $person->save();
        }

        // Verify instance
        $this->assertInstanceOf('Person', current(Person::getBy($field_key, 'B')));

        // Less than
        $persons = Person::getBy($field_key, 'B', '<');
        $this->assertEquals(1, count($persons));

        // Less than or equal to
        $persons = Person::getBy($field_key, 'B', '<=');
        $this->assertEquals(2, count($persons));

        // Equal to implicit
        $persons = Person::getBy($field_key, 'B');
        $this->assertEquals(1, count($persons));

        // Equal to explicit
        $persons = Person::getBy($field_key, 'B', '=');
        $this->assertEquals(1, count($persons));

        // Greater than
        $persons = Person::getBy($field_key, 'B', '>');
        $this->assertEquals(24, count($persons));

        // Greater than or equal to
        $persons = Person::getBy($field_key, 'B', '>=');
        $this->assertEquals(25, count($persons));

        // Limit
        $persons = Person::getBy($field_key, 'B', '>', array('numberposts'=>3));
        $this->assertEquals(3, count($persons));

        // Order ASC
        $persons = Person::getBy($field_key, 'B', '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'ASC'));
        $this->assertEquals('C', current($persons)->$field_key);
        $this->assertEquals('E', end($persons)->$field_key);

        // Order DESC
        $persons = Person::getBy($field_key, 'B', '>', array('numberposts'=>3, 'orderby'=>$field_key, 'order'=>'DESC'));
        $this->assertEquals('Z', current($persons)->$field_key);
        $this->assertEquals('X', end($persons)->$field_key);
    }


    public function testGetOneBy()
    {
        $field_key = 'first_name';

        // Cleanup
        Person::deleteAll();

        // Create posts
        for ($i=0; $i<100; $i++) {
            $person = new Person;
            $person->$field_key = $i;
            $person->save();
        }

        // Less than
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1, '<'));

        // Less than or equal to
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1, '<='));

        // Equal to implicit
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1));

        // Equal to explicit
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1, '='));

        // Greater than
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1, '>'));

        // Greater than or equal to
        $this->assertInstanceOf('Person', Person::getOneBy($field_key, 1, '>='));

        // Order ASC
        $args = array('orderby'=>$field_key, 'order'=>'ASC');
        $this->assertEquals('10', Person::getOneBy($field_key, '1', '>', $args)->$field_key);

        // Order DESC
        $args = array('orderby'=>$field_key, 'order'=>'DESC');
        $this->assertEquals('99', Person::getOneBy($field_key, '1', '>', $args)->$field_key);
    }


    public function testGetAll()
    {
        // Cleanup
        Person::deleteAll();

        for ($i=0; $i<100; $i++) {
            $person = new Person;
            $person->age = $i;
            $person->first_name = md5($i);
            $person->save();
        }

        $persons = Person::getAll();
        $this->assertEquals(100, count($persons));

        $persons = array_values(\Taco\Util\Collection::sortBy($persons, 'age'));
        foreach ($persons as $k => $person) {
            $this->assertInstanceOf('Person', $person);
            $this->assertEquals($k, $person->age);
            $this->assertEquals(md5($k), $person->first_name);
        }
    }


    public function testFind()
    {
        $person = new Person;
        $person->post_title = 'Find me';
        $post_id = $person->save();

        $person = Person::find($post_id);
        $this->assertEquals('Find me', $person->post_title);
        $this->assertEquals($post_id, $person->ID);
    }


    public function testGetPairs()
    {
        // Cleanup
        Person::deleteAll();

        $core_field_key = 'post_content';
        $numeric_field_key = 'age';
        $string_field_key = 'first_name';

        // Cleanup
        Person::deleteAll();

        // Create posts
        $expected_pairs = array();
        for ($i=0; $i<50; $i++) {
            $person = new Person;
            $person->post_title = sprintf('%s=%d;%s=%d', $numeric_field_key, $i, $string_field_key, $i);
            $person->$core_field_key = $i;
            $person->$string_field_key = $i;
            $person->$numeric_field_key = $i;
            $post_id = $person->save();
            $expected_pairs[$post_id] = sprintf('%s=%d;%s=%d', $numeric_field_key, $i, $string_field_key, $i);
        }

        // getPairs
        $pairs = Person::getPairs();
        $this->assertEquals(50, count($pairs));
        $this->assertEquals($expected_pairs, $pairs);

        // limit
        $pairs = Person::getPairs(array('numberposts'=>5));
        $this->assertEquals(5, count($pairs));

        // getPairs by core field
        $core_expected_pairs = array_slice($expected_pairs, 0, 1, true) + array_slice($expected_pairs, 10, 5, true) + array_slice($expected_pairs, 1, 1, true);
        $pairs = Person::getPairsBy($core_field_key, 15, '<');
        asort($pairs);
        asort($core_expected_pairs);
        $this->assertEquals($core_expected_pairs, $pairs);

        // getPairsBy meta field numeric
        $pairs = Person::getPairsBy($numeric_field_key, 20, '<');
        $this->assertEquals(20, count($pairs));
        $this->assertEquals(array_slice($expected_pairs, 0, 20, true), $pairs);

        // getPairsBy meta field string
        $string_meta_expected_pairs = array_slice($expected_pairs, 0, 1, true) + array_slice($expected_pairs, 10, 5, true) + array_slice($expected_pairs, 1, 1, true);
        $pairs = Person::getPairsBy($string_field_key, 15, '<');
        asort($pairs);
        asort($string_meta_expected_pairs);
        $this->assertEquals($string_meta_expected_pairs, $pairs);
    }


    public function testGetCount()
    {
        // Cleanup
        Person::deleteAll();

        for ($i=0; $i<50; $i++) {
            $person = new Person;
            $person->age = $i;
            $person->first_name = md5($i);
            $person->save();
        }

        $this->assertEquals(50, Person::getCount());
        $this->assertEquals(25, Person::getCount(array('numberposts'=>25)));
    }


    public function testTerms()
    {
        // Cleanup
        Person::deleteAll();

        // Set terms
        $person = new Person;
        $person->post_title = 'Term Test';
        $person->setTerms(array('term1'), 'irs');
        $post_id = $person->save();

        // Get terms
        $person = Person::find($post_id);
        $terms = $person->getTerms('irs');
        $term_names = \Taco\Util\Collection::pluck($terms, 'name');
        $this->assertEquals(array('term1'), $term_names);

        // Has term
        $term_id = current($terms)->term_id;
        $this->assertTrue($person->hasTerm($term_id));
    }
}
