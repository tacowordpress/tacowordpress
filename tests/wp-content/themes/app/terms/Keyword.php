<?php

/**
 * Plugin Name: taco_keyword
 * Description: Keyword
 */

class Keyword extends \Taco\Term
{
    public function getFields()
    {
        return array(
            'external_url'=>array('type'=>'url'),
            'heat_level'=>array('type'=>'number'),
        );
    }
}