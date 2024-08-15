// SQFM_fnc_battleReinforceSide     = {};
// SQFM_fnc_initBattleMap            = {};
// SQFM_fnc_handleNewBattleGroups     = {};
// SQFM_fnc_handleInvalidBattleGroups  = {};
// SQFM_fnc_updateBattle                = {};
// SQFM_fnc_battleReinforcements         = {};
// SQFM_fnc_battleSideNeedsReinforcements = {};
// SQFM_fnc_zoneStrengthBySide           = {};
// SQFM_fnc_onTransportCrewFired        = {};
// SQFM_fnc_onPassengerFired           = {};
// SQFM_fnc_onPassengerHit            = {};
// SQFM_fnc_onTransportCrewHit       = {};
// SQFM_fnc_removeTransportEvents   = {};
// SQFM_fnc_setTransportEvents     = {};
// SQFM_fnc_transportInitTask     = {};
// SQFM_fnc_transportEnded       = {};
// SQFM_fnc_transportCondition  = {};
// SQFM_fnc_updateTransport    = {};
// SQFM_fnc_manGetBuilding    = {};
// SQFM_fnc_menInsideBuilding = {};
// SQFM_fnc_buildingPosCount  = {};
// SQFM_fnc_buildingArrData   = {};
// SQFM_fnc_getBuildingScore  = {};
// SQFM_fnc_sortBuildings     = {};
// SQFM_fnc_nearBuildings     = {};
// SQFM_fnc_manForceMoveToPos = {};
// SQFM_fnc_groupFlashAction  = {};
// SQFM_fnc_groupGetInBuilding = {};
// SQFM_fnc_groupGarrison      = {};
// SQFM_fnc_onCuratorWaypoint   = {};
// SQFM_fnc_groupUnstop          = {};
// SQFM_fnc_waypointIdleGarrison = {};
// SQFM_fnc_groupIdleGarrison   = {};



SQFM_fnc_addPosMarker = { 
params[
    ["_position", nil,         [[]]],
    ["_text",     nil,         [""]],
    ["_size",     1,            [0]],
    ["_type",    "hd_dot",     [""]],
    ["_color",   "ColorBlack", [""]]    
];

private _markerName  = [_type,"_",round random 1000000] joinString "";
private _marker = createMarkerLocal [_markerName, _position];

_markerName setMarkerTypeLocal _type;
_markerName setMarkerSizeLocal  [_size, _size];
_markerName setMarkerColorLocal _color;
_markerName setMarkerTextLocal _text;
_markerName setMarkerAlpha 1;

_markerName
};

SQFM_fnc_drawObjectiveMarkers = { 
params[
    ["_module", nil, [objNull]]
];
private _area   = [_module] call SQFM_fnc_getModuleArea;
private _pos    = _area#0;
private _a      = _area#1;
private _b      = _area#2;
private _dir    = _area#3;
private _radius = selectMax [100,_a,_b];
private _text   = [_module getVariable "objectiveType"] call SQFM_fnc_objectiveDescription;

private _centerMarker = [_pos, _text, 0.8,"mil_objective_noShadow"] call SQFM_fnc_addPosMarker;
private _areaMarker   = [_pos, _a, _b, _dir]  call SQFM_fnc_addRectangleMarker;
private _radiusMarker = [_pos, _radius]       call SQFM_fnc_addCircleMarker;

_radiusMarker setMarkerAlpha 0.5;
_centerMarker setMarkerAlpha 0.5;

[
    _centerMarker, 
    _areaMarker , 
    _radiusMarker
];
};

SQFM_fnc_objectiveUpdateMarkers = { 
if!(SQFM_debugMode)exitWith{};
private _owner = _self get "owner";
private _color = [_owner,true] call SQFM_fnc_sideColor;

{_x setMarkerColor _color} forEach (_self get "markers");

true;
};

SQFM_fnc_addCircleMarker = { 
params[
    ["_position", nil,          [[]]],
    ["_radius",   nil,           [0]],
    ["_brush",    "BORDER",     [""]],
    ["_color",    "ColorBlack", [""]]
];

private _markerName  = [round random 1000000, "_circleMarker"] joinString "";
private _marker = createMarker [_markerName, _position];

_markerName setMarkerShape "ELLIPSE";
_markerName setMarkerBrush _brush;
_markerName setMarkerSize  [_radius, _radius];
_markerName setMarkerColor _color;
_markerName setMarkerAlpha 1;


_markerName
};

SQFM_fnc_addRectangleMarker = { 
params[
    ["_position", nil,          [[]]],
    ["_a",        nil,           [0]],
    ["_b",        nil,           [0]],
    ["_dir",      nil,           [0]],
    ["_color",    "ColorBlack", [""]],
    ["_brush",    "BORDER",     [""]]    
];
private _markerName  = [round random 1000000, "_ellipseMarker"] joinString "";
private _marker = createMarker [_markerName, _position];

_marker setMarkerColorLocal _color;
_marker setMarkerDirLocal   _dir;
_marker setMarkerShapeLocal "RECTANGLE";
_marker setMarkerSizeLocal  [_a, _b];
_marker setMarkerBrushLocal _brush;
_marker setMarkerAlpha      1;

_marker;
};




SQFM_fnc_initGroupData     = { 
params [
    ["_group", nil, [grpNull]]
]; 
[_group] call SQFM_fnc_groupBehaviourSettings
params[
    ["_squadClass",    nil,    [""]],
    ["_defend",        nil,  [true]],
    ["_attack",        nil,  [true]],
    ["_hunt",          nil,  [true]],
    ["_huntDistance",  nil,     [0]],
    ["_huntKnowledge", nil,     [0]],
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
    ["huntCoolDown",      round time],
    ["lastReinfReq",           0-300],
    ["lastFireCheck",          0-300],
    ["grp",                   _group],
    ["owner",      groupOwner _group],
    ["side",             side _group],
    ["action",                    ""],
    ["state",                     ""],
	["groupType",          "unknown"],
    ["squadClass",       _squadClass],
    ["travelData",               nil],
    ["available",               true],
    ["awaitingReforce",        false],
    ["awaitingReplenish",      false],
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
    ["unitEvHandlers",            []],

    /******Behaviour settings*******/
    ["canDefend",                    _defend],
    ["canAttack",                    _attack],
    ["canHunt",                        _hunt],
    ["huntDistance",           _huntDistance],
    ["huntKnowledge",         _huntKnowledge],
    ["canReinforce",              _reinforce],
    ["canCallReinforcements", _callReinforce],
    ["canCallAir",                  _callAir],
    ["canCallArty",                _callArty]
];

private _data = createHashmapObject [_dataArr];

// All methods(functions) related to this hashmap is found at "functions\groups\fn_setGroupMethods.sqf"
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

_data set  ["initialStrength", _strength];
_data call ["update"];

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
    ["debugText",                       SQFM_fnc_groupDebugText],
    ["flashAction",                   SQFM_fnc_groupFlashAction],

    /*************************{MISC}***************************/
    ["isIdle",                             SQFM_fnc_groupIsIdle],
    ["isValid", {[(_self get "grp")] call SQFM_fnc_validGroup;}],
    ["activeWp",                              SQFM_fnc_activeWp],
    ["update",                             SQFM_fnc_groupUpdate],
    ["setDataDelayed",             SQFM_fnc_groupSetDataDelayed],
    ["addUnitEH",             SQFM_fnc_groupAddUnitEventHandler],
    ["removeUnitEH",       SQFM_fnc_groupRemoveUnitEventHandler],
    ["sinceSpawn",                 {time - (_self get "birth")}],
    // ["availableForNewTask",      SQFM_fnc_groupAvailableForTask],
    
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
    ["addWaypoint",                   SQFM_fnc_groupAddWayPoint],

                      /*{transport}*/
    ["canCallTransport",           SQFM_fnc_groupCanCallTransport],
    ["callTransport",                 SQFM_fnc_groupCallTransport],
    ["getTransportSpawner",     SQFM_fnc_groupGetTransportSpawner],
    ["sinceTransportCall", {time-(_self get "lastTransportCall")}],
    ["waitForTransportSpawn", SQFM_fnc_groupWaitForTransportSpawn],

                      /*{boarding}*/
    ["canSelfTransport",         SQFM_fnc_groupCanSelfTransport],
    ["enoughTransportNear",   SQFM_fnc_enoughGroupTransportNear],
    ["canBoardNow",                   SQFM_fnc_groupcanBoardNow],
    ["boardingStatus",             SQFM_fnc_groupBoardingStatus],
    ["isBoarded",     {_self call["boardingStatus"]=="boarded"}],
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
    ["isInsideObjective",                  SQFM_fnc_groupIsInsideObjective],
    ["canAssignObjective",                SQFM_fnc_groupCanAssignObjective],
    ["canLeaveObjective",                  SQFM_fnc_groupCanLeaveObjective],
    ["assignObjective",                      SQFM_fnc_groupAssignObjective],
    ["unAssignObjective",                  SQFM_fnc_groupUnAssignObjective],
    ["autoAssignObjective",              SQFM_fnc_groupAutoAssignObjective],
    ["assignAttackObjective",          SQFM_fnc_groupAssignAttackObjective],
    ["assignDefenseObjective",        SQFM_fnc_groupAssignDefenseObjective],
    ["canAttackOnly",                             SQFM_fnc_groupAttackOnly],
    ["canDefendOnly",                             SQFM_fnc_groupDefendOnly],
    ["takeObjective",                          SQFM_fnc_groupTakeObjective],
    ["attackObjective",                      SQFM_fnc_groupAttackObjective],
    ["endObjectiveAttack",                SQFM_fnc_groupEndObjectiveAttack],
    ["onObjectiveArrival",                SQFM_fnc_groupOnObjectiveArrival],
    ["guardObjective",                        SQFM_fnc_groupGuardObjective],
    ["objectiveData",                          SQFM_fnc_groupObjectiveData],
    ["typeMatchObjective",                SQFM_fnc_groupTypeMatchObjective],
    ["objectiveHostile",                    SQFM_fnc_groupObjectiveHostile],
    ["objectiveInsertPos",                SQFM_fnc_groupObjectiveInsertPos],
    ["objectiveInsertPosStandard",SQFM_fnc_groupObjectiveInsertPosStandard],
    ["objectiveInsertPosDanger",    SQFM_fnc_groupObjectiveInsertPosDanger],
    ["objectiveAttackLoop",              SQFM_fnc_groupObjectiveAttackLoop],
    ["objectiveAssignedHostiles",  SQFM_fnc_groupObjectiveAssignedHostiles],

    ["clearObjective",                        SQFM_fnc_groupClearObjective],
    ["infClearObjective",                  SQFM_fnc_groupInfClearObjective],
    ["infClearUrbanObjective",        SQFM_fnc_groupInfClearUrbanObjective],
    ["getUrbanObjInfSearchP",          SQFM_fnc_groupGetUrbanObjInfSearchP],

    ["vehicleClearObjective",          SQFM_fnc_groupVehicleClearObjective],
    ["vehicleClearUrbanObjective",SQFM_fnc_groupVehicleClearUrbanObjective],

    /**********************{REINFORCEMENTS}**********************/
    ["canGetReinforcements",    SQFM_fnc_groupCanCallReinforcements],
    ["ableToReinforce",               SQFM_fnc_groupAbleToReinforce],
    // ["needsReinforcments",         SQFM_fnc_groupNeedsReinforcments],
    ["callReinforcements",      SQFM_fnc_groupRequestReinforcements],
    ["callReinforcementRadio", SQFM_fnc_groupCallReinforcementRadio],
    ["addToReinfRequests",         SQFM_fnc_groupAddToReinfRequests],
    ["reinforce",                   SQFM_fnc_groupInitReinforceTask],
    ["onReinforceArrival",         SQFM_fnc_groupOnReinforceArrival],
    ["endReinforcing",                 SQFM_fnc_groupEndReinforcing],
    ["reinforceInsertPos",         SQFM_fnc_groupReinforceInsertPos],

    /************************{TASKS}****************************/
    ["initTask",                              SQFM_fnc_initTaskData],
    ["canRecieveTask",              SQFM_fnc_groupCanRecieveNewTask],
    ["initObjectiveTask",           SQFM_fnc_groupInitObjectiveTask],
    ["getAbilities",      {[_self] call SQFM_fnc_getGroupAbilities}],
    ["removeTask",                         SQFM_fnc_groupRemoveTask],
    ["hasTask", {str(_self call ["getTaskData"]) isNotEqualTo "[]"}],
    ["getTaskData",  {[_self get "grp"] call SQFM_fnc_getGroupTask}],
    ["actionStatus",                     SQFM_fnc_groupActionStatus],

    /**********************{TACTICS}***************************/
    ["garrison",                         SQFM_fnc_groupGarrison],
    ["getNearUrbanZones",       SQFM_fnc_groupGetNearUrbanZones],
    ["getInBuilding",               SQFM_fnc_groupGetInBuilding],
    ["idleGarrison",                 SQFM_fnc_groupIdleGarrison],
    ["initIdleGarrison",         SQFM_fnc_groupInitIdleGarrison],
    ["canIdleGarrison",           SQFM_fnc_groupCanIdleGarrison],

    /********************{GROUP MEMBERS}************************/
    ["getUnits",                                    SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",                        SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",               {(_self call ["getOwnVehicles"])#2}],
    ["isVehicleGroup",       {count(_self call ["nonCrewMen"])isEqualTo 0}],
    ["getGrpMembers",                               SQFM_fnc_getGrpMembers],
    ["anyValidMan",{[_self get "grp"] call SQFM_fnc_firstValidGroupMember}],
    ["getStrength",                              SQFM_fnc_getGroupStrength],
    ["strengthCoef",                            SQFM_fnc_groupStrengthCoef],
    ["setStrengthIcon",                      SQFM_fnc_groupSetStrengthIcon],
	["crewMen",                                         SQFM_fnc_groupCrew],
	["nonCrewMen",                                   SQFM_fnc_groupNonCrew],
    ["tallyAssets",                              SQFM_fnc_groupTallyAssets],
    ["getGroupCluster",                           SQFM_fnc_getGroupCluster],
    ["setGroupCluster",                           SQFM_fnc_setGroupCluster],
    ["getAvgPos",                                     SQFM_fnc_groupAvgPos],
    ["getStrSide",                                SQFM_fnc_groupGetStrSide],
    ["isPlayerGroup",       {[_self get"grp"] call SQFM_fnc_isPlayerGroup}],
    ["mergeWithGroup",                        SQFM_fnc_groupMergeWithGroup],
    ["unStop",                                        SQFM_fnc_groupUnstop],


    /**********************{REPLENISH}************************/
    ["canReplenish",                            SQFM_fnc_groupCanReplenish],
    ["canBeReplenished",                    SQFM_fnc_groupCanBeReplenished],
    ["canReplenishGroup",                  SQFM_fnc_groupCanReplenishGroup],
    ["canCombatReplenish",                SQFM_fnc_groupCanCombatReplenish],
    ["needsCombatReplenish",            SQFM_fnc_groupNeedsCombatReplenish],
    ["combatReplenish",                      SQFM_fnc_groupCombatReplenish],
    ["replenishGroup",                        SQFM_fnc_groupReplenishGroup],
    ["replenishDirect",                 SQFM_fnc_groupReplenishGroupDirect],    
    

	/**********************{GROUP CLASS}************************/
	["isUnarmedMotorized",              SQFM_fnc_groupIsUnarmedMotorized],
	["isInfantrySquad",                    SQFM_fnc_groupIsInfantrySquad],
	["getGroupType",                                  SQFM_fnc_groupType],
	["setGroupType", {_self set["groupType",_self call["getGroupType"]]}],

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
    ["endReturnFire",   {_self spawn SQFM_fnc_endGrpReturnFire}],

    ["nearEnemyGrp",                 SQFM_fnc_groupNearEnemyGrp],
    ["attackGroup",                   SQFM_fnc_groupAttackGroup],
    ["updateBattleStrength", SQFM_fnc_groupUpdateBattleStrength],
    ["combatZone",                     SQFM_fnc_groupCombatZone],

    /**********************{Hunting}***************************/
    ["initHunt",                         SQFM_fnc_groupInitHunt],
    ["initHuntTask",                 SQFM_fnc_groupInitHuntTask],
    ["ableToHunt",                     SQFM_fnc_groupAbleToHunt]
];

{
    private _name = _x#0;
    private _code = _x#1;
    _groupData set [_name, _code];
    
} forEach _methods;

true;
};




SQFM_fnc_setObjectiveData = { 
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
private _buildings    = [_position, _radius] call SQFM_fnc_nearBuildings;
private _isUrbanArea  = (_type isEqualTo "town");//||{[_position, _radius, _buildings] call SQFM_fnc_isUrbanArea};
private _urbanZones   = [_buildings] call SQFM_fnc_getUrbanZones;
private _owner        = sideUnknown;
private _sides        = [];
private _assetTypes   = [];
private _markers      = if(SQFM_debugMode)then{[_module] call SQFM_fnc_drawObjectiveMarkers}else{[]};

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
    ["markers",                                             _markers],
    ["position",                                           _position],
    // ["posgrid",                                                   []],
	["area",                                                   _area],
	["zone",                                                   _zone],
	["buildings",                                         _buildings],
    ["isUrbanArea",                                     _isUrbanArea],
    ["urbanZones",                                       _urbanZones],
    ["roadmap",                   _zone call SQFM_fnc_getZoneRoadmap],
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
    ["safePosSearches",                                           []],

    /*************************{DEBUG-DATA}**************************/
    ["defaultIcon",    "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    ["contestedIcon",    "\A3\ui_f\data\map\markers\military\warning_CA.paa"],
    ["capturedIcon",     "\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"],
    ["3dData",                                                       _data3d],
    ["3dColor",                           ([_owner] call SQFM_fnc_sideColor)]
];


private _data = createhashMapObject [_dataArr];
[_data] call SQFM_fnc_setObjectiveMethods;
_data   call ["updateMarkers"];

// For some reason the urbanStatus function returns a false negative if called too soon.
_data spawn{sleep 1; _this call ["setUrbanStatus"]};
// _data   call ["setPosgrid"];

_module setVariable ["SQFM_objectiveData", _data, true];

_data;
};



SQFM_fnc_setObjectiveMethods = { 
params[
    ["_data",nil,[createHashmap]]
];
private _globalizeFnc      = {(_self get "module") setVariable ["SQFM_objectiveData", _self, true]};
private _getUrbanPositions = {(_self get"urbanZones")apply{_x get "position"}};
private _methods =
[
    ["getGroupsInZone",   {(_self get"zone") call SQFM_fnc_groupsInZone}],
    ["timeSinceCapture",               {time - (_self get"captureTime")}],
    ["getSidesInZone",                  SQFM_fnc_objectiveGetSidesInZone],
    ["getZoneMidPositions",        SQFM_fnc_objectiveGetZoneMidPositions],
    ["getUrbanPositions",                             _getUrbanPositions],

    // ["initRoadmap",                        SQFM_fnc_objectiveInitRoadmap],

    ["getAssignedAssets",            SQFM_fnc_objectiveGetAssignedAssets],
    ["countAssignedAssets",        SQFM_fnc_objectiveCountAssignedAssets],
    ["getContested",                      SQFM_fnc_objectiveGetContested],
    ["setContested",                      SQFM_fnc_objectiveSetContested],
    ["inBattle",          {_self get"zone"call SQFM_fnc_posInBattleZone}],
    ["update",                                  SQFM_fnc_objectiveUpdate],
    ["onCapture",                            SQFM_fnc_objectiveOnCapture],
    ["updateMarkers",                    SQFM_fnc_objectiveUpdateMarkers],
    ["troopsNeeded",                       SQFM_fnc_objectiveNeedsTroops],
    ["assignGroup",                        SQFM_fnc_objectiveAssignGroup],
    ["unAssignGroup",                    SQFM_fnc_objectiveUnAssignGroup],
	["draw3D",                              SQFM_fnc_drawObjectiveModule],
    ["storeSafePosSearch",          SQFM_fnc_objectiveStoreSafePosSearch],
    ["removeSafePosSearches",    SQFM_fnc_objectiveRemoveSafePosSearches],
    ["setUrbanStatus",                  SQFM_fnc_objectiveSetUrbanStatus],
    ["setMethods",           {[_self] call SQFM_fnc_setObjectiveMethods}],
    ["getZoneCone",                        SQFM_fnc_objectiveGetZoneCone],
    // ["setPosgrid"                           SQFM_fnc_objectiveSetPosgrid],
    ["globalize",                                          _globalizeFnc]
];
// 
{
    private _name = _x#0;
    private _code = _x#1;
    _data set [_name, _code];
    
} forEach _methods;

true;
};

SQFM_fnc_isUrbanArea = { 
params[
    ["_position",  nil, [[]]],
    ["_radius",     nil, [0]],
    ["_buildings", nil, [[]]]
];
private _urbanCoef = _this call SQFM_fnc_zoneUrbanCoef;
private _minCoef   = 0.22;
if(_urbanCoef >= _minCoef)exitWith{true};

false;
};


SQFM_fnc_objectiveSetUrbanStatus = { 
private _roadCount = count (_self get"roadmap"get"roads");
if(_roadCount < 10)exitWith{_self set["isUrbanArea",false]};

private _position  = (_self get "zone")#0;
private _radius    = (_self get "zone")#1;
private _buildings = _self get "buildings";
private _urbanArea = [_position, _radius, _buildings] call SQFM_fnc_isUrbanArea;
if!(_urbanArea)exitWith{_self set["isUrbanArea",false]};

_self set["isUrbanArea",true];
};



SQFM_fnc_posArrToPath = { 
params[
    ["_startPos", nil,[[]]],
	["_posArr",   nil,[[]]]
];
private _curPos          = _startPos;
private _sortedPositions = [];
private _posCount        = count _posArr;

for "_i"from 1 to _posCount do { 
    private _nextPos = [_curPos, _posArr] call SQFM_fnc_getNearest;
    _sortedPositions pushBackUnique _nextPos;
    _curPos = _nextPos;
    _posArr = _posArr select {!(_x in _sortedPositions)};
};

_sortedPositions;
};

SQFM_fnc_groupInfClearObjective = { 
params[
    ["_objective",nil,[objNull]]
];

private _objData         = _objective call getData;
private _center          = (_objData get "zone")#0;
private _radius          = ((_objData get "zone")#1)*0.8;
private _posCount        = 6;
private _endFunction     = 'SQFM_fnc_endTaskGroup';
private _startPos        = _self call ["getAvgPos"];
private _edgePositions   = [_center, _radius, _posCount] call SQFM_fnc_pos360;
private _pathPositions   = [_startPos, _edgePositions] call SQFM_fnc_posArrToPath;


_pathPositions pushBackUnique _center;

{_self call ["addWaypoint", [_x, 20]]}forEach _pathPositions;


// Place the last waypoint at a random position inside the objective radius
_self call ["addWaypoint", [_center,5,"MOVE", _endFunction,nil,nil,_radius]];

_pathPositions;
};



SQFM_fnc_groupInfClearUrbanObjective = { 
params[
    ["_objective",nil,[objNull]]
];
private _searchPositions = _self call ["getUrbanObjInfSearchP",[_objective]];
if(_searchPositions isEqualTo [])
exitWith{
    "No urban zones found" call dbgm;
    _self call ["infClearObjective",[_objective]];
};

private _wpFnc      = "SQFM_fnc_searchNearBuildings";
private _endFnc     = "SQFM_fnc_endTaskGroup";
private _endParams  = [_center,5,"MOVE", _endFnc,"AWARE","NORMAL",_radius];

{
    private _wpParams = [_x,10,"MOVE",_wpFnc,"AWARE","NORMAL",10];
    _self call ["addWaypoint", _wpParams]

}forEach _searchPositions;

_self call ["addWaypoint", _endParams];
_self set  ["action", "Clearing Urban Objective"];

true;
};

SQFM_fnc_groupGetUrbanObjInfSearchP = { 
params[
    ["_objective",nil,[objNull]]
];
private _objData         = _objective call getData;
private _startPos        = _self call ["getAvgPos"];
private _center          = _objData get "position";
private _dir             = _center getDir _startPos;
private _posCount        = 6;
private _midPositions    = _objData call ["getZoneMidPositions",[_dir, _posCount]];
private _urbanPositions  = _objData call ["getUrbanPositions"];
private _searchPositions = [];

if(_urbanPositions isEqualTo [])exitWith{[]};

{
    private _searchPos = [_x, _urbanPositions] call SQFM_fnc_getNearest;
    if(_searchPos in _searchPositions)then{_searchPos = _x};

    _searchPositions pushBackUnique _searchPos;
    
} forEach _midPositions;
private _finalSearchPos = [_center, _urbanPositions] call SQFM_fnc_getNearest;
private _pathPositions  = [_startPos, _searchPositions] call SQFM_fnc_posArrToPath;

_pathPositions pushBackUnique _finalSearchPos;

[_pathPositions] call SQFM_fnc_showPosArr3D;

_pathPositions;
};


SQFM_fnc_searchNearBuildings = { 
params[
    ["_group", nil,[grpNull]],
    ["_rad",   50,       [0]]
];
private _leader    = leader _group;
private _data      = _group call getData;
private _pos       = getPosATLVisual _leader;
private _buildings = [_pos, _rad] call SQFM_fnc_nearBuildings;
private _bldPosArr = [_buildings, _pos] call SQFM_fnc_allBuildingsPositions;
private _men       = _data call ["getUnitsOnfoot"];
private _endIndex  = count _men -1;


{
    if(_foreachIndex >= _endIndex)exitWith{};
    private _targetPos = _x;
    private _man       = _men#_foreachIndex;
    private _time      = round(_man distance _targetPos)+15;
    private _onMoveEnd = [_man, {_this setVariable ["SFSM_Excluded",false,true]}];
    private _condition = [_man, {currentCommand _this isEqualTo "SCRIPTED"}];

    _man setVariable ["SFSM_Excluded",true,true];
    [_man, _targetPos, _time,3,_onMoveEnd,_condition] spawn SQFM_fnc_fsmMoveManToPos;
    
} forEach _bldPosArr;

true;
};


SQFM_fnc_objectiveGetZoneMidPositions = { 
params[
    ["_dir",       0,        [0]],
    ["_posCount",  4,        [0]],
    ["_randomRad", false, [true]]
];
private _center    = (_self get "zone")#0;
private _radius    = (_self get "zone")#1;
private _dir       = _startPos getDir _center;
private _altitude  = 0;
private _coef      = if(_randomRad)then{0.5}else{0.35+(random 0.55)};

// This ensures we get positions between the center and the edge of the objective
// The random coef is usefull to make ai pathing unpredictable for the player.
// The output of the random coef is 35-90% of the zone radius.
_radius = _radius * _coef;

private _positions = [_center, _radius, _posCount, _altitude, _dir] call SQFM_fnc_pos360;

_positions;
};

SQFM_fnc_allBuildingsPositions = { 
params[
    ["_buildings",nil,[[]]],
    ["_startPos", nil,[[]]]   // If declared it will be used to sort the positions according to distance.
];
private _positions = [];

{
    _positions insert [(count _positions), _x buildingPos -1,true];
    
} forEach _buildings;

if(!isNil "_startPos")then{
    _positions = [_positions, [], {_startPos distance _x}, "ASCEND"] call BIS_fnc_sortBy;
};

_positions;
};


SQFM_fnc_getRoadData = { 
params[
    ["_roadSegment",nil,[objNull]]
];getRoadInfo _roadSegment
params[
    ["_type",         nil,   [""]],
    ["_width",        nil,    [0]],
    ["_pedestrian",   nil, [true]],
    ["_texture",      nil,   [""]],
    ["_textureEnd",   nil,   [""]],
    ["_material",     nil,   [""]],
    ["_begPos",       nil,   [[]]],
    ["_endPos",       nil,   [[]]],
    ["_isBridge",     nil, [true]],
    ["_AIpathOffset", nil,    [0]]
];
// private _shape     = [_roadSegment] call SQFM_fnc_objectShape;
private _length    = _begPos distance2D _endPos;//(_shape get "length")+0;
private _dir       = _begPos getDir _endPos; //getDirVisual _roadSegment;
private _position  = getPosATLVisual _roadSegment;
private _connected = roadsConnectedTo _roadSegment;
private _dataArr = [
    ["type",                _type],
    ["segment",      _roadSegment],
    ["position",        _position],
    ["dir",                  _dir],
    ["width",              _width],
    ["length",            _length],
    ["pedestrian",    _pedestrian],
    ["startPos",          _begPos],
    ["endPos",            _endPos],
    ["isBridge",        _isBridge],
    ["connected",      _connected]
];

private _hashmap = createHashmapObject [_dataArr];

_hashmap;
};


SQFM_fnc_hashifyRoads = { 
params[
    ["_roadArr",nil,[[]]]
];
private _validTypes   = ["ROAD", "MAIN ROAD", "TRACK", "TRAIL"];
private _roadHashmaps = [];

{
    private _hashmap   = [_x] call SQFM_fnc_getRoadData;
    private _validType = (_hashmap get "type") in _validTypes;
    private _canDrive  = (_hashmap get "pedestrian") isEqualTo false;
    private _valid     = _validType && {_canDrive};
    if(_valid)
    then{_roadHashmaps pushBack _hashmap};

} forEach _roadArr;

_roadHashmaps;
};


SQFM_fnc_roadIsZoneExit = { 
params[
    ["_pos",  nil,            [[]]],
    ["_rad",  nil,             [0]],
    ["_road", nil, [createHashmap]]  // Hashmaps extracted by using SQFM_fnc_getRoadData on a roadsegment.
];
private _validTypes = ["ROAD", "MAIN ROAD", "TRACK"];
private _thisType   = _road get "type";
if!(_thisType in _validTypes)exitWith{false};

private _connecters   = _road get "connected";
private _outLiers     = _connecters select {(getpos _x distance2D _pos)>_rad};

if(_outLiers isEqualTo _connecters) exitWith{false};
if(_outLiers isEqualTo [])          exitWith{false};
if(count _outLiers > 1)             exitWith{false};

// find out if the next segment connected to the road is back inside the zone.
// private _all      = [_road get "segment", _connecters];
// private _outLier1 = _outLiers#0;
// private _insiders = roadsConnectedTo _outLier1 select{(!(_x in _all)) && {_x distance _pos < _rad}};
// if(_outLiers isNotEqualTo [])exitWith{false};

true;
};


SQFM_fnc_getZoneExitRoads = { 
params[
    ["_pos",   nil, [[]]],
    ["_rad",   nil,  [0]],
    ["_roads", nil, [[]]]  // array of hashmaps extracted by using SQFM_fnc_hashifyRoads on an array of roadsegments.
];
private _exits = [];


{
    if([_pos,_rad,_x] call SQFM_fnc_roadIsZoneExit)
    then{_exits pushBack _x};
    
} forEach _roads;


_exits
};



SQFM_fnc_getZoneRoadmap = { 
params[
    ["_pos", nil, [[]]],
    ["_rad", nil,  [0]]
];
private _roads         = [_pos nearRoads _rad] call SQFM_fnc_hashifyRoads;
private _positions     = _roads apply {_x get "position"};
private _exits         = [_pos, _rad, _roads] call SQFM_fnc_getZoneExitRoads;
private _exitPositions = _exits apply {_x get "position"};

private _dataArr = [
    ["roads",                 _roads],
    ["positions",         _positions],
    ["exits",                 _exits],
    ["exitPositions", _exitPositions]
];

private _roadMap = createHashmapObject[_dataArr];

_roadMap;
};


SQFM_fnc_groupVehicleClearUrbanObjective = { 
"Vehicle clearing Urban objective" call dbgm;
params[
    ["_objective",nil,[objNull]]
];
private _objData    = _objective call getData;
private _center     = _objData get "position";
private _startPos   = _self call ["getAvgPos"];
private _roadMap    = _objData get "roadmap";
private _roads      = (_roadMap get "positions");//select{[_x, false, 8, 3]call SQFM_fnc_clearPos};
private _centerRoad = [_center, _roads] call SQFM_fnc_getNearest;
private _exits      = _roadMap get "exitPositions";

if([_centerRoad, false, 8, 3]call SQFM_fnc_clearPos)
then{_exits pushBackUnique _centerRoad};

private _pathPositions = [_startPos, _exits] call SQFM_fnc_posArrToPath;

[_pathPositions] call SQFM_fnc_showPosArr3D;

private _endFnc = "SQFM_fnc_endTaskGroup";
private _endPos = selectRandom _roads;

{_self call ["addWaypoint", [_x,5]]}forEach _pathPositions;
_self call ["addWaypoint", [_endPos,0,"MOVE",_endFnc]];

};


SQFM_fnc_groupVehicleClearObjective = { 
"Vehicle clearing standard objective"call dbgm;
params[
    ["_objective",nil,[objNull]]
];
private _group         = _self get "grp";
private _objData       = _objective call getData;
private _center        = _objData get "position";
private _radius        = (_objData get "zone")#1;
private _startPos      = _self call ["getAvgPos"];
private _roadMap       = _objData  get "roadmap";
private _roads         = (_roadMap get "positions");
private _centerRoad    = [_center, (_roads select {_x distance2D _center < 75})] call SQFM_fnc_getNearest;
private _conePositions = _objData call ["getZoneCone",[_startPos,0,180]];
private _targetPos     = if(!isNil "_centerRoad")then{_centerRoad}else{_center};
private _vehicle       = vehicle leader _group;
private _ignoreObjs    = [_vehicle];
private _endFunction   = 'SQFM_fnc_endTaskGroup';
private _firePositions = _conePositions select {
    private _z         = 1.5;
    private _firePos   = ATLToASL [_x#0,_x#1, _z];
    private _targetPos = ATLToASL [_targetPos#0,_targetPos#1, _z];
    private _valid     = [_x] call SQFM_fnc_clearPos && {!([_firePos,_targetPos,_ignoreObjs] call SQFM_fnc_lineBroken)};
    
    (!isNil "_valid"&&{_valid});
};

if(_firePositions isNotEqualTo [])then{
    private _firePos = selectRandom _firePositions;
    _self call ["addWaypoint", [_firePos]];
};

_self call ["addWaypoint", [_targetPos,20,"MOVE", _endFunction,nil,nil,_radius]];

true;
};


SQFM_fnc_zonePosArr = { 
params [
    ["_pos",     nil,  [[]]], // Center position of the zone
    ["_rad",     nil,   [0]],  // Radius of the zone
    ["_posDist", 10,    [0]] 
];

private _positions = []; // Array to store the positions

// Iterate over the radius, generating semicircles with decreasing radii
for "_r" from _rad to 0 step -_posDist do { 
    if(_r < _posDist)exitWith{};

    private _semiCirclePositions = [[_pos, _r],0, 359, _posDist] call SQFM_fnc_semiCirclePosArr;
    private _lastIndex = count _semiCirclePositions-1;
    private _first     = _semiCirclePositions#0;
    private _last      = _semiCirclePositions#_lastIndex;
        
    if(_first distance2D _last < _posDist)
    then{
        _semiCirclePositions deleteAt _lastIndex;
        _lastIndex = count _semiCirclePositions-1;
        _last      = _semiCirclePositions#_lastIndex;
        if(_first distance2D _last < _posDist)
        then{_semiCirclePositions deleteAt _lastIndex};
    };

    _positions append _semiCirclePositions;
};

_positions;
};

SQFM_fnc_zoneCone = { 
params [
    ["_pos",         nil,  [[]]],  // Center position of the zone
    ["_rad",         nil,   [0]],  // Radius of the zone
    ["_dir",         nil,   [0]],  // Direction of cone
    ["_width",       nil,   [0]],  // Width (in degrees) of the cone
    ["_clearRad",    nil,   [0]],  // Radius at which the cone starts
    ["_posDist",     10,    [0]],  // Distance between positions
    ["_maxPosCount", nil,   [0]]   // Max number of positions to return
];

private _positions = []; // Array to store the positions

// Adjust _posDist based on _maxPosCount if specified
if (!isNil "_maxPosCount") then {
            // Estimate the number of positions we would get with the original _posDist
        private _estPosCount = (_rad / _posDist) * (_width / 360) * 2 * 3.14159265358979323846 * (_rad / _posDist);
        
        if (_estPosCount > _maxPosCount) then {
            _posDist = _posDist * sqrt(_estPosCount / _maxPosCount);
        };
};

// Iterate over the radius, generating semicircles with decreasing radii
for "_r" from _rad to 0 step -_posDist do { 
    if(_r < _clearRad) exitWith{};
    if(_r < _posDist)  exitWith{};

    private _conePositions = [[_pos, _r], _dir, _width, _posDist] call SQFM_fnc_semiCirclePosArr;
    private _lastIndex = count _conePositions-1;
    private _first     = _conePositions#0;
    private _last      = _conePositions#_lastIndex;

    _positions append _conePositions;

    // Stop if _maxPosCount is reached
    if (!isNil "_maxPosCount" && {count _positions >= _maxPosCount}) exitWith {
        _positions resize _maxPosCount;
    };
};

_positions;
};

SQFM_fnc_objectiveGetZoneCone = { 
private _zone = _self get"zone";
private _pos  = _zone#0;
private _rad  = _zone#1;
params[
    ["_startPos",  nil,    [[]]],
    ["_overLap",   30,      [0]],
    ["_coneWidth", 180,     [0]],  // degrees wide 
    ["_minDepth",  100,     [0]],
    ["_sort",      true, [true]]
];
private _dir         = _pos getDir _startPos;
private _coneDepth   = selectMax [_minDepth,_rad*0.5]; // How much is added to the original radius 
private _coneStart   = _rad-_overLap;
private _coneRad     = _coneStart+(_coneDepth);
private _maxPosCount = 150;
private _zoneCone    = [_pos, _coneRad, _dir, _coneWidth, _coneStart, 30,_maxPosCount] call SQFM_fnc_zoneCone;

if(_sort)
then{_zoneCone=[_zoneCone,[],{_startPos distance _x},"ASCEND"]call BIS_fnc_sortBy};

_zoneCone;
};


SQFM_fnc_lineBroken = { 
params[
	["_startPosASL", nil,          [[]]],
	["_endPosASL",   nil,          [[]]],
    ["_ignoreList",  [],           [[]]]
];
private _count  = count _ignoreList;
private _needed = 2-_count;
if(_needed > 0)
then{
    for"_i"from 1 to _needed do
    {_ignoreList pushBack objNull}
};

private _linebreaks = lineIntersectsSurfaces [_startPosASL, _endPosASL, (_ignoreList#0), (_ignoreList#1), true, 5];

// Select objects that are not men, nor in the ignoreList
_linebreaks = _linebreaks select { 
    private _object         = _x#3;
    private _isMan          = _object isKindOf "man";// isEqualTo false;
    private _ignored        = _object in _ignoreList;
    private _validLineBreak = (_isMan isEqualTo false && {_ignored isEqualTo false})||{isNull _object};
    
    _validLineBreak;
};

private _broken = _linebreaks isNotEqualTo [];

_broken;
};