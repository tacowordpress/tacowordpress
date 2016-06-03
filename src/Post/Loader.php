<?php
namespace Taco\Post;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Utility functions
 */

// There is probably a better way to do this
// But WordPress only allows you to make one call to register_taxonomy for a given taxonomy key.
// So we need to collect all the post types that use a given key then group together their register_taxonomy call.
// The global variable is just a way to gather the post types using each taxonomy.
global $taxonomies_infos;
$taxonomies_infos = array();

class Loader
{
        
    /**
     * Load all the posts
     */
    public static function loadAll()
    {
        global $taxonomies_infos;
        
        // Classes
        $subclasses = self::subclasses();
        foreach ($subclasses as $class) {
            $taxonomies_infos = array_merge(
                $taxonomies_infos,
                static::taxonomyInfo()
            );
            
            self::load($class);
        }
    }
    

    /**
     * Load a post type
     * @param string $class
     */
    public static function load($class)
    {
        $instance = new $class;
        $post_type = static::postType();

        // WordPress has a limit of 20 characters per
        if (strlen($post_type) > 20) {
            throw new \Exception('Post Type name exceeds maximum 20 characters: '.$post_type);
        }

        // This might happen if you're introducing a middle class between your post type and TacoPost
        // Ex: Foo extends \ClientTacoPost extends Taco\Post
        if (!$post_type) {
            return false;
        }
        
        //add_action('init', array($class, 'registerPostType'));
        static::registerPostType();
        add_action('save_post', array($class, 'addSaveHooks'));

        if (is_admin()) {
            // If we're in the edit screen, we want the post loaded
            // so that TacoPost::getFields knows which post it's working with.
            // This helps if you want TacoPost::getFields to use conditional logic
            // based on which post is currently being edited.
            $is_edit_screen = (
                is_array($_SERVER)
                && preg_match('/post.php\?post=[\d]{1,}/i', $_SERVER['REQUEST_URI'])
                && !Arr::iterable($_POST)
            );
            $is_edit_save = (
                preg_match('/post.php/i', $_SERVER['REQUEST_URI'])
                && Arr::iterable($_POST)
            );
            $post = null;
            if ($is_edit_screen && array_key_exists('post', $_GET)) {
                    $post = get_post($_GET['post']);
            } elseif ($is_edit_save) {
                $post = get_post($_POST['post_ID']);
            }
            if ($post && $post->post_type === static::postType()) {
                $instance->load($post);
            }
            
            add_action('admin_menu', array($class, 'addMetaBoxes'));
            add_action(sprintf('manage_%s_posts_columns', $post_type), array($class, 'addAdminColumns'), 10, 2);
            add_action(sprintf('manage_%s_posts_custom_column', $post_type), array($class, 'renderAdminColumn'), 10, 2);
            add_filter(sprintf('manage_edit-%s_sortable_columns', $post_type), array($class, 'makeAdminColumnsSortable'));
            add_filter('request', array($class, 'sortAdminColumns'));
            add_filter('posts_clauses', array($class, 'makeAdminTaxonomyColumnsSortable'), 10, 2);
            
            // Hide the title column in the browse view of the admin UI
            $is_browsing_index = (
                is_array($_SERVER)
                && preg_match('/edit.php\?post_type='.$post_type.'$/i', $_SERVER['REQUEST_URI'])
            );
            if ($is_browsing_index && static::hideTitleFromAdminColumns()) {
                add_action('admin_init', function () {
                    wp_register_style('hide_title_column_css', plugins_url('taco/base/hide_title_column.css'));
                    wp_enqueue_style('hide_title_column_css');
                });
            }
        }
    }
    
    
    /**
     * Register the taxonomies
     * WordPress limits calls to register_taxonomy to once per taxonomy
     * So we need to externalize this from a single TacoPostUtil::load call
     * @return integer Number of taxonomies registered
     */
    public static function registerTaxonomies()
    {
        global $taxonomies_infos;
        if (!Arr::iterable($taxonomies_infos)) {
            return 0;
        }
        
        // Start by grouping all taxonomy requests by taxonomy key
        $count = 0;
        $grouped = Collection::groupBy($taxonomies_infos, 'key');
        foreach ($grouped as $key => $key_taxonomies) {
            // Now get all the post types
            $post_types = Collection::pluck($key_taxonomies, 'post_type');
            $configs = Collection::pluck($key_taxonomies, 'config');
            
            // Now we can finally register this taxonomy
            register_taxonomy($key, $post_types, current($configs));
            
            $count++;
        }
        return $count;
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
            if (is_subclass_of($class, 'Taco\Post')) {
                $subclasses[] = $class;
            }
        }
        return $subclasses;
    }
}
