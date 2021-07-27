<?php
    /**
     * --------------------------------------------------------------------------
     * File name: UserControler.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/15/2018
     * Last modified: (Daniel Bishop, 10/15/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class UserController
    {
        public function index()
        {
            $people = DI::get('query')->selectAll('users', 'User');
            require_once "Views/user/index.view.php";
        }
    
        public function create()
        {
            //validate
            $data = $_POST;
            unset($data["create"]);
            DI::get('query')->create('users', $data);
            header('Location: /user');
        }
        
        public function delete()
        {
            //validate
            DI::get('query')->delete('users', $_GET['delete']);
    
            header('Location: /user');
            
        }

        public function update()
        {
            $person = DI::get('query')->selectOne('users', 'User', $_GET['id']);
            require_once "Views/user/update.view.php";
        }

        public function put()
        {
            //validation
            $post = $_POST;
            unset($post['id']);
            DI::get('query')->update('users', $post, $_POST['id']);
            header('Location: /user');
        }
    }