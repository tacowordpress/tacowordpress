<?php
namespace Taco;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

class Base
{
    const SEPARATOR = '-';
    const METABOX_GROUPING_PREFIX = 'prefix';

    // Internal storage
    public $_info = array();

    // Messages (error, success, etc.)
    public $_messages = array();


    /**
     * Instantiate
     * @param array $info
     */
    public function __construct($info = array())
    {
        $this->_info = $info;
    }


    /**
     * Get the meta boxes
     * @return array
     */
    public function getMetaBoxes()
    {
        return array(
            $this->getKey() => array(
                'title'     => $this->getMetaBoxTitle(),
                'context'   => 'normal',
                'priority'  => 'high',
                'fields'    => $this->getFields(),
            )
        );
    }


    /**
     * Get meta boxes grouped by prefix
     * @return array
     */
    public function getPrefixGroupedMetaBoxes()
    {
        $fields = $this->getFields();

        // Just group by the field key prefix
        // Ex: home_foo would go in the Home section by default
        $groups = array();
        foreach ($fields as $k => $field) {
            $prefix = current(explode('_', $k));
            if (!array_key_exists($prefix, $groups)) {
                $groups[$prefix] = array();
            }

            $groups[$prefix][] = $k;
        }

        return $groups;
    }


    /**
     * Replace any meta box group matches
     * @param array $meta_boxes
     * @return array
     */
    public function replaceMetaBoxGroupMatches($meta_boxes)
    {
        if (!Arr::iterable($meta_boxes)) {
            return $meta_boxes;
        }

        foreach ($meta_boxes as $k => $group) {
            $group = (is_array($group)) ? $group : array($group);
            if (array_key_exists('fields', $group)) {
                continue;
            }

            $fields = $this->getFields();

            $new_group = array();
            foreach ($group as $pattern_key => $pattern) {
                if (!preg_match('/\*$/', $pattern)) {
                    $new_group[] = $pattern;
                    continue;
                }

                $prefix = preg_replace('/\*$/', '', $pattern);
                $regex = sprintf('/^%s/', $prefix);
                foreach ($fields as $field_key => $field) {
                    if (!preg_match($regex, $field_key)) {
                        continue;
                    }

                    $new_group[] = $field_key;
                }
            }
            $meta_boxes[$k] = $new_group;
        }

        return $meta_boxes;
    }


    /**
     * Get a meta box config handling defaults
     * @param array $config
     * @param string $key
     * @return array
     */
    public function getMetaBoxConfig($config, $key = null)
    {
        // allow shorthand
        if (!array_key_exists('fields', $config)) {
            $fields = array();
            foreach ($config as $field) {
                // Arbitrary HTML is allowed
                if (preg_match('/^\</', $field) && preg_match('/\>$/', $field)) {
                    $fields[md5(mt_rand())] = array(
                        'type'=>'html',
                        'label'=>null,
                        'value'=>$field,
                    );
                    continue;
                }

                $fields[$field] = $this->getField($field);
            }
            $config = array('fields'=>$fields);
        }
        if (Arr::iterable($config['fields'])) {
            $fields = array();
            foreach ($config['fields'] as $k => $v) {
                if (is_array($v)) {
                    $fields[$k] = $v;
                } else {
                    $fields[$v] = $this->getField($v);
                }
            }
            $config['fields'] = $fields;
        }

        // defaults
        $config['title']    = (array_key_exists('title', $config)) ? $config['title'] : $this->getMetaBoxTitle($key);
        $config['context']  = (array_key_exists('context', $config)) ? $config['context'] : 'normal';
        $config['priority'] = (array_key_exists('priority', $config)) ? $config['priority'] : 'high';
        return $config;
    }


    /**
     * Set multiple fields
     * @param array
     * @return integer Number of fields assigned
     */
    public function assign($vals)
    {
        if (count($vals) === 0) {
            return 0;
        }

        $n = 0;
        foreach ($vals as $k => $v) {
            if ($this->set($k, $v)) {
                $n++;
            }
        }

        return $n;
    }


    /**
     * Get a single field
     * @param string $key
     * @param bool $convert_value Convert the value (for select fields)
     */
    public function get($key, $convert_value = false)
    {
        $val = (array_key_exists($key, $this->_info))
            ? $this->_info[$key]
            : null;
        if (!is_null($val) && $val !== '' && !$convert_value) {
            return $val;
        }

        $field = $this->getField($key);
        if (!$convert_value) {
            if (!$field) {
                return $val;
            }
            if (array_key_exists('default', $field)) {
                return $field['default'];
            }
        }
        return (array_key_exists('options', $field) && array_key_exists($val, $field['options']))
            ? $field['options'][$val]
            : $val;
    }


    /**
     * Get a single field (magically)
     */
    public function __get($key)
    {
        return $this->get($key);
    }


    /**
     * Set a single field
     * @param string $key
     * @param mixed $val
     */
    public function set($key, $val)
    {
        $this->_info[$key] = $val;
        return true;
    }


    /**
     * Set a single field (magically)
     * @param string $key
     * @param mixed $val
     */
    public function __set($key, $val)
    {
        return $this->set($key, $val);
    }


    /**
     * Isset a single field (magically)
     * @return bool
     */
    public function __isset($key)
    {
        return array_key_exists($key, $this->getInfo());
    }


    /**
     * Unset a single field (magically)
     * @return bool
     */
    public function __unset($key)
    {
        if (!array_key_exists($key, $this->_info)) {
            return;
        }

        unset($this->_info[$key]);
        return;
    }


    /**
     * Get a field
     * @param string $key
     * @return mixed Array on success, null on failure
     */
    public function getField($key)
    {
        $fields = $this->getFields();
        return (array_key_exists($key, $fields)) ? $fields[$key] : null;
    }


    /**
     * Is this a valid entry?
     * @param array $vals
     * @return bool
     */
    public function isValid($vals)
    {
        $fields = $this->getFields();
        if (!Arr::iterable($fields)) {
            return true;
        }

        $result = true;

        // validate each field
        foreach ($fields as $k => $field) {
            // check if required
            if ($this->isRequired($field)) {
                if (!array_key_exists($k, $vals)
                        || is_null($vals[$k])
                        || $vals[$k] === ''
                        || $vals[$k] === false
                        || ($field['type'] === 'checkbox' && empty($vals[$k]))
                    ) {
                    $result = false;
                    $this->_messages[$k] = $this->getFieldRequiredMessage($k);
                    continue;
                }
            }

            // check maxlength
            if (array_key_exists('maxlength', $field)) {
                if (strlen($vals[$k]) > $field['maxlength']) {
                    $result = false;
                    $this->_messages[$k] = 'Value too long';
                    continue;
                }
            }

            // after this point, we're only checking values based on type
            if (!array_key_exists($k, $vals)) {
                continue;
            }
            if (!array_key_exists('type', $field)) {
                continue;
            }
 
            // Select
            if ($field['type'] === 'select') {
                if (!array_key_exists($vals[$k], $field['options'])) {
                    $result = false;
                    $this->_messages[$k] = 'Invalid option';
                }
                continue;
            }

            // Email
            if ($field['type'] === 'email') {
                if (!filter_var($vals[$k], FILTER_VALIDATE_EMAIL)) {
                    $result = false;
                    $this->_messages[$k] = 'Invalid email address';
                }
                continue;
            }

            // URL
            if ($field['type'] === 'url') {
                if (!filter_var($vals[$k], FILTER_VALIDATE_URL)) {
                    $result = false;
                    $this->_messages[$k] = 'Invalid URL';
                }
                continue;
            }

            // Color
            // http://www.w3.org/TR/html-markup/input.color.html#input.color.attrs.value
            if ($field['type'] === 'color') {
                if (!preg_match('/^#[0-9a-f]{6}$/i', $vals[$k])) {
                    $result = false;
                    $this->_messages[$k] = 'Invalid color';
                }
                continue;
            }
        }
        return $result;
    }


    /**
     * Get info
     * @return array
     */
    public function getInfo()
    {
        return $this->_info;
    }


    /**
     * Get messages (error, success, etc.);
     * @return array
     */
    public function getMessages()
    {
        return $this->_messages;
    }


    /**
     * Get the allowed fields
     * @return array
     */
    public function getAllowedFields()
    {
        // Extend me
        return array();
    }


    /**
     * Get the meta box title
     * @param string $key
     * @return string
     */
    public function getMetaBoxTitle($key = null)
    {
        return ($key) ? Str::human($key) : sprintf('%s', $this->getSingular());
    }


    /**
     * Get a rendered metabox field
     * @param string $name
     * @param array $field
     */
    public function getRenderMetaBoxField($name, $field = null)
    {
        if (is_null($field)) {
            $field = $this->getField($name);
        }

        $type = $field['type'];

        // Arbitrary HTML is allowed if you specify type=html and value=<yourhtml>
        if ($type === 'html') {
            return $field['value'];
        }

        if (!array_key_exists('value', $field)) {
            $field['value'] = null;
        }
        if (!array_key_exists('name', $field)) {
            $field['name'] = $name;
        }
        if (!$this->isRequired($field)) {
            unset($field['required']);
        }
        if (array_key_exists('required', $field)) {
            $field['required'] = 'required';
        }
        if (!array_key_exists('id', $field)) {
            $field['id'] = $name;
        }

        if (in_array($type, array('image', 'file'))) {
            $htmls = array();
            $field['class'] = (array_key_exists('class', $field)) ? $field['class'] . ' upload' : 'upload';
            $field['placeholder'] = (array_key_exists('placeholder', $field)) ? $field['placeholder'] : 'URL';

            $htmls[] = '<div class="upload_field">';
            $htmls[] = '<div class="upload-field-container">';
            $htmls[] = Html::tag('input', null, array_merge(self::scrubAttributes($field), array('type'=>'text')));
            $htmls[] = Html::tag('input', null, array('type'=>'button', 'value'=>'Select file', 'class'=>'browse'));
            $htmls[] = Html::tag('input', null, array('type'=>'button', 'value'=>'Clear', 'class'=>'clear'));
            $htmls[] = '</div>';
            $htmls[] = '</div>';
            return join("\n", $htmls);
        }

        if ($type === 'textarea') {
            $is_wysiwyg = (array_key_exists('class', $field) && in_array('wysiwyg', explode(' ', $field['class'])));
            if ($is_wysiwyg) {
                $settings = (array_key_exists('settings', $field)) ? $field['settings'] : array();
                ob_start();
                wp_editor($field['value'], $name, $settings);
                return ob_get_clean();
            }
            unset($field['type']);
            return sprintf('<textarea %s>%s</textarea>', Html::attribs(self::scrubAttributes($field, 'textarea')), $field['value']);
        }
        if (in_array($type, array('checkbox', 'radio'))) {
            if (in_array($field['value'], array(1, 'on'))) {
                // if value starts at 1, then it's checked
                $field['checked'] = 'checked';
            }

            $field['value'] = 1; // value attrib should be 1 so that $_POST[$name]=1 (or doesn't exist)
            return Html::tag('input', null, self::scrubAttributes($field));
        }
        if ($type === 'select') {
            if (!array_key_exists('', $field['options'])) {
                // Straight up array_merge will blow away your numeric keys
                $options = array(''=>'Select');
                if (Arr::iterable($field['options'])) {
                    foreach ($field['options'] as $k => $v) {
                        $options[$k] = $v;
                    }
                }
                $field['options'] = $options;
            }

            return Html::selecty($field['options'], $field['value'], self::scrubAttributes($field));
        }

        // Default to text field
        $field['value'] = htmlentities($field['value']);
        if (!array_key_exists('type', $field)) {
            $field['type'] = 'text';
        }

        // Render remaining fields with types normally assigned by type attrib (text, email, search, password)
        return Html::tag('input', null, self::scrubAttributes($field));
    }


    /**
     * Remove invalid HTML attribute keys from field definition
     * @param array $field
     * @return array
     */
    private static function scrubAttributes($field, $type = null)
    {
        $invalid_keys = [
            'default',
            'description',
            'label',
            'options',
        ];

        if ($type && $type ==='textarea') {
            $invalid_keys[] = 'value';
        }

        foreach ($invalid_keys as $invalid_key) {
            if (array_key_exists($invalid_key, $field)) {
                unset($field[$invalid_key]);
            }
        }
        return $field;
    }


    /**
     * Get the core field keys
     * @return array
     */
    public static function getCoreFieldKeys()
    {
        return array();
    }


    /**
     * Add admin columns
     * @param array $columns
     * @return bool
     */
    public function addAdminColumns($columns)
    {
        $admin_columns = $this->getAdminColumns();
        $fields = $this->getFields();
        
        foreach ($admin_columns as $k) {
            $field = $fields[$k];
            $columns[$k] = (is_array($field) && array_key_exists('label', $field))
                ? $field['label']
                : Str::human(str_replace('-', ' ', $k));
        }
        return $columns;
    }


    /**
     * Get the admin columns
     * @return array
     */
    public function getAdminColumns()
    {
        return array_keys($this->getFields());
    }


    /**
     * Get checkbox display for a specific admin column
     * @param string $column_name
     * @return array
     */
    public function getCheckboxDisplay($column_name)
    {
        $displays = $this->getCheckboxDisplays();
        if (array_key_exists($column_name, $displays)) {
            return $displays[$column_name];
        }
        if (array_key_exists('default', $displays)) {
            return $displays['default'];
        }
        return array('Yes', 'No');
    }


    /**
     * Get checkbox displays for admin columns
     * @return array
     */
    public function getCheckboxDisplays()
    {
        return array(
            'default' => array('Yes', 'No')
        );
    }


    /**
     * Render an admin column
     * @param string $column_name
     * @param integer $item_id
     */
    public function renderAdminColumn($column_name, $item_id)
    {
        $columns = $this->getAdminColumns();
        if (!in_array($column_name, $columns)) {
            return;
        }

        $field = $this->getField($column_name);
        if (is_array($field)) {
            $class = get_called_class();
            $entry = new $class;
            $entry->load($item_id);
            $out = $entry->get($column_name);
            if (isset($field['type'])) {
                switch ($field['type']) {
                    case 'checkbox':
                        $checkbox_display = $entry->getCheckboxDisplay($column_name);
                        $out = ($entry->get($column_name))
                            ? reset($checkbox_display)
                            : end($checkbox_display);
                        break;
                    case 'image':
                        $out = Html::image($entry->get($column_name), $entry->get($column_name), array('class'=>'thumbnail'));
                        break;
                    case 'select':
                        $out = array_key_exists($entry->get($column_name), $field['options'])
                            ? $field['options'][$entry->get($column_name)]
                            : null;
                        break;
                }
            }

            // Hide the title field if necessary.
            // But since the title field is the link to the edit page
            // we are instead going to link the first custom field column.
            if (method_exists($this, 'getHideTitleFromAdminColumns')
                && $this->getHideTitleFromAdminColumns()
                && method_exists($this, 'getEditPermalink')
                && array_search($column_name, array_values($columns)) === 0
            ) {
                $out = sprintf('<a href="%s">%s</a>', $this->getEditPermalink(), $out);
            }

            echo $out;
            return;
        }

        if (Arr::iterable($this->getTaxonomies())) {
            $taxonomy_key = $this->getTaxonomyKey($column_name);
            if ($taxonomy_key) {
                echo get_the_term_list($item_id, $taxonomy_key, null, ', ');
                return;
            }
        }
    }


    /**
     * Make the admin columns sortable
     * @param array $columns
     * @return array
     */
    public function makeAdminColumnsSortable($columns)
    {
        $admin_columns = $this->getAdminColumns();
        if (!Arr::iterable($admin_columns)) {
            return $columns;
        }

        foreach ($admin_columns as $k) {
            $columns[$k] = $k;
        }
        return $columns;
    }


    /**
     * Get the singular name
     * @return string
     */
    public function getSingular()
    {
        return (is_null($this->singular))
            ? Str::camelToHuman(get_called_class())
            : $this->singular;
    }


    /**
     * Get the plural name
     * @return string
     */
    public function getPlural()
    {
        $singular = $this->getSingular();
        if (preg_match('/y$/', $singular)) {
            return preg_replace('/y$/', 'ies', $singular);
        }
        return (is_null($this->plural))
            ? Str::human($singular) . 's'
            : $this->plural;
    }


    /**
     * Get any value run through the_content filter
     * @param string $key
     * @param bool $convert_value Convert the value (for select fields)
     * @param bool $return_wrapped Wrap lines in <p> tags
     * @return string HTML
     */
    public function getThe($key, $convert_value = false, $return_wrapped = true)
    {
        if ($return_wrapped) {
            return apply_filters('the_content', $this->get($key, $convert_value));
        }
        
        // Apply the_content filter without wrapping lines in <p> tags
        remove_filter('the_content', 'wpautop');
        $value = apply_filters('the_content', $this->get($key, $convert_value));
        add_filter('the_content', 'wpautop');
        return $value;
    }


    /**
     * Get any value run through htmlentities
     * @param string $key
     */
    public function getSafe($key)
    {
        return htmlentities($this->get($key));
    }


    /**
     * Get the anchor tag
     * @param string $field_key
     * @return string HTML <a>
     */
    public function getAnchorTag($field_key)
    {
        return sprintf('<a href="%s">%s</a>', $this->getPermalink(), $this->get($field_key));
    }


    /**
     * Get a field required error message
     * @param string $field_key
     * @return string
     */
    public function getFieldRequiredMessage($field_key)
    {
        return 'Field required';
    }


    /**
     * Get the label text for a field
     * @param mixed $field_key Alternatively, you can pass in the field array
     * @return string
     */
    public function getLabelText($field_key)
    {
        $field = $this->getField($field_key);
        if (!is_array($field)) {
            return null;
        }

        return (array_key_exists('label', $field))
            ? $field['label']
            : Str::human(str_replace('-', ' ', preg_replace('/_id$/i', '', $field_key)));
    }


    /**
     * Get the label HTML for a field
     * @param string $field_key
     * @param mixed $required_mark Pass null if you don't want required fields to be marked
     * @return string
     */
    public function getRenderLabel($field_key, $required_mark = ' <span class="required">*</span>')
    {
        return sprintf(
            '<label for="%s">%s%s</label>',
            $field_key,
            $this->getLabelText($field_key),
            ($required_mark && $this->isRequired($field_key)) ? $required_mark : null
        );
    }


    /**
     * Is the field required?
     * @param mixed $field_key Alternatively, you can pass in the field array
     * @return bool
     */
    public function isRequired($field_key)
    {
        $field = (is_array($field_key)) ? $field_key : $this->getField($field_key);
        return (is_array($field) && array_key_exists('required', $field) && $field['required']);
    }


    /**
     * Get the field keys
     * You may want to override this with a hard coded array to improve performance
     * @return array
     */
    public function getFieldKeys()
    {
        return array_keys($this->getFields());
    }
}
