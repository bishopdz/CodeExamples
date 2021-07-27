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
        
        <br> Update a Role:
        <form action = "/role/update" method="post">
            
            <input value="<?=$roles->id?>" type="hidden" name='id' >
            <div class=form-group">
                <label>Name:</label>
                <input value ="<?=$roles->name?>" type="text" name = 'name'>
            </div>
            <div class=form-group">
                <button class="btn-primary" type="submit">Submit</button>
            </div>
        </form>
    
    </body>

</html>