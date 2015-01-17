<?php
namespace Taco\Util;

/**
 * Convenience methods for handling HTML
 * @version 0.1
 */
class Html
{
    
    /**
     * Get a string of attributes given the attributes as an array
     * @param array $attribs
     * @param $leading_space
     * @return string
     */
    public static function attribs($attribs, $leading_space = true)
    {
        if (!Arr::iterable($attribs)) return '';
        
        $out = array();
        foreach ($attribs as $k => $v) {
            $v = (is_array($v)) ? join(' ', $v) : $v;
            $out[] = $k . '="' . str_replace('"', '\"', $v) . '"';
        }
        return (($leading_space) ? ' ' : '') . join(' ', $out);
    }
    
    
    /**
     * Render a HTML string
     * @param string $str
     * @return string HTML
     */
    public static function render($str, $html = false)
    {
        return ($html == true) ? $str : htmlentities($str);
    }
    
    
    /**
     * Generate a tag
     * @param string $element_type Examples: span, p, b
     * @param string $body
     * @param array $attribs
     * @param bool $close Add closing tag?
     * @return string
     */
    public static function tag($element_type, $body = '', $attribs = array(), $close = true, $is_html = false)
    {
        $not_self_closing = array('a', 'div', 'iframe', 'textarea');
        $is_self_closing = ($close && empty($body) && !in_array(strtolower($element_type), $not_self_closing));
        if ($is_self_closing) return '<' . $element_type . self::attribs($attribs) . ' />';
        
        return join(array(
            '<' . $element_type . self::attribs($attribs) . '>',
            self::render($body, $is_html),
            ($close) ? '</' . $element_type . '>' : ''
        ));
    }
    
    
    /**
     * Generate an img tag
     * @param string $src
     * @param string $alt
     * @param array $attribs
     * @return string
     */
    public static function image($src, $alt = null, $attribs = array())
    {
        $attribs = array_merge(array('src'=>$src), $attribs);
        if ($alt) $attribs['alt'] = htmlentities($alt);
        
        return self::tag('img', null, $attribs);
    }
    
    
    /**
     * Get an anchor (<a>) tag
     * @param string $url
     * @param string $body
     * @param array $attribs
     * @return string
     */
    public static function link($url, $body = null, $attribs=array())
    {
        $body = (is_null($body)) ? $url : $body;
        $attribs['href'] = $url;
        return self::tag('a', $body, $attribs);
    }
    
    
    
    /**
     * Get an anchor (<img>) tag
     * @param string $src
     * @param array $attribs
     * @return string
     */
    public static function img($src)
    {
        $attribs['src'] = $src;
        return self::tag('img', $attribs);
    }
    
    
    /**
     * Get an HTML ul list
     * @param array $items
     * @param array $attribs
     * @return string
     */
    public static function ulist($items, $attribs = array())
    {
        return self::listy($items, $attribs, 'ul');
    }
    
    
    /**
     * Get an HTML ol list
     * @param array $items
     * @param array $attribs
     * @return string
     */
    public static function olist($items, $attribs = array())
    {
        return self::listy($items, $attribs, 'ol');
    }
    
    
    /**
     * Get an HTML list
     * @param array $items
     * @param array $attribs
     * @param string $type
     */
    public static function listy($items, $attribs = array(), $type = 'ul')
    {
        if (!Arr::iterable($items)) return '';
        
        $htmls = array();
        $htmls[] = '<' . $type . self::attribs($attribs) . '>';
        foreach ($items as $item) {
            $htmls[] = '<li>' . $item . '</li>';
        }
        $htmls[] = '</' . $type . '>';
        return join("\n", $htmls);
    }
    
    
    /**
     * Get an HTML list of links
     * @param array $items
     * @param array $attribs
     * @param string $type
     * @param string $active_title
     */
    public static function alisty($items, $attribs = array(), $type = 'ul', $active_title = null)
    {
        if (!Arr::iterable($items)) return '';
        
        $htmls = array();
        $htmls[] = '<' . $type . self::attribs($attribs) . '>';
        foreach ($items as $title => $href) {
            $body = (is_array($href)) ? Html::a($title, $href) : Html::link($href, $title);
            
            $classes = array(Str::machine($title));
            if ($active_title === $title) $classes[] = 'active';
            
            $htmls[] = sprintf('<li class="%s">', join(' ', $classes)) . $body . '</li>';
        }
        $htmls[] = '</' . $type . '>';
        return join("\n", $htmls);
    }
    
    
    /**
     * Get a select list
     * @param array $options
     * @param string $selected
     * @param array $attribs
     * @return string
     */
    public static function selecty($options, $selected = null, $attribs = array())
    {
        $htmls = array();
        $htmls[] = self::select(null, $attribs, false);
        if (Arr::iterable($options)) {
            foreach ($options as $value => $title) {
                $option_attribs = array('value'=>$value);
                if ((string) $selected === (string) $value) $option_attribs['selected'] = 'selected';
                
                $htmls[] = self::option($title, $option_attribs);
            }
        }
        $htmls[] = '</select>';
        return join("\n", $htmls);
    }
    
    
    /**
     * Get a table
     * @param array $records
     * @return string
     */
    public static function tably($records)
    {
        if (count($records) === 0) return null;
        
        $htmls = array();
        $htmls[] = '<table>';
        foreach ($records as $record) {
            $htmls[] = '<tr>';
            foreach ($record as $k => $v) {
                $htmls[] = sprintf('<td class="%s">%s</td>', Str::machine($k), $v);
            }
            $htmls[] = '</tr>';
        }
        $htmls[] = '</table>';
        return join("\n", $htmls);
    }
    
    
    /**
     * Get a tag using an arbitrary element type
     * This is a shortcut for self::tag
     * @param string $body
     * @param array $attribs
     * @param bool $close Add closing tag?
     * @return string
     */
    public static function __callStatic($method, $args)
    {
        $element_type = $method;
        
        // Call tag from here so that the tag method can uniquely define default params
        // instead of this method trying to mirror tag's default params
        switch (count($args)) {
            case 0:
                return self::tag($element_type);
            case 1:
                return self::tag($element_type, $args[0]);
            case 2:
                return self::tag($element_type, $args[0], $args[1]);
            case 3:
                return self::tag($element_type, $args[0], $args[1], $args[2]);
        }
    }
}
