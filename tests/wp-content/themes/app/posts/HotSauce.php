<?php

/**
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

    public function getTaxonomies()
    {
        return array('keyword');
    }

    public function getMetaBoxes() {
        return [
            'Hot Sauce Info' => [
                'scovilles',
            ],
            'File Info' => [
                'image_path',
                'file_path',
            ]
        ];
    }

    public function getAdminColumns() {
        return [
            'scovilles',
        ];
    }
}
