<?php
namespace Taco\Util;

// Temporary storage for Underscore.php methods
class Collection
{
    
    // Extract an array of values for a given property
    public static function pluck($collection = null, $key = null)
    {
        $return = array();
        foreach ($collection as $item) {
            $return[] = (is_object($item)) ? $item->$key : $item[$key];
        }
        return $return;
    }
    
    // Sort the collection by return values from the iterator
    public static function sortBy($collection = null, $iterator = null, $sort_flag = null)
    {
        $results = array();
        foreach ($collection as $k => $item) {
            if (is_callable($iterator)) $results[$k] = $iterator($item);
            if (is_object($item)) $results[$k] = $item->$iterator;
            elseif (is_array($item)) $results[$k] = $item[$iterator];
        }
        $sort_flag = (is_null($sort_flag)) ? SORT_REGULAR : $sort_flag;
        asort($results, $sort_flag);
        foreach ($results as $k => $v) {
            $results[$k] = $collection[$k];
        }
        return $results;
    }
    
    
    // Group the collection by return values from the iterator
    public static function groupBy($collection = null, $iterator = null)
    {
        $result = array();
        $collection = (array) $collection;
        foreach ($collection as $k => $item) {
            if (is_object($iterator) && is_callable($iterator)) $key = $iterator($item, $k);
            elseif (is_object($item)) $key = $item->$iterator;
            elseif (is_array($item)) $key = $item[$iterator];
            
            if (!array_key_exists($key, $result)) $result[$key] = array();
            $result[$key][] = $item;
        }
        return $result;
    }
    
    // Return an array of the unique values
    public static function uniq($collection = null, $is_sorted = null, $iterator = null)
    {
        $return = array();
        if (count($collection) === 0) return $return;
        
        $calculated = array();
        foreach ($collection as $item) {
            $val = (!is_null($iterator)) ? $iterator($item) : $item;
            if (is_bool(array_search($val, $calculated, true))) {
                $calculated[] = $val;
                $return[] = $item;
            }
        }
        
        return $return;
    }
    
    // Get the first element of an array. Passing n returns the first n elements.
    public static function first($collection = null, $n = null)
    {
        if ($n === 0) return array();
        if (is_null($n)) return current(array_splice($collection, 0, 1, true));
        return array_splice($collection, 0, $n, true);
    }
    
    // Get the last element from an array. Passing n returns the last n elements.
    public static function last($collection = null, $n = null)
    {
        if ($n === 0) $result = array();
        elseif ($n === 1 || is_null($n)) $result = array_pop($collection);
        else {
            $result = self::rest($collection, -$n);
        }
        return $result;
    }
    
    // Get the rest of the array elements. Passing n returns from that index onward.
    public static function rest($collection = null, $index = null)
    {
        if (is_null($index)) $index = 1;
        return array_splice($collection, $index);
    }

    // Return an array of values that pass the truth iterator test
    public function filter($collection = null, $iterator = null)
    {
        $return = array();
        foreach ($collection as $val) {
            if (call_user_func($iterator, $val)) $return[] = $val;
        }
        return $return;
    }
}
