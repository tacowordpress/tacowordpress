<?php
namespace Taco;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

class Term extends Base
{
    const ID = 'term_id';
    
    public $taxonomy_key = null;


    /**
     * Get a single field
     * @param string $key
     * @param bool $convert_value Convert the value (for select fields)
     */
    public function get($key, $convert_value = false)
    {
        // See comment further down about WordPress not removing quote marks upon unserialization
        $val = parent::get($key);
        return str_replace('\"', '"', $val);
    }


    /**
     * Get the key
     */
    public function getKey()
    {
        return $this->getTaxonomyKey();
    }


    /**
     * Get the taxonomy key
     */
    public function getTaxonomyKey()
    {
        $called_class_segments = explode('\\', get_called_class());
        $class_name = end($called_class_segments);
        return (is_null($this->taxonomy_key))
            ? Str::machine(Str::camelToHuman($class_name), Base::SEPARATOR)
            : $this->taxonomy_key;
    }


    /**
     * Add meta boxes
     * @param object $term
     */
    public function addMetaBoxes($term = null)
    {
        if (is_object($term)) {
            $this->load($term->term_id);
        }

        $meta_boxes = $this->getMetaBoxes();
        $meta_boxes = $this->replaceMetaBoxGroupMatches($meta_boxes);
        if ($meta_boxes === self::METABOX_GROUPING_PREFIX) {
            $meta_boxes = $this->getPrefixGroupedMetaBoxes();
        }

        foreach ($meta_boxes as $k => $field_config) {
            $this->renderMetaBox($k, array(
                'args'=>$field_config
            ));
        }
    }


    /**
     * Render a meta box
     * @param object $taxonomy_key
     * @param array $term_config
     * @param bool $return Return the output? If false, echoes the output
     */
    public function renderMetaBox($taxonomy_key, $term_config, $return = false)
    {
        $config =& $term_config['args'];
        if (!Arr::iterable($config['fields'])) {
            return false;
        }

        $extra = get_option($this->getOptionID());

        // Hack to determine if we're on the category admin page
        $is_quick_add_page = (!preg_match('/tag_ID/', $_SERVER['REQUEST_URI']));

        $out = array();

        if ($is_quick_add_page) {
            $out[] = '<table class="form-table">';
        }

        foreach ($config['fields'] as $name => $field) {
            if ($is_quick_add_page && is_array($field) && array_key_exists('value', $field)) {
                $field['value'] = $field['value'];
            } elseif (is_array($extra) && array_key_exists($name, $extra)) {
                $field['value'] = $extra[$name];
            } else {
                $field['value'] = null;
            }

            // Remove the escaped double quotes that WordPress fails to remove
            // when it unserializes data stored in the options table.
            // This bug was identified when links were added to a WYSIWYG field
            // and the anchor tags were rendered like <a href=\"foo.com\">...
            $field['value'] = str_replace('\"', '"', $field['value']);

            $default = null;
            if (array_key_exists('default', $field)) {
                if ($field['type'] === 'select') {
                    $default = $field['options'][$field['default']];
                } elseif ($field['type'] === 'image') {
                    $default = '<br>'.Html::image($field['default'], null, array('style'=>'max-width:100px;'));
                } else {
                    $default = nl2br($field['default']);
                }
            }
            $tr_class = $name.' form-field';
            if ($field['type'] === 'hidden') {
                $tr_class .= ' hidden';
            }
            $out[] = sprintf(
                '<tr%s><th><label for="%s">%s%s</label></th><td>%s%s%s</td></tr>',
                Html::attribs(array('class'=>$tr_class)),
                (array_key_exists('id', $field)) ? $field['id'] : $name,
                array_key_exists('label', $field) ? $field['label'] : Str::human($name),
                (array_key_exists('required', $field) && $field['required']) ? '&nbsp;<span class="required">*</span>' : '',
                $this->getRenderMetaBoxField($name, $field),
                (array_key_exists('description', $field)) ? Html::p($field['description'], array('class'=>'description')) : null,
                (!is_null($default)) ? sprintf('<p class="description">Default: %s</p>', $default) : null
            );
        }

        if ($is_quick_add_page) {
            $out[] = '</table>';
        }

        $html = join("\n", $out);
        if ($return) {
            return $html;
        }
        echo $html;
    }


    /**
     * Get a rendered metabox field
     * @param string $name
     * @param array $field
     */
    public function getRenderMetaBoxField($name, $field = null)
    {
        $is_wysiwyg = (
            $field['type'] === 'textarea'
            && array_key_exists('class', $field)
            && preg_match('/wysiwyg/', $field['class'])
        );
        if ($is_wysiwyg) {
            // Showing the editor on the quick add form will break the WordPress admin UI
            // So we'll only allow the WYSIWYG to appear on the edit screen
            if (array_key_exists('tag_ID', $_GET)) {
                $value = (array_key_exists('value', $field)) ? $field['value'] : null;
                ob_start();
                wp_editor($value, $name);
                return ob_get_clean();
            }

            return '<p>Add this record, then edit the record to see the WYSIWYG editor.</p>';
        }

        return parent::getRenderMetaBoxField($name, $field);
    }


    /**
     * Get default values
     * Override this
     * @return array
     */
    public function getDefaults()
    {
        return array();
    }


    /**
     * Save meta fields after WordPress saves a term
     * Note: this is fired *after* WordPress has already saved the term
     * @param bool $exclude_core
     * @return integer term ID
     */
    public function save($exclude_core = false)
    {
        if (count($this->_info) === 0) {
            return false;
        }

        // set defaults
        $defaults = $this->getDefaults();
        if (count($defaults) > 0) {
            foreach ($defaults as $k => $v) {
                if (!array_key_exists($k, $this->_info)) {
                    $this->_info[$k] = $v;
                }
            }
        }

        // separate core fields from extra
        $core = array();
        $extra = array();
        $core_fields = static::getCoreFieldKeys();
        $extra_fields = array_keys($this->getFields());
        foreach ($this->_info as $k => $v) {
            if (in_array($k, $core_fields)) {
                $core[$k] = $v;
            } elseif (in_array($k, $extra_fields)) {
                $extra[$k] = $v;
            }
        }

        // save core fields
        $term_exists = term_exists($core['name'], $this->getTaxonomyKey());
        if ($term_exists) {
            $this->set(self::ID, $term_exists[self::ID]);
        }

        $is_update = (bool) $this->get(self::ID);
        if (!$exclude_core) {
            if (!array_key_exists(self::ID, $core)) {
                $core[self::ID] = (int) $this->get(self::ID);
            }
            if ($is_update) {
                wp_update_term($core[self::ID], $this->getTaxonomyKey(), $core);
            } else {
                $name = $core['name'];
                unset($core['name']);
                $res = wp_insert_term($name, $this->getTaxonomyKey(), $core);
                $this->_info[self::ID] = current($res);
            }
        }

        // Create option for meta field values in wp_options table
        if (count($extra) > 0) {
            delete_option($this->getOptionID($this->get(self::ID)));
            add_option($this->getOptionID($this->get(self::ID)), $extra);
        }

        return $this->_info[self::ID];
    }


    /**
     * Delete the term
     * @return bool
     */
    public function delete()
    {
        return wp_delete_term($this->get('term_id'), $this->getTaxonomyKey());
    }


    /**
     * Get the option ID
     * @param integet $term_id
     * @return string
     */
    public function getOptionID($term_id = null)
    {
        return join('_', array(
            $this->getTaxonomyKey(),
            ($term_id) ? $term_id : $this->get(self::ID)
        ));
    }


    /**
     * Get the core field keys
     * @return array
     */
    public static function getCoreFieldKeys()
    {
        return array(
            self::ID,
            'name',
            'slug',
            'parent',
            'description'
        );
    }


    /**
     * Add save hooks
     * @param integer $term_id
     * TODO add nonce check
     */
    public static function addSaveHooks($term_id)
    {
        // Assign vars
        $class = get_called_class();
        $instance = new $class;
        $updated_entry = new $class;
        $field_keys = array_merge(
            static::getCoreFieldKeys(),
            array_keys($instance->getFields())
        );
        foreach ($_POST as $k => $v) {
            if (in_array($k, $field_keys)) {
                $updated_entry->set($k, $v);
            }
        }

        // Not sure why WordPress uses tag_ID here and term_id otherwise
        if (array_key_exists('tag-name', $_POST)) {
            $updated_entry->set('name', $_POST['tag-name']);
        }
        if (array_key_exists('tag_ID', $_POST)) {
            $updated_entry->set(self::ID, $_POST['tag_ID']);
        }

        // Forcing $exclude_core to be true prevents an infinite loop
        return $updated_entry->save(true);
        // return $updated_entry->save(array_key_exists(self::ID, $updated_entry->getInfo()));
    }


    /**
     * Load a term by ID
     * TODO Let this accept entire objects
     * @param integer $term_id
     * @return bool
     */
    public function load($term_id)
    {
        $info = get_term($term_id, $this->getTaxonomyKey());
        if (!is_object($info)) {
            return false;
        }

        $this->_info = (array) $info;

        // extra
        $option = get_option($this->getOptionID($term_id));
        if (!is_object($option) && !is_array($option)) {
            return true;
        }

        foreach ($option as $k => $v) {
            $this->set($k, $v);
        }

        return true;
    }


    /**
     * Render an admin column
     * Note param order is flipped from parent
     * @param string $column_name
     * @param integer $term_id
     */
    public function renderAdminColumn($column_name, $term_id)
    {
        $this->load($term_id);
        parent::renderAdminColumn($column_name, $term_id);
    }


    /**
     * Get the permalink
     * @return string
     */
    public function getPermalink()
    {
        return get_term_link((int) $this->get('term_id'), $this->getTaxonomyKey());
    }


    /**
     * Get the edit permalink
     * @link http://codex.wordpress.org/Function_Reference/get_edit_term_link
     * @param string $object_type
     * @return string
     */
    public function getEditPermalink($object_type = null)
    {
        // WordPress get_edit_term_link requires an object_type
        // but if this object was created by \Taco\Post::getTerms
        // then it will have an object_id, which also works
        if (is_null($object_type)) {
            $object_type = $this->get('object_id');
            if (!$object_type) {
                throw new \Exception('No object_type nor object_id');
            }
        }
        return get_edit_term_link(
            $this->get('term_id'),
            $this->getTaxonomyKey(),
            $object_type
        );
    }


    /**
     * Get the anchor tag
     * @param string $field_key
     * @return string HTML <a>
     */
    public function getAnchorTag($field_key = 'name')
    {
        return parent::getAnchorTag($field_key);
    }


    /**
     * Get the term pairs
     * TODO Make this more efficient
     * @param array $args
     * @return array
     */
    public static function getPairs($args = array())
    {
        $terms = static::getWhere($args);
        if (!Arr::iterable($terms)) {
            return array();
        }

        return array_combine(
            Collection::pluck($terms, 'term_id'),
            Collection::pluck($terms, 'name')
        );
    }


    /**
     * Get by a key/val
     * TODO Make this more efficient
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param array $args
     * @return array
     */
    public static function getPairsBy($key, $val, $compare = '=', $args = array())
    {
        $terms = static::getBy($key, $val, $compare, $args);
        if (!Arr::iterable($terms)) {
            return array();
        }

        return array_combine(
            Collection::pluck($terms, 'term_id'),
            Collection::pluck($terms, 'name')
        );
    }


    /**
     * Get all terms
     * @return array
     */
    public static function getAll()
    {
        return static::getWhere();
    }


    /**
     * Get the default order by
     * @return string
     */
    public function getDefaultOrderBy()
    {
        return 'name';
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
     * Get terms with conditions
     * @param array $args
     * @return array
     */
    public static function getWhere($args = array())
    {
        $instance = Term\Factory::create(get_called_class());

        // Allow sorting both by core fields and custom fields
        // See: http://codex.wordpress.org/Class_Reference/WP_Query#Order_.26_Orderby_Parameters
        $default_args = array(
            'orderby' => $instance->getDefaultOrderBy(),
            'order' => $instance->getDefaultOrder(),
            'hide_empty' => false, // Note: This goes against a WordPress get_terms default. But this seems more practical.
        );

        $criteria = array_merge($default_args, $args);

        // Custom ordering
        $orderby = null;
        $order = null;
        $wordpress_sortable_fields = array('id', 'name', 'count', 'slug', 'term_group', 'none');
        if (array_key_exists('orderby', $criteria) && !in_array($criteria['orderby'], $wordpress_sortable_fields)) {
            $orderby = $criteria['orderby'];
            $order = (array_key_exists('order', $criteria))
                ? strtoupper($criteria['order'])
                : 'ASC';
            unset($criteria['orderby']);
            unset($criteria['order']);
        }

        $taxonomy = $instance->getTaxonomyKey();
        $terms = Term\Factory::createMultiple(get_terms($taxonomy, $criteria));

        // We might be done
        if (!Arr::iterable($terms)) {
            return $terms;
        }
        if (!$orderby) {
            return $terms;
        }

        // Custom sorting that WordPress can't do
        $field = $instance->getField($orderby);

        // Make sure we're sorting numerically if appropriate
        // because WordPress is storing strings for all vals
        if ($field['type'] === 'number') {
            foreach ($terms as &$term) {
                if (!isset($term->$orderby)) {
                    continue;
                }
                if ($term->$orderby === '') {
                    continue;
                }

                $term->$orderby = (float) $term->$orderby;
            }
        }

        // Sorting
        $sort_flag = ($field['type'] === 'number') ? SORT_NUMERIC : SORT_STRING;
        $terms = Collection::sortBy($terms, $orderby, $sort_flag);
        if (strtoupper($order) === 'DESC') {
            $terms = array_reverse($terms, true);
        }

        // Convert back to string as WordPress stores it
        if ($field['type'] === 'number') {
            foreach ($terms as &$term) {
                if (!isset($term->$orderby)) {
                    continue;
                }
                if ($term->$orderby === '') {
                    continue;
                }

                $term->$orderby = (string) $term->$orderby;
            }
        }

        return $terms;
    }


    /**
     * Get one term
     * @param array $args
     * @return object
     */
    public static function getOneWhere($args = array())
    {
        $args['number'] = 1;
        $result = static::getWhere($args);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get by a key/val
     * Note: This only works with custom meta fields, not core fields
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param mixed $args
     * @return array
     */
    public static function getBy($key, $val, $compare = '=', $args = array())
    {
        // Cleanup comparison for consistency
        $compare = strtoupper($compare);

        // We are going to restrict the number manually
        // because the filtering is done manually
        // not by WordPress
        $number = false;
        if (array_key_exists('number', $args)) {
            $number = (int) $args['number'];
            unset($args['number']);
        }

        // Get all the terms
        $terms = (Arr::iterable($args))
            ? static::getWhere($args)
            : static::getAll();

        // No terms? Get out of here.
        if (!Arr::iterable($terms)) {
            return array();
        }

        // We need to match the terms
        // because WordPress can't do it
        $matching_terms = array();
        foreach ($terms as $term_id => $term) {
            $term_val = $term->$key;
            switch ($compare) {
                case '=':
                    if ($term_val == $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case '!=':
                    if ($term_val != $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case '>':
                    if ($term_val > $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case '>=':
                    if ($term_val >= $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case '<':
                    if ($term_val < $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case '<=':
                    if ($term_val <= $val) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case 'IN':
                    if (in_array($term_val, $val)) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
                case 'NOT IN':
                    if (!in_array($term_val, $val)) {
                        $matching_terms[$term_id] = $term;
                    }
                    break;
            }

            // If we've already hit our limit, bust out of here
            // getWhere did the sorting already to make this possible
            if ($number && count($matching_terms) >= $number) {
                break;
            }
        }

        return $matching_terms;
    }


    /**
     * Get a single term by a key/val
     * Note: This only works with custom meta fields, not core fields
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param mixed $args
     * @return array
     */
    public static function getOneBy($key, $val, $compare = '=', $args = array())
    {
        $result = static::getBy($key, $val, $compare, $args);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get by multiple conditions
     * Conditions get treated with AND logic
     * TODO Make this more efficient
     * @param array $conditions
     * @param mixed $args
     * @return array
     */
    public static function getByMultiple($conditions, $args = array())
    {
        if (!Arr::iterable($conditions)) {
            return self::getWhere($args, $load_terms);
        }

        // Extract number if passed in $args
        // because we don't want to prematurely restrict the result set.
        $number = (array_key_exists('number', $args))
            ? $args['number']
            : null;
        unset($args['number']);

        // First, get all the post_ids
        $term_ids = array();
        foreach ($conditions as $k => $condition) {
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
            $terms = self::getBy($key, $value, $compare, $args);
            if (!Arr::iterable($terms)) {
                continue;
            }

            // Using array_intersect here gives us the AND relationship
            // array_merge would give us OR
            $new_term_ids = Collection::pluck($terms, 'term_id');
            $new_term_ids = array_map('intval', $new_term_ids);
            $term_ids = (Arr::iterable($term_ids))
                ? array_intersect($term_ids, $new_term_ids)
                : $new_term_ids;
            $term_ids = array_unique($term_ids);
            
            // After the first conditional, we can start modifying the args
            // to restrict results to previously matched posts.
            //
            // Effectively, this also means that when calling this method
            // you should put conditions you expect to be more restrictive
            // earlier in the conditionals array.
            $args['include'] = $term_ids;
        }

        // Reapply numberposts now that we have our desired post_ids
        if (!is_null($number)) {
            $args['number'] = $number;
        }

        // TODO This should probably use getWhere
        //      but it seems like getWhere may not work with the ordering
        unset($args['include']);
        return (Arr::iterable($term_ids))
            ? self::getBy('term_id', $term_ids, 'in', $args)
            : array();
    }


    /**
     * Get one by multiple conditions
     * Conditions get treated with AND logic
     * TODO Make this more efficient
     * @param array $conditions
     * @param mixed $args
     * @return array
     */
    public static function getOneByMultiple($conditions, $args = array())
    {
        $default_args = array();//array('number'=>1);
        $args = array_merge($args, $default_args);
        $results = self::getByMultiple($conditions, $args);
        return (Arr::iterable($results))
            ? current($results)
            : null;
    }


    /**
     * Get count
     * TODO Make this more efficient
     * @param array $args
     * @param string $sort
     */
    public static function getCount($args = array())
    {
        return count(static::getPairs($args));
    }


    /**
     * Delete all the terms for this taxonomy
     * TODO Make this more efficient
     * @return integer Number of posts deleted
     */
    public static function deleteAll()
    {
        $terms = static::getAll();
        if (!Arr::iterable($terms)) {
            return 0;
        }

        $num_deleted = 0;
        foreach ($terms as $term) {
            if ($term->delete()) {
                $num_deleted++;
            }
        }
        return $num_deleted;
    }


    /**
     * Find a term
     * @param integer $term_id
     * @return object
     */
    public static function find($term_id)
    {
        $instance = Post\Factory::create(get_called_class());
        $instance->load($term_id);
        return $instance;
    }
}
