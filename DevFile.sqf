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

	/******************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getUnits",                                      _getUnits],
	["getGrpMembers",                            _getGrpMembers],
	["getVehicles",                   SQFM_fnc_getGroupVehicles],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],
	["canSelfTransport",                      _canSelfTransport],
	["boardingStatus",                       _getBoardingStatus],
	["getGroupCluster",                SQFM_fnc_getGroupCluster],
	["setGroupCluster",                        _setGroupCluster],
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
// SQFM_fnc_hashifyClusterData = {};


SQFM_fnc_crewSize = { 
params[
  ["_vehicle", nil, [objNull]]
];
private _crewCount = count fullCrew [_vehicle, "", true];

_crewCount;
};

SQFM_fnc_vehiclesCanTransportMen = { 
params[ 
	["_men",      nil, [[]]],
	["_vehicles", nil, [[]]]
];
private _menInVehicles     = _men select {vehicle _x in _vehicles};
private _crewSizeNeeded    = count _men - count _menInVehicles;
private _crewSizeAvailable = 0;
{
	private _capacity  = [_x] call SQFM_fnc_crewSize;
	private _crewCount = count crew _x;
	_capacity = _capacity-_crewCount;
	_crewSizeAvailable = _crewSizeAvailable+_capacity;
	
} forEach _vehicles;

if(_crewSizeNeeded <= _crewSizeAvailable)exitWith{true;};

false;
};

SQFM_fnc_isLandVehicle = { 
params[
	["_vehicle",nil,[objNull]]
];
if!(_vehicle isKindOf "land") exitWith{false;};
// if!(canMove _vehicle)         exitWith{false;};
if (_vehicle isKindOf "man")  exitWith{false;};

true;
};

SQFM_fnc_validGroupVehicle = { 
params[
	["_vehicle", nil, [objNull]]
];
private _grpPos   = _self get"groupCluster"get"position";

if(!alive _vehicle)
exitWith{false;};

if(!canMove _vehicle)
exitWith{false;};

if(fuel _vehicle < 0.05)
exitWith{false;};

if!([_vehicle] call SQFM_fnc_isLandVehicle)
exitWith{false;};

private _men           = _self call ["getUnits"];
private _menInVehicles = _men select {vehicle _x isEqualTo _vehicle};
private _crewed        = count _menInVehicles > 0;

if(_vehicle distance2D _grpPos > 200
&&{_crewed isEqualTo false})
exitWith{false;};

true;
};

SQFM_fnc_leaveInvalidVehicles = { 
private _group = _self get "grp";

{
	if!(_self call ["validVehicle", [_x]])
	then{_group leaveVehicle _x;};
	
} forEach assignedVehicles _group;

true;
};

SQFM_fnc_getGroupVehicles = { 
_self call ["leaveInvalidVehicles"];
private _group    = _self get "grp";
private _grpPos   = _self get"groupCluster"get"position";
private _inUse    = _self call ["getGrpMembers"] select {[_x] call SQFM_fnc_isLandVehicle};
private _assigned = assignedVehicles _group select {alive _x;};
private _all      = [];

_all insert [0, _inUse,    true];
_all insert [0, _assigned, true];

[_all, _assigned, _inUse];
};

SQFM_fnc_validAvailableVehicle = { 
if!([_vehicle] call SQFM_fnc_isLandVehicle)
exitWith{false;};

if(!alive _vehicle)
exitWith{false;};

if(!canMove _vehicle)
exitWith{false;};

if(fuel _vehicle < 0.05)
exitWith{false;};

if(crew _vehicle isNotEqualTo [])
exitWith{false;};

true;
};

SQFM_fnc_getNearAvailVehicles = { 
params[
	["_pos", nil, [[]]],
	["_rad", 200,  [0]]
];
private _vehicles = nearestObjects [_pos, ["Car", "Tank"], _rad] select {[_x] call SQFM_fnc_validAvailableVehicle;};
_vehicles;
};

SQFM_fnc_clearPos = { 
params[
	"_pos", 
	["_excludeRoads",    false],
	["_safeDistX",           8],
	["_safeDistZ",          20]
];
if(isNil "_pos")exitWith{false;};
private _xx = _pos#0;

if(isNil "_xx")exitWith{
	(str _this) call dbgm;
	false;
};

// FRLI_fnc_distToNearWp
private _groundPos = ATLToASL [_pos#0, _pos#1, 0.1];
private _topPos    = ATLToASL [_pos#0, _pos#1, _safeDistZ];

private _blocked = [objNull, "VIEW"] checkVisibility [_groundPos, _topPos] < 1;
if(_blocked)exitWith{false;};

private _nearObj = nearestTerrainObjects [_pos, ["BUILDING", "HOUSE", "ROCK", "ROCKS", "TREE", "ROAD"], _safeDistX]; 
if(count _nearObj > 0)exitWith{false;};

_nearObj = _pos nearObjects ["land", _safeDistX];
if(count _nearObj > 0)exitWith{false;};


private _nearRoads = _pos nearRoads _safeDistX;
if((count _nearRoads > 0) isEqualTo true
&&{_excludeRoads          isEqualTo true})
exitWith{false;};


true;
};

SQFM_fnc_clearPosSqrArea = { 
params[
	["_center",   nil,     [[]]],
	["_size",     nil,      [0]]
];

if(_size < 30)then{_size = 30;};
private _posRad    = 10;
private _posCount  = round (_size / _posRad);

if(_posCount < 30)then{_posCount = 30;};

private _positions  = [_center, _size, _posCount, 0, false] call SQFM_fnc_squareGrid;
private _posDist    = _positions#0 distance2D (_positions#1);

while {_posDist > 5} do {
		_posCount  = _posCount+50;
		systemChat str _posDist;
		_positions = [_center, _size, _posCount] call SQFM_fnc_squareGrid;
		_posDist   = _positions#0 distance2D (_positions#1);
		systemChat str _posDist;
};


private _posFilter = {
	_x isNotEqualTo [0,0,0] 
	&& {_x isNotEqualTo [0,0]
	&& {[_x, true, 5] call SQFM_fnc_clearPos
	}}
};

// _positions = _clearPoss select _posFilter;
_positions = _positions select _posFilter;

_positions;
};


SQFM_fnc_clearPosInArea = { 
params[
  ["_area",           nil,    [[]]],
  ["_minPosCount",    1,       [0]],
  ["_allowExpansion", true, [true]]
];
private _areaSize = selectMax[_area#1, _area#2];
private _center   = _area#0;
private _posgrid  = [_center, _areaSize] call SQFM_fnc_clearPosSqrArea;
private _posCount = count _posgrid;
private _attempts = 0;



while{_posCount<_minPosCount
&&   {_attempts < 10}}do{
    _areaSize = _areaSize+50;
    _attempts = _attempts+1;
    
    _posgrid  = [_center, _areaSize] call SQFM_fnc_clearPosSqrArea;
    _posCount = count _posgrid;
};

_posgrid = [_posgrid, [], {_center distance _x}, "ASCEND"] call BIS_fnc_sortBy;

_posgrid;
};

SQFM_fnc_findParkingSpot = { 
params["_pos"];
private _parkingArea  = [_pos, 30, 30];
private _parkingSpot  = _pos;
private _parkingSpots = [_parkingArea, 4] call SQFM_fnc_clearPosInArea;
private _spotCount    = count _parkingSpots;

if(_spotCount > 0)then{
  _parkingSpot = _parkingSpots#(_spotCount-1);
};

_parkingSpot;
};

// private _parking = [getPos player] call SQFM_fnc_findParkingSpot;
// ;
// SQFM_Custom3Dpositions = [[_parking, "Parking"]];

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

SQFM_fnc_onTravelWpComplete = { 
_self call ["deleteWaypoints"];

_self deleteAt "travelData";
_self set ["action", ""];
_self set ["state",  ""];

hint str "Waypond ndded";
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

private _vehicles       = (_self call ["getVehicles"]);
private _hasCapacity    = _self call ["canSelfTransport"];
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

[364];