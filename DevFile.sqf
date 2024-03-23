scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap = {};

// SQFM_fnc_initGroupData = { };
// SQFM_fnc_groupBattleInit             = {};
// SQFM_fnc_groupBattleEnd              = {};
// SQFM_fnc_groupAvgPos                 = {};
// SQFM_fnc_groupcanBoardNow            = {};
// SQFM_fnc_getGroupBoardingMen         = {};
// SQFM_fnc_getAssignedVehicles         = {};
// SQFM_fnc_teleportIntoAssignedVehicle = {};
// SQFM_fnc_groupBoardingStarted        = {};
// SQFM_fnc_groupBoardingEnded          = {};
// SQFM_fnc_groupBoardingFailed         = {};
// SQFM_fnc_groupBoardVehicles          = {};
// SQFM_fnc_postGroupBoarding           = {};
// SQFM_fnc_endGroupBoarding            = {};
// SQFM_fnc_execGroupTravel             = {};
// SQFM_fnc_onTravelWpComplete          = {};
// SQFM_fnc_initGroupTravel             = {};
// SQFM_fnc_groupEjectFromAllVehicles   = {};
// SQFM_fnc_groupBoardThenTravel        = {};

/*********************************/
/*
TODO:
1) Battle-init/End Loop-fix
2) Objective call available units.
	-objective data includes grps under way.

3) Task FSM.
	- Task Area.
	- Task type
	- Travel data
	- Travel needed?
	- Task pause for combat-while traveling.

4) Travel FSM.
	- POST-boarding: Fix it (end state)
	- Get vehicle (if needed) 
	- transport->get out.
	- transport pause for combat 

5) BUGS.
	- crash to desktop on massive friendly fire (eventHandler?)

6) Implement FSM functionality
   - There are 2 sets of states
     1) The overAll task the group is performing
	 2) The current action within the context of said task.

The task should be displayed by text.
The action should be displayed by the Icon.
The boarding status should be displayed by a second Icon
*/

// SQFM_fnc_decimals               = {};
// SQFM_fnc_shapeFitsShape         = {};
// SQFM_fnc_objectShape            = {};
// SQFM_fnc_transportVehicleData   = {};
// SQFM_Custom3Dpositions             = [];
// SQFM_fnc_transportSpawnPosClear    = {};
// SQFM_fnc_spawnerGetVehicleType     = {};
// SQFM_fnc_transportSpawnPos         = {};
// SQFM_fnc_drawTransportModuleNoInit = {};
// SQFM_fnc_drawTransportModule       = {};
// SQFM_fnc_onPickupWpTransporter  = {};
// SQFM_fnc_onDropOffWpTransporter = {};
// SQFM_fnc_onReturnWpTransporter  = {};
// SQFM_fnc_groupPickupPos         = {};
// SQFM_fnc_sendTransport          = {};
// SQFM_fnc_initTransportSpawner = {};
// SQFM_fnc_spawnTransport       = {};
// SQFM_fnc_initTaskData         = {};
// SQFM_fnc_endTask              = {};
// SQFM_fnc_addTaskWaypoint      = {};
// SQFM_fnc_getGroupsZone        = {};

/*
Post-Init transport-Group
	- Define as transport group
	- Set waypoints (pickup, drop off, return)
	- Task states are :
		"Picking up"    (Moving)
		"Boarding"      (Not Moving)
		"Dropping Off"  (Moving)
		"Unloading"     (Not Moving)
		"Returning"     (Moving)

- Subtract from VehiclePool
- Add waypoint to caller (sync with transport (Pickup & drop off))
- Message on fail (Cannot send now / no more vehicles left)
- reaction to combat = Stop->cargo eject->return to base. 
- If disabeled delete driver, delete vehicle on timeLimit

private _trnsprtOnWay = _grpData call ["callTransport", [destination]];

"callTransport" = {
	sort modules by distance.
	first module with capacity is selected 
	module is requested for transport.
	Radio message informing side of request result.
	if(true)then{
		_mdlData call ["sendTransport", [_group, _pickup, _dropOff]]
	};
}

"sendTransport" = {
	1) spawn vehicle
	2) spawn crew (Init group)
	3) Subtract from VehiclePool
	4) Add 3 waypoints. (Board / unboard logic added)
	5) SQFM_transports pushBackUnique transport;
	6) Set timeLimit
	7) Add data as variable to the vehicle
	8) Dissalow getout in combat.
};

{
	1) check if it is moving 
	2) check if it has cargo 
	3) check if timeLimit has expired
	4) if time > timeLimit & alive delete and re-add to pool
	5) if time > timeLimit & !alive delete
	6) Check if waypoint has failed (see unstuck)
	
} forEach SQFM_transports;


*/




// SQFM_fnc_onPickupWpPassenger = { 
// params[
// 	["_group", nil, [grpNull]]
// ];
// private _grpData = _group getVariable "SQFM_grpData";


// };



// [grp1] call SQFM_fnc_initGroup;
// private _spawner   = TS1 getVariable "SQFM_spawnerData";
// private _trGroup   = grp1;
// private _pickUpPos = [6296.67,3508.34,0];
// private _dropPos   = [5662.64,4219.16,0];

// _spawner set ["assetCount", 3];
// _spawner set ["sendTransport", SQFM_fnc_sendTransport];
// _spawner call ["sendTransport",  [_trGroup, _dropPos]];
// deleteVehicle cursorObject;

// {
// 	[_x] call SQFM_fnc_initTransportSpawner;
	
// } forEach (entities "SQFSM_TransportSpawner");

// [TS1] call SQFM_fnc_initTransportSpawner;
// copyToClipboard str allVariables TS1;

// hint str (_data get "lastSpawnTime");
// _data set  ["spawnTransport", SQFM_fnc_spawnTransport];
// _data call ["spawnTransport", [15]];
// ooo= str ([v3] call SQFM_fnc_transportVehicleData);
// group move position

/************************************************************/
// private _pos      = getPosATLVisual player;
// private _taskName = "reinforce";
// private _params   = [_pos, _taskName];

// [testGrp] call SQFM_fnc_initGroup;
// private _data = testGrp getVariable "SQFM_grpData";
// then{Hint "Yaaa"};
// _data call ["initTravel", _params];
/************************************************************/

/**************************************************************/

/*********************************/
systemChat "devfiled read";

[];