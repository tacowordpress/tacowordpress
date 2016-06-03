<?php
namespace Taco\Term;

use Taco\Base as Base;
use Taco\Term as Term;
use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Taco term factory
 * Generates instances of classes extending \Taco\Term
 */
class Factory
{
    
    /**
     * Create an instance based on a term object
     * This basically autoloads the meta data
     * @param mixed $term Object or term id
     * @param string $taxonomy
     * @return object
     */
    public static function create($term, $taxonomy = null)
    {
        // Ex: Taco\Term\Factory::create('Keyword')
        if (is_string($term) && class_exists($term)) {
            return new $term;
        }

        // Prevent existing Taco term from being loaded again
        if(is_subclass_of($term, 'Taco\Base')) {
            return $term;
        }

        if (!is_object($term)) {
            $term = get_term($term, $taxonomy);
        }
        
        // TODO Refactor how this works to be more explicit and less guess
        $class = str_replace(' ', '', ucwords(str_replace(Base::SEPARATOR, ' ', $term->taxonomy)));
        if (!class_exists($class)) {
            $class = str_replace(' ', '\\', ucwords(str_replace(Base::SEPARATOR, ' ', $term->taxonomy)));
        }

        $instance = new $class;
        $instance->load($term->term_id);
        return $instance;
    }
    
    
    /**
     * Create multiple instances based on term objects
     * This basically autoloads the meta data
     * @param array $terms
     * @param string $taxonomy
     * @return array
     */
    public static function createMultiple($terms, $taxonomy = null)
    {
        if (!Arr::iterable($terms)) {
            return $terms;
        }
        
        $out = array();
        foreach ($terms as $term) {
            $instance = self::create($term, $taxonomy);
            $out[$instance->get('term_id')] = $instance;
        }
        return $out;
    }
}
