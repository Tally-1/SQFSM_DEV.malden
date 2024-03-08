Talib_customMarkers = [];
Talib_trajectories  = [];

addMissionEventHandler 
[
    "Draw3D", 
    {
        [] call Talib_fnc_custom3Dmarkers;
    }
];

addMissionEventHandler 
[
    "Draw3D", 
    {
        {[_x] call Talib_fnc_drawTrajectory} forEach Talib_trajectories;
    }
];

addMissionEventHandler["projectileCreated",{
    params ["_projectile"];

    
    _projectile setVariable ["Talib_lineColor", [0,0,1,1]];
    _projectile setVariable ["Talib_track", [getPosATL _projectile]];
    [_projectile] spawn Talib_fnc_trackTrajectory;

    _projectile addEventHandler ["Deleted", {
	params ["_projectile"];
        Talib_customMarkers pushBackUnique [getPosATL _projectile, "-"];
        [_projectile] call Talib_fnc_addTrajectory;
    }];

_projectile addEventHandler ["SubmunitionCreated", {
	params ["_projectile", "_submunitionProjectile", "_pos", "_velocity"];

    

    // systemChat str (_projectile distance _submunitionProjectile);

    Talib_customMarkers pushBackUnique [getPosATL _projectile, "P"];
    Talib_customMarkers pushBackUnique [ASLToATL _pos, "S-C"];

    _submunitionProjectile setVariable ["Talib_lineColor", [1,0,0,1]];
    _submunitionProjectile setVariable ["Talib_track", [ASLToATL _pos]];

    _projectile addEventHandler ["Deleted", {
	params ["_projectile"];
        Talib_customMarkers pushBackUnique [getPosATL _projectile, "-"];
        [_projectile] call Talib_fnc_addTrajectory;
    }];

    _submunitionProjectile addEventHandler ["Deleted", {
        params ["_projectile"];
        Talib_customMarkers pushBackUnique [getPosATL _projectile, "--"];
        _projectile setVariable ["Talib_lineColor", [1,0,0,1]];
        [_projectile] call Talib_fnc_addTrajectory;
    }];

}];




}];