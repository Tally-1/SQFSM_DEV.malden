scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
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
    ["taskData",           _emptyMap]
];

private _data = createHashmapObject [_dataArr];

// All methods(functions) related to this hashmap is found at ""
[_data] call SQFM_fnc_setGroupMethods;

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

SQFM_fnc_setGroupMethods = { 
params[
    ["_groupData",nil,[createHashmap]]
];

private _methods = [    
    ["3DIcon",                             SQFM_fnc_group3DIcon],
    ["3DColor",                           SQFM_fnc_group3DColor],
    ["setMethods",      {[_self] call SQFM_fnc_setGroupMethods}],
    
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
    ["guardObjective",             SQFM_fnc_groupGuardObjective],
    ["objectiveData",               SQFM_fnc_groupObjectiveData],

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

{
    private _name = _x#0;
    private _code = _x#1;
    _groupData set [_name, _code];
    
} forEach _methods;

true;
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
    ["module",                                               _module],
    ["position",                                           _position],
	["area",                                                   _area],
	["zone",                                                   _zone],
    ["range",                                              _distance],
    ["type",                                                   _type],
    ["description",                                     _description],
    ["asset",                                             _assetType],
    ["count",                                            _assetcount],
    ["owner",                                            sideUnknown],
    ["allowedSides",                                          _sides],
    ["groupsPresent",                                             []],
    ["sidesPresent",                                              []],
	["assignedGroups",                               _assignedGroups],
    ["contested",                                              false],

    /*************************{DEBUG DATA}**************************/
    ["defaultIcon",   "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    ["contestedIcon", "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    // ["3dIcon",        "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    ["3dData",                                                      _data3d],
    ["3dColor",                                                   [1,1,1,1]],
    
	
	/**********************{METHODS}***********************/
	["getGroupsInZone",   {(_self get"zone") call SQFM_fnc_groupsInZone}],
    ["getSidesInZone",                  SQFM_fnc_objectiveGetSidesInZone],
    ["getAssignedAssets",            SQFM_fnc_objectiveGetAssignedAssets],
    ["getContested",                      SQFM_fnc_objectiveGetContested],
    ["setContested",{_self set ["contested",_self call["getContested"]]}],
    ["inBattle",          {_self get"zone"call SQFM_fnc_posInBattleZone}],
    ["update",                       SQFM_fnc_objectiveGetAssignedAssets],
    ["troopsNeeded",                       SQFM_fnc_objectiveNeedsTroops],
    ["assignGroup",                        SQFM_fnc_objectiveAssignGroup],
    ["unAssignGroup",                    SQFM_fnc_objectiveUnAssignGroup],
	["draw3D",                              SQFM_fnc_drawObjectiveModule]

];


private _data = createhashMapObject [_dataArr];

_module setVariable ["SQFM_objectiveData", _data];

_data;
};

/*********************************/
/*
TODO:
--> OBJECTIVES: 
    1) UPDATE:

        - Check sides present.
        - Check groups present.
        - Check if contested.
        - Set owner if not contested.
    
    2) CONTESTED
        - 2 sides in objective or Objective in battleRadius.
    
    
*/

// SQFM_fnc_groupInitObjectiveTask  = {};
// SQFM_fnc_groupOnObjectiveArrival = {};
// SQFM_fnc_groupObjectiveData      = {};

SQFM_fnc_sidesFromGroupArr = { 
params[
    ["_groups",nil,[[]]]
];
private _sides=[];
{_sides pushBackUnique side _x}forEach _groups;

_sides;
};

SQFM_fnc_objectiveGetContested = { 
private _inBattle = _self call ["inBattle"];
if(_inBattle)exitWith{true;};

private _sideCount = count(_self call ["getSidesInZone"]);
if(_sideCount > 1)exitWith{true;};

false;
};


SQFM_fnc_objectiveGetSidesInZone = { 
private _groups = _self call ["getGroupsInZone"];
private _sides  = [_currentGroups] call SQFM_fnc_sidesFromGroupArr;

_sides;
};

SQFM_fnc_objectiveUpdate = { 
_self call ["setContested"];

private _contested      = _self get "contested";

private _previousOwner  = _self get "owner";
private _previousGroups = _self get "groupsPresent";
private _previousSides  = _self get "sidesPresent";
private _currentGroups  = _self call ["getGroupsInZone"];

if(_contested     isEqualTo false
&&{_currentGroups isEqualTo _previousGroups})
exitWith{};

private _currentSides = [_currentGroups] call SQFM_fnc_sidesFromGroupArr;
private _currentOwner =  _currentSides#0;

// _self set ["owner",         _currentOwner];
_self set ["sidesPresent",  _currentSides];
_self set ["groupsPresent", _currentGroups];

if()

};


private _group = grp1;
private _objct = o_3;
private _grpData  = _group getVariable "SQFM_grpData";
_grpData call ["setMethods"];
_grpData call ["takeObjective", [_objct]];


/*********************************/

systemChat "devfiled read";