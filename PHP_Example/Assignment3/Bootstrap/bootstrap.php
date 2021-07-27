<?php
    /**
     * --------------------------------------------------------------------------
     * File name: bootstrap.php
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
    
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    </head>
    
</html>

<?php
    require_once 'App/DI.php';
    require_once 'App/Route.php';
    require_once 'Database/QueryBuilder.php';
    require_once 'Database/Database.php';
    require_once 'Controllers/HomeController.php';
    require_once 'Controllers/UserController.php';
    require_once 'Controllers/CourseController.php';
    require_once 'Controllers/MajorController.php';
    require_once 'Controllers/RoleController.php';
    require_once 'Models/Course.php';
    require_once 'Models/Major.php';
    require_once 'Models/Role.php';
    require_once 'Models/User.php';
    require_once 'TableBuilder.php';
    
    DI::bind('query', new QueryBuilder(Database::connect("sqlite", "Database/database.sqlite")));

    require_once 'routes.php';
    
    if(isset($_SERVER['PATH_INFO']))
    {
        Route::direct($_SERVER['PATH_INFO'], $_SERVER['REQUEST_METHOD']);
    }
    else
    {
        Route::direct($_SERVER['REQUEST_URI'], $_SERVER['REQUEST_METHOD']);
    }

?>