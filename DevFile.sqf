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
// SFSM_fnc_functional


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

/*
- CHECK POS ON VECTOR FUNCTION
- MAKE SURE OBJECTIVE ATTACK LOOP IMPLEMENTS NEW FUNCTIONS
- UPDATE ENDTASK FUNCTIONS (OBJECTIVES)
- Multiple target test on Mech unload.
*/

// SQFM_fnc_zoneUrbanCoef = {};


// SQFM_fnc_groupObjectiveAttackLoop = {};
// SQFM_fnc_endTaskGroup = {};


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

[["mech: ",_mech, " infantry: ", _infantry, " vehicle: ", _vehicle, " urban: ", _urban, " type: ",_squadType]] call dbgm;

if(_urban isEqualTo false
&&{_infantry}) exitWith{_self call ["infClearObjective",[_objective]]};
if(_infantry)  exitWith{_self call ["infClearUrbanObjective",[_objective]]};

if(_urban isEqualTo false
&&{_mech}) exitWith{_self call ["mechClearObjective",[_objective]]};
if(_mech)  exitWith{_self call ["mechClearUrbanObjective",[_objective]]};

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


SQFM_fnc_groupMechClearObjective      = {};


SQFM_fnc_groupMechClearUrbanObjective = { 
params[
    ["_objective",nil,[objNull]]
];
private _vehicles   = (_self call ["getOwnVehicles"])#2;
private _objData    = _objective call getData;
private _center     = _objData get "position";
private _startPos   = _self call ["getAvgPos"];
private _roadMap    = _objData get "roadmap";
private _roads      = (_roadMap get "positions");//select{[_x, false, 8, 3]call SQFM_fnc_clearPos};
private _centerRoad = [_center, _roads] call SQFM_fnc_getNearest;
private _exits      = _roadMap get "exitPositions";

if([_centerRoad, false, 8, 3]call SQFM_fnc_clearPos)
then{_exits pushBackUnique _centerRoad};

private _pathPositions = [_startPos, _exits] call SQFM_fnc_posArrToPath;

{_self call ["mechUnload"]} forEach _vehicles;


};


// hint str ((allTurrets this)apply{this weaponsTurret _x});
SQFM_fnc_assignSuppressionTargets = { 
params[
    ["_shooters",    nil,   [[]]],
    ["_targets",     nil,   [[]]],
    ["_setVariable", nil, [true]]
];
if(_targets  isEqualTo [])exitWith{false};
if(_shooters isEqualTo [])exitWith{false};

private _endIndex    = count _targets;
private _targetIndex = 0;

{
    if(_targetIndex >= _endIndex)
    then{_targetIndex = 0};

    private _target = _targets#_targetIndex;

    if(typeName _target isEqualTo "OBJECT"
    &&{_target isKindOf "house"})
    then{_target = [aimPos _x, _target] call SQFM_fnc_getBuildingSuppressionPos};

    if(_setVariable)
    then{_x setVariable ["SQFM_suppressionTarget", _target]}
    else{_x doSuppressiveFire _target};
    
    _targetIndex=_targetIndex+1;
    
} forEach _shooters;

true;
};

SQFM_fnc_onMechUnloadDanger = { 
params[
    ["_vehicle",  nil,[objNull]],
    ["_shooters", nil,     [[]]],
    ["_targets",  nil,     [[]]]
];
private _gunners = (allTurrets _vehicle)apply{_vehicle turretUnit _x};

[_vehicle] call SQFM_fnc_deployVehicleSmoke;

if(_targets isEqualTo [])exitWith{};
[_gunners, _targets, false] call SQFM_fnc_assignSuppressionTargets;

if(_shooters isEqualTo [])exitWith{};
[_shooters, _targets, true] call SQFM_fnc_assignSuppressionTargets;

private _gunner = gunner _vehicle;
if(!alive _gunner)exitWith{};

sleep 3;

private _command = toLower currentCommand _gunner;
if("supp" in _command)exitWith{};

_gunner suppressFor 15;

true;
};








// [_pathPositions] call SQFM_fnc_showPosArr3D;


/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

if(time < 3)exitWith{};


private _pos      = eyePos player;
// ppp = ASLToATL ([_pos, cursorObject] call SQFM_fnc_getBuildingSuppressionPos);
// [[ppp]] call SQFM_fnc_showPosArr3D;

// private _dir      = getDirVisual vehicle player;
private _dir      = [(getDirVisual (vehicle player)-180)] call SQFM_fnc_formatDir;
private _width    = 170;
private _clearRad = 100;
private _grpData  = (curatorSelected#1#0) call getData;

// private _objCenter = cursorObject modelToWorld (([cursorObject] call SQFM_fnc_objectShape)get"center");
// [[_objCenter]] call SQFM_fnc_showPosArr3D;
// hint str _objCenter;
// _positions = [[_pos, 30], _dir, 160, 10,6] call SQFM_fnc_semiCirclePosArr;
// [_positions] call SQFM_fnc_showPosArr3D;
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
_grpData call ["garrison"];


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