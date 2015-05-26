<?php
namespace Taco;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Use WordPress posts like a normal model
 * You don't want to use this class directly. Extend it.
 */
class Post extends Base
{
    const ID = 'ID';
    const KEY_CLASS = 'class';
    const KEY_NONCE = 'nonce';
    const URL_SUBMIT = '/wp-content/plugins/taco/post/submit.php';

    public $singular    = null;
    public $plural      = null;
    public $last_error  = null;
    private $_terms     = array();
    
    
    public function getKey()
    {
        return $this->getPostType();
    }


    /**
     * Load a post by ID
     * @param mixed $id String or integer as post ID, or post object
     * @param bool $load_terms
     * @return bool
     */
    public function load($id, $load_terms = true)
    {
        $info = (is_object($id)) ? $id : get_post($id);
        if (!is_object($info)) return false;

        // Handle how WordPress converts special chars out of the DB
        // b/c even when you pass 'raw' as the 3rd partam to get_post,
        // WordPress will still encode the values.
        if (isset($info->post_title) && preg_match('/[&]{1,}/', $info->post_title)) {
            $info->post_title = html_entity_decode($info->post_title);
        }

        $this->_info = (array) $info;

        // meta
        $meta = get_post_meta($this->_info[self::ID]);
        if (Arr::iterable($meta)) {
            foreach ($meta as $k => $v) {
                $this->set($k, current($v));
            }
        }

        // terms
        if (!$load_terms) return true;
        $this->loadTerms();

        return true;
    }
    
    
    /**
     * Load the terms
     * @return bool
     */
    public function loadTerms()
    {
        $taxonomy_keys = $this->getTaxonomyKeys();
        if (!Arr::iterable($taxonomy_keys)) return false;
        
        // TODO Move this to somewhere more efficient
        // Check if this should be an instance of TacoTerm.
        // If not, the object will just be a default WP object from wp_get_post_terms below.
        $taxonomies_subclasses = array();
        $subclasses = Term\Loader::getSubclasses();
        foreach ($subclasses as $subclass) {
            $term_instance = new $subclass;
            $term_instance_taxonomy_key = $term_instance->getKey();
            foreach ($taxonomy_keys as $taxonomy_key) {
                if (array_key_exists($taxonomy_key, $taxonomies_subclasses)) continue;
                if ($term_instance_taxonomy_key !== $taxonomy_key) continue;

                $taxonomies_subclasses[$taxonomy_key] = $subclass;
                break;
            }
        }

        foreach ($taxonomy_keys as $taxonomy_key) {
            $terms = wp_get_post_terms($this->get(self::ID), $taxonomy_key);
            if (!Arr::iterable($terms)) continue;
            
            $terms = array_combine(
                array_map('intval', Collection::pluck($terms, 'term_id')),
                $terms
            );

            // Load Taco\Term if applicable
            if (array_key_exists($taxonomy_key, $taxonomies_subclasses)) {
                $terms = Term\Factory::createMultiple($terms, $taxonomy_key);
            }

            $this->_terms[$taxonomy_key] = $terms;
        }
        
        return true;
    }


    /**
     * Save a post
     * @param bool $exclude_post
     * @return mixed Integer on success: post ID, false on failure (with WP_Error accessible via getLastError)
     */
    public function save($exclude_post = false)
    {
        if (count($this->_info) === 0) return false;

        // set defaults
        $defaults = $this->getDefaults();
        if (count($defaults) > 0) {
            foreach ($defaults as $k => $v) {
                if (!array_key_exists($k, $this->_info)) $this->_info[$k] = $v;
            }
        }

        // separate regular post fields from meta
        $post = array();
        $meta = array();
        $post_fields = static::getCoreFieldKeys();
        $meta_fields = $this->getMetaFieldKeys();
        foreach ($this->_info as $k => $v) {
            if (in_array($k, $post_fields)) $post[$k] = $v;
            elseif (in_array($k, $meta_fields)) $meta[$k] = $v;
        }

        // save post
        $is_update = array_key_exists(self::ID, $post);
        if (!$exclude_post) {
            if ($is_update) wp_update_post($post);
            else {
                // Pass true as the second param to wp_insert_post
                // so that WP won't silently fail if we hit an error
                $id = wp_insert_post($post, true);
                if (!is_int($id)) {
                    $this->last_error = $id;
                    return false;
                }

                $this->_info[self::ID] = $id;
            }

            // Hack to fix ampersand saving in post titles
            // TODO See if there is a better way to do this
            if ($this->_info[self::ID] && array_key_exists('post_title', $post) && preg_match('/[&\']{1,}/', $post['post_title'])) {
                global $wpdb;
                $prepared_sql = $wpdb->prepare(
                    "UPDATE {$wpdb->posts} SET post_title=%s WHERE ID=%d",
                    $post['post_title'],
                    $this->_info[self::ID]
                );
                $wpdb->query($prepared_sql);
            }
        }

        // delete old meta
        if ($is_update) {
            $old_meta = get_post_meta($this->_info[self::ID]);
            if (Arr::iterable($old_meta)) {
                foreach ($old_meta as $old_meta_k => $old_meta_vals) {
                    if (preg_match('/^_/', $old_meta_k)) continue;

                    delete_post_meta($this->_info[self::ID], $old_meta_k);
                }
            }
        }

        // save meta
        if (count($meta) > 0) {
            foreach ($meta as $k => $v) {
                if ($is_update) update_post_meta($this->_info[self::ID], $k, $v);
                else add_post_meta($this->_info[self::ID], $k, $v);
            }
        }

        // save terms
        if (Arr::iterable($this->_terms) > 0) {
            foreach ($this->_terms as $taxonomy_key => $term_ids) {
                if (!Arr::iterable($term_ids)) continue;

                foreach ($term_ids as $n => $term_id) {
                    // Did a name get passed that's not a term_id?
                    // Try getting the term_id, or saving a new term and using that term_id
                    $convert_term_name_to_term_id = (
                        is_string($term_id)
                        && !is_numeric($term_id)
                        && $taxonomy_key !== 'post_tag'
                    );
                    if ($convert_term_name_to_term_id) {
                        $term = get_term_by('name', $term_id, $taxonomy_key);
                        if (!is_object($term)) {
                            $term = wp_insert_term($term_id, $taxonomy_key);
                        }
                        $term_id = (object) $term;
                    }

                    // The terms might come in as an ID or a whole term object
                    // This makes sure the wp_set_post_terms call only gets term IDs, not objects
                    if (is_object($term_id)) $term_ids[$n] = $term_id->term_id;
                }
                
                wp_set_post_terms($this->_info[self::ID], $term_ids, $taxonomy_key);
            }
        }

        return $this->_info[self::ID];
    }


    /**
     * Fields from posts table
     * @return array()
     */
    public static function getCoreFieldKeys()
    {
        return array(
            self::ID,
            'post_author',
            'post_date',
            'post_date_gmt',
            'post_content',
            'post_title',
            'post_category',
            'post_excerpt',
            'post_status',
            'comment_status',
            'ping_status',
            'post_password',
            'post_name',
            'to_ping',
            'pinged',
            'post_modified',
            'post_modified_gmt',
            'post_content_filtered',
            'post_parent',
            'guid',
            'menu_order',
            'post_type',
            'post_mime_type',
            'comment_count',
        );
    }


    /**
     * Get the meta fields
     * @return array
     */
    public function getFields()
    {
        return array();
    }


    /**
     * Get the meta field keys
     * If your admin UI is rendering slowly,
     * you may want to override this and return a hardcoded array
     * @return array
     */
    public function getMetaFieldKeys()
    {
        return array_keys($this->getFields());
    }


    /**
     * Get default values
     * Override this
     * @return array
     */
    public function getDefaults()
    {
        global $user;
        return array(
            'post_type'     => $this->getPostType(),
            'post_author'   => (is_object($user)) ? $user->ID : null,
            'post_date'     => current_time('mysql'),
            'post_category' => array(0),
            'post_status'   => 'publish'
        );
    }


    /**
     * Get the supporting fields
     * @return array
     */
    public function getSupports()
    {
        return array(
            'title',
            'editor', // content
            //'author',
            //'thumbnail',
            //'excerpt',
            //'trackbacks',
            //'custom-fields',
            //'comments',
            //'revisions',
            //'page-attributes',
            //'post-formats',
        );
    }


    /**
     * Get the last error from WordPress
     * @return object Instance of WP_Error
     */
    public function getLastError()
    {
        return $this->last_error;
    }


    /**
     * Add save hooks
     * @param integer $post_id
     * TODO add nonce check
     */
    public function addSaveHooks($post_id)
    {
        global $post;
        $class = get_called_class();
        $old_entry = new $class;
        $old_entry->load($post_id);

        // Make sure we have the right post type
        // Without this, you'll get weird cross-polination errors across post types
        if (!is_object($post) || $post->post_type !== $this->getPostType()) return;

        // Check autosave
        if (defined('DOING_AUTOSAVE') && DOING_AUTOSAVE) return $post_id;
        
        // Check that a post_type is defined. It's not in the case of a delete.
        if (!array_key_exists('post_type', $_POST)) return $post_id;
        
        // Check perms
        $check = ($_POST['post_type'] === 'page') ? 'edit_page' : 'edit_post';
        if (!current_user_can($check, $post_id)) return $post_id;

        // Get fields to assign
        $updated_entry = new $class;
        $field_keys = array_merge(static::getCoreFieldKeys(), $this->getMetaFieldKeys());

        // Assign vars
        foreach ($_POST as $k => $v) {
            if (in_array($k, $field_keys)) $updated_entry->set($k, $v);
        }

        return $updated_entry->save(true);
    }


    /**
     * Render a meta box
     * @param object $post
     * @param array $post_config
     * @param bool $return Return the output? If false, echoes the output
     */
    public function renderMetaBox($post, $post_config, $return = false)
    {
        $config = $this->getMetaBoxConfig($post_config['args']);
        if (!Arr::iterable($config['fields'])) return false;

        $this->load($post);

        $out = array();
        $out[] = '<table>';
        foreach ($config['fields'] as $name => $field) {
            // Hack to know if we're editing an existing post
            $is_existing_post = (
                is_array($_SERVER)
                && array_key_exists('REQUEST_URI', $_SERVER)
                && preg_match('/post=([\d]{1,})/', $_SERVER['REQUEST_URI'])
            );
            
            $field['type'] = (array_key_exists('type', $field)) ? $field['type'] : 'text';

            if (array_key_exists($name, $this->_info)) $field['value'] = $this->_info[$name];
            elseif ($is_existing_post && $field['type'] !== 'html') $field['value'] = null;

            $default = null;
            if (array_key_exists('default', $field)) {
                if ($field['type'] === 'select') $default = $field['options'][$field['default']];
                elseif ($field['type'] === 'image') $default = '<br>'.Html::image($field['default'], null, array('style'=>'max-width:100px;'));
                else $default = nl2br($field['default']);
            }
            $tr_class = $name;
            if ($field['type'] === 'hidden') {
                $tr_class .= ' hidden';
            }
            $out[] = sprintf(
                '<tr%s><td>%s</td><td>%s%s</td><td>%s</td></tr>',
                Html::attribs(array('class'=>$tr_class)),
                $this->getRenderLabel($name),
                $this->getRenderMetaBoxField($name, $field),
                (array_key_exists('description', $field)) ? Html::p($field['description'], array('class'=>'description')) : null,
                (!is_null($default)) ? sprintf('<p class="description">Default: %s</p>', $default) : null
            );
        }
        $out[] = '</table>';

        $html = join("\n", $out);
        if ($return) return $html;
        echo $html;
    }


    /**
     * Register the post type
     * Override this if you need to
     */
    public function registerPostType()
    {
        $config = $this->getPostTypeConfig();
        if (empty($config)) return;

        register_post_type($this->getPostType(), $config);
    }


    /**
     * Get the taxonomies
     * @return array
     */
    public function getTaxonomies()
    {
        return ($this->getPostType() === 'post') ? array('category') : array();
    }


    /**
     * Get a taxonomy by name
     * @param string $key
     * @return array
     */
    public function getTaxonomy($key)
    {
        $taxonomies = $this->getTaxonomies();
        if (!Arr::iterable($taxonomies)) return false;
        
        $taxonomy = (array_key_exists($key, $taxonomies)) ? $taxonomies[$key] : false;
        if (!$taxonomy) return false;
        
        // Handle all of these:
        // return array('one', 'two', 'three');
        // return array('one'=>'One Category', 'two', 'three');
        // return array(
        //     'one'=>array('label'=>'One Category'),
        //     'two'=>array('rewrite'=>array('slug'=>'foobar')),
        //     'three'
        // );
        if (is_string($taxonomy)) {
            $taxonomy = (is_numeric($key))
                ? array('label'=>self::getGeneratedTaxonomyLabel($taxonomy))
                : array('label'=>$taxonomy);
        } elseif (is_array($taxonomy) && !array_key_exists('label', $taxonomy)) {
            $taxonomy['label'] = self::getGeneratedTaxonomyLabel($key);
        }

        // Unlike WordPress default, we'll default to hierarchical=true
        // That's just more common for us
        if (!array_key_exists('hierarchical', $taxonomy)) {
            $taxonomy['hierarchical'] = true;
        }
        
        return $taxonomy;
    }
    
    
    /**
     * Get an autogenerated taxonomy label
     * @param string $str
     * @return string
     */
    public static function getGeneratedTaxonomyLabel($str)
    {
        return Str::human(str_replace('-', ' ', $str));
    }


    /**
     * Get the taxonomy keys
     * @return array
     */
    public function getTaxonomyKeys()
    {
        $taxonomies = $this->getTaxonomies();
        if (!Arr::iterable($taxonomies)) return array();

        $out = array();
        foreach ($taxonomies as $k => $taxonomy) {
            $taxonomy = $this->getTaxonomy($k);
            $out[] = $this->getTaxonomyKey($k, $taxonomy);
        }
        return $out;
    }


    /**
     * Get a taxonomy key
     * @param string $key
     * @param array $taxonomy
     * @return string
     */
    public function getTaxonomyKey($key, $taxonomy = array())
    {
        if (is_string($key)) return $key;
        if (is_array($taxonomy) && array_key_exists('label', $taxonomy)) {
            return Str::machine($taxonomy['label'], Base::SEPARATOR);
        }
        return $key;
    }


    /**
     * Get the taxonomy info
     * @return array
     */
    public function getTaxonomiesInfo()
    {
        $taxonomies = $this->getTaxonomies();
        if (!Arr::iterable($taxonomies)) return array();

        $out = array();
        foreach ($taxonomies as $k => $taxonomy) {
            $taxonomy = $this->getTaxonomy($k);
            $key = $this->getTaxonomyKey($k, $taxonomy);
            $out[] = array(
                'key'       => $key,
                'post_type' => $this->getPostType(),
                'config'    => $taxonomy
            );
        }
        return $out;
    }


    /**
     * Get hierarchical
     */
    public function getHierarchical()
    {
        return false;
    }


    /**
     * Get the post type config
     * @return array
     */
    public function getPostTypeConfig()
    {
        if (in_array($this->getPostType(), array('post', 'page'))) {
            return null;
        }
        
        return array(
            'labels' => array(
                'name'              => _x($this->getPlural(), 'post type general name'),
                'singular_name'     => _x($this->getSingular(), 'post type singular name'),
                'add_new'           => _x('Add New', $this->getSingular()),
                'add_new_item'      => __(sprintf('Add New %s', $this->getSingular())),
                'edit_item'         => __(sprintf('Edit %s', $this->getSingular())),
                'new_item'          => __(sprintf('New %s', $this->getPlural())),
                'view_item'         => __(sprintf('View %s', $this->getSingular())),
                'search_items'      => __(sprintf('Search %s', $this->getPlural())),
                'not_found'         => __(sprintf('No %s found', $this->getPlural())),
                'not_found_in_trash'=> __(sprintf('No %s found in Trash', $this->getPlural())),
                'parent_item_colon' => ''
            ),
            'hierarchical'        => $this->getHierarchical(),
            'public'              => $this->getPublic(),
            'supports'            => $this->getSupports(),
            'show_in_menu'        => $this->getShowInMenu(),
            'show_in_admin_bar'   => $this->getShowInAdminBar(),
            'menu_icon'           => $this->getMenuIcon(),
            'menu_position'       => $this->getMenuPosition(),
            'exclude_from_search' => $this->getExcludeFromSearch(),
            'has_archive'         => $this->getHasArchive(),
            'rewrite'             => $this->getRewrite(),
        );
    }


    /**
     * Is this post type public?
     * If not, users trying to visit the URL for a post of this type will get a 404
     * @return bool
     */
    public function getPublic()
    {
        return true;
    }
    
    
    /**
     * Does this have an archive?
     * @return bool
     */
    public function getHasArchive()
    {
        return false;
    }
    
    
    /**
     * Get any applicable rewrites
     * @return mixed
     */
    public function getRewrite()
    {
        return null;
    }


    /**
     * Get the menu icon
     * @return string
     */
    public function getMenuIcon()
    {
        // Look for these files by default
        // If your plugin directory contains an [post-type].png file, that will by default be the icon
        // Ex: hot-sauce.png
        $reflector = new \ReflectionClass(get_called_class());
        $dir = basename(dirname($reflector->getFileName()));
        $post_type = $this->getPostType();
        $fnames = array(
            $post_type.'.png',
            $post_type.'.gif',
            $post_type.'.jpg'
        );
        foreach ($fnames as $fname) {
            $fpath = sprintf('%s/%s/%s', WP_PLUGIN_DIR, $dir, $fname);
            if (!file_exists($fpath)) continue;

            return sprintf('%s/%s/%s', WP_PLUGIN_URL, $dir, $fname);
        }
        return '';
    }
    
    
    /**
     * Show in the admin menu?
     * @return bool
     */
    public function getShowInMenu()
    {
        return true;
    }
    
    
    /**
     * Show in the admin bar?
     * @return bool
     */
    public function getShowInAdminBar()
    {
        return true;
    }


    /**
     * Get menu position
     * @return integer
     */
    public function getMenuPosition()
    {
        return null;
    }


    /**
     * Sort the admin columns if necessary
     * @param array $vars
     * @return array
     */
    public function sortAdminColumns($vars)
    {
        if (!isset($vars['orderby'])) return $vars;

        $admin_columns = $this->getAdminColumns();
        if (!Arr::iterable($admin_columns)) return $vars;

        foreach ($admin_columns as $k) {
            if ($vars['orderby'] !== $k) continue;

            $vars = array_merge($vars, array(
                'meta_key'=> $k,
                'orderby' => 'meta_value'
            ));

            break;
        }
        return $vars;
    }
    
    
    /**
     * Make the admin taxonomy columns sortable
     * Admittedly this is a bit hackish
     * @link http://wordpress.stackexchange.com/questions/109955/custom-table-column-sortable-by-taxonomy-query
     * @param array $clauses
     * @param object $wp_query
     * @return array
     */
    public function makeAdminTaxonomyColumnsSortable($clauses, $wp_query)
    {
        global $wpdb;
        
        // Not sorting at all? Get out.
        if (!array_key_exists('orderby', $wp_query->query)) return $clauses;
        if ($wp_query->query['orderby'] !== 'meta_value') return $clauses;
        if (!array_key_exists('meta_key', $wp_query->query)) return $clauses;

        // No taxonomies defined? Get out.
        $taxonomies = $this->getTaxonomies();
        if (!Arr::iterable($taxonomies)) return $clauses;

        // Not sorting by a taxonomy? Get out.
        $sortable_taxonomy_key = null;
        foreach ($taxonomies as $taxonomy_key => $taxonomy) {
            $taxonomy_key = (is_int($taxonomy_key)) ? $taxonomy : $taxonomy_key;
            if ($wp_query->query['meta_key'] !== $taxonomy_key) continue;

            $sortable_taxonomy_key = $taxonomy_key;
            break;
        }
        if (!$sortable_taxonomy_key) return $clauses;
        if ($wp_query->query['meta_key'] !== $sortable_taxonomy_key) return $clauses;
        
        // Now we know which taxonomy the user is sorting by
        // but WordPress will think we're sorting by a meta_key.
        // Correct for this bad assumption by WordPress.
        $clauses['where'] = str_replace(
            "AND ({$wpdb->postmeta}.meta_key = '".$taxonomy."' )",
            '',
            $clauses['where']
        );
        
        // This is how we find the posts
        $clauses['join'] .= "
            LEFT OUTER JOIN {$wpdb->term_relationships} ON {$wpdb->posts}.ID={$wpdb->term_relationships}.object_id
            LEFT OUTER JOIN {$wpdb->term_taxonomy} USING (term_taxonomy_id)
            LEFT OUTER JOIN {$wpdb->terms} USING (term_id)
        ";
        $clauses['where'] .= "AND (taxonomy = '".$taxonomy."' OR taxonomy IS NULL)";
        $clauses['groupby'] = "object_id";
        $clauses['orderby'] = "GROUP_CONCAT({$wpdb->terms}.name ORDER BY name ASC)";
        $clauses['orderby'] .= (strtoupper($wp_query->get('order')) == 'ASC') ? 'ASC' : 'DESC';
        return $clauses;
    }


    /**
     * Get the admin columns
     * @return array
     */
    public function getAdminColumns()
    {
        return array_merge(
            array_keys($this->getFields()),
            $this->getTaxonomyKeys()
        );
    }
    
    
    /**
     * Hide the title from admin columns?
     * @return bool
     */
    public function getHideTitleFromAdminColumns()
    {
        if (in_array('title', $this->getAdminColumns())) return false;
        
        $supports = $this->getSupports();
        if (is_array($supports) && in_array('title', $supports)) return false;
        
        return true;
    }


    /**
     * Add meta boxes
     */
    public function addMetaBoxes()
    {
        $meta_boxes = $this->getMetaBoxes();
        $meta_boxes = $this->replaceMetaBoxGroupMatches($meta_boxes);
        if ($meta_boxes === self::METABOX_GROUPING_PREFIX) {
            $meta_boxes = $this->getPrefixGroupedMetaBoxes();
        }
        
        $post_type = $this->getPostType();
        foreach ($meta_boxes as $k => $config) {
            $config = $this->getMetaBoxConfig($config, $k);
            if (!array_key_exists('fields', $config)) continue;
            if (!Arr::iterable($config['fields'])) continue;
            
            add_meta_box(
                sprintf('%s_%s', $post_type, $k), // id
                $config['title'],                 // title
                array(&$this, 'renderMetaBox'),   // callback
                $post_type,                       // post_type
                $config['context'],               // context
                $config['priority'],              // priority
                $config                           // callback_args
            );
        }
    }
    

    /**
     * Get the post type
     */
    public function getPostType()
    {
        return (is_null($this->post_type))
            ? Str::machine(Str::camelToHuman(get_called_class()), Base::SEPARATOR)
            : $this->post_type;
    }


    /**
     * The public facing post type
     * @return string
     */
    public function getPublicPostType()
    {
        return $this->getPostType();
    }


    /**
     * Should this content type be excluded from search or no?
     * @return bool
     */
    public function getExcludeFromSearch()
    {
        return false;
    }


    /**
     * Get the pairs
     * @param array $args for get_posts()
     * @return array
     */
    public static function getPairs($args = array())
    {
        $instance = Post\Factory::create(get_called_class());

        // Optimize the query if no args
        // Unfortunately, WP doesn't provide a clean way to specify which columns to select
        // If WP allowed that, this custom SQL wouldn't be necessary
        if (!Arr::iterable($args)) {
            global $wpdb;
            $sql = sprintf(
                "SELECT
                    p.ID,
                    p.post_title
                FROM $wpdb->posts p
                WHERE p.post_type = '%s'
                AND (p.post_status = 'publish')
                ORDER BY p.post_title ASC",
                $instance->getPostType()
            );
            $results = $wpdb->get_results($sql);
            if (!Arr::iterable($results)) return array();
            
            return array_combine(
                Collection::pluck($results, 'ID'),
                Collection::pluck($results, 'post_title')
            );
        }
        
        // Custom args provided
        $default_args = array(
            'post_type'  => $instance->getPostType(),
            'numberposts'=> -1,
            'order'      => 'ASC',
            'orderby'    => 'title',
        );
        $args = (Arr::iterable($args)) ? $args : $default_args;
        if (!array_key_exists('post_type', $args)) $args['post_type'] = $instance->getPostType();

        $all = get_posts($args);
        if (!Arr::iterable($all)) return array();

        return array_combine(
            Collection::pluck($all, self::ID),
            Collection::pluck($all, 'post_title')
        );
    }
    
    
    /**
     * Get by a key/val
     * Note: This only works with custom meta fields, not core fields
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param mixed $args
     * @param bool $load_terms
     * @return array
     */
    public static function getPairsBy($key, $val, $compare = '=', $args = array())
    {
        $instance = Post\Factory::create(get_called_class());

        global $wpdb;
        if (in_array($key, static::getCoreFieldKeys())) {
            // Using a core field
            $sql = sprintf(
                "SELECT p.ID, p.post_title
                FROM $wpdb->posts p
                WHERE p.post_type = %s
                AND (p.post_status = 'publish')
                AND %s %s %s
                ORDER BY p.ID ASC",
                '%s',
                $key,
                $compare,
                '%s'
            );
            $prepared_sql = $wpdb->prepare($sql, $instance->getPostType(), $val);
        } else {
            // Number fields should be compared numerically, not alphabetically
            // Of course, this currently requires you to use type=number to achieve numeric sorting
            $fields = $instance->getFields();
            $field_is_numeric = ($fields[$key]['type'] === 'number');

            // Using a meta field
            $sql = sprintf("
                SELECT p.ID, p.post_title
                FROM $wpdb->postmeta pm
                INNER JOIN $wpdb->posts p
                ON p.ID = pm.post_id
                WHERE p.post_type = %s
                AND (p.post_status = 'publish')
                AND pm.meta_key = %s
                AND %s %s %s
                ORDER BY p.ID ASC",
                '%s',
                '%s',
                ($field_is_numeric) ? 'CAST(pm.meta_value AS DECIMAL)' : 'pm.meta_value',
                $compare,
                '%s'
            );
            $prepared_sql = $wpdb->prepare($sql, $instance->getPostType(), $key, $val);
        }
        $results = $wpdb->get_results($prepared_sql);
        $post_ids = Collection::pluck($results, 'ID');
        if (!Arr::iterable($args)) {
            if (!Arr::iterable($results)) return array();
            
            return array_combine(
                $post_ids,
                Collection::pluck($results, 'post_title')
            );
        }

        if (array_key_exists('post__in', $args)) {
            $args = (is_array($args)) ? $args : array_map('trim', explode(',', $args));
            $args['post__in'] = array_merge($args['post__in'], $post_ids);
        } else {
            $args['post__in'] = $post_ids;
        }

        // Need to use args? Call getBy.
        $records = static::getBy($key, $val, $compare, $args, false);
        if (!Arr::iterable($records)) return array();
    
        return array_combine(
            Collection::pluck($records, 'ID'),
            Collection::pluck($records, 'post_title')
        );
    }


    /**
     * Get all posts
     * @param bool $load_terms
     * @return array
     */
    public static function getAll($load_terms = true)
    {
        return static::getWhere(array(), $load_terms);
    }


    /**
     * Get posts with conditions
     * @param array $args
     * @param bool $load_terms
     * @return array
     */
    public static function getWhere($args = array(), $load_terms = true)
    {
        $instance = Post\Factory::create(get_called_class());

        // Allow sorting both by core fields and custom fields
        // See: http://codex.wordpress.org/Class_Reference/WP_Query#Order_.26_Orderby_Parameters
        $default_orderby = $instance->getDefaultOrderBy();
        $default_order = $instance->getDefaultOrder();
        $default_args = array(
            'post_type'  => $instance->getPostType(),
            'numberposts'=> -1,
            'orderby'    => $default_orderby,
            'order'      => $default_order,
        );

        // Sometimes you will specify a default orderby using getDefaultOrderBy
        if ($default_orderby !== 'menu_order') {
            $fields = $instance->getFields();
            if (array_key_exists($default_orderby, $fields)) {
                $default_args['meta_key'] = $default_orderby;
                
                // Number fields should be sorted numerically, not alphabetically
                // Of course, this currently requires you to use type=number to achieve numeric sorting
                $default_args['orderby'] = ($fields[$default_orderby]['type'] === 'number')
                    ? 'meta_value_num'
                    : 'meta_value';
            }
        }

        // But other times, you'll just pass in orderby via $args,
        // e.g. if you call getBy or getWhere with the $args param
        if (array_key_exists('orderby', $args)) {
            $fields = $instance->getFields();
            if (array_key_exists($args['orderby'], $fields)) {
                $args['meta_key'] = $args['orderby'];
                
                // Number fields should be sorted numerically, not alphabetically
                // Of course, this currently requires you to use type=number to achieve numeric sorting
                $args['orderby'] = ($fields[$args['orderby']]['type'] === 'number')
                    ? 'meta_value_num'
                    : 'meta_value';
            }
        }
        
        $criteria = array_merge($default_args, $args);
        return Post\Factory::createMultiple(get_posts($criteria), $load_terms);
    }


    /**
     * Get one post
     * @param array $args
     * @return object
     */
    public static function getOneWhere($args = array())
    {
        $args['numberposts'] = 1;
        $result = static::getWhere($args);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get by a key/val
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param mixed $args
     * @param bool $load_terms
     * @return array
     */
    public static function getBy($key, $val, $compare = '=', $args = array(), $load_terms = true)
    {
        $instance = Post\Factory::create(get_called_class());

        // Hack to handle fields like post_date, post_title, etc.
        if (!in_array($key, static::getCoreFieldKeys())) {
            $args = array_merge($args, array(
                'meta_query'=>array(
                    array(
                        'key'=>$key,
                        'compare'=>$compare,
                        'value'=>$val
                    )
                ),
            ));
            return static::getWhere($args, $load_terms);
        }

        $orderby = (array_key_exists('orderby', $args) && in_array($args['orderby'], static::getCoreFieldKeys()))
            ? $args['orderby']
            : 'p.post_date';
        $order = (array_key_exists('order', $args) && in_array(strtoupper($args['order']), array('ASC', 'DESC')))
            ? $args['order']
            : 'DESC';

        // First we are going to get the post IDs for matching records.
        // Then we will append that to our $args so that the remaining filters (if applicable) can be applied
        global $wpdb;
        $sql = sprintf(
            "SELECT p.ID
            FROM $wpdb->posts p
            WHERE p.post_type = %s
            AND (p.post_status = %s)
            AND %s %s %s
            ORDER BY %s %s
            %s",
            '%s',
            '%s',
            $key,
            $compare,
            '%s',
            $orderby,
            $order,
            (array_key_exists('numberposts', $args))
                ? sprintf("LIMIT %d", (int) $args['numberposts'])
                : null
        );
        $prepared_sql = $wpdb->prepare(
            $sql,
            $instance->getPostType(),
            (array_key_exists('post_status', $args)) ? $args['post_status'] : 'publish',
            $val
        );
        $results = $wpdb->get_results($prepared_sql);
        if (!Arr::iterable($results)) {
            return $results;
        }

        $post_ids = Collection::pluck($results, 'ID');
        if (!Arr::iterable($args)) {
            return Post\Factory::createMultiple($post_ids, $load_terms);
        }

        if (array_key_exists('post__in', $args)) {
            $args = (is_array($args)) ? $args : array_map('trim', explode(',', $args));
            $args['post__in'] = array_merge($args['post__in'], $post_ids);
        } else {
            $args['post__in'] = $post_ids;
        }

        return static::getWhere($args, $load_terms);
    }


    /**
     * Get a single record by a key/val
     * Note: This only works with custom meta fields, not core fields
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param mixed $args
     * @param bool $load_terms
     * @return array
     */
    public static function getOneBy($key, $val, $compare = '=', $args = array(), $load_terms = true)
    {
        $args['numberposts'] = 1;
        $result = static::getBy($key, $val, $compare, $args, $load_terms);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get by multiple conditions
     * Conditions get treated with AND logic
     * TODO Make this more efficient
     * @param array $conditions
     * @param mixed $args
     * @param bool $load_terms
     * @return array
     */
    public static function getByMultiple($conditions, $args = array(), $load_terms = true)
    {
        if (!Arr::iterable($conditions)) {
            return self::getWhere($args, $load_terms);
        }

        // Extract numberposts if passed in $args
        // because we don't want to prematurely restrict the result set.
        $numberposts = (array_key_exists('numberposts', $args))
            ? $args['numberposts']
            : null;
        unset($args['numberposts']);

        // First, get all the post_ids
        $post_ids = array();
        foreach ($conditions as $k=>$condition) {
            // Conditions can have numeric or named keys:
            // ['key1', 'val1', '=']
            // ['key'=>'foo', 'val'=>'bar', '=']
            $condition_values = array_values($condition);
            $key = (array_key_exists('key', $condition)) ? $condition['key'] : $condition_values[0];
            $value = (array_key_exists('value', $condition)) ? $condition['value'] : $condition_values[1];

            // Make sure we have a compare
            $compare = '=';
            if (array_key_exists('compare', $condition)) {
                $compare = $condition['compare'];
            } elseif (array_key_exists(2, $condition_values)) {
                $compare = $condition_values[2];
            }

            // Get the posts from getBy
            // Trying to replicate getBy's logic could be significant
            // b/c it handles both core and meta fields
            $posts = self::getBy($key, $value, $compare, $args, false);

            // If no results, that means we found a condition
            // that was not met by any posts.
            // So we need to clear out $post_ids so that
            // we don't get false positives.
            if (!Arr::iterable($posts)) {
                $post_ids = array();
                break;
            }

            // Using array_intersect here gives us the AND relationship
            // array_merge would give us OR
            $new_post_ids = Collection::pluck($posts, 'ID');
            $post_ids = (Arr::iterable($post_ids))
                ? array_intersect($post_ids, $new_post_ids)
                : $new_post_ids;
        }

        // You can't do this within the loop b/c WordPress treats
        // post__in as an OR relationship when passed to get_posts
        if (Arr::iterable($post_ids)) {
            $args['post__in'] = $post_ids;
        }

        // Reapply numberposts now that we have our desired post_ids
        if (!is_null($numberposts)) {
            $args['numberposts'] = $numberposts;
        }

        return (Arr::iterable($post_ids))
            ? self::getWhere($args, $load_terms)
            : array();
    }


    /**
     * Get one by multiple conditions
     * Conditions get treated with AND logic
     * TODO Make this more efficient
     * @param array $conditions
     * @param mixed $args
     * @param bool $load_terms
     * @return array
     */
    public static function getOneByMultiple($conditions, $args = array(), $load_terms = true)
    {
        $default_args = array('numberposts'=>1);
        $args = array_merge($args, $default_args);
        $results = self::getByMultiple($conditions, $args, $load_terms);
        return (Arr::iterable($results))
            ? current($results)
            : null;
    }
    
    
    /**
     * Get by a taxonomy and term
     * @param string $taxonomy
     * @param mixed $terms
     * @param string $field
     * @param array $args
     * @param bool $load_terms
     * @return array
     */
    public static function getByTerm($taxonomy, $terms, $field = 'slug', $args = array(), $load_terms = true)
    {
        $args = array_merge($args, array(
            'tax_query'=>array(
                array(
                    'taxonomy'=>$taxonomy,
                    'terms'=>$terms,
                    'field'=>$field
                )
            ),
        ));
        return static::getWhere($args, $load_terms);
    }
    
    
    /**
     * Get one by a taxonomy and term
     * @param string $taxonomy
     * @param mixed $terms
     * @param string $field
     * @param array $args
     * @param bool $load_terms
     * @return object
     */
    public static function getOneByTerm($taxonomy, $terms, $field = 'slug', $args = array(), $load_terms = true)
    {
        $args['numberposts'] = 1;
        $result = static::getByTerm($taxonomy, $terms, $field, $args, $load_terms);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get results by page
     * @param int $page
     * @param array $args
     * @param string $sort
     * @param bool $load_terms
     */
    public static function getPage($page = 1, $args = array(), $load_terms = true)
    {
        $instance = Post\Factory::create(get_called_class());

        $criteria = array(
            'post_type' => $instance->getPostType(),
            'orderby' => 'date',
            'order' => 'DESC',
            'posts_per_page' => $instance->getPostsPerPage(),
            'offset' => ($page - 1) * $instance->getPostsPerPage()
        );
        $criteria = array_merge($criteria, $args);
        return Post\Factory::createMultiple(get_posts($criteria), $load_terms);
    }


    /**
     * Get results by page
     * TODO Make this more efficient
     * @param array $args
     */
    public static function getPageCount($args = array())
    {
        $instance = Post\Factory::create(get_called_class());

        $posts_per_page = $instance->getPostsPerPage();
        $criteria = array(
            'post_type'=>$instance->getPostType(),
            'posts_per_page'=>-1
        );
        $criteria = array_merge($criteria, $args);

        $query = new \WP_Query($criteria);
        $n = 0;
        while($query->have_posts()) {
            $n++;
            $query->next_post();
        }

        return ceil($n / $posts_per_page);
    }


    /**
     * Get count
     * TODO Make this more efficient
     * @param array $args
     */
    public static function getCount($args = array())
    {
        return count(static::getPairs($args));
    }


    /**
     * Get the posts per page
     * @return int
     */
    public function getPostsPerPage()
    {
        return get_option('posts_per_page');
    }


    /**
     * Set the terms
     * @param array $term_ids
     * @param string $taxonomy
     * @param bool $append
     * @return array
     */
    public function setTerms($term_ids, $taxonomy = null, $append = false)
    {
        $taxonomy = ($taxonomy) ? $taxonomy : 'post_tag';
        if (!is_array($this->_terms)) $this->_terms = array();
        if (!array_key_exists($taxonomy, $this->_terms)) $this->_terms[$taxonomy] = array();

        $this->_terms[$taxonomy] = ($append)
            ? array_merge($this->_terms[$taxonomy], $term_ids)
            : $term_ids;
        return $this->_terms[$taxonomy];
    }


    /**
     * Get the terms
     * @param string $taxonomy
     * @return array
     */
    public function getTerms($taxonomy = null)
    {
        if ($taxonomy) {
            return (array_key_exists($taxonomy, $this->_terms))
                ? $this->_terms[$taxonomy]
                : array();
        }

        return $this->_terms;
    }


    /**
     * Does this post have this term?
     * @param integer $term_id
     * @return bool
     */
    public function hasTerm($term_id)
    {
        $taxonomy_terms = $this->getTerms();
        if (!Arr::iterable($taxonomy_terms)) return false;

        foreach ($taxonomy_terms as $taxonomy_key => $terms) {
            if (!Arr::iterable($terms)) continue;

            foreach ($terms as $term) {
                if ((int) $term->term_id === (int) $term_id) return true;
            }
        }

        return false;
    }


    /**
     * Get the permalink
     * @return string
     */
    public function getPermalink()
    {
        return get_permalink($this->get('ID'));
    }


    /**
     * Get the edit permalink
     * @link http://codex.wordpress.org/Template_Tags/get_edit_post_link
     * @param string $context
     * @return string
     */
    public function getEditPermalink($context = 'display')
    {
        return get_edit_post_link($this->get('ID'), $context);
    }


    /**
     * Get the title through the_title filter
     * @return string
     */
    public function getTheTitle()
    {
        return apply_filters('the_title', $this->get('post_title'));
    }


    /**
     * Get the content through the_content filter
     * @return string
     */
    public function getTheContent()
    {
        return apply_filters('the_content', $this->get('post_content'));
    }


    /**
     * Get the excerpt through the_content filter
     * Accepted values for length_unit: 'char', 'word'
     * @param array $args
     * @return string
     */
    public function getTheExcerpt($args = array())
    {
        $default_args = array(
            'length' => 150,
            'length_unit' => 'char',
            'strip_shortcodes' => true,
            'hellip' => '&hellip;'
        );
        $args = (Arr::iterable($args))
            ? array_merge($default_args, $args)
            : $default_args;
        extract($args);
        
        $excerpt = $this->get('post_excerpt');
        if (!strlen($excerpt)) {
            $excerpt = strip_tags($this->get('post_content'));
            if ($length_unit == 'char') {
                $excerpt = Str::shortenWordsByChar($excerpt, $length, $hellip);
            } elseif ($length_unit == 'word') {
                $excerpt = Str::shortenWords($excerpt, $length, $hellip);
            }
            $excerpt = apply_filters('the_excerpt', $excerpt);
        }
        
        return ($strip_shortcodes) ? strip_shortcodes($excerpt) : $excerpt;
    }


    /**
     * Get the thumbnail (featured image)
     * @param string $size
     * @param string $alt
     * @param bool $use_alt_as_title
     * @return string HTML img tag
     */
    public function getThePostThumbnail($size = 'full', $alt = '', $use_alt_as_title = false)
    {
        if (!has_post_thumbnail($this->get('ID'))) return false;
        
        $thumbnail = get_the_post_thumbnail($this->get('ID'), $size, array(
            'title' => ($use_alt_as_title ? $alt : ''),
            'alt' => $alt
        ));
        return $thumbnail;
    }


    /**
     * Get the image attachment array for post's featured image
     * @param string $size
     * @param string $property
     * @return array or string
     */
    public function getPostAttachment($size = 'full', $property = null)
    {
        $post_id = $this->get('ID');
        if (!has_post_thumbnail($post_id)) return false;
        
        $attachment_id = get_post_thumbnail_id($post_id);
        $image_properties = array(
            'url',
            'width',
            'height',
            'is_resized'
        );
        $image_array = array_combine(
            $image_properties,
            array_values(wp_get_attachment_image_src($attachment_id, $size))
        );
        if (in_array($property, $image_properties)) {
            return $image_array[$property];
        }
        return $image_array;
    }


    /**
     * Get the image attachment URL for post's featured image
     * @param string $size
     * @return string
     */
    public function getPostAttachmentURL($size = 'full')
    {
        return $this->getPostAttachment($size, 'url');
    }


    /**
     * Get the anchor tag
     * @param string $field_key
     * @return string HTML <a>
     */
    public function getAnchorTag($field_key = 'post_title')
    {
        return parent::getAnchorTag($field_key);
    }


    /**
     * Delete the post
     * @param $bypass_trash (aka force_delete per wp_delete_post)
     * @return bool
     */
    public function delete($bypass_trash = false)
    {
        return wp_delete_post($this->get('ID'), $bypass_trash);
    }
    
    
    /**
     * Get the default order by
     * @return string
     */
    public function getDefaultOrderBy()
    {
        return 'menu_order';
    }
    
    
    /**
     * Get the default order
     * @return string
     */
    public function getDefaultOrder()
    {
        return 'ASC';
    }
    
    
    /**
     * Render a public field
     * @param string $key See code below for accepted vals
     * @param array $field
     * @param bool $load_value
     * @return string
     */
    public function getRenderPublicField($key, $field = null, $load_value = true)
    {
        $class = get_called_class();
        if ($key === self::KEY_CLASS) {
            $attribs = array('type'=>'hidden', 'name'=>$key, 'value'=>$class);
            return Html::tag('input', null, $attribs);
        }
        if ($key === self::KEY_NONCE) {
            $attribs = array('type'=>'hidden', 'name'=>$key, 'value'=>wp_create_nonce($this->getNonceAction()));
            return Html::tag('input', null, $attribs);
        }

        if ($load_value) {
            if (!is_array($field)) {
                $field = self::getField($key);
            }
            if (!array_key_exists('value', $field)) {
                $field['value'] = $this->$key;
            }
        }
        return self::getRenderMetaBoxField($key, $field);
    }
    
    
    /**
     * Get the nonce/CSRF action
     * @return string
     */
    public function getNonceAction()
    {
        return md5(join('_', array(
            __FILE__,
            get_called_class(),
            md5_file(__FILE__),
            $this->getPostType()
        )));
    }
    
    
    /**
     * Verify the nonce
     * @param string $nonce
     * @return bool
     */
    public function verifyNonce($nonce)
    {
        return wp_verify_nonce($nonce, $this->getNonceAction());
    }
    
    
    /**
     * Get the public form key
     * This is useful for integrations with FlashData and the like
     * when you want to persist data from the form to another page.
     * For instance, in the case of error messages and form values.
     * @param string $suffix
     * @return string
     */
    public function getPublicFormKey($suffix = null)
    {
        $val = sprintf('%s_public_form', $this->getPostType());
        return ($suffix) ? sprintf('%s_%s', $val, $suffix) : $val;
    }


    /**
     * Delete all the posts
     * TODO Make this more efficient
     * @param $bypass_trash (aka force_delete per wp_delete_post)
     * @return integer Number of posts deleted
     */
    public static function deleteAll($bypass_trash = false)
    {
        $num_deleted = 0;

        $all = static::getAll(false);
        if (!Arr::iterable($all)) return $num_deleted;

        foreach ($all as $post) {
            if ($post->delete($bypass_trash)) {
                $num_deleted++;
            }
        }

        return $num_deleted;
    }


    /**
     * Find a post
     * @param integer $post_id
     * @return object
     */
    public static function find($post_id, $load_terms = true)
    {
        $instance = Post\Factory::create(get_called_class());
        $instance->load($post_id, $load_terms);
        return $instance;
    }
}
