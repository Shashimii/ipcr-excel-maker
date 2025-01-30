<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Officers;
use Illuminate\Http\Request;
use Validator;

class OfficersController extends Controller
{
    // get all officers
    public function getOfficers() {
        $officers = Officers::select('id', 'name')->orderBy('id', 'asc')->get();
        return response()->json($officers);
    }

    // get assigned officers and their duties
    public function getAssignedOfficers() {
        $assignedOfficers = Officers::with('assignedDuties')->has('assignedDuties')->get();
        return response()->json($assignedOfficers);
    }

    // select officer
    public function selectOfficer($id) {
        // validate
        if (!is_numeric($id)) {
            return response()->json(['message' => 'Invalid officer id'], 422);
        }

        // find
        $officer = Officers::find($id);
        
        if (!$officer) {
            return response()->json(['message' => 'Officer not found'], 404); 
        }

        // return finded officer
        return response()->json($officer);

    }

    // post officer
    public function postOfficer(Request $request) {
        // validate
        $validate = Validator::make($request->all(), [
            'name' => 'required|string|max:255'
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }

        // create
        Officers::create([
            'name' => $request->name
        ]);

        // response
        return response()->json(200);
    }

    // edit officer
    public function editOfficer(Request $request, $id) {
        // validate
        $validate = Validator::make($request->all(), [
            'name' => 'required|string|max:255'
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }

        // find
        $officer = Officers::find($id);

        if (!$officer) {
            return response()->json(['message' => 'Officer not found'], 404);
        }

        // edit
        $officer->name = $request->input('name');
        $officer->save();

        // response
        return response()->json(['message' => 'Officer edited successfully'], 200);
    }

    // delete officer
    public function deleteOfficer($id) {
        // validate
        if (!is_numeric($id)) {
            return response()->json(['message' => 'Invalid officer number'], 422);
        }

        // find
        $officer = Officers::find($id);

        if (!$officer) {
            return response()->json(['message' => 'Officer not found'], 404);
        }

        //delete
        $officer->delete();

        // response
        return response()->json(['message' => 'Officer deleted successfully'], 200);
    }
}
