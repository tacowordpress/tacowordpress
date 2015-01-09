<?php

/**
 * Plugin Name: taco_person
 * Description: Person
 */

class Person extends \Taco\Post {

  public function getFields() {
    return array(
      'first_name'=>array('type'=>'text'),
      'last_name'=>array('type'=>'text'),
      'email'=>array('type'=>'email'),
      'age'=>array('type'=>'number'),
    );
  }

  public function getTaxonomies() {
    return array('irs');
  }
}