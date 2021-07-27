<?php
    /**
     * --------------------------------------------------------------------------
     * File name: Role.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/20/2018
     * Last modified: (Daniel Bishop, 10/20/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class RoleController
    {
        public function index()
        {
            $roles = DI::get('query')->selectAll('roles', 'Role');
            require_once "Views/role/index.view.php";
        }
    
        public function create()
        {
            //validate
            $data = $_POST;
            unset($data["create"]);
            DI::get('query')->create('roles', $data);
            header('Location: /role');
        }
    
        public function delete()
        {
            //validate
            DI::get('query')->delete('roles', $_GET['delete']);
        
            header('Location: /role');
        
        }
    
        public function update()
        {
            $roles = DI::get('query')->selectOne('roles', 'Role', $_GET['id']);
            require_once "Views/role/update.view.php";
        }
    
        public function put()
        {
            //validation
            $post = $_POST;
            unset($post['id']);
            DI::get('query')->update('roles', $post, $_POST['id']);
            header('Location: /role');
        }
    }