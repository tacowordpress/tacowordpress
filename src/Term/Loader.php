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
        $subclasses = self::subclasses();
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
        $taxonomy_key = static::taxonomyKey();
    
        if (is_admin()) {
            add_action(sprintf('created_%s', $taxonomy_key), array($class, 'addSaveHooks'));
            add_action(sprintf('edited_%s', $taxonomy_key), array($class, 'addSaveHooks'));
            add_action(sprintf('%s_add_form_fields', $taxonomy_key), array($class, 'addMetaBoxes'));
            add_action(sprintf('%s_edit_form_fields', $taxonomy_key), array($class, 'addMetaBoxes'));
            
            add_action(sprintf('manage_edit-%s_columns', $taxonomy_key), array($class, 'addAdminColumns'), 10, 3);
            add_action(sprintf('manage_%s_custom_column', $taxonomy_key), array($class, 'renderAdminColumn'), 10, 3);
            
            // TODO add sorting
            // add_filter(sprintf('manage_edit-%s_sortable_columns', $taxonomy_key), array($class, 'makeAdminColumnsSortable'));
            // add_filter('request', array($class, 'sortAdminColumns'));
        }
    }


    /**
     * Get all subclasses
     * @return array
     */
    public static function getSubclasses()
    {
        return static::subclasses();
    }
    public static function subclasses()
    {
        $subclasses = array();
        foreach (get_declared_classes() as $class) {
            if (method_exists($class, 'isLoadable') && $class::isLoadable() === false) {
                continue;
            }
            if (is_subclass_of($class, 'Taco\Term')) {
                $subclasses[] = $class;
            }
        }
        return $subclasses;
    }
}
