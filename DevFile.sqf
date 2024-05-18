scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner

// SQFM_fnc_initBattleMap       = {};
SQFM_fnc_initGroupData = { 
params [
    ["_group", nil, [grpNull]]
]; 
[_group] call SQFM_fnc_groupBehaviourSettings
params[
    ["_squadClass",    nil,    [""]],
    ["_defend",        nil,  [true]],
    ["_attack",       nil,  [true]],
    ["_hunt",          nil,  [true]],
    ["_reinforce",     nil,  [true]],
    ["_callReinforce", nil,  [true]],
    ["_callAir",       nil,  [true]],
    ["_callArty",      nil,  [true]]
];

private _3Dtxt    = ["100%", 0.546, "#ffffff", "#00000000", "PuristaBold"]call SQFM_fnc_getTextTexture;
private _emptyMap = createHashmapObject[[]];
private _dataArr  = [ 

    ["birth",             round time],
    ["lastTransportCall", round time],
    ["grp",                   _group],
    ["side",             side _group],
    ["action",                    ""],
    ["state",                     ""],
	["groupType",          "unknown"],
    ["squadClass",       _squadClass],
    ["travelData",               nil],
    ["available",               true],
    ["battlefield",       [-1,-1,-1]],
    ["battleTimes",               []],
    ["shots",                     []],
    ["groupCluster",             nil],
    ["transportCrew",          false],
    ["transportVehicle",     objNull],
    ["initialStrength",            0],
    ["strengthIndicator",     _3Dtxt],
    ["objective",            objNull],
    ["taskData",           _emptyMap],

    /******Behaviour settings*******/
    ["canDefend",                    _defend],
    ["canAttack",                   _attack],
    ["canHunt",                        _hunt],
    ["canReinforce",              _reinforce],
    ["canCallReinforcements", _callReinforce],
    ["canCallAir",                  _callAir],
    ["canCallArty",                _callArty]
];

private _data = createHashmapObject [_dataArr];

// All methods(functions) related to this hashmap is found at ""
[_data] call SQFM_fnc_setGroupMethods;

_data call ["setGroupCluster"];
_data call ["setGroupType"];

private _veh1     = (_data call ["getVehiclesInUse"])#0;
private _strength = _data call ["getStrength"];

if((!isNil "_veh1")
&&{_veh1 getVariable ["SQFM_transport", false]})
then{
    _data set ["transportCrew",    true];
    _data set ["transportVehicle", _veh1];
};

_data set ["initialStrength", _strength];
_data call ["update"];

_group setVariable ["SQFM_grpData", _data, true];

_data;
};

SQFM_fnc_setGroupMethods     = { 
params[
    ["_groupData",nil,[createHashmap]]
];

private _methods = [    
    ["3DIcon",                             SQFM_fnc_group3DIcon],
    ["3DColor",                           SQFM_fnc_group3DColor],
    ["setMethods",      {[_self] call SQFM_fnc_setGroupMethods}],
    ["debugText",                       SQFM_fnc_groupDebugText],

    /*************************{MISC}***************************/
    ["isIdle",                             SQFM_fnc_groupIsIdle],
    ["isValid", {[(_self get "grp")] call SQFM_fnc_validGroup;}],
    ["activeWp",                              SQFM_fnc_activeWp],
    ["update",                            SQFM_fnc_groupUpdate],
    
    /**********************{TRAVEL}*****************************/
    ["initTravel",                     SQFM_fnc_initGroupTravel],
    ["execTravel",                     SQFM_fnc_execGroupTravel],
    ["onArrival",                            SQFM_fnc_onArrival],
    ["isTraveling",                   SQFM_fnc_groupIsTraveling],
    ["deleteWaypoints",                      SQFM_fnc_deleteWps],
    ["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
    ["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
    ["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
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
	["validObjective",                       SQFM_fnc_group_validObjective],
    ["objectiveInRange",                    SQFM_fnc_groupObjectiveInRange],
    ["getNearObjectives",                  SQFM_fnc_groupGetNearObjectives],
    ["assignObjective",                      SQFM_fnc_groupAssignObjective],
    ["autoAssignObjective",              SQFM_fnc_groupAutoAssignObjective],
    ["canAttackOnly",                             SQFM_fnc_groupAttackOnly],
    ["canDefendOnly",                             SQFM_fnc_groupDefendOnly],
    ["takeObjective",                          SQFM_fnc_groupTakeObjective],
    ["attackObjective",                      SQFM_fnc_groupAttackObjective],
    ["onObjectiveArrival",                SQFM_fnc_groupOnObjectiveArrival],
    ["guardObjective",                        SQFM_fnc_groupGuardObjective],
    ["objectiveData",                          SQFM_fnc_groupObjectiveData],
    ["typeMatchObjective",                SQFM_fnc_groupTypeMatchObjective],
    ["objectiveHostile",                    SQFM_fnc_groupObjectiveHostile],
    ["objectiveInsertPos",                SQFM_fnc_groupObjectiveInsertPos],
    ["objectiveInsertPosStandard",SQFM_fnc_groupObjectiveInsertPosStandard],
    ["objectiveInsertPosDanger",    SQFM_fnc_groupObjectiveInsertPosDanger],
    

    /************************{TASKS}****************************/
    ["initTask",                              SQFM_fnc_initTaskData],
    ["initObjectiveTask",           SQFM_fnc_groupInitObjectiveTask],
    ["getAbilities",      {[_self] call SQFM_fnc_getGroupAbilities}],

    /**********************{TACTICS}***************************/
    ["garrison",                         SQFM_fnc_groupGarrison],

    /********************{GROUP MEMBERS}************************/
    ["getUnits",                              SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",                  SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",         {(_self call ["getOwnVehicles"])#2}],
    ["isVehicleGroup", {count(_self call ["nonCrewMen"])isEqualTo 0}],
    ["getGrpMembers",                         SQFM_fnc_getGrpMembers],
    ["getStrength",                        SQFM_fnc_getGroupStrength],
    ["setStrengthIcon",                SQFM_fnc_groupSetStrengthIcon],
	["crewMen",                                   SQFM_fnc_groupCrew],
	["nonCrewMen",                             SQFM_fnc_groupNonCrew],
    ["tallyAssets",                        SQFM_fnc_groupTallyAssets],
    ["getGroupCluster",                     SQFM_fnc_getGroupCluster],
    ["setGroupCluster",                     SQFM_fnc_setGroupCluster],
    ["getAvgPos",                               SQFM_fnc_groupAvgPos],
    ["getStrSide",                          SQFM_fnc_groupGetStrSide],
    ["isPlayerGroup", {[_self get"grp"] call SQFM_fnc_isPlayerGroup}],

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




SQFM_fnc_setObjectiveData    = { 
params[
    ["_module", nil, [objNull]]
];
private _position     = getPosATLVisual _module;
private _data3d       = [_module] call SQFM_fnc_module3dData;
private _area         = _data3d get "area";
private _radius       = selectMax [100, _area#1, _area#2];
private _zone         = [_position, _radius];
private _zoneLines    = [_position, _radius, 16, [0,1,0,1]] call SQFM_fnc_getCircleLines;
private _type         = _module getVariable "objectiveType";
private _description  = [_type] call SQFM_fnc_objectiveDescription;
private _capStrength  = _module getVariable "capStrength";
private _distance     = _module getVariable "activationDistance";
private _defaultOwner = _module getVariable "defaultOwner";
private _owner        = sideUnknown;
private _sides        = [];
private _assetTypes   = [];

if (_defaultOwner isNotEqualTo "undefined")
then{_owner = (call compile _defaultOwner)};

if(_module getVariable "allowEast")              then {_sides pushBack east;};
if(_module getVariable "allowWest")              then {_sides pushBack west;};
if(_module getVariable "allowIndependent")       then {_sides pushBack independent;};

if(_type isEqualTo "recon")
then{_assetTypes = ["recon"]}
else{ 
    if(_module getVariable "allowreconcapture")      then {_assetTypes pushBack "recon";};
    if(_module getVariable "allowinfantrycapture")   then {_assetTypes pushBack "infantry";};
    if(_module getVariable "allowcarcapture")        then {_assetTypes pushBack "cars";};
    if(_module getVariable "allowlightarmorcapture") then {_assetTypes pushBack "light armor";};
    if(_module getVariable "allowheavyarmorcapture") then {_assetTypes pushBack "heavy armor";};
};


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
    ["assetStrength",                                   _capStrength],
    ["owner",                                                 _owner],
    ["allowedSides",                                          _sides],
    ["allowedAssets",                                    _assetTypes],
    ["groupsPresent",                                             []],
    ["sidesPresent",                                              []],
	["assignedGroups",                               _assignedGroups],
    ["contested",                                              false],
    ["captureTime",                                             time],

    /*************************{DEBUG DATA}**************************/
    ["defaultIcon",    "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    ["contestedIcon",    "\A3\ui_f\data\map\markers\military\warning_CA.paa"],
    ["capturedIcon",     "\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"],
    ["3dData",                                                       _data3d],
    ["3dColor",                           ([_owner] call SQFM_fnc_sideColor)]
];


private _data = createhashMapObject [_dataArr];
[_data] call SQFM_fnc_setObjectiveMethods;

_module setVariable ["SQFM_objectiveData", _data];

_data;
};

SQFM_fnc_setObjectiveMethods = { 
params[
    ["_data",nil,[createHashmap]]
];
private _methods =
[
    ["getGroupsInZone",   {(_self get"zone") call SQFM_fnc_groupsInZone}],
    ["timeSinceCapture",               {time - (_self get"captureTime")}],
    ["getSidesInZone",                  SQFM_fnc_objectiveGetSidesInZone],
    ["getAssignedAssets",            SQFM_fnc_objectiveGetAssignedAssets],
    ["countAssignedAssets",        SQFM_fnc_objectiveCountAssignedAssets],
    ["getContested",                      SQFM_fnc_objectiveGetContested],
    ["setContested",{_self set ["contested",_self call["getContested"]]}],
    ["inBattle",          {_self get"zone"call SQFM_fnc_posInBattleZone}],
    ["update",                                  SQFM_fnc_objectiveUpdate],
    ["troopsNeeded",                       SQFM_fnc_objectiveNeedsTroops],
    ["assignGroup",                        SQFM_fnc_objectiveAssignGroup],
    ["unAssignGroup",                    SQFM_fnc_objectiveUnAssignGroup],
	["draw3D",                              SQFM_fnc_drawObjectiveModule],
    ["setMethods",           {[_self] call SQFM_fnc_setObjectiveMethods}]
];

{
    private _name = _x#0;
    private _code = _x#1;
    _data set [_name, _code];
    
} forEach _methods;

true;
};

/*********************************/

SQFM_fnc_fiveMinTasks={};
// SQFM_fnc_groupInitObjectiveTask       = {};
// SQFM_fnc_groupOnObjectiveArrival      = {};
// SQFM_fnc_groupObjectiveData           = {};
// SQFM_fnc_getData                      = {};
// SQFM_fnc_sidesFromGroupArr            = {};
// SQFM_fnc_objectiveGetContested        = {};
// SQFM_fnc_objectiveGetSidesInZone      = {};
// SQFM_fnc_sendTransport                = {};
// SQFM_fnc_updateMethodsAllGroups       = {};
// SQFM_fnc_updateMethodsAllObjectives   = {};
// SQFM_fnc_activeWp                     = {};
// SQFM_fnc_groupIsTraveling             = {};
// SQFM_fnc_groupIsIdle                  = {};
// SQFM_fnc_getIdleGroups                = {};
// SQFM_fnc_objectiveCountAssignedAssets = {};
// SQFM_fnc_objectivesSorted             = {};
// SQFM_fnc_groupAutoAssignObjective     = {};
// SQFM_fnc_assignGroupListToObectives   = {};
// SQFM_fnc_assignAllGroupsToObjective   = {};
// SQFM_fnc_groupSetStrengthIcon         = {};
// SQFM_fnc_ACE_Medical_OnStatusChange = {};
// SQFM_fnc_objectiveDescription       = {};
// SQFM_fnc_group_validObjective       = {};
// SQFM_fnc_groupUpdate                = {};
// SQFM_fnc_getGroupStrength           = {};
// SQFM_fnc_objectiveGetAssignedAssets = {};
// SQFM_fnc_objectiveNeedsTroops       = {};
// SQFM_fnc_groupGetNearObjectives     = {};
// SQFM_fnc_getAttackGroups            = {};
// SQFM_fnc_getTextTexture             = {};
// SQFM_fnc_groupAutoAssignObjective   = {};
// SQFM_fnc_groupAutoAssignObjective   = {};
// SQFM_fnc_groupGetBehaviorModule     = {};
// SQFM_fnc_groupType                  = {};
// SQFM_fnc_groupBehaviourSettings     = {};
// SQFM_fnc_groupDebugTextAbilities    = {};
// SQFM_fnc_groupDebugText             = {};
// SQFM_fnc_onCuratorGroupSelection    = {};
// SQFM_fnc_getGroupAbilities          = {};
// SQFM_fnc_getCategorizedGroups       = {};
// SQFM_fnc_groupTypeMatchObjective  = {};
// SQFM_fnc_group_validObjective     = {};
// SQFM_fnc_groupGetNearObjectives   = {};
// SQFM_fnc_groupAutoAssignObjective = {};
// SQFM_fnc_assignAttackGroups       = {};
// SQFM_fnc_assignAllGroupTasks      = {};
// SQFM_fnc_groupTypeMatchObjective  = {};
// SQFM_fnc_distanceToNearestBattle = {};
// SQFM_fnc_nearestObjective        = {};
// SQFM_fnc_initBattle              = {};
// SQFM_fnc_battlefieldRadius       = {};
// SQFM_fnc_battlefieldCenter       = {};
// SQFM_fnc_battlefieldDimensions   = {};
// SQFM_fnc_groupUpdate             = {};
// SQFM_fnc_isHouse               = {};
// SQFM_fnc_buildingChangedEh     = {};
// SQFM_fnc_updateBattleBuildings = {};

/************************New Functions*******************************/

/*
TODO:
-Posponed-1)  Fix bug where some available Squads are not assigned.
-Complete-2)  Limit battle-size -min/max- (Important in order to implement reinforcements)
-Complete-3)  Set building changed eventhandler for BFFs and Objectives (In order to implement defensive tactics)
-Posponed-4)  Make sure Objectives are actually captured
5)  Make attack-only squads keep pushing to the next Objective once the current one is taken.
6)  Send defensive squads.
7)  Call/Send reinforcements.
8)  Combat insertion.
9)  Transport react to fire / Enemy spotted.
10) Transport Pickup fail handling.
11) Battlefield Map markers
12) Objective   Map markers
*/
SQFM_fnc_groupAttackOnly = { 
private _abilities = _self call ["getAbilities"];
private _canAttack = "attack" in _abilities;
private _canDefend = "defend" in _abilities;

if (_canDefend)exitWith{false;};
if!(_canAttack)exitWith{false;};

true;
};

SQFM_fnc_groupDefendOnly = { 
private _abilities = _self call ["getAbilities"];
private _canAttack = "attack" in _abilities;
private _canDefend = "defend" in _abilities;

if!(_canDefend)exitWith{false;};
if (_canAttack)exitWith{false;};

true;
};


// [_self, _targetObjective] spawn {(_this#0) call ["takeObjective", [(_this#1)]]};

SQFM_fnc_assignAttackGroups = { 
params[
    ["_groupsMap", nil,            [createHashmap]],
    ["_category",  "attackSquads",            [""]]
]; 
private _available          = _groupsMap call ["getAvailable",[_category]];
private _assignedGroups     = [];
private _assignedObjectives = [];
{
    private _grpObj = (_x call getData)call ["autoAssignObjective",[_assignedObjectives]];
    if(_grpObj isNotEqualTo [])
    then{
        _assignedGroups     pushBackUnique (_grpObj#0);
        _assignedObjectives pushBackUnique (_grpObj#1);
    };
    
} forEach _available;

_assignedGroups;
};


SQFM_fnc_assignAllGroupTasks = { 
private _groupMap     = call SQFM_fnc_getCategorizedGroups;

private _groups = [_groupMap, "recon"] call SQFM_fnc_assignAttackGroups;
_groupMap call ["removeMultiple",[_groups]];

_groups = [_groupMap, "attackSquads"] call SQFM_fnc_assignAttackGroups;
_groupMap call ["removeMultiple",[_groups]];
};


SQFM_fnc_groupInitObjectiveTask = { 
private _defTaskName = "Taking Objective";
private _defArrCode  = {(_self call ["ownerData"]) call ["onObjectiveArrival"]};
private _defEndCode  = {(_self call ["ownerData"]) call ["guardObjective"]};
params[
	["_objectiveModule", nil,     [objNull]],
    ["_taskName",        _defTaskName, [""]],
    ["_onArrival",       _defArrCode,  [{}]],
    ["_onTaskEnd",       _defEndCode,  [{}]]
];

private _objctvData = _objectiveModule getVariable "SQFM_objectiveData";
private _zone       = _objctvData get "zone";
private _pos        = _objctvData get "position";
private _task       = _self call ["initTask",
[
    _taskName,          // Taskname     ["name"]
    _zone,              // Task zone    ["zone"]
    [_pos],             // Positions    ["positions"]
    [_objectiveModule], // TaskParams   ["params"]
    _onArrival,         // Arrival-code ["arrivalCode"]
    _onTaskEnd          // End-code     ["endCode"]
]];

_task;
};

SQFM_fnc_groupAutoAssignObjective = { 
params[
    ["_excluded",[],[[]]] // Objectives excluded from the search
];
private _group      = _self get "grp";
private _side       = _self call ["getStrSide"];//side _group;
private _objectives = _self call ["getNearObjectives",[_excluded]] select {(_x call getData)call ["troopsNeeded",[_side]]};
if(_objectives isEqualTo [])exitWith{[]};

private _targetObjective = ([_objectives, _group] call SQFM_fnc_objectivesSorted)#0;
_self call ["takeObjective", _targetObjective];

sleep 1;

[_group, _targetObjective];
};

SQFM_fnc_groupTakeObjective = { 
params["_objModule"];
[_self, _objModule]spawn{
params[
    ["_self",      nil,[createHashmap]],
	["_objModule", nil,[objNull]]
];

private _dropPos   = _self call ["objectiveInsertPos",[_objModule]];
private _canTravel = _self call ["initTravel",[_dropPos]];

if!(_canTravel)exitWith{false;};

_self call ["initObjectiveTask",[_objModule]];
_self call ["assignObjective",  [_objModule]];

true;
}};



SQFM_fnc_groupObjectiveHostile = { 
params[
	["_objModule",nil,[objNull]]
]; 
private _objData      = _objModule call getData;
private _side         = _self get "side";
private _contested    = _objData call ["getContested"];
private _owner        = _objData get "owner";
private _hostileOwner = [_side, _owner] call SQFM_fnc_hostile;

if(_contested)                   exitWith{true};
if(_owner isEqualTo sideUnknown) exitWith{false};
if(_owner isEqualTo _side)       exitWith{false};

_hostileOwner;
};

/*
ATTACK Sequence:
1) Define Insertion point.
   - If Infantry or Mixed group a position in a safe distance (cover?)
     is needed for unloading infantry.
   - If the objective is not hostile then standard insertion pos is used
2) Travel to objective.
3) Once the insertion point is reached then loop a search and destroy
   sequence.
4) Once the Objective is secured (Not hostile or contested) then the
   attackGroup returns to the insertion point and is set as idle ("task"="" & "action"="")

*/
SQFM_fnc_groupObjectiveInsertPosStandard = { 
params[
	["_objModule",nil,[objNull]]
];
private _objData = _objModule call getData;
private _area    = _objData get "area";
private _leader  = leader(_self get"grp");
private _insPos  = [_area, 6, _leader, true] call SQFM_fnc_getAreaParkingPos;

_insPos;
};


SQFM_fnc_formatDir = { 
params[
    ["_dir",   nil,     [0]],
    ["_round", false, [true]]
];

if!(_round)exitWith{((_dir + 360) % 360);};
_dir = round((_dir + 360) % 360);

_dir;
};

SQFM_fnc_lineBroken = { 
params[
	["_startPosASL", nil,          [[]]],
	["_endPosASL",   nil,          [[]]],
	["_ignoreObj1",  objNull, [objNull]],
	["_ignoreObj2",  objNull, [objNull]],
    ["_ignoreList",  [],           [[]]]
];

private _linebreaks = lineIntersectsSurfaces [_startPosASL, _endPosASL, _ignoreObj1, _ignoreObj2, true, 5];

// Select objects that are not men, nor in the ignoreList
_linebreaks = _linebreaks select { 
    private _object         = _x#3;
    private _isMan          = _object isKindOf "man";// isEqualTo false;
    private _ignored        = _object in _ignoreList;
    private _validLineBreak = _isMan isEqualTo false && {_ignored isEqualTo false};
    
    _validLineBreak;
};

private _broken = _linebreaks isNotEqualTo [];

_broken;
};

SQFM_fnc_enemiesInZone = { 
params[
    ["_ownSide",  nil, [objNull,west,grpNull,createHashmap]],
    ["_zone",     nil,                                 [[]]]
];
_zone params["_pos","_rad"];
private _enemies  = [];

{
    if([_x] call SQFM_fnc_validLandEntity
    &&{[_ownSide,_x] call SQFM_fnc_hostile})
    then{_enemies pushBackUnique _x};
    
} forEach (_pos nearEntities ["land", _rad]);

_enemies;
};

SQFM_fnc_clustersFromObjArr = { 
params[
    ["_objArr",     nil, [[]]],
    ["_clusterRad", 50,   [0]]
];
private _registeredObjects = [];
private _allClusters       = [];

{isNil{
    private _hashMap = [_x, _clusterRad,_registeredObjects] call SQFM_fnc_cluster;
    private _objects = _hashMap get "objects";

    _registeredObjects insert [0, _objects, true];
    _allClusters pushBackUnique _hashMap;
    
}} forEach _objArr;

_allClusters;
};

SQFM_fnc_posHasTerrainCover = { 
params[
    ["_pos",            nil,  [[]]], // The position that is being evaluated
    ["_enemyPositions", nil,  [[]]], // A list of positions to hide from
    ["_z",              3,     [0]]  // Meters above ground (at 0 it may give a false positive)
];
if(surfaceIsWater _pos)exitWith{false;};

private _hasCover    = true;
private _searchEnded = false;
private _startPos    = [_pos#0, _pos#1, _z];

{
    if(_searchEnded)exitWith{};

    private _endPos  = [_x#0, _x#1, _z];
    private _inCover = terrainIntersect [_startPos, _endPos];
    
    if!(_inCover)exitWith{
        _hasCover    = false;
        _searchEnded = true;
    };

    
} forEach _enemyPositions;

_hasCover;
};

SQFM_fnc_posIsHidden = { 
params[
    ["_pos",            nil,  [[]]], // The position that is being evaluated
    ["_enemyPositions", nil,  [[]]], // A list of positions to hide from
    ["_z",              0,     [0]], // Meters above ground (at 0 it may give a false positive)
    ["_objectList",     [],   [[]]]  // A list of units or vehicles that does not break LOS 
];

private _hidden = true;
private _startPos = ATLToASL [_pos#0, _pos#1, _z];
{
    if!(_hidden)exitWith{};

    private _endPos  = ATLToASL [_x#0, _x#1, _z];
    private _blocked = [_startPos,_endPos,nil,nil,_objectList] call SQFM_fnc_lineBroken;
    
    if!(_blocked)exitWith{_hidden = false;};

} forEach _enemyPositions;

_hidden;
};

SQFM_fnc_selectSafePositions = { 
params[
    ["_posArr",  nil, [[]]], // List of positions to be evaluated
    ["_enemies", nil, [[]]]  // List of enemies (Units / vehicles that needs to be hidden from)
];
private _safePositions = _posArr select {[_x,false,7,10] call SQFM_fnc_clearPos};
if(_safePositions isEqualTo []) exitWith{[]};
if(_enemies isEqualTo [])       exitWith{_safePositions};

private _enemyClusters  = [_enemies] call SQFM_fnc_clustersFromObjArr;
private _enemyPositions = _enemyClusters apply {_x get "position"};
private _safePositions  = _posArr select {[_x, _enemyPositions, 2] call SQFM_fnc_posHasTerrainCover};

// Terrain is the best cover so if found only those are returned.
if(_safePositions isNotEqualTo [])exitWith{_safePositions};

_safePositions  = _posArr select {[_x, _enemyPositions, 3, _enemies] call SQFM_fnc_posIsHidden};

_safePositions;
};


SQFM_fnc_dangerZoneInsertionPos = { 
params[
    ["_startPos",  nil,                                 [[]]], // The position where you start the calculation
    ["_zone",      nil,                                 [[]]], // The dangerous area [pos, rad]
    ["_ownSide",   nil, [objNull,west,grpNull,createHashmap]], // the side of the entity doing the inquiry
    ["_bufferRad", 0,                                    [0]]  // Added distance to Zone-radius 
];
private _dirRange = 70;
private _center   = _zone#0;
private _radius   = _zone#1;
private _maxDist  = _startPos distance2D _center;
private _finalRad = _radius+_bufferRad;

if(_finalRad > _maxDist)then{_finalRad = _maxDist};

private _enemies  = [_ownSide, [_center, _finalRad]] call SQFM_fnc_enemiesInZone;
private _zeroDir  = [_center getDir _startPos] call SQFM_fnc_formatDir;
private _zeroPos  = [_center, _zeroDir, _finalRad] call SQFM_fnc_sinCosPos;

if(_enemies isEqualTo [])exitWith{
    private _insertPos = [_zeroPos, _startPos] call SQFM_fnc_findParkingSpot;
    _insertPos;
};

private _startDir    = [_zeroDir-_dirRange, true]call SQFM_fnc_formatDir;
private _stepDirDiff = _dirRange*0.2;
private _positions   = [];

SQFM_Custom3Dpositions = [];// [[getPosATL player, "playerPos"]];

for "_i" from 1 to 10 do {
    private _pos    = [_center, _startDir, _finalRad] call SQFM_fnc_sinCosPos;
    private _newDir = _startDir + _stepDirDiff;
    
    _startDir = [_newDir] call SQFM_fnc_formatDir;
    _positions pushBack _pos;
    SQFM_Custom3Dpositions pushBack [_pos];
};

private _safePositions = [_positions, _enemies] call SQFM_fnc_selectSafePositions;
SQFM_Custom3Dpositions append (_safePositions apply{[_x,"",[0,1,0,1]]});

if(_safePositions isEqualTo [])exitWith{
    private _insertPos = [_zeroPos, _startPos] call SQFM_fnc_findParkingSpot;
    _insertPos;
};

private _parkingRadius = selectMax [(_bufferRad*0.5),50];
private _safePos       = selectRandom _safePositions;
private _insertPos     = [_safePos, _startPos, _parkingRadius] call SQFM_fnc_findParkingSpot;

SQFM_Custom3Dpositions pushBack [_safePos,   "S",[1,0,0,1]];
SQFM_Custom3Dpositions pushBack [_insertPos, "I",[0,0,1,1]];

_insertPos;
};

private _pos    = getPos player;
private _zone   = (obj_1 call getData)get"zone";
private _side   = side player;
private _buffer = 300;
[
    _pos,
    _zone,
    _side,
    _buffer
] call SQFM_fnc_dangerZoneInsertionPos;


// private _min45Dir  = [(_zeroDir-45)] call SQFM_fnc_formatDir;
// private _plus45Dir = [(_zeroDir+45)] call SQFM_fnc_formatDir;

SQFM_fnc_groupObjectiveInsertPosDanger = { 
params[
	["_objModule",nil,[objNull]]
];
private ["_insertionPos"];
private _grpPos  = _self call [""];
private _objPos  = getPosATLVisual _objModule;
private _objData = _objModule call getData;
// private _posZero = 

};

SQFM_fnc_groupObjectiveInsertPos = { 
params[
	["_objModule",nil,[objNull]]
];
private ["_insertionPos"];
private _danger       = _self call ["objectiveHostile",[_objModule]];
private _vehicleGroup = _self call ["isVehicleGroup"];

// Vehicle groups do not need to drop infantry, so a standard position is valid.
if(_danger       isEqualTo false 
or{_vehicleGroup isEqualTo true})
then{_insertionPos = _self call ["objectiveInsertPosStandard",[_objModule]]}
else{_insertionPos = _self call ["objectiveInsertPosDanger",[_objModule]]};

_insertionPos;
};

SQFM_fnc_groupAttackObjective = { 
params[
	["_objModule",nil,[objNull]]
];
private _infilPos = _self call ["objectiveInsertPos", [_objModule]];


_self call["assignObjective",[_objModule]];
};


/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/





// call SQFM_fnc_assignAllGroupTasks;
// private _obj = town_1 call getData;
// private _grp = grp_1  call getData;
// hint str(_grp call ["autoAssignObjective"]);
// hint str(_grp call ["getNearObjectives",[[]]]);

systemChat "devfiled read";