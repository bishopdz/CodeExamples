<?php
    /**
     * --------------------------------------------------------------------------
     * File name: update.view.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/20/2018
     * Last modified: (Daniel Bishop, 10/20/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
?>
<html>

    <body>

        <br> Update a Course:
        <form action = "/course/update" method="post">

            <input value="<?=$courses->id?>" type="hidden" name='id' >
            <div class=form-group">
                <label>Course Name:</label>
                <input value ="<?=$courses->course_name?>" type="text" name = 'course_name'>
            </div>
            <div class=form-group">
                <label>Course Number:</label>
                <input value ="<?=$courses->course_number?>" type="text" name = 'course_number'>
            </div>
            <div class=form-group">
                <label>Credit Hour:</label>
                <input value ="<?=$courses->credit_hour?>" type="text" name = 'credit_hour'>
            </div>
            <div class="form-group">
                <label>Major:</label>
                <select class="form-control" name='major_id'>
                    <?php
                        foreach($majors as $major){
                            if($courses->major_id == $major->id){?>
                                <option selected value="<?=$major->id?>"><?=$major->name ?></option>
                            
                            <?php }else{ ?>
                                <option value="<?=$major->id?>"><?=$major->name ?></option>
                            <?php }
                        } ?>
                </select>
            </div>
            <div class=form-group">
                <label>Active:</label>
                <input value ="<?=$courses->active?>" type="text" name = 'active'>
            </div>
            <div class=form-group">
                <label>Description:</label>
                <input value ="<?=$courses->description?>" type="text" name = 'description'>
            </div>
            <div class=form-group">
                <label>Course Coordinator ID:</label>
                <input value ="<?=$courses->course_coordinator_id?>" type="text" name = 'course_coordinator_id'>
            </div>
            <div class=form-group">
                <button class="btn-primary" type="submit">Submit</button>
            </div>
        </form>

    </body>

</html>