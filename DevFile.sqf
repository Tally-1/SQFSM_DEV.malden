scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap               = {};
SQFM_fnc_initGroupData               = { 

params [
	["_group", nil, [grpNull]]
];
private _emptyMap = createHashmapObject[[]];
private _dataArr = [ 

	["birth",             round time],
	["lastTransportCall", round time],
	["grp",                   _group],
	["side",             side _group],
	["action",                    ""],
	["state",                     ""],
	["travelData",               nil],
	["available",               true],
	["battlefield",       [-1,-1,-1]],
	["battleTimes",               []],
	["shots",                     []],
	["groupCluster",             nil],
	["transportCrew",          false],
	["transportVehicle",     objNull],
	["taskData",           _emptyMap], 

//  {METHODS}

	["3DIcon",                             SQFM_fnc_group3DIcon],
	["3DColor",                           SQFM_fnc_group3DColor],
	["initTask",                          SQFM_fnc_initTaskData],
	
	/**********************{TRAVEL}*****************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["deleteWaypoints",                      SQFM_fnc_deleteWps],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
	["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
	["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
	["callTransport",                SQFM_fnc_validGroupVehicle],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],
	["getPickupPos",                    SQFM_fnc_groupPickupPos],

					  /*{transport}*/
	["canCallTransport",           SQFM_fnc_groupCanCallTransport],
	["callTransport",                 SQFM_fnc_groupCallTransport],
	["getTransportSpawner",     SQFM_fnc_groupGetTransportSpawner],
	["sinceTransportCall", {time-(_self get "lastTransportCall")}],

                      /*{boarding}*/
	["canSelfTransport",         SQFM_fnc_groupCanSelfTransport],
	["enoughTransportNear",   SQFM_fnc_enoughGroupTransportNear],
	["canBoardNow",                   SQFM_fnc_groupcanBoardNow],
	["boardingStatus",             SQFM_fnc_groupBoardingStatus],
	["getBoardingMen",             SQFM_fnc_getGroupBoardingMen],
	["boardVehicles",               SQFM_fnc_groupBoardVehicles],
	["boardOwnVehicles",         SQFM_fnc_groupBoardOwnVehicles],
	["boardAllAvailable",       SQFM_fnc_groupBoardAllAvailable],
	["postBoarding",                 SQFM_fnc_postGroupBoarding],
	["boardingStarted",           SQFM_fnc_groupBoardingStarted],
	["boardingEnded",               SQFM_fnc_groupBoardingEnded],
	["boardingFailed",             SQFM_fnc_groupBoardingFailed],
	["endBoarding",                   SQFM_fnc_endGroupBoarding],
	["boardThenTravel",           SQFM_fnc_groupBoardThenTravel],
	["ejectAll",             SQFM_fnc_groupEjectFromAllVehicles],
	
	/********************{GROUP MEMBERS}************************/
	["getUnits",                         SQFM_fnc_getGroupUnits],
	["getUnitsOnfoot",             SQFM_fnc_getGroupUnitsOnFoot],
	["getVehiclesInUse",    {(_self call ["getOwnVehicles"])#2}],
	["getGrpMembers",                    SQFM_fnc_getGrpMembers],
	["getGroupCluster",                SQFM_fnc_getGroupCluster],
	["setGroupCluster",                SQFM_fnc_setGroupCluster],
	["getAvgPos",                          SQFM_fnc_groupAvgPos],

	/**********************{COMBAT}****************************/
	["battleInit",                     SQFM_fnc_groupBattleInit],
	["battleEnd",                       SQFM_fnc_groupBattleEnd],
	["addShot",                          SQFM_fnc_addGroupShots],
	["getBattle",  {SQFM_battles get (_self get "battlefield")}],
	["inBattle",                         SQFM_fnc_groupInBattle],
	["canInitBattle",               SQFM_fnc_groupCanInitBattle],
	["sinceBattle",           SQFM_fnc_timeSinceLastGroupBattle],
	["isNotSuppressing",           SQFM_fnc_grpIsNotSuppressing],
	["returnFire",                     SQFM_fnc_groupReturnFire],
	["endReturnFire",   {_self spawn SQFM_fnc_endGrpReturnFire}]
];

private _data = createHashmapObject [_dataArr];

_data call ["setGroupCluster"];
private _veh1 = (_data call ["getVehiclesInUse"])#0;
if((!isNil "_veh1")
&&{_veh1 getVariable ["SQFM_transport", false]})
then{
	_data set ["transportCrew",    true];
	_data set ["transportVehicle", _veh1];
};

_group setVariable ["SQFM_grpData", _data, true];

_data;
};
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
// SQFM_fnc_decimals                    = {};
// SQFM_fnc_shapeFitsShape              = {};
// SQFM_fnc_objectShape                 = {};
// SQFM_fnc_transportVehicleData        = {};
// SQFM_Custom3Dpositions               = [];
// SQFM_fnc_transportSpawnPosClear      = {};
// SQFM_fnc_spawnerGetVehicleType       = {};
// SQFM_fnc_transportSpawnPos           = {};
// SQFM_fnc_drawTransportModuleNoInit   = {};
// SQFM_fnc_drawTransportModule         = {};
// SQFM_fnc_onPickupWpTransporter       = {};
// SQFM_fnc_onDropOffWpTransporter      = {};
// SQFM_fnc_onReturnWpTransporter       = {};
// SQFM_fnc_groupPickupPos              = {};
// SQFM_fnc_sendTransport               = {};
// SQFM_fnc_initTransportSpawner        = {};
// SQFM_fnc_spawnTransport              = {};
// SQFM_fnc_initTaskData                = {};
// SQFM_fnc_endTask                     = {};
// SQFM_fnc_addTaskWaypoint             = {};
// SQFM_fnc_getGroupsZone               = {};
// SQFM_fnc_groupGetTransportSpawner    = {};
// SQFM_fnc_groupCanCallTransport       = {};
// SQFM_fnc_groupCallTransport          = {};

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
*/


// [grp1] call SQFM_fnc_initGroup;
private _dropPos = [6296.67,3508.34,0];
private _data    = grp1 getVariable "SQFM_grpData";
_data call ["callTransport", [_dropPos]];

/*********************************/
systemChat "devfiled read";

[];