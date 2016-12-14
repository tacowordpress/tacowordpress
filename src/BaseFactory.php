<?php
namespace Taco;

use Taco\Util\Str as Str;

class BaseFactory
{
    
    private static $class_pairs = null;
    
    
    /**
     * Resolve class name
     * @param string $identifier
     * @return string
     */
    public static function resolveClassName($identifier)
    {
        if (is_array(self::$class_pairs) && array_key_exists($identifier, self::$class_pairs)) {
            return self::$class_pairs[$identifier];
        }
        
        $class_name = self::inferClassName($identifier);
        self::$class_pairs[$identifier] = $class_name;
        return $class_name;
    }
    
    
    /**
     * Infer class name
     * @param string $identifier
     * @return string
     */
    private static function inferClassName($identifier)
    {
        $class = Str::pascal($identifier);
        
        if (class_exists($class)) {
            return $class;
        }
        
        // Check if class belongs to pre-defined namespace
        $namespace = (strpos(get_called_class(), 'Taco\Post') === 0)
            ? 'POST_NAMESPACE'
            : 'TERM_NAMESPACE';
        if (defined($namespace) && class_exists(constant($namespace).'\\'.$class)) {
            return constant($namespace).'\\'.$class;
        }
        
        // Check if any subclass has a matching class name (this only works if
        // every class name is unique, regardless of namespace)
        $subclasses = BaseLoader::getSubclasses();
        foreach ($subclasses as $subclass) {
            if (preg_match('/\b'.$class.'$/', $subclass)) {
                return $subclass;
            }
        }
        
        // Check if identifier represents the full namespace (this only works if
        // each segment of the fully-qualified class name is a single word)
        $namespaced_class = join('\\', array_map('ucfirst', explode(Base::SEPARATOR, $identifier)));
        if (class_exists($namespaced_class)) {
            return $namespaced_class;
        }
        
        return null;
    }
    
}
