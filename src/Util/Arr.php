<?php

namespace Taco\Util;

/**
 * Convenience methods for handling arrays
 * @version 0.1
 */
class Arr {
  
  /**
   * Is this array iterable?
   * @param array $arr
   * @return bool
   */
  public static function iterable($arr) {
    return (is_array($arr) && count($arr) > 0);
  }
  
  
  /**
   * Get the mean
   * @param array $arr
   * @return float
   */
  public static function mean($arr) {
    return array_sum($arr) / count($arr);
  }
  
  
  /**
   * Get the median
   * @param array $arr
   * @return mixed
   */
  public static function median($arr) {
    $vals = array_values($arr);
    sort($vals);
    
    $num_vals = count($vals);
    return ($num_vals % 2)
      ? ($vals[$num_vals / 2] + $vals[($num_vals / 2) + 1]) / 2
      : $vals[($num_vals + 1) / 2];
  }
  
  
  /**
   * Get the mode
   * @param array $arr
   * @return mixed
   */
  public static function mode($arr) {
    $vals = array_count_values($arr);
    asort($vals);
    return end(array_keys($vals));
  }
  
  
  /**
   * Get the data only with specific keys
   * @param array $records
   * @param array $keys
   * @return array
   */
  public static function withKeys($records, $keys) {
    if(!self::iterable($records)) return array();
    
    $out = array();
    foreach($records as $n=>$record) {
      if(!self::iterable($record)) {
        $out[$n] = $record;
        continue;
      }
      $out[$n] = array();
      
      foreach($record as $k=>$v) {
        if(!in_array($k, $keys)) continue;
        $out[$n][$k] = $v;
      }
    }
    return $out;
  }
  
  
  /**
   * Get the data with specific keys removed
   * @param array $records
   * @param array $keys
   * @return array
   */
  public static function withoutKeys($records, $keys) {
    if(!self::iterable($records)) return array();
    
    $out = array();
    foreach($records as $n=>$record) {
      if(!self::iterable($record)) {
        $out[$n] = $record;
        continue;
      }
      $out[$n] = array();
      
      foreach($record as $k=>$v) {
        if(in_array($k, $keys)) continue;
        $out[$n][$k] = $v;
      }
    }
    return $out;
  }
  
  
  /**
   * Translate keys
   * @param array $records
   * @param array $translations
   * @return array
   */
  public static function translateKeys($records, $translations) {
    if(!self::iterable($records)) return array();
    
    $out = array();
    foreach($records as $n=>$record) {
      if(!self::iterable($record)) {
        $out[$n] = $record;
        continue;
      }
      $out[$n] = array();
      
      foreach($record as $k=>$v) {
        $new_k = (array_key_exists($k, $translations)) ? $translations[$k] : $k;
        $out[$n][$new_k] = $v;
      }
    }
    return $out;
  }
}