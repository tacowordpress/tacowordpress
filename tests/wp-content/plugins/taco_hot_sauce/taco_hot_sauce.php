<?php

/**
 * Plugin Name: taco_hot_sauce
 * Description: HotSauce
 */

class HotSauce extends \Taco\Post {

  public function getFields() {
    return array(
      'scovilles'=>array('type'=>'number'),
    );
  }

  public function getSupports() {
    return array('title');
  }
}