<?php
    /**
     * --------------------------------------------------------------------------
     * File name: Major.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/20/2018
     * Last modified: (Daniel Bishop, 10/20/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class MajorController
    {
        public function index()
        {
            $majors = DI::get('query')->selectAll('majors', 'Major');
            require_once "Views/major/index.view.php";
        }
    
        public function create()
        {
            //validate
            $data = $_POST;
            unset($data["create"]);
            DI::get('query')->create('majors', $data);
            header('Location: /major');
        }
    
        public function delete()
        {
            //validate
            DI::get('query')->delete('majors', $_GET['delete']);
        
            header('Location: /major');
        
        }
    
        public function update()
        {
            $majors = DI::get('query')->selectOne('majors', 'Major', $_GET['id']);
            require_once "Views/major/update.view.php";
        }
    
        public function put()
        {
            //validation
            $post = $_POST;
            unset($post['id']);
            DI::get('query')->update('majors', $post, $_POST['id']);
            header('Location: /major');
        }
    }