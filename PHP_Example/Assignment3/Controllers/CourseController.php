<?php
    /**
     * --------------------------------------------------------------------------
     * File name: CourseController.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/20/2018
     * Last modified: (Daniel Bishop, 10/20/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class CourseController
    {
        public function index()
        {
            $courses = DI::get('query')->selectAll('courses', 'Course');
            $majors = DI::get('query')->selectAll('majors', 'Major');
            require_once "Views/course/index.view.php";
        }
    
        public function create()
        {
            //validate
            $data = $_POST;
            unset($data["create"]);
            DI::get('query')->create('courses', $data);
            header('Location: /course');
        }
    
        public function delete()
        {
            //validate
            DI::get('query')->delete('courses', $_GET['delete']);
        
            header('Location: /course');
        
        }
    
        public function update()
        {
            $courses = DI::get('query')->selectOne('courses', 'Course', $_GET['id']);
            $majors = DI::get('query')->selectAll('majors', 'Major');
            require_once "Views/course/update.view.php";
        }
    
        public function put()
        {
            //validation
            $post = $_POST;
            unset($post['id']);
            DI::get('query')->update('courses', $post, $_POST['id']);
            header('Location: /course');
        }
    }