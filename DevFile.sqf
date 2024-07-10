scr = [] execVM "devFile2.sqf";
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

/*********************************/
SQFM_fnc_initTransportSpawner = { 
params[
	["_module",nil,[objNull]]
];
private _vehicles     = [];
private _capacities   = [];
private _parkingSpots = [];
private _side         = call compile (_module getVariable "sqfm_side");
private _globalizeFnc = {(_self get "module") setVariable ["SQFM_spawnerData", _self, true]};

{
	deleteVehicleCrew _x;
	private _data = [_x] call SQFM_fnc_transportVehicleData;
	if(!isNil "_data")then{
		_vehicles     pushBackUnique  _data;
		_capacities   pushBackUnique (_data get "capacity");
		_parkingSpots pushBackUnique [_data get "pos", _data get "dir", _data get "shape"];
	};
	deleteVehicle _x;	
} forEach (synchronizedObjects _module);

if(_vehicles isEqualTo [])exitWith{["Transport-spawner cannot init\nNo vehicles was synced to it", "hint"]call dbgm;};

private _dataArr = [
	["vehicles",                               _vehicles],
	["module",                                   _module],
	["lastSpawnTime",                               time],
	["side",                                       _side],
	["assetCount", _module getVariable "sqfm_assetcount"],
	["maxCapacity",                                  nil],
	["waitingToSpawn",                             false],
/***********************************************************/
	["timeSinceSpawn",    {time-(_self get "lastSpawnTime")}],
	["spawnTransport",               SQFM_fnc_spawnTransport],
	["sendTransport",                 SQFM_fnc_sendTransport],
    ["initTransportTask",SQFM_fnc_transportInitTask],
	["transportAvailability", SQFM_fnc_transportAvailability],
	["getVehicleType",        SQFM_fnc_spawnerGetVehicleType],
	["selectSpawnPos",            SQFM_fnc_transportSpawnPos],
	["globalize",                              _globalizeFnc]
];
private _maxCapacity = selectMax _capacities;
private _hashMap     = createHashmapObject [_dataArr];

_hashMap set         ["maxCapacity",  _maxCapacity];
_module  setVariable ["SQFM_spawnerData", _hashMap, true];

true;
};
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
// SQFM_fnc_groupAddUnitEventHandler    = {};
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

SQFM_fnc_assignAllGroupTasks = {};






/**************Update group and objective methods***********************/
// call SQFM_fnc_initReinforRequestsMap;
// call SQFM_fnc_updateMethodsAllGroups;
// call SQFM_fnc_updateMethodsAllObjectives;
// call SQFM_fnc_initAllTransportModules;
/************************Code to execute*******************************/

private _pos          = getPosATLVisual player;
private _trnsportData = SP1 call getData;
private _passengerGrp = grp_1;

_trnsportData call ["sendTransport",[_passengerGrp, _pos]];

/************************{FILE END}*******************************/
systemChat "devfiled read";