<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AssignedDuties extends Model
{
    use HasFactory;

    protected $fillable = [
        'officer_id',
        'duty_id',
        'officer_index',
        'duty_index',
        'officer',
        'duty',
        'date',
        'code'
    ];
}
