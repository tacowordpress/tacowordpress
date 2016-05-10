<?php
namespace Taco\Post;

use Taco\Base as Base;
use Taco\Post as Post;
use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Custom post factory
 * Generates instances of classes extending CustomPostType
 */
class Factory
{
    
    /**
     * Create an instance based on a WP post
     * This basically autoloads the meta data
     * @param object $post
     * @param bool $load_terms
     * @return object
     */
    public static function create($post, $load_terms = true)
    {
        // Ex: Taco\Post\Factory::create('Video')
        if (is_string($post) && class_exists($post)) {
            return new $post;
        }

        $original_post = $post;
        if (!is_object($post)) {
            $post = get_post($post);
        }
        if (!is_object($post)) {
            throw new \Exception(sprintf('Post %s not found in the database', json_encode($original_post)));
        }
        
        // TODO Refactor how this works to be more explicit and less guess
        $class = str_replace(' ', '', ucwords(str_replace(Base::SEPARATOR, ' ', $post->post_type)));
        if (!class_exists($class)) {
            $class = str_replace(' ', '\\', ucwords(str_replace(Base::SEPARATOR, ' ', $post->post_type)));
        }
        
        $instance = new $class;
        $instance->load($post, $load_terms);
        return $instance;
    }
    
    
    /**
     * Create multiple instances based on WP posts
     * This basically autoloads the meta data
     * @param array $posts
     * @param bool $load_terms
     * @return array
     */
    public static function createMultiple($posts, $load_terms = true)
    {
        if (!Arr::iterable($posts)) {
            return $posts;
        }
        
        $out = array();
        foreach ($posts as $k => $post) {
            if (!get_post_status($post)) {
                continue;
            }
            $record = self::create($post, $load_terms);
            $out[$k] = $record;
        }
        return $out;
    }
}
