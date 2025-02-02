<?php

use App\Http\Controllers\AssignedDutiesController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DutiesController;
use App\Http\Controllers\OfficersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

// User Auth
Route::get('/sanctum/csrf-cookie', [AuthController::class, 'csrfCookie']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
Route::get('/user', [AuthController::class, 'user'])->middleware('auth:sanctum');
Route::patch('/editUsername/{id}', [AuthController::class, 'editUsername'])->middleware('auth:sanctum');
Route::patch('/editPassword/{id}', [AuthController::class, 'editPassword'])->middleware('auth:sanctum');

// Officers
Route::get('/getOfficers', [OfficersController::class, 'getOfficers']);
Route::get('/getOfficer/{id}', [OfficersController::class, 'selectOfficer']);
Route::post('/postOfficer', [OfficersController::class, 'postOfficer']);
Route::patch('/editOfficer/{id}', [OfficersController::class, 'editOfficer']);
Route::delete('/deleteOfficer/{id}', [OfficersController::class, 'deleteOfficer']);

// Duties
Route::get('/getDuties', [DutiesController::class, 'getDuties']);
Route::post('/postDuty', [DutiesController::class, 'postDuty']);
Route::patch('/editDuty/{id}', [DutiesController::class, 'editDuty']);
Route::delete('/deleteDuty/{id}', [DutiesController::class, 'deleteDuty']);

// Assigned Duties
Route::get('/getAssignedDuties', [AssignedDutiesController::class, 'getAssignedDuties']);
Route::post('/postAssignedDuty', [AssignedDutiesController::class, 'postAssignedDuty']);
Route::delete('/deleteAssignedDuty/{id}', [AssignedDutiesController::class, 'deleteAssignedDuty']);
Route::delete('/deleteAllAssignedDuties', [AssignedDutiesController::class, 'clearAssignedDuties']);

// Assigned Officers
Route::get('/getAssignedOfficers', [OfficersController::class, 'getAssignedOfficers']);