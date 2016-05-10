<?php
namespace Taco\Frontend;

use Taco\Util\Arr as Arr;
use Taco\Util\Collection as Collection;
use Taco\Util\Color as Color;
use Taco\Util\Html as Html;
use Taco\Util\Num as Num;
use Taco\Util\Obj as Obj;
use Taco\Util\Str as Str;

/**
 * Loads frontend code like HTML, CSS, and JS
 */
class Loader
{

    /**
     * Add HTML to the page for frontend code
     * This is probably not the right way to do it
     * but it avoids us needing to reference files from vendor over HTTP requests.
     */
    public static function addToHTML()
    {
        if (!self::isViewingHTMLPage()) {
            return;
        }

        // js
        $paths = self::getAssetFilePaths('js');
        echo sprintf(
            '<script>%s</script>',
            self::getCombinedContents($paths)
        );

        // css
        $paths = self::getAssetFilePaths('css');
        echo sprintf(
            '<style>%s</style>',
            self::getCombinedContents($paths)
        );
    }


    /**
     * Is the user currently viewing a HTML page?
     * Things that are not HTML would be admin-ajax.php for instance
     * @return bool
     */
    public static function isViewingHTMLPage()
    {
        if (!is_admin()) {
            return false;
        }
        if (!array_key_exists('SCRIPT_NAME', $_SERVER)) {
            return false;
        }
        
        $whitelisted_script_names = array(
            'wp-admin/post-new.php',
            'wp-admin/post.php',
            'wp-admin/edit.php',
        );
        $script_name = strstr($_SERVER['SCRIPT_NAME'], 'wp-admin');
        if (!in_array($script_name, $whitelisted_script_names)) {
            return false;
        }

        return true;
    }


    /**
     * Get file paths for a type of asset
     * @param string $type Ex: js
     * @return array
     */
    public static function getAssetFilePaths($type)
    {
        $path = sprintf('%s/assets/%s/', __DIR__, $type);
        $filenames = preg_grep('/^[^\.]/', scandir($path));
        if (!Arr::iterable($filenames)) {
            return array();
        }

        return array_map(function ($filename) use ($path) {
            return $path.$filename;
        }, $filenames);
    }


    /**
     * Get the combined contents of multiple file paths
     * @param string array
     * @return string
     */
    public static function getCombinedContents($paths)
    {
        if (!Arr::iterable($paths)) {
            return '';
        }

        $out = array();
        foreach ($paths as $path) {
            $out[] = file_get_contents($path);
        }
        return join("\n", $out);
    }
}
