<?php

/**
 * Plugin Name: taco_hot_sauce
 * Description: HotSauce
 */

class HotSauce extends \Taco\Post
{

    public function getFields()
    {
        return array(
            'scovilles'=>array('type'=>'number'),
            'image_path'=>array('type'=>'image'),
            'file_path'=>array('type'=>'file'),
        );
    }

    public function getSupports()
    {
        return array('title', 'editor');
    }
}
