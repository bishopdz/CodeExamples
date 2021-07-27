<?php
    /**
     * --------------------------------------------------------------------------
     * File name: course.view.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/17/2018
     * Last modified: (Daniel Bishop, 10/17/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
?>

<html>
    
    <body>

        <table class="table">
            <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Course Name</th>
                    <th scope="col">Course Number</th>
                    <th scope="col">Credit Hour</th>
                    <th scope="col">Major</th>
                    <th scope="col">Active</th>
                    <th scope="col">Description</th>
                    <th scope="col">Course Coordinator_ID</th>
                    <th scope="col">Update</th>
                    <th scope="col">Delete</th>
                </tr>
            </thead>
            <tbody>
                <?php
                    foreach ($courses as $course):?>
                        <tr>
                            <th scope="row"><?= $course->id?></th>
                            <td><?= htmlspecialchars($course->course_name)?></td>
                            <td><?= htmlspecialchars($course->course_number)?></td>
                            <td><?= htmlspecialchars($course->credit_hour)?></td>
                            <td><?= $course->joinMajorId($course->major_id)?></td>
                            <td><?= htmlspecialchars($course->active)?></td>
                            <td><?= htmlspecialchars($course->description)?></td>
                            <td><a href ="/course/update?id=<?= $course->id ?>"><i class="fas fa-edit"></a></td>
                            <td><a href ="/course/delete?delete=<?= $course->id ?>"><i class="fas fa-trash-alt"></i></a></td>
                        </tr>
                    <?php endforeach; ?>

            </tbody>
        </table>
        
        <br> Create a new Course:
        <form action = "" method="post">
            <input type="hidden" name="create" value="true">
            <div class="form-group">
                <label>Course Name:</label>
                <input type="text" name = 'course_name'>
            </div>
            <div class="form-group">
                <label>Course Number:</label>
                <input type="text" name = 'course_number'>
            </div>
            <div class="form-group">
                <label>Credit Hour:</label>
                <input type="text" name = 'credit_hour'>
            </div>
            <div class="form-group">
                <label>Major Field:</label>
                <select class="form-control" name='major_id'>
                    <?php
                        foreach($majors as $major): ?>
                            <option value="<?=$major->id?>"><?= $major->name ?></option>
                        <?php endforeach;?>
                </select>
            </div>
            <div class="form-group">
                <label>Description:</label>
                <input type="text" name = 'description'>
            </div>
            <div class="form-group">
                <label>Course Coordinator ID:</label>
                <input type="text" name = 'course_coordinator_id'>
            </div>
            <div class="form-group">
                <button class="btn-primary" type="submit">Submit</button>
            </div>
        </form>
    
    </body>

</html>