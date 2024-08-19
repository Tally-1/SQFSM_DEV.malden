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
// SQFM_fnc_addPosMarker = {};
// SQFM_fnc_drawObjectiveMarkers = {};
// SQFM_fnc_objectiveUpdateMarkers = {};
// SQFM_fnc_addCircleMarker = {};
// SQFM_fnc_addRectangleMarker = {};




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
    // ["mechUnload",                     SQFM_fnc_groupMechUnload],

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

    ["mechClearObjective",                SQFM_fnc_groupMechClearObjective],
    ["mechClearUrbanObjective",      SQFM_fnc_groupMechClearUrbanObjective],

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

// SQFM_fnc_flashActionMan = {};
// SQFM_fnc_man3dAction = {};
// SQFM_fnc_isUrbanArea = {};
// SQFM_fnc_objectiveSetUrbanStatus = {};
// SQFM_fnc_posArrToPath = {};
// SQFM_fnc_groupInfClearObjective = {};
// SQFM_fnc_groupInfClearUrbanObjective = {};
// SQFM_fnc_groupGetUrbanObjInfSearchP = {};
// SQFM_fnc_searchNearBuildings = {};
// SQFM_fnc_objectiveGetZoneMidPositions = {};
// SQFM_fnc_allBuildingsPositions = {};
// SQFM_fnc_getRoadData = {};
// SQFM_fnc_hashifyRoads = {};
// SQFM_fnc_roadIsZoneExit = {};
// SQFM_fnc_getZoneExitRoads = {};
// SQFM_fnc_getZoneRoadmap = {};
// SQFM_fnc_groupVehicleClearUrbanObjective = {};
// SQFM_fnc_groupVehicleClearObjective      = {};
// SQFM_fnc_zonePosArr = {};
// SQFM_fnc_zoneCone = {};
// SQFM_fnc_semiCirclePosArr = {};
// SQFM_fnc_objectiveGetZoneCone = {};
// SQFM_fnc_lineBroken = {};
// SQFM_fnc_manInFipo = {};
// SQFM_fnc_validMan = {};
// SQFM_fnc_functionalMan = {};
// SQFM_fnc_manEjectThenCover = {};
// SQFM_fnc_manEjectFromVehicle = {};
// SQFM_fnc_mechUnloadActivateMen = {};
// SQFM_fnc_deployVehicleSmoke = {};
// SQFM_fnc_getVehiclePassengers = {};
// SQFM_fnc_mechUnloadPositions = {};
// SQFM_fnc_mechUnloadEnd = {};
// SQFM_fnc_manCurrentBuilding = {};
// SQFM_fnc_validSurfaceIntersections = {};
// SQFM_fnc_getSuppressionTargetPosition = {};

// 
// [player, aa] call SQFM_fnc_getSuppressionTargetPosition;
/*
params [
	"_intersectPosASL",    // Position where line intersects surface
	"_surfaceNormal",     //  Vector normal to the intersected surface
	"_intersectObj",     //   Object the surface belongs to (proxy-object. Ex: The current weapon of a man)
	"_parentObject",    //    Proxy-objects parent. (Ex: The man holding said weapon)- objNull if terrain
	"_selectionNames", //     Array of Strings (Names of the intersected selections) (bones).
	"_pathToBisurf"   //      String - path to intersected surface properties (.bisurf) file.
];
*/

// SQFM_fnc_getBuildingSuppressionPos = {};
// SQFM_fnc_posOnVector = {};
// SQFM_fnc_getSuppressionTarget = {};
// SQFM_fnc_suppressionTargetValue = {};
// SQFM_fnc_zoneSuppressionTargets = {};