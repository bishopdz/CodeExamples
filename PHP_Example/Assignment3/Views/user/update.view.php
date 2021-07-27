<?php
/**
 * Created by PhpStorm.
 * User: bishopdz
 * Date: 10/17/2018
 * Time: 5:43 PM
 */
?>

<html>


<body>

    <br> Update a User:
    <form action = "/user/update" method="post">

        <input value="<?=$person->id?>" type="hidden" name='id' >
        <div class=form-group">
            <label>First Name:</label>
            <input value ="<?=$person->first_name?>" type="text" name = 'first_name'>
        </div>
        <div class=form-group">
            <label>Last Name:</label>
            <input value ="<?=$person->last_name?>" type="text" name = 'last_name'>
        </div>
        <div class=form-group">
            <label>Title:</label>
            <input value ="<?=$person->title?>" type="text" name = 'title'>
        </div>
        <div class=form-group">
            <label>Email:</label>
            <input value ="<?=$person->email?>" type="text" name = 'email'>
        </div>
        <div class=form-group">
            <label>Active:</label>
            <input value ="<?=$person->active?>" type="text" name = 'active'>
        </div>
        <div class=form-group">
            <button class="btn-primary" type="submit">Submit</button>
        </div>
    </form>

</body>

</html>