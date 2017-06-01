<?php

class DatabaseTest extends PHPUnit\Framework\TestCase
{
    public function testConnection()
    {
        global $wpdb;
        $this->assertTrue(is_object($wpdb));
    }
}
