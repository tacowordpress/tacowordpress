<?php

/**
 * Plugin Name: taco_person
 * Description: Person
 */

class Person extends \Taco\Post
{

    public function getFields()
    {
        return array(
            'first_name'=>array('type'=>'text', 'required'=>true, 'placeholder'=>'1st name', 'label'=>'Your first name'),
            'middle_name'=>array('type'=>'text'),
            'last_name'=>array('type'=>'text', 'label'=>'Your last name'),
            'email'=>array('type'=>'email'),
            'age'=>array('type'=>'number'),
            'quote'=>array('type'=>'textarea'),
            'favorite_color'  =>array('type'=>'color'),
            'is_professional' =>array('type'=>'checkbox'),
            'favorite_sauce'  =>array(
              'type'=>'select',
              'options'=>array(
                'mild'  =>'Mild',
                'medium'=>'Medium',
                'spicy' =>'Spicy'
              ),
            ),
            'favorite_way_to_break_select'=>array(
                'type'=>'select',
                'options'=>array(
                    'closed_double'=>'"Closed double"',
                    'unclosed_double'=>'"Unclosed double',
                    'closed_single'=>"'Closed single'",
                    'unclosed_single'=>"'Unclosed single",
                    'closed_html'=>'<b>Closed HTML</b>',
                    'unclosed_html'=>'<b>Unclosed HTML',
                ),
            ),
            'photo_path'      =>array('type'=>'image'),
            'resume_pdf_path' =>array('type'=>'file'),
            'website_url'     =>array('type'=>'url'),
        );
    }

    public function getTaxonomies()
    {
        return array('irs');
    }
}
