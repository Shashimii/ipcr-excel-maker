<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthController extends Controller
{
    // set csrf cookie
    public function csrfCookie(Request $request){
        return response()->json(['message' => 'CSRF cookie set']);
    }

    //login

    public function login(Request $request) {
        // set credentials
        $credentials = $request->only('username', 'password');

        // find username
        $user = User::where('username', $credentials['username'])->first();
        
        if (!$user) {
            return response()->json(['message' => 'Invalid Username'], 404);
        }

        // attempt auth
        if (Auth::attempt($credentials)) {
            $user = Auth::user();

            // create token
            $token = $user->createToken('authToken')->plainTextToken;
            
            // response token
            return response()->json(['token' => $token, 'user' => $user], 200);
        }

        // if auth failed
        return response()->json(['message' => 'Invalid Password'], 401);
    }

    //logout

    public function logout(Request $request) {
        // delete the user token
        $request->user()->currentAccessToken()->delete();

        // response
        return response()->json(['message' => 'logged out'], 200);
    }

    // current user
    public function user(Request $request) {
        return response()->json($request->user());
    }

    // update username
    public function editUsername(Request $request, $id) {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $validatedData = $request->validate([
            'username' => 'string|required',
        ]);

        $user->username = $validatedData['username'];
        $user->save();

        return response()->json(['message' => 'Username updated successfully'], 200);
    }

    // update password
    public function editPassword(Request $request, $id) {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $validatedData = $request->validate([
            'password' => 'string|required'
        ]);

        $user->password = $validatedData['password'];
        $user->save();

        return response()->json(['message' => 'Password updated successfully'], 200);
    }
}
