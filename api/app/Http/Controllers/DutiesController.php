<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Duties;
use Illuminate\Http\Request;
use Validator;

class DutiesController extends Controller
{   
    // get all duties
    public function getDuties() {
        $duties = Duties::select('id', 'title')->orderBy('id', 'asc')->get();
        return response()->json($duties);
    }

    // post officer
    public function postDuty(Request $request) {
        // validate
        $validate = Validator::make($request->all(), [
            'title' => 'required|string|max:255'
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }

        // create
        Duties::create([
            'title' => $request->title
        ]);

        // response
        return response()->json(200);
    }

    // edit duty
    public function editDuty(Request $request, $id) {
        // validate
        $validate = Validator::make($request->all(), [
            'title' => 'required|string|max:255'
        ]);
        
        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }

        // find duty
        $duty = Duties::find($id);

        if (!$duty) {
            return response()->json(['message' => 'Duty not found'], 404);
        }
        
        // edit duty
        $duty->title = $request->input('title');
        $duty->save();

        // send success response
        return response()->json(['message' => 'Duty edited successfully'], 200);
    }

    // delete duty
    public function deleteDuty($id) {
        // validate
        if (!is_numeric($id)) {
            return response()->json(['message' => 'Invalid duty id'], 422);
        }

        // find duty
        $duty = Duties::find($id);

        if (!$duty) {
            return response()->json(['message' => 'Duty not found']. 404);
        }

        // delete duty
        $duty->delete();

        // send success response
        return response()->json(['message' => 'Duty deleted successfully'], 200);

    }
}
