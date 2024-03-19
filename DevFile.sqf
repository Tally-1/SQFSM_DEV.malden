scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles

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

private _getGrpMembers = {
	private _grpVehMen = []; // all men and vehicles in the group
	{_grpVehMen pushBackUnique vehicle _x;} forEach units (_self get "grp");
	_grpVehMen;
};
private _getUnits         = {units (_self get "grp") select {alive _x}};
private _getUnitsOnfoot   = {_self call ["getUnits"] select {vehicle _x isEqualTo _x}};
private _setGroupCluster  = {_self set ["groupCluster", (_self call ["getGroupCluster"])]};
private _canSelfTransport = {
	private _men      = _self call["getUnits"];
	private _vehicles = (_self call["getVehicles"])#0;
	private _canTransport = [_men, _vehicles] call SQFM_fnc_vehiclesCanTransportMen;
	_canTransport;
};
private _getBoardingStatus = { 
	private _members  = _self call ["getGrpMembers"];
	private _vehicles = _members select {[_x] call SQFM_fnc_isLandVehicle};
	private _men      = _members select {!(_x in _vehicles)};
	
	if(count _vehicles isEqualTo 0 &&{count _men > 0})
	exitWith{"on foot"};

	if(count _men isEqualTo 0 &&{count _vehicles > 0})
	exitWith{"boarded"};

	if(count _men > 0 &&{count _vehicles > 0})
	exitWith{"partially boarded"};

	"unknown";
};

private _deleteWps = {
	private _group = _self get"grp";
	private _count = count waypoints _group - 1;
	for"_i"from 0 to _count do{deleteWaypoint [_group, 0]};
};

private _dataArr = [ 

	["birth",              time],
	["grp",              _group],
	["action",               ""],
	["state",                ""],
	// ["taskData",  createHashmap],
	["travelData",          nil],
	["available",          true],
	["battlefield",  [-1,-1,-1]],
	["battleTimes",          []],
	["shots",                []],
	["groupCluster",        nil],

//  {METHODS}

	/**********************{TRAVEL}*****************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getVehicles",                   SQFM_fnc_getGroupVehicles],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],
	["canSelfTransport",                      _canSelfTransport],
	["boardingStatus",                       _getBoardingStatus],
	["boardOwnVehicles",         SQFM_fnc_groupBoardOwnVehicles],

	/********************{GROUP MEMBERS}************************/
	["getUnits",                                      _getUnits],
	["getUnitsOnfoot",                          _getUnitsOnfoot],
	["getGrpMembers",                            _getGrpMembers],
	["getGroupCluster",                SQFM_fnc_getGroupCluster],
	["setGroupCluster",                        _setGroupCluster],

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
	// ["enemies",              []],

SQFM_fnc_groupBattleInit = { 
params [
	["_battlePos",nil,[[]]] // center of battle, used as key in the SQFM_battles hashmap.
];

_self set ["battlefield",  _battlePos];
_self set ["state",       "In battle"];
_self set ["action",      "In battle"];
_self set ["available",         false];

(_self get "battleTimes")pushBackUnique round time;
};

SQFM_fnc_groupBattleEnd = { 
private _action = "";

if(!([_x] call SQFM_fnc_validGroup))
then{_action = "eliminated"};

_self set ["battlefield", [-1,-1,-1]];
_self set ["state",               ""];
_self set ["action",          _action];
_self set ["available",         true];

(_self get "battleTimes")pushBackUnique round time;
};

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
	- Get vehicle (if needed)
	- transport->get out.
	- transport pause for combat 
*/
// SQFM_fnc_hashifyClusterData      = {};
// SQFM_fnc_crewSize                = {};
// SQFM_fnc_vehiclesCanTransportMen = {};
// SQFM_fnc_isLandVehicle           = {};
// SQFM_fnc_validAvailableVehicle   = {};
// SQFM_fnc_getNearAvailVehicles    = {};
// SQFM_fnc_clearPos                = {};
// SQFM_fnc_clearPosSqrArea         = {};
// SQFM_fnc_clearPosInArea          = {};
// SQFM_fnc_findParkingSpot         = {};
// SQFM_fnc_validGroupVehicle       = {};
// SQFM_fnc_leaveInvalidVehicles    = {};
// SQFM_fnc_getGroupVehicles        = {};



// private _parking = [getPos player] call SQFM_fnc_findParkingSpot;
// SQFM_Custom3Dpositions = [[_parking, "Parking"]];

SQFM_fnc_onTravelWpComplete = { 
_self call ["deleteWaypoints"];

_self deleteAt "travelData";
_self set ["action", ""];
_self set ["state",  ""];

hint str "Waypond ndded";
};

SQFM_fnc_execGroupTravel = { 
params[
	["_movePos",  nil,    [[]]],
	["_taskName", "move", [""]]
];
_self call ["deleteWaypoints"];
private _parkingSpot = [_movePos] call SQFM_fnc_findParkingSpot;
private _targetPos   = _parkingSpot;
private _onCompleted = '(group this getVariable "SQFM_grpData") call ["onTravelWpComplete"]';
if(_movePos distance2D _parkingSpot > 100)
then{_targetPos = _movePos;};

private _wp = (_self get "grp") addWaypoint [_targetPos, 0];
private _dataArr = [
	["startTime", round time],
	["waypoint",         _wp],
	["taskName",   _taskName]
];

private _travelData = createHashmapObject [_dataArr];
_self set ["travelData", _travelData];
_self set ["action",     "traveling"];
_self set ["state",      "traveling"];


_wp setWaypointStatements ["true", _onCompleted];
};

SQFM_fnc_vehicleEjectDeadAndUncon = { 
params[
	["_vehicle", nil, [objNull]]
];
{
	private _eject = (!alive _x) or {[_x] call SQFM_fnc_unconscious};
	if(_eject)then{
		_x action ["Eject", _vehicle];
		_x leaveVehicle _vehicle;
	};
	
} forEach crew _vehicle;

true;
};

// moveInDriver
// moveInCommander
// moveInGunner
// moveInTurret
// moveInCargo

// "driver"
// "commander"
// "gunner"
// "turret"
// "cargo"
// [
// 	unit, 
// 	role, 
// 	cargoIndex, 
// 	turretPath, 
// 	personTurret, 
// 	assignedUnit, 
// 	positionName
// ]
// fullCrew [_vehicle, "driver",    true];


SQFM_fnc_seatStatus = { 
params[
	["_seatData", nil, [[]]]
];

if(_seatData isEqualTo [])exitWith{"occupied";};

private _crewMan     = _seatData#0;
private _assignedMan = _seatData#5;

if(alive _crewMan)     exitWith{"occupied";};
if(alive _assignedMan) exitWith{"assigned"};

"available";
};


SQFM_fnc_clearSeat = { 
private _man     = _self get "man";
private _vehicle = _self get "vehicle";
if(isNull _man)
exitWith{"no man"};

if(vehicle _man != _vehicle)
exitWith{_man leaveVehicle _vehicle; "unassigned"};

_man action ["Eject", _vehicle];
unassignVehicle _man; 
"ejected";
};


SQFM_fnc_hashifySeatData = { 
params[
	["_seatData", nil,      [[]]],
	["_vehicle",  nil, [objNull]]
];
private _crewMan     = _seatData#0;
private _assignedMan = _seatData#5;
private _cargoIndex  = _seatData#2;
private _turretPath  = _seatData#3;
private _seatStatus  = [_seatData] call SQFM_fnc_seatStatus;

if(!alive _crewMan
&&{alive _assignedMan})
then{_crewMan = _assignedMan};

private _dataArr     = [
	["vehicle",                  _vehicle],
	["man",                      _crewMan],
	["seat",   [_cargoIndex, _turretPath]],
	["status",                _seatStatus],

	/************************************/
	["clearSeat",      SQFM_fnc_clearSeat]
];

private _hashMap = createHashmapObject [_dataArr];

_hashMap;
};


SQFM_fnc_cargoSeatData = { 
params[
	["_vehicle", nil, [objNull]],
	["_role",    nil,      [""]]
];

if!(_role in ["turret", "cargo"])
exitWith{
	"Wrong enum for seats query" call dbgm;
	'Use: ["turret", "cargo"]'   call dbgm;
	nil;
};
private _dataArr = fullCrew [_vehicle, _role, true];
if(_dataArr isEqualTo [])exitWith{[]};

private _seats = [];
{
	private _hashMap = [_x, _vehicle] call SQFM_fnc_hashifySeatData;
	_seats pushBackUnique _hashMap;

} forEach _dataArr;

_seats;
}; 

// SQFM_fnc_availableTurrets = { 
// private _turrets = ;
// if(_turrets isEqualTo [])exitWith{[]};
// private _available = _self 

// _available;
// };


SQFM_fnc_crewData = { 
params[
	["_vehicle", nil, [objNull]]
];
private _turrets    = [_vehicle, "turret"] call SQFM_fnc_cargoSeatData;
private _cargoSeats = [_vehicle, "cargo"]  call SQFM_fnc_cargoSeatData;
private _driverSeat =  (fullCrew [_vehicle, "driver", true])#0;
private _gunnerSeat =  (fullCrew [_vehicle, "gunner", true])#0;
private _cmmndrSeat =  (fullCrew [_vehicle, "commander", true])#0;

if(isNil "_driverSeat")then{_driverSeat = []};
if(isNil "_gunnerSeat")then{_gunnerSeat = []};
if(isNil "_cmmndrSeat")then{_cmmndrSeat = []};

if(_driverSeat isNotEqualTo [])then{_driverSeat = [_driverSeat, _vehicle] call SQFM_fnc_hashifySeatData};
if(_gunnerSeat isNotEqualTo [])then{_gunnerSeat = [_gunnerSeat, _vehicle] call SQFM_fnc_hashifySeatData};
if(_cmmndrSeat isNotEqualTo [])then{_cmmndrSeat = [_cmmndrSeat, _vehicle] call SQFM_fnc_hashifySeatData};

private _dataArr = [
	["driver",      _driverSeat],
	["gunner",      _gunnerSeat],
	["commander",   _cmmndrSeat],
	["turrets",     _turrets],
	["passengers",  _cargoSeats]/*,

	["availableTurrets",  SQFM_fnc_availableTurrets]*/
];

private _hashMap = createHashmapObject [_dataArr];

_hashMap;
};

// private _hashmap = [cursorObject] call SQFM_fnc_crewData;
// [_hashmap] call SQFM_fnc_copyHashmap;

// SQFM_fnc_availableCrewSpace = {
// SQFM_fnc_manGetInVehicle
// };

SQFM_fnc_manGetInVehicle = { 
params[
	["_man",      nil, [objNull]],
	["_vehicle",  nil, [objNull]]
];

if(_man distance _vehicle < 10)exitWith{_man moveInAny _vehicle;};
private _crewData     = [_vehicle] call SQFM_fnc_crewData;
private _driverStatus = _crewData get"driver"get"status";
private _gunnerStatus = _crewData get"gunner"get"status";
private _cmmndrStatus = _crewData get"commander"get"status";
private _turret       = (_crewData get "turrets" select {_x get "status" isEqualTo "available"})#0;
private _seat         = (_crewData get "passengers" select {_x get "status" isEqualTo "available"})#0;

if((!isNil "_driverStatus")
&&{_driverStatus isEqualTo "available"})exitWith{
	_man assignAsDriver _vehicle;
	[_man] allowGetIn true;
	[_man] orderGetIn true;
	true;
};

if((!isNil "_gunnerStatus")
&&{_gunnerStatus isEqualTo "available"})exitWith{
	_man assignAsGunner _vehicle;
	[_man] allowGetIn true;
	[_man] orderGetIn true;
	true;
};

if((!isNil "_cmmndrStatus")
&&{_cmmndrStatus isEqualTo "available"})exitWith{
	_man assignAsCommander _vehicle;
	[_man] allowGetIn true;
	[_man] orderGetIn true;
	true;
};

if(!isNil "_turret")exitWith{ 
	private _turretPath = (_turret get"seat")#1;
	_man assignAsTurret [_vehicle, [_turretPath]];
	[_man] allowGetIn true;
	[_man] orderGetIn true;
	true;
};

if(!isNil "_seat")exitWith{ 
	_man assignAsCargo _vehicle;
	[_man] allowGetIn true;
	[_man] orderGetIn true;
	true;
};

false;
};

SQFM_fnc_menGetInSingleVehicle = { 
params[
	["_men",     nil,      [[]]],
	["_vehicle", nil, [objNull]]
];
[_vehicle] call SQFM_fnc_vehicleEjectDeadAndUncon;
private _crewMen = [];
{
	private _boarded = [_x, _vehicle] call SQFM_fnc_manGetInVehicle;
	if(_boarded)then{_crewMen pushBackUnique _x;};
	
} forEach _men;

_crewMen;
};

private _men = units testGrp select {vehicle _x == _x};
[_men, cursorObject] call SQFM_fnc_menGetInSingleVehicle;

SQFM_fnc_menOrderGetInVehicles = { 
params[
	["_men",      nil, [[]]],
	["_vehicles", nil, [[]]]
];
private _assignedMen = [];

{
	private _availableMen = _men select {!(_x in _assignedMen)};
	private _menOrderedIn = [_availableMen, _x] call SQFM_fnc_menGetInSingleVehicle;
	_assignedMen insert [0, _menOrderedIn, true];

} forEach _vehicles;


};


SQFM_fnc_groupBoardOwnVehicles = { 
private _vehicles    = _self call ["getVehicles"];
private _menOnFoot   = _self call ["getUnitsOnfoot"];
private _grpVehInUse = _vehicles#2;
private _allVehicles = _vehicles#0;
private _hasCapacity = [_menOnFoot, _grpVehInUse] call SQFM_fnc_vehiclesCanTransportMen;
if(_hasCapacity)exitWith{
	[_menOnFoot, _grpVehInUse] call SQFM_fnc_menOrderGetInVehicles;
};

[_menOnFoot, _allVehicles] call SQFM_fnc_menOrderGetInVehicles;

true;
};



SQFM_fnc_initGroupTravel = { 
params[
	["_movePos",  nil,    [[]]],
	["_taskName", "move", [""]]
];
_self call ["setGroupCluster"];
private _grpPos         = _self get"groupCluster"get"position";
private _distance       = _movePos distance2D _grpPos;
private _boardingStatus = _self call ["boardingStatus"];
private _noTransport    = _distance < 500 || {_boardingStatus isEqualTo "boarded"};
private _params         = [_movePos, _taskName];

if(_noTransport)exitWith{_self call ["execTravel", _params]};

private _vehicles    = (_self call ["getVehicles"]);
private _hasCapacity = _self call ["canSelfTransport"];
// private _nearVehicles   = [_grpPos] call SQFM_fnc_getNearAvailVehicles;

};

// [testGrp] call SQFM_fnc_initGroup;
// private _data = testGrp getVariable "SQFM_grpData";
// _data call ["execTravel", [getpos player, "---"]];
// hint str (_data call ["canSelfTransport"]);
// private _vehicles    = _data call ["getVehicles"];
// hint str _vehicles;
// private _types       = _vehicles apply {_x apply {typeOf _x}};
// private _members     = _data call ["getGrpMembers"];
// private _memberTypes = _members apply {typeOf _x};
// systemChat str (_types#0);
// systemChat str _memberTypes;
// hint str _vehicles;

// ["battleInit", SQFM_fnc_groupBattleInit] call addToGroups;

/**************************************************************/

/*********************************/
systemChat "devfiled read";

[];