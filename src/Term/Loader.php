<?php
namespace Taco\Term;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Utility functions for loading the taco taxonomies
 */

class Loader
{
    
    /**
     * Load all taco terms
     */
    public static function loadAll()
    {
        // Classes
        $subclasses = self::getSubclasses();
        foreach ($subclasses as $class) {
            self::load($class);
        }
    }
    

    /**
     * Load a term
     * @param string $class
     */
    public static function load($class)
    {
        $instance = new $class;
        $taxonomy_key = $instance->getTaxonomyKey();
    
        if (is_admin()) {
            add_action(sprintf('created_%s', $taxonomy_key), array($instance, 'addSaveHooks'));
            add_action(sprintf('edited_%s', $taxonomy_key), array($instance, 'addSaveHooks'));
            add_action(sprintf('%s_add_form_fields', $taxonomy_key), array($instance, 'addMetaBoxes'));
            add_action(sprintf('%s_edit_form_fields', $taxonomy_key), array($instance, 'addMetaBoxes'));
            
            add_action(sprintf('manage_edit-%s_columns', $taxonomy_key), array($instance, 'addAdminColumns'), 10, 3);
            add_action(sprintf('manage_%s_custom_column', $taxonomy_key), array($instance, 'renderAdminColumn'), 10, 3);
            
            // TODO add sorting
            //add_filter(sprintf('manage_edit-%s_sortable_columns', $taxonomy_key), array($instance, 'makeAdminColumnsSortable'));
            //add_filter('request', array($instance, 'sortAdminColumns'));
        }
    }


    /**
     * Get all subclasses
     * @return array
     */
    public static function getSubclasses()
    {
        $subclasses = array();
        foreach (get_declared_classes() as $class) {
            if (is_subclass_of($class, 'Taco\Term')) {
                $subclasses[] = $class;
            }
        }
        return $subclasses;
    }
}
