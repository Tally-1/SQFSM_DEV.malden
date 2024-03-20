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

	/**********************{TRAVEL}*****************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["deleteWaypoints",                      SQFM_fnc_deleteWps],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
	["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
	["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
	["enoughTransportNear",   SQFM_fnc_enoughGroupTransportNear],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],
	["canSelfTransport",         SQFM_fnc_groupCanSelfTransport],
	["boardingStatus",             SQFM_fnc_groupBoardingStatus],
	["boardVehicles",               SQFM_fnc_groupBoardVehicles],
	["boardOwnVehicles",         SQFM_fnc_groupBoardOwnVehicles],
	["boardAllAvailable",       SQFM_fnc_groupBoardAllAvailable],
	["postBoarding",   {_self spawn SQFM_fnc_postGroupBoarding}],
	
	

	/********************{GROUP MEMBERS}************************/
	["getUnits",                         SQFM_fnc_getGroupUnits],
	["getUnitsOnfoot",             SQFM_fnc_getGroupUnitsOnFoot],
	["getVehiclesInUse",    {(_self call ["getOwnVehicles"])#2}],
	["getGrpMembers",                    SQFM_fnc_getGrpMembers],
	["getGroupCluster",                SQFM_fnc_getGroupCluster],
	["setGroupCluster",                SQFM_fnc_setGroupCluster],

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

5) BUGS.
	- crash to desktop on massive friendly fire (eventHandler?)
*/


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


};



SQFM_fnc_groupBoardVehicles = { 
if(_self call  ["canSelfTransport"])exitWith{ 
	_self set  ["state", "boarding"];
	_self call ["boardOwnVehicles"];
	_self call ["postBoarding"];
	true;
};

if(_self call  ["enoughTransportNear"])exitWith{ 
	_self set  ["state", "boarding"];
	_self call ["boardAllAvailable"];
	_self call ["postBoarding"];
	true;
};

false;
};

SQFM_fnc_postGroupBoarding = { 
private _self = _this;

};


// \A3\ui_f\data\map\markers\military\end_CA.paa
// SQFM_fnc_sortTravelVehicleList
[testGrp] call SQFM_fnc_initGroup;
private _data = testGrp getVariable "SQFM_grpData";

_data call ["boardVehicles"];

// _data call ["execTravel", [getpos player, "---"]];

// ["battleInit", SQFM_fnc_groupBattleInit] call addToGroups;

/**************************************************************/

/*********************************/
systemChat "devfiled read";

[];