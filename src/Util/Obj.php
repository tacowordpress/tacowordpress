<?php

namespace Taco\Util;

/**
 * Convenience methods for handling objects
 * @version 0.1
 */
class Obj {
  
  /**
   * Is this object iterable?
   * @param array $obj
   * @return bool
   */
  public static function iterable($obj) {
    return (is_object($obj) && count((array) $obj) > 0);
  }
}