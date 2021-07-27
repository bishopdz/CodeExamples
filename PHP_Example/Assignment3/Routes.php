<?php
/**
 * Created by PhpStorm.
 * User: bishopdz
 * Date: 10/17/2018
 * Time: 5:25 PM
 */
 
Route::get('/', 'HomeController@index');


Route::get('/user', 'UserController@index');
Route::get('/user/update', 'UserController@update');
Route::get('/user/delete', 'UserController@delete');

Route::post('/user', 'UserController@create');
Route::post('/user/update', 'UserController@put');


Route::get('/course', 'CourseController@index');
Route::get('/course/update', 'CourseController@update');
Route::get('/course/delete', 'CourseController@delete');

Route::post('/course', 'CourseController@create');
Route::post('/course/update', 'CourseController@put');


Route::get('/major', 'MajorController@index');
Route::get('/major/update', 'MajorController@update');
Route::get('/major/delete', 'MajorController@delete');

Route::post('/major', 'MajorController@create');
Route::post('/major/update', 'MajorController@put');


Route::get('/role', 'RoleController@index');
Route::get('/role/update', 'RoleController@update');
Route::get('/role/delete', 'RoleController@delete');

Route::post('/role', 'RoleController@create');
Route::post('/role/update', 'RoleController@put');

?>