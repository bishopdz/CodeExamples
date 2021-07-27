<?php
    /**
     * --------------------------------------------------------------------------
     * File name: index.view.php
     * Project name: Assignment3
     * --------------------------------------------------------------------------
     * Author’s name and email: Daniel Bishop, bishopdz@etsu.edu
     * Course-Section: CSCI 2910
     * Creation Date: 10/15/2018
     * Last modified: (Daniel Bishop, 10/15/2018, bishopdz@etsu.edu)
     * --------------------------------------------------------------------------
     */
?>

<html>

<body>
    
    <?php
        $table = new TableBuilder();
        $table->__tableBuilder($people, 'user');
    ?>
    
    <br> Create a new User:
    <form action = "/user" method="post">
        <input type="hidden" name="create" value="true">
        <div class=form-group">
            <label>First Name:</label>
            <input type="text" name = 'first_name'>
        </div>
        <div class=form-group">
            <label>Last Name:</label>
            <input type="text" name = 'last_name'>
        </div>
        <div class=form-group">
            <label>Title:</label>
            <input type="text" name = 'title'>
        </div>
        <div class=form-group">
            <label>Email:</label>
            <input type="text" name = 'email'>
        </div>
        <div class=form-group">
            <button class="btn-primary" type="submit">Submit</button>
        </div>
    </form>

</body>

</html>
