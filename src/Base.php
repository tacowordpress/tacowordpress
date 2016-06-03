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

    public static $singular = null;
    public static $plural = null;

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
     * Get slug of class name with namespace
     * @return string
     */
    public static function namespacedClassSlug() {
        return Str::machine(Str::camelToHuman(get_called_class()), self::SEPARATOR);
    }


    /**
     * Get slug of class name without namespace
     * @return string
     */
    public static function classSlug() {
        return end(explode(self::SEPARATOR, static::namespacedClassSlug()));
    }


    /**
     * Get the meta boxes
     * @return array
     */
    public function getMetaBoxes()
    {
        return static::metaBoxes();
    }
    public static function metaBoxes() {
        return array(
            static::key() => array(
                'title'     => static::metaBoxTitle(),
                'context'   => 'normal',
                'priority'  => 'high',
                'fields'    => static::fields(),
            )
        );
    }


    /**
     * Get the meta fields
     * @return array
     */
    public function getFields()
    {
        return static::fields();
    }
    public static function fields()
    {
        return array();
    }


    /**
     * Get meta boxes grouped by prefix
     * @return array
     */
    public function getPrefixGroupedMetaBoxes()
    {
        return static::prefixGroupedMetaBoxes();
    }
    public static function prefixGroupedMetaBoxes()
    {
        $fields = static::fields();

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
        return static::replaceTheMetaBoxGroupMatches($meta_boxes);
    }
    public static function replaceTheMetaBoxGroupMatches($meta_boxes)
    {
        if (!Arr::iterable($meta_boxes)) {
            return $meta_boxes;
        }

        foreach ($meta_boxes as $k => $group) {
            $group = (is_array($group)) ? $group : array($group);
            if (array_key_exists('fields', $group)) {
                continue;
            }

            $fields = static::fields();

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
        return static::metaBoxConfig($config, $key);
    }
    public static function metaBoxConfig($config, $key = null)
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

                $fields[$field] = static::field($field);
            }
            $config = array('fields'=>$fields);
        }
        if (Arr::iterable($config['fields'])) {
            $fields = array();
            foreach ($config['fields'] as $k => $v) {
                if (is_array($v)) {
                    $fields[$k] = $v;
                } else {
                    $fields[$v] = static::field($v);
                }
            }
            $config['fields'] = $fields;
        }

        // defaults
        $config['title']    = (array_key_exists('title', $config)) ? $config['title'] : static::metaBoxTitle($key);
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

        $field = static::field($key);
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
        return array_key_exists($key, $this->info());
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
        return static::field($key);
    }
    public static function field($key)
    {
        $fields = static::fields();
        return (array_key_exists($key, $fields)) ? $fields[$key] : null;
    }


    /**
     * Is this a valid entry?
     * @param array $vals
     * @return bool
     */
    public function isValid($vals)
    {
        $fields = static::fields();
        if (!Arr::iterable($fields)) {
            return true;
        }

        $result = true;

        // validate each field
        foreach ($fields as $k => $field) {
            // check if required
            if (static::isFieldRequired($field)) {
                if (!array_key_exists($k, $vals)
                        || is_null($vals[$k])
                        || $vals[$k] === ''
                        || $vals[$k] === false
                        || ($field['type'] === 'checkbox' && empty($vals[$k]))
                    ) {
                    $result = false;
                    $this->_messages[$k] = static::fieldRequiredMessage($k);
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
        return $this->info();
    }
    public function info()
    {
        return $this->_info;
    }


    /**
     * Get messages (error, success, etc.);
     * @return array
     */
    public function getMessages()
    {
        return $this->messages();
    }
    public function messages()
    {
        return $this->_messages;
    }


    /**
     * Get the allowed fields
     * @return array
     */
    public function getAllowedFields()
    {
        return static::allowedFields();
    }
    public static function allowedFields()
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
        return static::metaBoxTitle($key);
    }
    public static function metaBoxTitle($key = null)
    {
        return ($key) ? Str::human($key) : sprintf('%s', static::singular());
    }


    /**
     * Get a rendered metabox field
     * @param string $name
     * @param array $field
     */
    public function getRenderMetaBoxField($name, $field = null)
    {
        return static::renderField($name, $field);
    }
    public static function renderField($name, $field = null)
    {
        if (is_null($field)) {
            $field = static::field($name);
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
        if (!static::isFieldRequired($field)) {
            unset($field['required']);
        }
        if (array_key_exists('required', $field)) {
            $field['required'] = 'required';
        }
        if (array_key_exists('label', $field)) {
            unset($field['label']);
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
            $htmls[] = Html::tag('input', null, array_merge($field, array('type'=>'text')));
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
            return sprintf('<textarea%s>%s</textarea>', Html::attribs($field), $field['value']);
        }
        if (in_array($type, array('checkbox', 'radio'))) {
            if (in_array($field['value'], array(1, 'on'))) {
                // if value starts at 1, then it's checked
                $field['checked'] = 'checked';
            }

            $field['value'] = 1; // value attrib should be 1 so that $_POST[$name]=1 (or doesn't exist)
            return Html::tag('input', null, $field);
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

            return Html::selecty($field['options'], $field['value'], $field);
        }

        // Default to text field
        $field['value'] = htmlentities($field['value']);
        if (!array_key_exists('type', $field)) {
            $field['type'] = 'text';
        }

        // Render remaining fields with types normally assigned by type attrib (text, email, search, password)
        return Html::tag('input', null, $field);
    }


    /**
     * Get the core field keys
     * @return array
     */
    public static function getCoreFieldKeys()
    {
        return static::coreFieldKeys();
    }
    public static function coreFieldKeys()
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
        return static::addTheAdminColumns($columns);
    }
    public static function addTheAdminColumns($columns)
    {
        $admin_columns = static::adminColumns();
        $fields = static::fields();
        
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
        return static::adminColumns();
    }
    public static function adminColumns()
    {
        return array_keys(static::fields());
    }


    /**
     * Get checkbox display for a specific admin column
     * @param string $column_name
     * @return array
     */
    public function getCheckboxDisplay($column_name)
    {
        return static::checkboxDisplay($column_name);
    }
    public static function checkboxDisplay($column_name)
    {
        $displays = static::checkboxDisplays();
        if (array_key_exists($column_name, $displays)) {
            return $displays[$column_name];
        }
        if (array_key_exists('default', $displays)) {
            return $displays['default'];
        }
        return static::defaultCheckboxDisplays();
    }


    /**
     * Get checkbox displays for admin columns
     * @return array
     */
    public function getCheckboxDisplays()
    {
        return static::checkboxDisplays();
    }
    public static function checkboxDisplays()
    {
        return array(
            'default' => static::defaultCheckboxDisplays(),
        );
    }
    
    
    /**
     * Get default checkbox display values
     * @return array
     */
    public static function defaultCheckboxDisplays()
    {
        return array('Yes', 'No');
    }


    /**
     * Render an admin column
     * @param string $column_name
     * @param integer $item_id
     */
    public function renderAdminColumn($column_name, $item_id)
    {
        return static::renderTheAdminColumn($column_name, $item_id);
    }
    public static function renderTheAdminColumn($column_name, $item_id)
    {
        $columns = static::adminColumns();
        if (!in_array($column_name, $columns)) {
            return;
        }

        $field = static::field($column_name);
        if (is_array($field)) {
            $class = get_called_class();
            $entry = new $class;
            $entry->load($item_id);
            $out = $entry->get($column_name);
            if (isset($field['type'])) {
                switch ($field['type']) {
                    case 'checkbox':
                        $checkbox_display = static::checkboxDisplay($column_name);
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
            if (method_exists($class, 'getHideTitleFromAdminColumns')
                && static::hideTitleFromAdminColumns()
                && method_exists($class, 'getEditPermalink')
                && array_search($column_name, array_values($columns)) === 0
            ) {
                $out = sprintf('<a href="%s">%s</a>', $entry->editLink(), $out);
            }

            echo $out;
            return;
        }

        if (Arr::iterable(static::taxonomies())) {
            $taxonomy_key = static::taxonomyKey($column_name);
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
        return static::makeTheAdminColumnsSortable($columns);
    }
    public static function makeTheAdminColumnsSortable($columns)
    {
        $admin_columns = static::adminColumns();
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
        return static::singular();
    }
    public static function singular()
    {
        return (!is_null(static::$singular))
            ? static::$singular
            : Str::camelToHuman(get_called_class());
    }


    /**
     * Get the plural name
     * @return string
     */
    public function getPlural()
    {
        return static::plural();
    }
    public static function plural()
    {
        if (!is_null(static::$plural)) {
            return static::$plural;
        }
        
        $singular = static::singular();
        return (preg_match('/y$/', $singular))
            ? preg_replace('/y$/', 'ies', $singular)
            : Str::human($singular) . 's';
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
        return $this->the($key, $convert_value, $return_wrapped);
    }
    public function the($key, $convert_value = false, $return_wrapped = true)
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
        return $this->safe($key);
    }
    public function safe($key)
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
        return $this->anchorTag($field_key);
    }
    public function anchorTag($field_key)
    {
        return sprintf('<a href="%s">%s</a>', $this->url(), $this->get($field_key));
    }


    /**
     * Get a field required error message
     * @param string $field_key
     * @return string
     */
    public function getFieldRequiredMessage($field_key)
    {
        return static::fieldRequiredMessage($field_key);
    }
    public static function fieldRequiredMessage($field_key)
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
        return static::labelText($field_key);
    }
    public static function labelText($field_key)
    {
        $field = static::field($field_key);
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
        return static::renderLabel($field_key, $required_mark);
    }
    public static function renderLabel($field_key, $required_mark = ' <span class="required">*</span>')
    {
        return sprintf(
            '<label for="%s">%s%s</label>',
            $field_key,
            static::labelText($field_key),
            ($required_mark && static::isFieldRequired($field_key)) ? $required_mark : null
        );
    }


    /**
     * Is the field required?
     * @param mixed $field_key Alternatively, you can pass in the field array
     * @return bool
     */
    public function isRequired($field_key)
    {
        return static::isFieldRequired($field_key);
    }
    public static function isFieldRequired($field_key)
    {
        $field = (is_array($field_key)) ? $field_key : static::field($field_key);
        return (is_array($field) && array_key_exists('required', $field) && $field['required']);
    }


    /**
     * Get the field keys
     * You may want to override this with a hard coded array to improve performance
     * @return array
     */
    public function getFieldKeys()
    {
        return static::fieldKeys();
    }
    public static function fieldKeys()
    {
        return array_keys(static::fields());
    }
}
