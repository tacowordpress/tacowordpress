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


    public function testSaveSpecialChars()
    {
        // Cleanup
        Person::deleteAll();

        // Insert
        $person = new Person;
        $person->first_name = 'Foo & Bar';
        $person->last_name = 'Doe';
        $person->email = 'fooandbar@test.com';
        $person->post_title = 'Foo & Bar Doe';
        $post_id = $person->save();
        $this->assertTrue(is_int($post_id));

        // Load from insert
        $person = new Person;
        $this->assertTrue($person->load($post_id));
        $this->assertEquals('Foo & Bar', $person->first_name);
        $this->assertEquals('Doe', $person->last_name);
        $this->assertEquals('fooandbar@test.com', $person->email);
        $this->assertEquals('Foo & Bar Doe', $person->post_title);

        // Update from insert
        $person->first_name = 'Biz & Baz';
        $person->last_name = 'Dough';
        $person->email = 'bizandbazdough@test.com';
        $person->post_title = 'Biz & Baz Dough';
        $this->assertEquals($post_id, $person->save());
        $this->assertEquals('Biz & Baz', $person->first_name);
        $this->assertEquals('Dough', $person->last_name);
        $this->assertEquals('bizandbazdough@test.com', $person->email);
        $this->assertEquals('Biz & Baz Dough', $person->post_title);
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


    public function testDeleteAll()
    {
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

        // If no results, you get an empty array back
        $persons = Person::getBy($field_key, 'ZZZ');
        $this->assertEquals(0, count($persons));

        // Cleanup
        Person::deleteAll();

        // Test getting one by core field with special char
        $person = new Person;
        $person->post_title = 'Biz & Baz';
        $person->save();
        $this->assertEquals(1, count(Person::getBy('post_title', 'Biz & Baz')));
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


    public function testGetByMultiple()
    {
        // Cleanup
        Person::deleteAll();

        // Create posts
        // 0=B, 1=A, 2=B, 3=A, 4=B, 5=A
        for ($i=0; $i<10; $i++) {
            $person = new Person;
            $person->first_name = ($i % 2) ? 'A' : 'B';
            $person->age = $i;
            $person->save();
        }

        $conditions = array(
            array('first_name', 'A'),
            array('age', 5, '<='),
        );
        $args = array('orderby'=>'age', 'order'=>'asc');
        $results = Person::getByMultiple($conditions, $args);
        $this->assertEquals(3, count($results));
        $this->assertEquals('A', current($results)->first_name);
        $this->assertEquals(1, current($results)->age);
        $this->assertEquals('A', end($results)->first_name);
        $this->assertEquals(5, end($results)->age);


        // Test that getByMultiple works when you pass numberposts=1
        // This might fail if the algorithm in getByMultiple
        // changes and does premature restriction on numberposts
        // Cleanup
        Person::deleteAll();

        // Create posts
        $person_1 = new Person;
        $person_1->first_name = 'John';
        $person_1->age = 1;
        $person_1->save();

        $person_2 = new Person;
        $person_2->first_name = 'Jane';
        $person_2->age = 2;
        $person_2->save();

        $person_3 = new Person;
        $person_3->first_name = 'John';
        $person_3->age = 3;
        $person_3->save();

        $person_4 = new Person;
        $person_4->first_name = 'John';
        $person_4->age = 4;
        $person_4->save();

        // Only person 3 should be returned
        $conditions = array(
            array('first_name', 'John'),
            array('age', 1, '>'),
        );
        $args = array('numberposts'=>1, 'orderby'=>'age', 'order'=>'asc');
        $results = Person::getByMultiple($conditions, $args);
        $this->assertEquals(1, count($results));
        $this->assertEquals('John', current($results)->first_name);
        $this->assertEquals(3, current($results)->age);


        // Test that just a single condition works
        $conditions = array(
            array('age', 1, '>'),
        );
        $results = Person::getByMultiple($conditions);
        $this->assertEquals(3, count($results));
        $this->assertTrue(current($results)->age > 1);


        // WordPress handles post__in as an OR relationship relative
        // to the other conditions passed into get_posts.
        // This scenario tests that we can apply multiple conditions
        // and getByMultiple handles those properly internally
        // despite WordPress' post__in handling.
        Person::deleteAll();
        $person1 = new Person;
        $person1->post_title = 'person 1';
        $person1->post_date = '2015-01-11 00:00:00';
        $person1->save();

        $person2 = new Person;
        $person2->post_title = 'person 2';
        $person2->post_date = '2015-02-12 00:00:00';
        $person2->save();

        $person3 = new Person;
        $person3->post_title = 'person 3';
        $person3->post_date = '2015-03-13 00:00:00';
        $person3->save();

        $conditions = array(
            array('post_date', '2015-02-01 00:00:00', '>='),
            array('post_date', '2015-03-01 00:00:00', '<='),
        );
        $results = Person::getByMultiple($conditions);
        $this->assertEquals(1, count($results));
        $this->assertEquals('person 2', current($results)->post_title);


        // Test that getByMultiple works when your first condition is met
        // but not the second condition
        // Cleanup
        Person::deleteAll();

        // Create posts
        $person_1 = new Person;
        $person_1->first_name = 'John';
        $person_1->age = 1;
        $person_1->save();

        $conditions = array(
            array('first_name', 'John'),
            array('age', 5, '>='),
        );
        $results = Person::getByMultiple($conditions);
        $this->assertEquals(0, count($results));


        // Test that getByMultiple works when your
        // first condition matches
        // and second condition matches
        // and a third condition matches.
        // There should be zero overlap between conditions 1 and 2.
        // Cleanup
        Person::deleteAll();

        $person_1 = new Person;
        $person_1->first_name = 'John';
        $person_1->last_name = 'Doe';
        $person_1->age = 1;
        $person_1->save();

        $person_2 = new Person;
        $person_2->first_name = 'Jane';
        $person_2->last_name = 'Doe';
        $person_2->age = 2;
        $person_2->save();

        $person_3 = new Person;
        $person_3->first_name = 'Jim';
        $person_3->last_name = 'Doe';
        $person_3->age = 3;
        $person_3->save();

        $conditions = array(
            array('first_name', 'John'),
            array('age', 2),
            array('last_name', 'Doe'),
        );
        $results = Person::getByMultiple($conditions);
        $this->assertEquals(0, count($results));

        
        // TODO Test that passing post__in is abided by
    }

    public function testGetOneByMultiple()
    {
        // Cleanup
        Person::deleteAll();

        // Create posts
        // 0=B, 1=A, 2=B, 3=A, 4=B, 5=A
        for ($i=0; $i<10; $i++) {
            $person = new Person;
            $person->first_name = ($i % 2) ? 'A' : 'B';
            $person->age = $i;
            $person->save();
        }

        $conditions = array(
            array('first_name', 'A'),
            array('age', 5, '<='),
        );
        $args = array('orderby'=>'age', 'order'=>'asc');
        $person = Person::getOneByMultiple($conditions, $args);
        $this->assertInstanceOf('Person', $person);
        $this->assertEquals('A', $person->first_name);
        $this->assertTrue($person->age <= 5);
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


    public function testUnset()
    {
        // Cleanup
        Person::deleteAll();

        $person = new Person;
        $person->post_title = 'Jane';
        $person->age = 10;
        $person->save();

        $this->assertEquals(10, $person->age);
        unset($person->age);
        $this->assertEmpty($person->age);

        $person->save();
        $person_id = $person->ID;

        $person = Person::find($person_id);
        $this->assertEmpty($person->age);
    }
}
