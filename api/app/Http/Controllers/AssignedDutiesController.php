<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\AssignedDuties;
use Illuminate\Http\Request;
use Validator;

class AssignedDutiesController extends Controller
{
    // get all
    public function getAssignedDuties() {
        $assignedDuties = AssignedDuties::latest()->select('id', 'officer_id', 'duty_id', 'officer_index', 'duty_index', 'officer', 'duty', 'code', 'date')->get();
        return response()->json($assignedDuties);
    }

    // post
    public function postAssignedDuty(Request $request) {
        // validate
        $validation = Validator::make($request->all(), [
            'officer_id' => 'required',
            'duty_id' => 'required',
            'officer_index' => 'required',
            'duty_index' => 'required',
            'officer' => 'required',
            'duty' => 'required',
            'date' => 'required',
            'odtsCode' => 'required'
        ]);
        
        if ($validation->fails()) {
            return response()->json($validation->errors(), 422);
        }

        // post
        AssignedDuties::create([
            'officer_id' => $request->officer_id,
            'duty_id' => $request->duty_id,
            'officer_index' => $request->officer_index,
            'duty_index' => $request->duty_index,
            'officer' => $request->officer,
            'duty' => $request->duty,
            'date' => $request->date,
            'code' => $request->odtsCode,
        ]);

        // response
        return response()->json(200);

    }

    // delete
    public function deleteAssignedDuty($id) {
        // validate
        if (!is_numeric($id)) {
            return response()->json(['message' => 'Invalid assigned duty id'], 422);
        }

        // find
        $assignedDuty = AssignedDuties::find($id);

        if (!$assignedDuty) {
            return response()->json(['message' => 'Assigned duty not found'], 404);
        }

        // delete
        $assignedDuty->delete();

        // response
        return response()->json(['message' => 'Assigned duty deleted successfully'], 200);
    }
}
