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

    public $class = null;
    public $taxonomy_key = null;


    /**
     * Get a single field
     * @param string $key
     * @param bool $convert_value Convert the value (for select fields)
     */
    public function get($key)
    {
        // See comment further down about WordPress not removing quote marks upon unserialization
        $val = parent::get($key);
        return str_replace('\"', '"', $val);
    }


    public function getKey()
    {
        return $this->getTaxonomyKey();
    }


    /**
     * Get the taxonomy key
     */
    public function getTaxonomyKey()
    {
        $class = get_called_class();
        return (is_null($this->taxonomy_key))
            ? Str::machine(Str::camelToHuman($class), parent::SEPARATOR)
            : $this->taxonomy_key;
    }


    /**
     * Add meta boxes
     * @param object $term
     */
    public function addMetaBoxes($term = null)
    {
        if (is_object($term)) $this->load($term->term_id);

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
        if (!Arr::iterable($config['fields'])) return false;

        $extra = get_option($this->getOptionID());

        $out = array();
        $out[] = '<table class="form-table">';
        foreach ($config['fields'] as $name => $field) {
            // Hack to determine if we're on the category admin page
            $is_quick_add_page = (!preg_match('/tag_ID/', $_SERVER['REQUEST_URI']));

            if ($is_quick_add_page && is_array($field) && array_key_exists('value', $field)) $field['value'] = $field['value'];
            elseif (is_array($extra) && array_key_exists($name, $extra)) $field['value'] = $extra[$name];
            else $field['value'] = null;

            // Remove the escaped double quotes that WordPress fails to remove
            // when it unserializes data stored in the options table.
            // This bug was identified when links were added to a WYSIWYG field
            // and the anchor tags were rendered like <a href=\"foo.com\">...
            $field['value'] = str_replace('\"', '"', $field['value']);

            $default = null;
            if (array_key_exists('default', $field)) {
                if ($field['type'] === 'select') $default = $field['options'][$field['default']];
                elseif ($field['type'] === 'image') $default = '<br>'.Html::image($field['default'], null, array('style'=>'max-width:100px;'));
                else $default = nl2br($field['default']);
            }
            $tr_class = $name.' form-field';
            if ($field['type'] === 'hidden') {
                $tr_class .= ' hidden';
            }
            $out[] = sprintf(
                '<tr%s><td><label for="%s">%s%s</label></td><td>%s%s</td><td>%s</td></tr>',
                Html::attribs(array('class'=>$tr_class)),
                (array_key_exists('id', $field)) ? $field['id'] : $name,
                array_key_exists('label', $field) ? $field['label'] : Str::human($name),
                (array_key_exists('required', $field) && $field['required']) ? '&nbsp;<span class="required">*</span>' : '',
                $this->getRenderMetaBoxField($name, $field),
                (array_key_exists('description', $field)) ? Html::p($field['description'], array('class'=>'description')) : null,
                ($default) ? sprintf('<p class="description">Default: %s</p>', $default) : null
            );
        }
        $out[] = '</table>';

        $html = join("\n", $out);
        if ($return) return $html;
        echo $html;
    }


    /**
     * Get a rendered metabox field
     * @param string $name
     * @param array $field
     */
    public function getRenderMetaBoxField($name, $field)
    {
        $is_wysiwyg = ($field['type'] === 'textarea' && array_key_exists('class', $field) && preg_match('/wysiwyg/', $field['class']));
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
     * Save a post
     * @param bool $exclude_core
     * @return integer term ID
     */
    public function save($exclude_core = false)
    {
        if (count($this->_info) === 0) return false;

        // set defaults
        $defaults = $this->getDefaults();
        if (count($defaults) > 0) {
            foreach ($defaults as $k => $v) {
                if (!array_key_exists($k, $this->_info)) $this->_info[$k] = $v;
            }
        }

        // separate core fields from extra
        $core = array();
        $extra = array();
        $core_fields = $this->getCoreFieldKeys();
        $extra_fields = array_keys($this->getFields());
        foreach ($this->_info as $k => $v) {
            if (in_array($k, $core_fields)) $core[$k] = $v;
            elseif (in_array($k, $extra_fields)) $extra[$k] = $v;
        }

        // save core fields
        $term_exists = term_exists($core['name'], $this->getTaxonomyKey());
        if ($term_exists) {
            $this->set(self::ID, $term_exists[self::ID]);
        }

        $is_update = (bool) $this->get(self::ID);
        if (!$exclude_core) {
            if ($is_update) wp_update_term($core[self::ID], $this->getTaxonomyKey(), $core);
            else {
                $name = $core['name'];
                unset($core['name']);
                $res = wp_insert_term($name, $this->getTaxonomyKey(), $core);
                $this->_info[self::ID] = current($res);
            }
        }

        // save extra
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
        $updated_entry = new $class;
        $field_keys = array_merge(
            static::getCoreFieldKeys(),
            array_keys($this->getFields())
        );
        foreach ($_POST as $k => $v) {
            if (in_array($k, $field_keys)) $updated_entry->set($k, $v);
        }

        // Not sure why WordPress uses tag_ID here and term_id otherwise
        if (array_key_exists('tag-name', $_POST)) $updated_entry->set('name', $_POST['tag-name']);
        if (array_key_exists('tag_ID', $_POST)) $updated_entry->set(self::ID, $_POST['tag_ID']);

        return $updated_entry->save(array_key_exists(self::ID, $updated_entry->getInfo()));
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
        if (!is_object($info)) return false;

        $this->_info = (array) $info;

        // extra
        $option = get_option($this->getOptionID($term_id));
        if (!is_object($option) && !is_array($option)) return true;

        foreach ($option as $k => $v) {
            $this->set($k, $v);
        }

        return true;
    }


    /**
     * Render an admin column
     * Note param order is flipped from parent
     * @param integer $empty
     * @param string $column_name
     * @param integer $term_id
     */
    public function renderAdminColumn($empty, $column_name, $term_id)
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
    public function getAnchorTag($field_key = 'title')
    {
        return parent::getAnchorTag($field_key);
    }


    /**
     * Get all terms
     * @return array
     */
    public static function getAll()
    {
        return static::getWhere(false);
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
     * @param bool $hide_empty
     * @param array $args
     * @return array
     */
    public static function getWhere($hide_empty = false, $args=array())
    {
        // Allow sorting both by core fields and custom fields
        // See: http://codex.wordpress.org/Class_Reference/WP_Query#Order_.26_Orderby_Parameters
        $default_orderby = $this->getDefaultOrderBy();
        $default_order = $this->getDefaultOrder();
        $default_args = array(
            'orderby' => $default_orderby,
            'order' => $default_order,
        );

        $criteria = array_merge($default_args, $args);

        $criteria['hide_empty'] = $hide_empty;
        $taxonomy = $this->getTaxonomyKey();
        $terms = Term\Factory::createMultiple(get_terms($taxonomy, $criteria));

        if (!Arr::iterable($terms)) return $terms;

        // Custom sorting that WordPress can't do
        if (!in_array($criteria['orderby'], array('id', 'name', 'count', 'slug', 'term_group', 'none'))) {
            $field = static::getField($criteria['orderby']);

            // Make sure we're sorting numerically if appropriate
            // because WordPress is storing strings for all vals
            if ($field['type'] === 'number') {
                $orderby = $criteria['orderby'];
                foreach ($terms as &$term) {
                    if (!isset($term->$orderby)) continue;
                    if ($term->$orderby === '') continue;

                    $term->$orderby = (float) $term->$orderby;
                }
            }

            $terms = Collection::sortBy($terms, $criteria['orderby']);
            if (strtoupper($criteria['order']) === 'ASC') {
                arsort($terms);
            }
        }

        return $terms;
    }


    /**
     * Get one term
     * @param bool $hide_empty
     * @param array $args
     * @return object
     */
    public static function getOneWhere($hide_empty = false, $args = array())
    {
        $args['number'] = 1;
        $result = static::getWhere($hide_empty, $args);
        return (count($result)) ? current($result) : null;
    }


    /**
     * Get by a key/val
     * Note: This only works with custom meta fields, not core fields
     * @param string $key
     * @param mixed $val
     * @param string $compare
     * @param bool $hide_empty
     * @param mixed $args
     * @return array
     */
    public static function getBy($key, $val, $compare = '=', $hide_empty = false, $args = array())
    {
        $get_one = false;
        if (array_key_exists('get_one', $args)) {
            $get_one = true;
            unset($args['get_one']);
        }

        $terms = (Arr::iterable($args) || $hide_empty)
            ? static::getWhere($hide_empty, $args)
            : static::getAll();
        $matching_terms = array();

        if (!Arr::iterable($terms)) return array();

        foreach ($terms as $term) {
            $term_info = $term->_info;
            if (!array_key_exists($key, $term_info)) {
                // if the key isn't there and the compare is negative
                // it's a match
                if ($compare == '!=' || $compare == 'NOT IN') {
                    $matching_terms[] = $term;
                    if ($get_one) break;
                }
                continue;
            }

            if (
                ($compare == '=' && $term_info[$key] == $val)
                || ($compare == '!=' && $term_info[$key] != $val)
            ) {
                $matching_terms[] = $term;
                if ($get_one) break;
            } elseif ($compare == 'IN' || $compare == 'NOT IN') {
                if (
                    strpos($term_info[$key], ',') !== false
                    || strpos($term_info[$key], ';') !== false
                ) {
                    // if the meta value looks like a list
                    $separator = (strpos($term_info[$key], ';') !== false)
                        ? ';'
                        : ',';
                    $meta_values = explode($separator, $term_info[$key]);
                    $meta_values = array_map('trim', $meta_values);
                    if (
                        (in_array($val, $meta_values) && $compare == 'IN')
                        || (!in_array($val, $meta_values) && $compare == 'NOT IN')
                    ) {
                        $matching_terms[] = $term;
                        if ($get_one) break;
                    }
                } elseif (
                    ($term_info[$key] == $val && $compare == 'IN')
                    || ($term_info[$key] != $val && $compare == 'NOT IN')
                ) {
                    $matching_terms[] = $term;
                    if ($get_one) break;
                }
            } elseif ($compare == 'HAS' || $compare == 'NOT HAS') {
                // This is basically the opposite of IN, in that the
                // meta value is expected to be a single value, and the
                // input is expected to be a comma- or semicolon-separated
                // list of possible matches
                if (
                    strpos($val, ',') !== false
                    || strpos($val, ';') !== false
                ) {
                    // if the input value looks like a list
                    $separator = (strpos($val, ';') !== false)
                        ? ';'
                        : ',';
                    $input_values = explode($separator, $val);
                    $input_values = array_map('trim', $input_values);
                    if (
                        (in_array($term_info[$key], $input_values) && $compare == 'HAS')
                        || (!in_array($term_info[$key], $input_values) && $compare == 'NOT HAS')
                    ) {
                        $matching_terms[] = $term;
                        if ($get_one) break;
                    }
                } elseif (
                    ($term_info[$key] == $val && $compare == 'HAS')
                    || ($term_info[$key] != $val && $compare == 'NOT HAS')
                ) {
                    $matching_terms[] = $term;
                    if ($get_one) break;
                }
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
     * @param bool $hide_empty
     * @param mixed $args
     * @return array
     */
    public static function getOneBy($key, $val, $compare = '=', $hide_empty = false, $args = array())
    {
        $args['get_one'] = true;
        $result = static::getBy($key, $val, $compare, $hide_empty, $args);
        return (count($result)) ? current($result) : null;
    }
}
