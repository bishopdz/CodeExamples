<?php
    /**
     * --------------------------------------------------------------------------
     * File name: HomeController.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/18/2018
     * Last modified: (Daniel Bishop, 10/18/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class HomeController
    {
        public function index()
        {
            require_once 'Views/homepage/index.view.php';
        }
    }