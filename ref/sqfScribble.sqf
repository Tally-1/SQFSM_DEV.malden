(str SQFM_fnc_groupObjectiveInsertPos splitString " = ") findIf {
"'SQFM_fnc_" in _x}



SQFM_fnc_groupInitMechClearingFormation = { 
private _vehicles  = _self call ["getVehiclesInUse"];
private _men       = _self call ["getUnitsOnfoot"];
private _group     = _self get "grp";
private _formation = formation _group;
private _leaderVeh = vehicle formLeader leader _group;

{_x lockCargo true} forEach _vehicles;
_leaderVeh forceSpeed 3;
_men allowGetIn false;
_group setFormation "FILE";

if(count _men < 6)exitWith{};

private _formationScript = [_leaderVeh] spawn SQFM_fnc_mechFileFormationLoop;

_leaderVeh setVariable ["SQFM_mechFormationScript", _formationScript];

true;
};


SQFM_fnc_mechCanMaintainFormation = { 
params[
    ["_vehicle", nil, [objNull]]
];
private _group = group _vehicle;
if(isNil "_group")   exitWith{"nil group" call dbgm;   false};
if(isNil "_vehicle") exitWith{"nil vehicle" call dbgm; false};
if(isNull _group)    exitWith{"null group" call dbgm;  false};

private _badVehicle = !([_vehicle]call SQFM_fnc_validVehicle);
if(_badVehicle)exitWith{"vehicle invalid" call dbgm; false};


true;
};

SQFM_fnc_mechFileFormationLoop = { 
params[
    ["_vehicle", nil, [objNull]]
];
private _keepFormation = [_vehicle] call SQFM_fnc_mechCanMaintainFormation;
while {_keepFormation} do {

    _keepFormation = [_vehicle] call SQFM_fnc_mechCanMaintainFormation;
    [_vehicle] call SQFM_fnc_mechFileFormation;
    if!(_keepFormation)exitWith{};

    sleep 1;
};

};

SQFM_fnc_mechFileFormationPositions = { 
params[
    ["_vehicle",nil, [objNull]],
    ["_posCount",nil,      [0]]
];
private _posDist    = 2;
private _corners    = [_vehicle] call SQFM_fnc_getObjectCorners;
private _dir        = [(getDirVisual _vehicle)-180] call SQFM_fnc_formatDir;
private _rightCount = round(_posCount/2);
private _leftCount  = round(_rightCount % _posCount);

private _rightStart = _corners#1;
private _rightEnd   = [_rightStart, _dir, _posCount*_posDist] call SQFM_fnc_sinCosPos;
private _rightArr   = [_rightStart, _rightEnd, _rightCount,false] call SQFM_fnc_straightPosArr;

private _leftStart = _corners#0;
private _leftEnd   = [_leftStart, _dir, _posCount*_posDist] call SQFM_fnc_sinCosPos;
private _leftArr   = [_leftStart, _rightEnd, _rightCount,false] call SQFM_fnc_straightPosArr;


[_rightArr] call SQFM_fnc_showPosArr3D;


};

SQFM_fnc_mechFileFormation = { 
params[
    ["_vehicle",nil,[objNull]]
];

private _group     = group _vehicle;
private _men       = units _group select{vehicle _x isEqualTo _x};
private _teamR     = _men select [0, round (count _men/2)];
private _teamL     = _men select {!(_x in _teamR)};





true;
};