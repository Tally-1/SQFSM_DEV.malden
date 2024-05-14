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
	["validObjective",            SQFM_fnc_group_validObjective],
    ["objectiveInRange",         SQFM_fnc_groupObjectiveInRange],
    ["getNearObjectives",       SQFM_fnc_groupGetNearObjectives],
    ["assignObjective",           SQFM_fnc_groupAssignObjective],
    ["autoAssignObjective",   SQFM_fnc_groupAutoAssignObjective],
    ["takeObjective",               SQFM_fnc_groupTakeObjective],
    ["onObjectiveArrival",     SQFM_fnc_groupOnObjectiveArrival],
    ["guardObjective",             SQFM_fnc_groupGuardObjective],
    ["objectiveData",               SQFM_fnc_groupObjectiveData],
    ["typeMatchObjective",     SQFM_fnc_groupTypeMatchObjective],

    /************************{TASKS}****************************/
    ["initTask",                          SQFM_fnc_initTaskData],
    ["initObjectiveTask",       SQFM_fnc_groupInitObjectiveTask],

    /**********************{TACTICS}***************************/
    ["garrison",                         SQFM_fnc_groupGarrison],

    /********************{GROUP MEMBERS}************************/
    ["getUnits",                              SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",                  SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",         {(_self call ["getOwnVehicles"])#2}],
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

/************************New Functions*******************************/

/*
TODO:
1) Fix bug where some available Squads are not assigned.
2) Limit battle-size (Important in order to implement reinforcements)
3) Set building changed eventhandler for BFFs and Objectives (In order to implement defensive tactics)
4) Make sure Objectives are actually captured
5) Make attack-only squads keep pushing to the next Objective once the current one is taken.
6) Send defensive squads.
7) Combat insertion.
8) Transport react to fire.


*/

SQFM_fnc_groupUpdate = { 
_self call ["setGroupCluster"];
_self call ["setGroupType"];
_self call ["setStrengthIcon"];
};


// SQFM_fnc_groupTypeMatchObjective = {};


SQFM_fnc_group_validObjective = { 
params[
	["_objModul",nil,[objNull]]
];
private _objData       = _objModul call getData;
private _allowedSides  = _objData get "allowedSides";
private _groupType     = _self    get "groupType";
private _side          = _self    get "side";
private _strSide       = _self call ["getStrSide"];
private _inRange       = _self call ["objectiveInRange",[_objModul]];

if!(_inRange)                                      exitWith{"Out of range" call dbgm;false;};
if!(_side in _allowedSides)                        exitWith{"Wong side" call dbgm;false;};
if!(_objData call ["troopsNeeded",[_strSide]])     exitWith{"Has troops" call dbgm;false;};
if!(_self call ["typeMatchObjective",[_objModul]]) exitWith{"No match" call dbgm;false;};

true;
};


SQFM_fnc_groupGetNearObjectives = { 
params[
    ["_excluded",[],[[]]] // Objectives excluded from the search
];

_self call ["setGroupCluster"];

private _pos        = _self get"groupCluster"get"position";
private _objectives = (_pos nearEntities ["SQFSM_Objective", SQFM_maxObjectiveRange]);
// systemChat str _objectives;
_objectives = _objectives select{
    _self call ["validObjective", [_x]] &&
    {!(_x in _excluded)}
};

_objectives;
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

[_self, _targetObjective] spawn {(_this#0) call ["takeObjective", [(_this#1)]]};

sleep 1;

[_group, _targetObjective];
};



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

SQFM_fnc_groupTypeMatchObjective = { 
params[
	["_objModul",nil,[objNull]]
];
private _objData       = _objModul call getData;
private _allowedAssets = _objData get "allowedAssets";
private _groupType     = _self    get "groupType";

if(_groupType in _allowedAssets)exitWith{true;};

private _match = false;
{
    if(_x in _groupType)exitWith{_match = true;};
    systemChat str [_groupType, _x];
    
} forEach _allowedAssets;

_match;
};

// params ["_curator", "_group"];
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
// call SQFM_fnc_assignAllGroupTasks;


// SQFM_fnc_getAreaParkingPos = {};
// call ["validObjective", [_x]]
private _grp = grp_1  call getData;
// private _obj = town_1 call getData;
// hint str(_grp call ["getNearObjectives",[[]]]);
hint str(_grp call ["autoAssignObjective"]);
// private _objective = town_2 call getData;
// _grp call ["typeMatchObjective", [town_1]];
// systemChat ((_grp call getData)get"squadClass");
// hint str (_grp call ["typeMatchObjective", [recon_1]]);

// private _area      = (_objective call getData)get"area";
// private _pos       = _area#0;
// private _leader    = leader _grp;
// private _dropPos   = [_area, 6, _leader, true] call SQFM_fnc_getAreaParkingPos;
// SQFM_Custom3Dpositions =[[_dropPos]]

// (grp_1 call getData) call ["takeObjective", [obj_3]]; //call ["autoAssignObjective"];
// (grp_2 call getData)call ["autoAssignObjective"];
// call SQFM_fnc_assignAllGroupTasks;

// private _groupMap = call SQFM_fnc_getCategorizedGroups;
// [_groupMap] call SQFM_fnc_copyHashmap;
// hint str  (_groupMap call ["getAvailable",["attackSquads"]]);

// call SQFM_fnc_assignAllGroupsToObjective;
// [grp_1] call SQFM_fnc_initGroupData;
// [grp_1] call SQFM_fnc_groupBehaviourSettings;
// private _objData = obj_1 call getData;
// private _grpData = grp_3 call getData;
// _grpData call ["update"];
// hint str (_objData call ["troopsNeeded",["east"]]);
// private _objs  = _grpData call ["getNearObjectives"];
// hint str _objs;

/*********************************/

systemChat "devfiled read";