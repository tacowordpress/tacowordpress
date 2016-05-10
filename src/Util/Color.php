<?php
namespace Taco\Util;

/**
 * Utility methods for color
 */
class Color
{
    /**
     * Turn a val to a color for a gauge
     * @param $val Val from 0 to 100
     * @return string Hex
     */
    public static function gauge($val, $floor = 0)
    {
        $colors = self::getGaugeColors();
        $key_size =    100 / count($colors);
        $key = floor($val / $key_size);
        return (array_key_exists((int) $key, $colors)) ? $colors[$key] : end($colors);
    }
    
    
    /**
     * Get the gauge colors
     * @return array
     */
    public static function getGaugeColors()
    {
        return array(
            '#00B230',
            '#00D93D',
            '#71FB49',
            '#C4FC4B',
            '#E5FC4C',
            '#FFE445',
            '#FFA634',
            '#FF5F22',
            '#e33'
        );
    }
    
    
    /**
     * Convert RGB values to hex
     * @param integer $r Red (0 to 255)
     * @param integer $g Green (0 to 255)
     * @param integer $b Blue (0 to 255)
     * @return string Hex
     */
    public static function RGBToHex($r, $g, $b)
    {
        return sprintf('%02X%02X%02X', $r, $g, $b);
    }


    /**
     * Convert hex to RGB values
     * @param string $hex Hex (3 or 6 chars, with or without leading #)
     * @return array RGB values with 'r', 'g', and 'b' keys
     */
    public static function hexToRgb($hex)
    {
        $hex = preg_replace('/[^a-zA-Z0-9]/', '', $hex);
        if (strlen($hex) === 3) {
            $hex = preg_replace('/([a-f0-9]{1})/i', "$1$1", $hex);
        }
        return array_combine(array('r','g','b'), array_map('hexdec', str_split($hex, 2)));
    }
    
    
    /**
     * Convert color name to hex
     * @param string $color Color
     * @return string
     */
    public static function colorToHex($color)
    {
        $colors = array(
            'maroon'    => '800000',
            'red'       => 'FF0000',
            'orange'    => 'FFA500',
            'yellow'    => 'FFFF00',
            'olive'     => '808000',
            'purple'    => '800080',
            'fuchsia'   => 'FF00FF',
            'white'     => 'FFFFFF',
            'lime'      => '00FF00',
            'green'     => '008000',
            'navy'      => '000080',
            'blue'      => '0000FF',
            'aqua'      => '00FFFF',
            'teal'      => '008080',
            'black'     => '000000',
            'silver'    => 'C0C0C0',
            'gray'      => '808080',
        );
        if (array_key_exists($color, $colors)) {
            return $colors[$color];
        }
        
        $color_pattern = '/rgb\((.*?)\)/';
        preg_match($color_pattern, $color, $matches);
        if (is_array($matches) && count($matches) > 0) {
            $rgb = explode(',', $matches[1]);
            if (is_array($rgb) && count($rgb) === 3) {
                return self::RGBToHex($rgb[0], $rgb[1], $rgb[2]);
            }
        }
        
        return $color;
    }
    
    
    /**
     * Get a random hex
     * @return string
     */
    public static function rand()
    {
        return '#' . self::rgbToHex(
            mt_rand(0, 255),
            mt_rand(0, 255),
            mt_rand(0, 255)
        );
    }
    
    
    /**
     * Convert a color to binary: black=0; white=1
     * @param string $hex
     * @return integer
     */
    public static function binary($hex)
    {
        $rgb = self::hexToRgb($hex);
        return (array_sum($rgb) > ((255 / 2) * 3));
    }
    
    
    /**
     * Get grayscale value: black=0; medium gray=0.5; white=1
     * @param string $hex
     * @return float
     */
    public static function hexToGray($hex)
    {
        $rgb = self::hexToRgb($hex);
        return ((array_sum($rgb) / 3) / 255);
    }
}
