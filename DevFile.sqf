scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap = {};
SQFM_fnc_initGroupData = { 

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
	["groupType",          "unknown"],
    ["travelData",               nil],
    ["available",               true],
    ["battlefield",       [-1,-1,-1]],
    ["battleTimes",               []],
    ["shots",                     []],
    ["groupCluster",             nil],
    ["transportCrew",          false],
    ["transportVehicle",     objNull],
    ["objective",            objNull],
    ["taskData",           _emptyMap], 

//  {METHODS}

    ["3DIcon",                             SQFM_fnc_group3DIcon],
    ["3DColor",                           SQFM_fnc_group3DColor],
    
    /**********************{TRAVEL}*****************************/
    ["initTravel",                     SQFM_fnc_initGroupTravel],
    ["execTravel",                     SQFM_fnc_execGroupTravel],
    ["onArrival",                            SQFM_fnc_onArrival],
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
    ["isBoarded",  {_self call ["boardingStatus"] == "boarded"}],
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

	/********************{OBJECTIVES}***************************/
	["validObjective",            SQFM_fnc_group_validObjective],
    ["objectiveInRange",         SQFM_fnc_groupObjectiveInRange],
    ["getNearObjectives",       SQFM_fnc_groupGetNearObjectives],
    ["assignObjective",           SQFM_fnc_groupAssignObjective],
    ["takeObjective",               SQFM_fnc_groupTakeObjective],
    ["onObjectiveArrival",     SQFM_fnc_groupOnObjectiveArrival],

    /************************{TASKS}****************************/
    ["initTask",                          SQFM_fnc_initTaskData],
    ["initObjectiveTask",       SQFM_fnc_groupInitObjectiveTask],

    /************************{MOVES}****************************/
    ["garrison",                         SQFM_fnc_groupGarrison],

    /********************{GROUP MEMBERS}************************/
    ["getUnits",                         SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",             SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",    {(_self call ["getOwnVehicles"])#2}],
    ["getGrpMembers",                    SQFM_fnc_getGrpMembers],
	["crewMen",                              SQFM_fnc_groupCrew],
	["nonCrewMen",                        SQFM_fnc_groupNonCrew],
    ["tallyAssets",                   SQFM_fnc_groupTallyAssets],
    ["getGroupCluster",                SQFM_fnc_getGroupCluster],
    ["setGroupCluster",                SQFM_fnc_setGroupCluster],
    ["getAvgPos",                          SQFM_fnc_groupAvgPos],
    ["getStrSide",                     SQFM_fnc_groupGetStrSide],

	/**********************{GROUP CLASS}************************/
	["isUnarmedMotorized",     SQFM_fnc_groupIsUnarmedMotorized],
	["isInfantrySquad",           SQFM_fnc_groupIsInfantrySquad],
	["getGroupType",                         SQFM_fnc_groupType],
	["setGroupType",{_self set["groupType",_self call["getGroupType"]]}],

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
_data call ["setGroupType"];

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

// {drawLine3D _x}forEach(_self get "edgeLines");

SQFM_fnc_setObjectiveData = { 
params[
    ["_module", nil, [objNull]]
];
private _position    = getPosATLVisual _module;
private _data3d      = [_module] call SQFM_fnc_module3dData;
private _area        = _data3d get "area";
private _radius      = selectMax [100, _area#1, _area#2];
private _zone        = [_position, _radius];
private _zoneLines   = [_position, _radius, 16, [0,1,0,1]] call SQFM_fnc_getCircleLines;
private _type        = _module getVariable "objectiveType";
private _description = [_type] call SQFM_fnc_objectiveDescription;
private _assetType   = _module getVariable "assetType";
private _assetcount  = _module getVariable "assetCount";
private _distance    = _module getVariable "activationDistance";
private _owner       = sideUnknown;
private _sides       = [];

if(_module getVariable "allowEast")        then {_sides pushBack east;};
if(_module getVariable "allowWest")        then {_sides pushBack west;};
if(_module getVariable "allowIndependent") then {_sides pushBack independent;};

(_data3d get "lines")insert [0, _zoneLines, true];

private _assignedGroups = createHashmapObject [[
    ["east",        []],
    ["west",        []],
    ["independent", []]
]];

private _dataArr = [
    ["module",                                      _module],
    ["position",                                  _position],
	["area",                                          _area],
	["zone",                                          _zone],
    ["range",                                     _distance],
    ["type",                                          _type],
    ["description",                            _description],
    ["asset",                                    _assetType],
    ["count",                                   _assetcount],
    ["owner",                                   sideUnknown],
    ["allowedSides",                                 _sides],
    ["groupsPresent",                                    []],
	["assignedGroups",                      _assignedGroups],
    ["contested",                                     false],
    ["3dData",                                      _data3d],
    ["3dColor",                                   [1,1,1,1]],
    ["3dIcon",    "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
	
	/**********************{METHODS}***********************/
	["getGroupsInZone",{(_self get"zone") call SQFM_fnc_groupsInZone}],
    ["getAssignedAssets",         SQFM_fnc_objectiveGetAssignedAssets],
    ["troopsNeeded",                    SQFM_fnc_objectiveNeedsTroops],
    ["assignGroup",                     SQFM_fnc_objectiveAssignGroup],
    ["unAssignGroup",                 SQFM_fnc_objectiveUnAssignGroup],
	["draw3D",                           SQFM_fnc_drawObjectiveModule]

];

private _data = createhashMapObject [_dataArr];

_module setVariable ["SQFM_objectiveData", _data];

_data;
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

// SQFM_fnc_initGroupTravel            = {};
// SQFM_fnc_groupCrew                  = {};
// SQFM_fnc_groupNonCrew               = {};
// SQFM_fnc_vehicleDescription         = {};
// SQFM_fnc_vehicleClass               = {};
// SQFM_fnc_groupIsUnarmedMotorized    = {};
// SQFM_fnc_groupIsInfantrySquad       = {};
// SQFM_fnc_groupType                  = {};
// SQFM_fnc_assetTypesMatch            = {};
// SQFM_fnc_                           = {};
// SQFM_fnc_isArmedCar                 = {};
// SQFM_fnc_isLightArmor               = {};
// SQFM_fnc_isHeavyArmor               = {};
// SQFM_fnc_sideToStrSide              = {};
// SQFM_fnc_groupGetStrSide            = {};
// SQFM_fnc_removeNull                 = {};
// SQFM_fnc_objectiveAssignGroup       = {};
// SQFM_fnc_objectiveUnAssignGroup     = {};
// SQFM_fnc_groupTallyAssets           = {};
// SQFM_fnc_objectiveGetAssignedAssets = {};
// SQFM_fnc_objectiveNeedsTroops       = {};


// SQFM_fnc_group_validObjective = { 
// params[
// 	["_objectiveModule",nil,[objNull]]
// ];
// private _objctvData  = _objectiveModule getVariable "SQFM_objectiveData";
// private _assetWanted = _objctvData get "asset";
// private _groupType   = _self       get "groupType";
// private _matches     = [_assetWanted, _groupType] call SQFM_fnc_assetTypesMatch;

// if!(_matches)exitWith{false;};

// true;
// };



// SQFM_fnc_takeObjective = { 
// params[
// 	["_objectiveModule",nil,[objNull]]
// ];

// };
SQFM_fnc_groupObjectiveInRange = { 
params[
	["_objectiveModule",nil,[objNull]]
];
private _objctvData = _objectiveModule getVariable "SQFM_objectiveData";
private _pos        = _self get"groupCluster"get"position";
private _range      = _objctvData get "range";
private _distance   = _pos distance2D _objectiveModule;
private _inRange    = _distance < _range;

_inRange;
};

SQFM_fnc_roadsInArea = { 
private _targetPos = (_this#0)#0;
params[
  ["_area",           nil,                 [[]]],
  ["_minRoadCount",    2,                   [0]],
  ["_proxyPos",       _targetPos, [[], objNull]],
  ["_allowExpansion", true,              [true]]  
];

private _radius = selectMax[_area#1, _area#2];
private _center    = _area#0;
private _roads     = _center nearRoads _radius;
private _roadCount = count _roads;
private _attempts  = 0;

while{_allowExpansion
&&   {_roadCount < _minRoadCount
&&   {_attempts  < 10}}}
do{
    _radius    = _radius+50;
    _attempts  = _attempts+1;
    _roads     = _center nearRoads _radius;
    _roadCount = count _roads;
};

_roads = [_roads, [], {_proxyPos distance _x}, "ASCEND"] call BIS_fnc_sortBy;

_roads;
};


SQFM_fnc_getAreaParkingPos = { 
private _targetPos = (_this#0)#0;
params[
  ["_area",           nil,                 [[]]],
  ["_minRoadCount",    2,                   [0]],
  ["_proxyPos",       _targetPos, [[], objNull]], // The road nearest to this position will be used. Default is center of area.
  ["_allowExpansion", true,              [true]]  
];
private _roadPos    = getPosATLVisual (([_area, _minRoadCount, _proxyPos, _allowExpansion] call SQFM_fnc_roadsInArea)#0);
private _parkingPos = [_roadPos] call SQFM_fnc_findParkingSpot;

_parkingPos;
};


SQFM_fnc_group_validObjective = { 
params[
	["_objectiveModule",nil,[objNull]]
];
private _objctvData   = _objectiveModule getVariable "SQFM_objectiveData";
private _assetWanted  = _objctvData get "asset";
private _allowedSides = _objctvData get "allowedSides";
private _groupType    = _self       get "groupType";
private _side         = side (_self get "grp");
private _matches      = [_assetWanted, _groupType] call SQFM_fnc_assetTypesMatch;
private _inRange      = _self call ["objectiveInRange",[_objectiveModule]];

if!(_side in _allowedSides) exitWith{false;};
if!(_matches)               exitWith{false;};
if!(_inRange)               exitWith{false;};

true;
};

SQFM_fnc_groupGetNearObjectives = { 
_self call ["setGroupCluster"];

private _pos        = _self get"groupCluster"get"position";
private _objectives = (_pos nearEntities ["SQFSM_Objective", SQFM_maxObjectiveRange])select{_self call ["validObjective", [_x]]};

_objectives;
};

SQFM_fnc_groupGarrison = { 
private _pos       = _self call ["getAvgPos"];
private _buildings =  [_pos, 75] call SQFM_fnc_nearBuildings;

if(_buildings isEqualTo [])exitWith{};

_pos = getPosATLVisual (selectRandom _buildings);

private _wp = (_self get "grp") addWaypoint [_pos, 0];
_wp setWaypointType "GARRISON";
_wp setWaypointScript "\x\cba\addons\ai\fnc_waypointGarrison.sqf";

_wp;
};

SQFM_fnc_groupAssignObjective = { 
params[
	["_objectiveModule",nil,[objNull]]
];
private _objctvData = _objectiveModule getVariable "SQFM_objectiveData";
private _group      = _self get "grp";

_objctvData call ["assignGroup",[_group]];


true;
};

SQFM_fnc_groupOnObjectiveArrival = { 
private _taskData  = _self get "taskData";
private _zone      = _taskData get "zone";
private _pos       = _zone#0;

_self set ["state", ""];
_self set ["action", "Clearing area"];

private _statement = 'group this getVariable "SQFM_grpData"get"taskData"call["endTask"]';
_taskData call ["addWaypoint", [_pos,_statement,"SAD"]];

};

SQFM_fnc_groupInitObjectiveTask = { 
params[
	["_objectiveModule", nil,        [objNull]],
    ["_taskName",        "Take Objective",[""]]
];

private _objctvData = _objectiveModule getVariable "SQFM_objectiveData";
private _zone       = _objctvData get "zone";
private _pos        = _objctvData get "position";
private _onArrival  = {(_self call ["ownerData"]) call ["onObjectiveArrival"]};
private _task       = _self call ["initTask",
[
    "Take Objective",    // Taskname     ["name"]
    _zone,               // Task zone    ["zone"]
    [_pos],              // Positions    ["positions"]
    [_objectiveModule],  // TaskParams   ["params"]
    _onArrival,          // Arrival-code ["arrivalCode"]
    {}                   // End-code     ["endCode"]
]];

_task;
};


SQFM_fnc_initGroupTravel = { 
params[
    ["_movePos",  nil,    [[]]],
    ["_taskName", "move", [""]]
];
private _grpPos         = _self call ["getAvgPos"];
private _distance       = _movePos distance2D _grpPos;
private _boardingStatus = _self call ["boardingStatus"];
private _travelNow      = _distance < 500 || {_boardingStatus isEqualTo "boarded"};
private _params         = [_movePos, _taskName];

// The group moves to its destination as is.
if(_travelNow)
exitWith{ 
	_self call ["execTravel", _params]; 
	true;
};

// The group Boards available vehicles, then moves to its destination.
if(_self call ["canBoardNow"]
&&{_self call ["boardThenTravel", _params]})
exitWith{true;};

// The group cannot call for transport, the move is aborted.
if!(_self call ["canCallTransport"])
exitWith{
    "Cannot call transport" call dbgm;
    false;
};

// Transport is called, if denied the move is aborted.
private _transport = _self call ["callTransport", [_movePos]];
if(isNull _transport)
exitWith{false;};

true;
};


SQFM_fnc_groupTakeObjective = { 
params[
	["_objModule",nil,[objNull]]
];
private _area      = _objModule getVariable "SQFM_objectiveData"get"area";
private _pos       = _area#0;
private _leader    = leader(_self get"grp");
private _dropPos   = [_area, 3, _leader, true] call SQFM_fnc_getAreaParkingPos;
private _canTravel = _self call ["initTravel",[_dropPos]];
// systemChat str _dropPos;

// 

if!(_canTravel)exitWith{false;};

_self call ["initObjectiveTask",[_objModule]];
_self call ["assignObjective",  [_objModule]];

true;
};




private _group = grp3;
private _objct = o_4;
// [_group] call SQFM_fnc_initGroupData;
private _grpData  = _group getVariable "SQFM_grpData";
_grpData call ["takeObjective", [_objct]];

// private _pos      = getPosATLVisual o_4;
// hint str(_grpData call ["initTravel",[_pos]]);
// _grpData call ["initObjectiveTask",[o_1]];
// _grpData call ["assignObjective",  [_objModule]];
// _grpData call ["garrison"];

// hint str (_grpData call ["getNearObjectives"]);


// {[_x] call SQFM_fnc_initGroupData;} forEach allGroups;
// {[_x] call SQFM_fnc_setObjectiveData;} forEach entities "SQFSM_Objective";
// [o1]      call ;
// private _grpData  = grp2 getVariable "SQFM_grpData";
// private _obctData = o_3 getVariable "SQFM_objectiveData";
// hint str (_obctData call ["getGroupsInZone"]);
// hint str (_obctData get "assignedGroups" get "west");

// _obctData call ["assignGroup",[grp1]];
// _obctData call ["assignGroup",[grp2]];

// hint str (_grpData call ["tallyAssets"]);
// hint str (_obctData get "assignedGroups" get "west");
// hint str (_obctData call ["getAssignedAssets",["west"]]);
// systemChat str (_obctData call ["troopsNeeded",["west"]]);
// 
// 
// 
// SQFM_fnc_execGroupTravel = { 
// params[
// 	["_movePos",          nil,[[]]],
// 	["_transportVehicle", nil,[objNull]]
// ];
// _self call ["deleteWaypoints"];
// private _parkingSpot = [_movePos] call SQFM_fnc_findParkingSpot;
// private _targetPos   = _parkingSpot;
// private _onCompleted = '(group this getVariable "SQFM_grpData") call ["onArrival"]';
// if(_movePos distance2D _parkingSpot > 100)then{_targetPos = _movePos;};
// private _wp = (_self get "grp")addWaypoint[_targetPos, 0];



// _wp setWaypointStatements ["true", _onCompleted];
// };


/*********************************/

systemChat "devfiled read";