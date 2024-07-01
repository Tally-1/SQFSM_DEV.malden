scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap   = {};
// SQFM_fnc_initGroupData    = {};
// SQFM_fnc_setGroupMethods   = {};
// SQFM_fnc_setObjectiveData   = {};
// SQFM_fnc_setObjectiveMethods = {};

/*********************************/


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
// SQFM_fnc_transportCrewGetOutEh = {};
// SQFM_fnc_groupCanReplenish     = {};
// SQFM_fnc_groupCanBeReplenished  = {};
// SQFM_fnc_onTransportCrewGetOut    = {};
// SQFM_fnc_groupReplenishTaskEnd     = {};
// SQFM_fnc_groupWaitForTransportSpawn = {};
// SQFM_fnc_groupIsIdle               = {};
// SQFM_fnc_initBattleMap            = {};
// SQFM_fnc_updateBattle            = {};
// SQFM_fnc_updateBattleHudGlobal    = {};
// SQFM_fnc_groupNeedsCombatReplenish  = {};
// SQFM_fnc_groupCanReplenish           = {};
// SQFM_fnc_groupCanCombatReplenish      = {};
// SQFM_fnc_groupCombatReplenishAlgorythm = {};
// SQFM_fnc_groupCombatReplenish         = {};
// SQFM_fnc_battleReplenishGroups       = {};
// SQFM_fnc_groupCanReplenishGroup     = {};

SQFM_fnc_battlefieldDimensions = { 
params [
	["_man",    nil, [objNull]], 
	["_target", nil, [objNull]]
];
private _baseRad = _man distance2D _target;
private _minRadB = (_baseRad*1.1)+50;
private _scanRad = ceil(selectMax[_baseRad, SQFM_minBattleSize]);
private _pos     = [[_man, _target]] call SQFM_fnc_avgPos2D;
private _list    = _pos nearEntities ["land", _scanRad];
private _dataArr = [_list] call SQFM_fnc_objArrData;
private _center  = _dataArr#0;
private _radius  = _dataArr#1;

// if(_radius > _minRadB)exitWith{[_center, _radius+50]};


// private _center  = [_man, _target] call SQFM_fnc_battlefieldCenter;
// private _radius  = [_center, _baseRad] call SQFM_fnc_battlefieldRadius;

[_center, _radius];
};


/**************Update group and objective methods***********************/
// call SQFM_fnc_initReinforRequestsMap;
call SQFM_fnc_updateMethodsAllGroups;
// call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/


// []spawn{
// private _data = grp1 call getData;
// private _targetGroup = group player;

// _data call ["replenishGroup", [_targetGroup]];
// };

systemChat "devfiled read";