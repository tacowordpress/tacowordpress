<?php
namespace Taco;

class BaseLoader
{
    
    /**
     * Get all subclasses
     * @return array
     */
    public static function getSubclasses()
    {
        $subclasses = array();
        $parent_class = (strpos(get_called_class(), 'Taco\Post') === 0)
            ? 'Taco\Post'
            : 'Taco\Term';
        
        foreach (get_declared_classes() as $class) {
            if (method_exists($class, 'isLoadable') && $class::isLoadable() === false) {
                continue;
            }
            if (is_subclass_of($class, $parent_class)) {
                $subclasses[] = $class;
            }
        }
        return $subclasses;
    }
    
}
