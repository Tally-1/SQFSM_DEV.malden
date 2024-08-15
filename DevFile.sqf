scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
scr = [] execVM "SFSM_Devfile.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap     = {};
// SQFM_fnc_setObjectiveData   = {};
// SQFM_fnc_setObjectiveMethods = {};
// SQFM_fnc_initTransportSpawner = {};

/*********************************/

// SQFM_fnc_posRadInitBattle = {};

//  
/************************TODO list*******************************/

/*
TODO:
1) Improve Objective clearing.
    - Faster and more spread out:
        - Remove "SAD" wp type
        - Start clearing on the insertion position.
        - Make a rough grid (1 wp on every 200sqm?)
    - Do not have all squads end up in the middle:
        - Use the GRID mentioned above to delegate positions to squads.
        - A Objective position selection Algorythm
*/
/********************New Functions/Methods*****************************/
// SQFM_fnc_groupAddUnitEventHandler   = {};
// SQFM_fnc_groupRemoveUnitEventHandler = {};
// SQFM_fnc_initGroup                   = {};
// SQFM_fnc_initSquadMembers           = {};
// SQFM_fnc_onSquadManFired           = {};
// SQFM_fnc_onSquadManSuppressed     = {};
// SQFM_fnc_onUnitJoined            = {};
// SQFM_fnc_grpEvents              = {};
// SQFM_fnc_onTransportCombatDrop = {};
// SQFM_fnc_onPassengerCombatDrop = {};
// SQFM_fnc_emergencyParking     = {};
// SQFM_fnc_transportAborted    = {};
// SQFM_fnc_groupAbleToHunt    = {};
// SQFM_fnc_isHuntGroup       = {};
// SQFM_fnc_sendHuntGroups    = {};
// SQFM_fnc_groupHuntCondition = {};
// SQFM_fnc_groupInitHunt     = {};
// SQFM_fnc_onGroupHuntWp    = {};
// SQFM_fnc_groupInitHuntTask = {};
// SQFM_fnc_onGroupHuntEnd   = {};
// SFSM_fnc_canRun


SQFM_fnc_assignAllGroupTasks = {};
// SQFM_fnc_groupGetNearUrbanZones = {};
// SQFM_fnc_groupCanIdleGarrison = {};
// SQFM_fnc_allWaypointPositions = {};
// SQFM_fnc_groupInitIdleGarrison = {};
// SQFM_fnc_assignGroupsMapIdleCover = {};
// SQFM_fnc_assignGroupsIdleCover = {};
// SQFM_fnc_addMoveManFsmCombatEh    = {};
// SQFM_fnc_removeMoveManFsmCombatEh = {};
// SQFM_fnc_moveManFsmCondition      = {};
// SQFM_fnc_validFsmMoveTarget       = {};
// SQFM_fnc_fsmMoveHandleTarget      = {};
// SQFM_fnc_whileManFsmMoving        = {};
// SQFM_fnc_fsmMoveHandleAutoTarget  = {};
// SQFM_fnc_initFsmMoveMan           = {};
// SQFM_fnc_endFsmMoveMan            = {};
// SQFM_fnc_execFsmMoveMan           = {};
// SQFM_fnc_fsmMoveManToPos          = {};
// SQFM_fnc_garrisonMan              = {};


SQFM_fnc_zoneUrbanCoef = { 
params[
    ["_position",  nil, [[]]],
    ["_radius",     nil, [0]],
    ["_buildings", nil, [[]]]
];
if(isNil "_buildings")then{_buildings = [_position, _radius] call SQFM_fnc_nearBuildings};
if(_buildings isEqualTo []) exitWith{0};
if(_radius <= 20)           exitWith{0};

private _count = count _buildings;
private _coef  = _count/_radius;

_coef;
};




SQFM_fnc_groupObjectiveAttackLoop = { 
private _group        = _self get "grp";
private _ownSide      = _self get "side";
private _ownPos       = _self call ["getAvgPos"];
private _objModule    = _self get "objective";
private _objData      = _objModule call getData;
private _taskData     = _self call ["getTaskData"];
private _groups       = _objData  call ["getGroupsInZone"];
private _enemyGroups  = _groups select {[_x, _ownSide] call SQFM_fnc_hostile && {[_x] call SQFM_fnc_validGroup}};
private _enemyCount   = count _enemyGroups;

if(_enemyCount < 1)exitWith{
    "No enemies present" call dbgm; 
    _taskData call ["endTask"];
};

_self call ["deleteWaypoints"];
_self set  ["action", "Attacking Enemies inside objective"];

private _enemyPositions = _enemyGroups apply {(_x call getData) call ["getAvgPos"]};
private _nearest        = [_ownPos, _enemyPositions] call SQFM_fnc_getNearest;
private _onCompletion   = '(group this call getData) call ["objectiveAttackLoop"]';
private _wayPoint       = _group addWaypoint [_nearest, 0];

_wayPoint setWaypointType "SAD";
_wayPoint setWaypointStatements ["true", _onCompletion];
_wayPoint setWaypointCompletionRadius 30;

true;
};

SQFM_fnc_endTaskGroup = { 
params[
	["_group",nil,[grpNull]]
];
private _data     = _group call getData;
private _taskData = _data call ["getTaskData"];
private _nullTask = str _taskData isEqualTo "[]";

if(_nullTask)then{
	_taskData = [_group] call SQFM_fnc_reapplyTask;
	_nullTask = str _taskData isEqualTo "[]";
};

if(_nullTask)
exitWith{"{TaskData not found}" call dbgm};

_taskData call["endTask"];

true
};
/*
Types of objective clearing:
    1) Infantry clearing (non urban)
    2) Infantry clearing (Urban)
    3) Mech(mixed) clearing (non urban)
    4) Mech(mixed) clearing (urban)
    5) Vehicle clearing (non urban)
    6) Vehicle clearing (urban)
*/

SQFM_fnc_groupMechClearObj      = {};
SQFM_fnc_groupMechClearUrbanObj = {};


SQFM_fnc_groupClearObjective = { 
params[
    ["_objective",nil,[objNull]]
];
"group clearing objective" call dbgm;
private _objData   = _objective call getData;
private _urban     = _objData get "isUrbanArea";
private _squadType = _self get "groupType";
private _infantry  = _squadType isEqualTo "infantry";
private _mech      = "(infantry)" in _squadType;
private _vehicle   = _infantry isEqualTo false && {_mech isEqualTo false};

[["mech: ",_mech, " infantry: ", _infantry, " vehicle: ", _vehicle, " urban: ", _urban]] call dbgm;

if(_urban isEqualTo false
&&{_infantry}) exitWith{_self call ["infClearObjective",[_objective]]};
if(_infantry)  exitWith{_self call ["infClearUrbanObjective",[_objective]]};


if(_urban isEqualTo false
&&{_vehicle}) exitWith{_self call ["vehicleClearObjective",[_objective]]};
if(_vehicle)  exitWith{_self call ["vehicleClearUrbanObjective",[_objective]]};


"No valid clearing options" call dbgm;
};


SQFM_fnc_groupOnObjectiveArrival = { 
private _taskData  = _self call ["getTaskData"];
private _objective = (_taskData get "params")#0;
private _objData   = _objective call getData;
private _center    = (_objData get "zone")#0;

_self set  ["state", ""];
_self set  ["action", "Clearing Objective"];
_self call ["clearObjective",[_objective]];

};


SQFM_fnc_showPosArr3D = { 
params[
	["_posArr",nil,[[]]]
];
SQFM_Custom3Dpositions = [];
if(isNil "_posArr")      exitWith{};
if(_posArr isEqualTo []) exitWith{};
private _i = 0;
SQFM_Custom3Dpositions = _posArr apply {_i=_i+1;[_x, str _i]};

};

SQFM_fnc_semiCirclePosArr = { 
params [
    ["_zone",         nil,  [[]]], // [pos, rad] (The zone which will be encircled)
    ["_dir",          nil,   [0]], // 0-359 
    ["_dirRange",     nil,   [0]], // 0-360 (default to 180 degrees for a semicircle)
    ["_posToPosDist", nil,   [0]]  // 0-inf (the wanted distance between each position)
];
_zone params ["_center", "_radius"];

private _dir           = [_dir - (_dirRange*0.5)]call SQFM_fnc_formatDir;
private _circumference = _radius * 2 * 3.14159265358979323846; // Full circle circumference
private _angleStep     = _posToPosDist / _circumference * 360; // Angle step in degrees
private _positions     = [];

for "_i" from 0 to _dirRange step _angleStep do {
    private _currentDir = [_dir + _i]call SQFM_fnc_formatDir;
    private _pos = [_center, _currentDir, _radius] call SQFM_fnc_sinCosPos;
    _positions pushBack _pos;
};

_positions;
};






// [_pathPositions] call SQFM_fnc_showPosArr3D;


/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

if(time < 3)exitWith{};


private _pos      = getPos player;
private _dir      = getDirVisual player;
private _width    = 170;
private _clearRad = 100;
private _grpData = (curatorSelected#1#0) call getData;
// private _grpData = (group player) call getData;
// private _rad     = 250;
// private _posDist = selectMax [_rad*0.1, 10];

// private _positions = [_pos, _rad, _dir, _width, _clearRad, _posDist, 100] call SQFM_fnc_zoneCone;
// [_positions] call SQFM_fnc_showPosArr3D;

if(isNil "SQFM_curObj")
exitWith{systemChat "nil module"};

// [SQFM_curObj] call SQFM_fnc_setObjectiveData;

if(isNil "_grpData")
exitWith{systemChat "nil grpData"};



// private _roads   = _pos nearRoads _rad;
// private _road    = _roads#0;
// private _data    = [_pos, _rad] call SQFM_fnc_getZoneRoadmap;

_grpData call ["vehicleClearObjective",[SQFM_curObj]];

// [_data get "exitPositions"] call SQFM_fnc_showPosArr3D;

// copyToClipboard str _data;

// hint str (_roads#0);



// private _module = SQFM_curObj;
// private _data   = _module call getData;
// _data call ["setUrbanStatus"];

// private _type        = _module getVariable "objectiveType";
// private _buildings   = [_pos, _rad] call SQFM_fnc_nearBuildings;
// private _positions   = _grpData call ["getUrbanObjInfSearchP",[_module]];
// // private _isUrbanArea = (_type isEqualTo "town")||{[_pos, _rad, _buildings] call SQFM_fnc_isUrbanArea};

// [_positions] call SQFM_fnc_showPosArr3D;


// private _markers = _data get "markers";

// hint str ([_data get "isUrbanArea",round time]);

// {
//     private _mrkr = _markers#0;
//     if(isNil "_mrkr")exitWith{};
//     deleteMarker _mrkr;
//     _markers deleteAt 0;

// } forEach _markers;

// _markers = [_module] call SQFM_fnc_drawObjectiveMarkers;
// _data set ["markers", _markers];


// testMarker = [_pos, _rad] call SQFM_fnc_addCircleMarker;
// hint str (count ([_pos,_rad] call SQFM_fnc_nearBuildings)/_rad);


// private _groups = curatorSelected#1;
// [_groups] spawn SQFM_fnc_assignGroupsIdleCover;
/************************{FILE END}*******************************/
systemChat "devfiled read";