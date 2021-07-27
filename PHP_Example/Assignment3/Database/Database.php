<?php
    /**
     * --------------------------------------------------------------------------
     * File name: Database.php
     * Project name: Assignment2
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 09/18/2018
     * Last modified: (Daniel Bishop, 09/18/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class Database
    {
        public static function connect($type, $location, $name = null, $username = null, $password = null)
        {
            if ($type == "sqlite")
            {
                return new PDO("$type:$location");
            }
            else if($type == "mysql")
            {
                return new PDO("$type:host=$location;dbname=$name", $username, $password);
            }
            else
            {
                throw new Exception("Unable to connect");
            }
        }
    }

?>