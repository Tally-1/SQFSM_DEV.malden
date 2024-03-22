scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner

SQFM_fnc_initBattleMap = { 
params[ 
    ["_pos",    nil, [[]]],
    ["_rad",    nil,  [0]]
];

private _entities      = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr    = [_entities] call SQFM_fnc_objArrData;
private _sides         = _objDataArr#3;
private _groups        = _objDataArr#4;
private _grid          = [_pos, _rad] call SQFM_fnc_getBattleGrid;
private _edgeLines     = [_pos, _rad] call SQFM_fnc_getCircleLines;

private _dataArr = [
/******************Data*************************/
    ["position",                _pos],
    ["radius",                  _rad],
    ["startTime",               time],
    ["sides",                 _sides],
    ["groups",               _groups],
    ["buildings",                 []],
    ["grid",                   _grid],
	["edgeLines",         _edgeLines],
    ["groupShots",                []],
    ["shotsFired",             false],
	["urbanZones",                []],

/***************Methods*************************/
    ["initGroups",    SQFM_fnc_initBattleGroups],
    ["postInit",      {_self spawn SQFM_fnc_postInitBattle}],
	["update",        SQFM_fnc_updateBattle],
    ["endGroups",     SQFM_fnc_endBattleGroups],
    ["endBattle",     SQFM_fnc_endBattle],
    ["drawBattle",    SQFM_fnc_drawBattle],
    ["onFirstShot",   SQFM_fnc_onBattleFirstShot],
	["timeSinceShot", SQFM_fnc_timeSinceLastBattleShot],
	["initBuildings", {_self spawn SQFM_fnc_initBattleBuildings}]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap call ["initBuildings"];

_battleMap;
};

SQFM_fnc_initGroupData = { 
params [
	["_group", nil, [grpNull]]
];

private _dataArr = [ 

	["birth",              time],
	["grp",              _group],
	["action",               ""],
	["state",                ""],
	["travelData",          nil],
	["available",          true],
	["battlefield",  [-1,-1,-1]],
	["battleTimes",          []],
	["shots",                []],
	["groupCluster",        nil],

//  {METHODS}

	["3DIcon",                             SQFM_fnc_group3DIcon],
	["3DColor",                           SQFM_fnc_group3DColor],
	
	/**********************{TRAVEL}*****************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["deleteWaypoints",                      SQFM_fnc_deleteWps],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
	["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
	["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],

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

_group setVariable ["SQFM_grpData", _data, true];
_data call ["setGroupCluster"];

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

SQFM_fnc_initTransportSpawner   = { 
params[
	["_module",nil,[objNull]]
];
private _vehicles     = [];
private _capacities   = [];
private _parkingSpots = [];
private _side         = call compile (_module getVariable "sqfm_side");
private _assetCount   = 

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

if(_vehicles isEqualTo [])exitWith{["Transport-spawner cannot init", "hint"]call dbgm;};

private _dataArr = [
	["vehicles",                               _vehicles],
	["lastSpawnTime",                            time-10],
	["side",                                       _side],
	["assetCount", _module getVariable "sqfm_assetcount"],
	["maxCapacity",                                  nil],
/***********************************************************/
	["timeSinceSpawn",{time-(_self get "lastSpawnTime")}],
	["spawnTransport",           SQFM_fnc_spawnTransport],
	["getVehicleType",    SQFM_fnc_spawnerGetVehicleType],
	["selectSpawnPos",        SQFM_fnc_transportSpawnPos]
];
private _maxCapacity = selectMax _capacities;
private _hashMap     = createHashmapObject [_dataArr];

_hashMap set         ["maxCapacity",  _maxCapacity];
_module  setVariable ["SQFM_spawnerData", _hashMap];

true;
};

SQFM_fnc_spawnTransport = { 
params[
	["_capacity",nil,[]]
];
private _vehicleData = _self call ["getVehicleType", [_capacity]];
if(isNil "_vehicleData")
exitWith{};

private _spawnPosData = _self call ["selectSpawnPos", [_vehicleData]];
if(isNil "_spawnPosData")
exitWith{};

private _vehicleType = _vehicleData  get "type";
private _spawnPos    = _spawnPosData get "pos";
private _spawnDir    = _spawnPosData get "dir";

private _vehicle = createVehicle [
	_vehicleType, 
	_spawnPos, 
	[], 
	0, 
	"CAN_COLLIDE"
];

_vehicle allowDamage false;
_vehicle setDir    _spawnDir;
_vehicle setPosATL _spawnPos;


_vehicle spawn{sleep 1; _this allowDamage true;};

_vehicle;
};
/*
Post-Init transport-Group
	- Define as transport group
	- Set waypoints (pickup, drop off, return)
	- Transport spawner module initial build.
Subtract from VehiclePool
Add waypoint to caller 

*/


// [TS1] call SQFM_fnc_initTransportSpawner;
// copyToClipboard str allVariables TS1;
// private _data = TS1 getVariable "SQFM_spawnerData";
// _data set  ["spawnTransport", SQFM_fnc_spawnTransport];
// _data call ["spawnTransport", [15]];
// ooo= str ([v3] call SQFM_fnc_transportVehicleData);
// 

/************************************************************/
// private _pos      = getPosATLVisual player;
// private _taskName = "reinforce";
// private _params   = [_pos, _taskName];

// [testGrp] call SQFM_fnc_initGroup;
// private _data = testGrp getVariable "SQFM_grpData";
// _data call ["initTravel", _params];
/************************************************************/

/**************************************************************/

/*********************************/
systemChat "devfiled read";

[];