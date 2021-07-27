<?php
    /**
     * --------------------------------------------------------------------------
     * File name: DI.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/15/2018
     * Last modified: (Daniel Bishop, 10/15/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class DI
    {
        private static $registry = [];
        
        public static function bind($key, $value)
        {
            static::$registry[$key] = $value;
        }
        
        public static function get($key)
        {
            return static::$registry[$key];
        }
    }