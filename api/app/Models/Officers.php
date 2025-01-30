<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Officers extends Model
{
    use HasFactory;

    protected $fillable = [
        'name'
    ];

    
    public function assignedDuties() {
        return $this->hasMany(AssignedDuties::class, 'officer_id');
    }
}
