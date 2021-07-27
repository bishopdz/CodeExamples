<?php
    /**
     * --------------------------------------------------------------------------
     * File name: Route.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/17/2018
     * Last modified: (Daniel Bishop, 10/17/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class Route
    {
        private static $routes = [];
    
        public static function get($uri, $controller)
        {
            static::$routes['GET'][$uri] = $controller;
        }
    
        public static function post($uri, $controller)
        {
            static::$routes['POST'][$uri] = $controller;
        }
    
        public static function direct($uri, $method)
        {
            try {
                if(!array_key_exists($uri, static::$routes[$method]))
                {
                    throw new Exception();
                }
                else {
                    $controller = static::$routes[$method][$uri];
                
                    $split = explode('@', $controller);
                
                    $class = new $split[0]();
                    $class->{$split[1]}();
                }
            }
            catch(Exception $e)
            {
                header('Location: /');
            }
        }
    }