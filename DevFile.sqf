systemChat "devfiled found";
// SFSM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
/*********************************/
/*
Basic Mod setup:
    1) Debug-mode (messages, logging & 3D).
	2) 3Den Debug.
	3) Group-init (Events and data)
	3) Init (Server and Client).
    4) Combat zones (define when combat starts and ends).
    5) Task Manager.

	Current:
	init Objective 
	Debug-3d ingame
*/

// SQFM_fnc_groupSpawnedEh      = {};
// SQFM_fnc_onEnemyDetected     = {};
// SQFM_fnc_onKnowsAboutChanged = {};
// SQFM_fnc_grpEvents           = {};
// SQFM_fnc_initGroup           = {};
// SQFM_fnc_initGroupData       = {};
// SQFSM_Objective

SQFM_fnc_getModuleArea = { 
params[
	["_module", nil, [objNull]]
];
(_module getVariable "objectarea")
params[
	["_a",           nil,    [0]],
	["_b",           nil,    [0]],
	["_angle",       nil,    [0]],
	["_isRectangle", nil, [true]],
	["_c",           nil,    [0]]
]; 

private _center = getPosATLVisual _module;
private _area   = [_center, _a, _b, _angle, _isRectangle, _c];

_area;
};

SQFM_fnc_sinCosPos = { 
params[
	["_origin", nil, [[]]],
	["_dir",    nil,  [0]],
	["_dist",   nil,  [0]],
	["_z",      0,    [0]]
];
private _pos = _origin getPos [_dist, _dir];

[_pos#0, _pos#1, _z];
};

SQFM_fnc_AddZ = { 
params[
	["_Position",   nil, [[]]],
	["_valueToAdd", nil,  [0]]
];

if(typeName _Position isNotEqualTo "ARRAY")
exitWith{"non-array data passed to the Add Z function" call dbgm;};
if(count _Position < 3)
exitWith{"less than 3 coordinates passed to the Add Z function" call dbgm;};

private _newPos = [
	_Position select 0,
    _Position select 1,
    (_Position select 2) + _valueToAdd
];

_newPos;
};

SQFM_fnc_getAreaCorners = { 
params[
	["_center",      nil,   [[]]],
	["_a",           nil,    [0]],
	["_b",           nil,    [0]],
	["_angle",       nil,    [0]],
	["_isRectangle", nil, [true]],
	["_c",           nil,    [0]]
];

_center             = ATLToASL _center;
private _z          = _center#2;
private _cFront     = [_center, _angle,       _b, _z] call SQFM_fnc_sinCosPos;
private _frontRight = [_cFront, _angle+90,    _a, _z] call SQFM_fnc_sinCosPos;
private _frontLeft  = [_cFront, _angle-90,    _a, _z] call SQFM_fnc_sinCosPos;
private _cBack      = [_center, (_angle+180), _b, _z] call SQFM_fnc_sinCosPos;
private _backRight  = [_cBack, _angle+90,     _a, _z] call SQFM_fnc_sinCosPos;
private _backLeft   = [_cBack, _angle-90,     _a, _z] call SQFM_fnc_sinCosPos;

private _positions      = [];
private _floorPositions = [_frontRight, _frontLeft, _backLeft, _backRight] apply {ASLToATL _x};
private _roofPositions  = _floorPositions apply {[_x, _c] call SQFM_fnc_AddZ;};

_positions append _floorPositions;
_positions append _roofPositions;

_floorPositions =
_floorPositions apply {
	_x params ["_xx", "_y", "_z"];
	[_xx, _y, 0.2];
};

[_floorPositions, _roofPositions, _positions];
};

SQFM_fnc_areaCornerLines = { 
params[
	["_floor", nil, [[]]], // BottomCorners
	["_roof",  nil, [[]]], // TopCorners
	["_all",   nil, [[]]]
];
private _color = [0.4, 1, 0.9, 1];
private _j     = 0;
private _lines = (_floor apply {
	private _endPos = _roof#_j; _j= _j+1;
	[_x, _endPos, _color];
});

_lines append [
	[_roof#0, _roof#1, _color],
	[_roof#2, _roof#3, _color],
	[_roof#0, _roof#3, _color],
	[_roof#1, _roof#2, _color]
];


_lines;
};


SQFM_fnc_module3dData = { 
params[
	["_module", nil, [objNull]]
];
private _area    = [_module] call SQFM_fnc_getModuleArea;
private _corners = _area     call SQFM_fnc_getAreaCorners; 
private _lines   = _corners  call SQFM_fnc_areaCornerLines;

private _dataArr = [
	["area",       _area],
	["corners", _corners],
	["lines",     _lines]
];

private _data = createHashmapObject [_dataArr];

_data;
};

SQFM_fnc_setObjectiveData = { 
params[
	["_module", nil, [objNull]]
];
private _data3d     = [_module] call SQFM_fnc_module3dData;
private _type       = _module getVariable "objectiveType";
private _assetType  = _module getVariable "assetType";
private _assetcount = _module getVariable "assetCount";
private _distance   = _module getVariable "activationDistance";
private _owner      = sideUnknown;
private _sides      = [];

if(_module getVariable "allowEast")        then {_sides pushBack east;};
if(_module getVariable "allowIndependent") then {_sides pushBack independent;};
if(_module getVariable "allowWest")        then {_sides pushBack west;};


private _dataArr = [
	["3dData",        _data3d],
	["distance",    _distance],
	["type",            _type],
	["asset",      _assetType],
	["count",     _assetcount],
	["owner",     sideUnknown],
	["contested",       false]
];

private _data = createhashMapObject [_dataArr];

_module setVariable ["SQFM_objectiveData", _data];

_data;
};

SQFM_fnc_objective3D = { 
private _camPos     = (positionCameraToWorld [0,0,0]);
private _objectives = _camPos nearEntities ["SQFSM_Objective", 200];

{
	private _data = _x getVariable "SQFM_objectiveData";
	if(!isNil "_data")then{};
	
} forEach _objectives;


};

SQFM_fnc_initObjective = { 
params[
	["_module", nil, [objNull]]
];
[_module] call SQFM_fnc_setObjectiveData;

};

[o1] call SQFM_fnc_setObjectiveData;
// [o1] call SQFM_fnc_module3dData;

/*********************************/
systemChat "devfiled read";