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
-Complete- 1)  Fix bug where some available Squads are not assigned.
-Complete- 2)  Limit battle-size -min/max- (Important in order to implement reinforcements)
-Complete- 3)  Set building changed eventhandler for BFFs and Objectives (In order to implement defensive tactics)
-Complete- 4)  Make sure Objectives are actually captured
-Complete- 5)  Make attack-only squads keep pushing to the next Objective once the current one is taken.
-Complete- 6)  Send defensive squads.

7)  Call/Send reinforcements.
    - Call function:
        * Sends a request via radio.
        * Request data is stored in an array (Pos, caller, time sent)
        * Request is responded to on group assignment loop.
    - Send function.
        (complete) * Checks all requests and sorts them by time sent.
        (canceled) * Each ReInf squad is selected by proximity of strength to enemy target.
        (complete) * Requests that cannot be fulfilled are denied via radio.
        (complete) * Denied requests are deleted from request Array.
    - Can request function:
        (complete) * If a squad already has a reinforcement request it cannot send another.
        (complete) * A squad needs to be inside a battle-zone to request reinforcements.
    - Can respond:
        (complete) * Squad is currently not in a fight.
        (complete) * Squad is not already responding to a request.
        (complete) * Squad does not have any current tasks.
        (complete) * Squad is set to allow reinforcing (Via module, default = true)

(complete) 8)  Combat insertion.

9)  Transport react to fire / Enemy spotted.
10) Transport Pickup fail handling.
11) Battlefield Map markers
12) Objective   Map markers
13) Redo State entry.
    - Eliminated
    - In transport
    - In battle
    - ""(normal/idle)
14) Control action status (remove states as action)
15) Do the taskmanager in a forEachFrame loop to avoid scheduler issues.
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


/*
// 1) Stuck on objective
// 2) Push near enemies. (Instead of hunt *namechange)
// 3) Knowledge to push slider.
// 4) Endless defense fix.
5) Garrison / Take cover when idle.
6) Mortars
7) Ammo rearm (Supply-truck / crates).
*/
SQFM_fnc_assignAllGroupTasks = {};
// SQFM_fnc_groupGetNearUrbanZones = {};
// SQFM_fnc_groupCanIdleGarrison = {};
// SQFM_fnc_allWaypointPositions = {};
// SQFM_fnc_groupInitIdleGarrison = {};
// SQFM_fnc_assignGroupsMapIdleCover = {};
// SQFM_fnc_assignGroupsIdleCover = {};

SFSM_fnc_forcedMoveToPos = { 
params [ 
    ["_man",       nil, [objNull]],      //The man that will move.
    ["_pos",       nil,      [[]]],     // Target position
    ["_time",      nil,       [0]],    //  Timeout (max time to attempt to reach said pos)
    ["_cRadius",   3,         [0]],   //   Completion radius (distance to wanted pos before move can be considered complete).
    ["_endCode",   nil,      [[]]],  //    Function to be run on completion [[params],{_code}]
    ["_condition", [],       [[]]], //     Boolean function, if it returns false the move will be aborted. [[params],{_code}]
    ["_cndFreq",   0.1,       [0]] //      How often the custom condition is checked
];
private _canSprint  = [_man, _pos, 50, 5] call SFSM_fnc_canSprint;
private _combatMode = unitCombatMode _man;
_pos = [_pos] call SFSM_fnc_formatMovePos;

if(_canSprint)exitWith{
    [_man, _pos] call SFSM_fnc_sprint;
    
    if([_man, _pos] call SFSM_fnc_canSprint)
    then{[_man, _pos] call SFSM_fnc_sprint};

    if(!isNil "_endCode")
    then{(_endCode#0)call(_endCode#1)};
};


private _alreadyMoving = (_man getVariable ["FSM_moveEnded", true])isEqualTo false;
if(_alreadyMoving)exitWith{"Double move" call dbgm};

private _canRun = isNil "SFSM_fnc_canRun"or{[_man,nil,nil,nil,true] call SFSM_fnc_canRun};
if!(_canRun)exitWith{"Move blocked by soldier FSM" call dbgm};

_this set [5,[[_man,true], SFSM_fnc_canRun]];
_this set [6,1];

_this call SQFM_fnc_initFsmMoveMan;
_this call SQFM_fnc_execFsmMoveMan;
_this call SQFM_fnc_endFsmMoveMan;

private _distToPos  = [_man distance2D _pos, 2] call Tcore_fnc_decimals;
private _moveFailed = _distToPos > _maxDistance;

if(_moveFailed)exitWith{ 
    private _noFlash = SFSM_debugger && {(_man getVariable "SFSM_UnitData" get "flashAction") isEqualTo ""};
    private _txt     = ["Target-pos missed by ", _distToPos,"m"]joinString"";
    if(_noFlash)then{[_man, _txt] spawn SFSM_fnc_flashAction;};
    false;
};


true;
};


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
// SQFM_fnc_onManGarrison            = {};


/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
// call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

private _groups = curatorSelected#1;
[_groups] spawn SQFM_fnc_assignGroupsIdleCover;
// {
//     private _data = _x call getData;
//     _data spawn {_this call["initIdleGarrison"]};
//     systemChat str _x;
    
// } forEach _groups;

// private _camPos  = (positionCameraToWorld [0,0,0]);
// private _data = grp1 call getData;
// _camPos set [2,0];

// _data call ["unStop"];




// 
// SQFM_fnc_testWp = { 
// params [
//     ["_group", nil, [grpNull]]
// ];
// systemChat str _this;
// };

// private _function  = "SQFM_fnc_testWp";
// private _data      = grpH call getData;
// private _pos       = getPosATLVisual player;
// private _waypoint  = _data call ["addWaypoint",[_pos,5,"MOVE",_function]];
// private _trnsportData = SP1 call getData;
// private _passengerGrp = grp_1;
// _trnsportData call ["sendTransport",[_passengerGrp, _pos]];

/************************{FILE END}*******************************/
systemChat "devfiled read";