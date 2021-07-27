<?php
    /**
     * --------------------------------------------------------------------------
     * File name: index.view.php
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
        
        <?php
            $table = new TableBuilder();
            $table->__tableBuilder($roles, 'role');
        ?>
        
        <br> Create a new Role:
        <form action = "" method="post">
            <input type="hidden" name="create" value="true">
            <div class=form-group">
                <label>Name:</label>
                <input type="text" name = 'name'>
            </div>
            <div class=form-group">
                <button class="btn-primary" type="submit">Submit</button>
            </div>
        </form>
    
    </body>

</html>