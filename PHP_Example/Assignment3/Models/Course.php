<?php
    /**
     * --------------------------------------------------------------------------
     * File name: Course.php
     * Project name: Assignment2
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 09/21/2018
     * Last modified: (Daniel Bishop, 09/21/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
    
    class Course
    {
        public function joinMajorId($major_id)
        {
            $stmt = DI::get('query')->getPDO()->prepare("select majors.name from majors join courses on major_id = ?");
            $stmt->execute([$major_id]);
            return $stmt->fetch()[0];
        }
    }
    
?>