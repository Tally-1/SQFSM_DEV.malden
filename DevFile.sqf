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
// 
SQFM_fnc_initGroupData = { 
params [
    ["_group", nil, [grpNull]]
]; 
[_group] call SQFM_fnc_groupBehaviourSettings
params[
    ["_squadClass",    nil,    [""]],
    ["_defend",        nil,  [true]],
    ["_attack",        nil,  [true]],
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
    ["lastReinfReq",           0-300],
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

SQFM_fnc_setGroupMethods = { 
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
    ["update",                             SQFM_fnc_groupUpdate],
    ["setDataDelayed",             SQFM_fnc_groupSetDataDelayed],
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

    /**********************{REINFORCEMENTS}**********************/
    ["canCallReinforcements",   SQFM_fnc_groupCanCallReinforcements],
    ["needsReinforcments",         SQFM_fnc_groupNeedsReinforcments],
    ["callReinforcements",      SQFM_fnc_groupRequestReinforcements],
    ["callReinforcementRadio", SQFM_fnc_groupCallReinforcementRadio],
    ["addToReinfRequests",         SQFM_fnc_groupAddToReinfRequests],
    ["reinforce",                   SQFM_fnc_groupInitReinforceTask],
    ["onReinforceArrival",         SQFM_fnc_groupOnReinforceArrival],
    ["endReinforcing",                 SQFM_fnc_groupEndReinforcing],

    /************************{TASKS}****************************/
    ["initTask",                              SQFM_fnc_initTaskData],
    ["initObjectiveTask",           SQFM_fnc_groupInitObjectiveTask],
    ["getAbilities",      {[_self] call SQFM_fnc_getGroupAbilities}],

    /**********************{TACTICS}***************************/
    ["garrison",                         SQFM_fnc_groupGarrison],

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
    ["endReturnFire",   {_self spawn SQFM_fnc_endGrpReturnFire}],

    ["nearEnemyGrp",                 SQFM_fnc_groupNearEnemyGrp],
    ["attackGroup",                   SQFM_fnc_groupAttackGroup],
    ["combatZone",                     SQFM_fnc_groupCombatZone]
];

{
    private _name = _x#0;
    private _code = _x#1;
    _groupData set [_name, _code];
    
} forEach _methods;

true;
};

// SQFM_fnc_setObjectiveData    = {};
// SQFM_fnc_setObjectiveMethods = {};

/*********************************/

// SQFM_fnc_fiveMinTasks={};
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
// SQFM_fnc_groupAttackOnly = {};
// SQFM_fnc_groupDefendOnly = {};
// SQFM_fnc_formatDirRanges = {};
// SQFM_fnc_inDirRange      = {};
// SQFM_fnc_formatDir                       = {};
// SQFM_fnc_lineBroken                      = {};
// SQFM_fnc_enemiesInZone                   = {};
// SQFM_fnc_clustersFromObjArr              = {};
// SQFM_fnc_posHasTerrainCover              = {};
// SQFM_fnc_posIsHidden                     = {};
// SQFM_fnc_selectSafePositions             = {};
// SQFM_fnc_objectiveRemoveSafePosSearches  = {};
// SQFM_fnc_objectiveStoreSafePosSearch     = {};
// SQFM_fnc_dangerZoneSafePositions         = {};
// SQFM_fnc_groupObjectiveInsertPosDanger   = {};
// SQFM_fnc_groupObjectiveInsertPos         = {};
// SQFM_fnc_objectiveSafeposMatch           = {};
// SQFM_fnc_objectiveGetStoredSafePositions = {};
// SQFM_fnc_describeDistance    = {};
// SQFM_fnc_describeDir         = {};
// SQFM_fnc_getLocationNamePos  = {};
// SQFM_fnc_closestLocationName = {};
// SQFM_fnc_areaName            = {};
// SQFM_fnc_getCategorizedGroups       = {};
// SQFM_fnc_assignAttackGroups         = {};
// SQFM_fnc_assignAllGroupTasks        = {};
// SQFM_fnc_groupInitObjectiveTask     = {};
// SQFM_fnc_group_validObjective       = {};
// SQFM_fnc_groupGetNearObjectives     = {};
// SQFM_fnc_groupAssignAttackObjective = {};
// SQFM_fnc_groupAutoAssignObjective   = {};
// SQFM_fnc_groupTakeObjective         = {};
// SQFM_fnc_groupObjectiveHostile      = {};
// SQFM_fnc_groupOnObjectiveArrival    = {};
// SQFM_fnc_groupUnAssignObjective     = {};
// SQFM_fnc_groupIsInsideObjective     = {};
// SQFM_fnc_groupObjectiveAttackLoop   = {};
// SQFM_fnc_groupEndObjectiveAttack    = {};
// SQFM_fnc_groupAttackObjective       = {};
// SQFM_fnc_objectiveOnCapture         = {};
// SQFM_fnc_getCategorizedGroups        = {};
// SQFM_fnc_assignAllGroupTasks         = {};
// SQFM_fnc_assignGroupsAndObjectives   = {};
// SQFM_fnc_groupAutoAssignObjective    = {};
// SQFM_fnc_groupAssignDefenseObjective = {};

/************************TODO list*******************************/

/*
TODO:
-Complete- 1)  Fix bug where some available Squads are not assigned.
-Complete- 2)  Limit battle-size -min/max- (Important in order to implement reinforcements)
-Complete- 3)  Set building changed eventhandler for BFFs and Objectives (In order to implement defensive tactics)
-Complete- 4)  Make sure Objectives are actually captured
-Complete- 5)  Make attack-only squads keep pushing to the next Objective once the current one is taken.
-Complete- 6)  Send defensive squads.

7)  Call/Send reinforcements.
    - Call function:
        * Sends a request via radio.
        * Request data is stored in an array (Pos, caller, time sent)
        * Request is responded to on group assignment loop.
    - Send function.
        (complete) * Checks all requests and sorts them by time sent.
        (canceled) * Each ReInf squad is selected by proximity of strength to enemy target.
        * Requests that cannot be fulfilled are denied via radio.
        * Denied requests are deleted from request Array.
    - Can request function:
        * If a squad already has a reinforcement request it cannot send another.
        * A squad needs to be inside a battle-zone to request reinforcements.
        * (optional) There needs to be
    - Can respond:
        * Squad is currently not in a fight.
        * Squad is not already responding to a request.
        * Squad does not have any current tasks.
        * Squad is set to allow reinforcing (Via module, default = true)

8)  Combat insertion.
9)  Transport react to fire / Enemy spotted.
10) Transport Pickup fail handling.
11) Battlefield Map markers
12) Objective   Map markers
13) Redo State entry.
    - Eliminated
    - In transport
    - In battle
    - ""(normal/idle)
14) Control action status (remove states as action)
15) Do the taskmanager in a forEachFrame loop to avoid scheduler issues.
*/
/********************New Functions/Methods*****************************/

// SQFM_fnc_validEnum = {};
// SQFM_fnc_delayedBaseSideChat         = {};
// SQFM_fnc_groupCallReinforcementRadio = {};
// SQFM_fnc_initReinforRequestsMap      = {};
// SQFM_fnc_groupAddToReinfRequests     = {};
// SQFM_fnc_getNearestGroup             = {};
// SQFM_fnc_reinfRequestRadioResponse   = {};
// SQFM_fnc_sendReinfRadioResponse      = {};
// SQFM_fnc_groupSetStrengthIcon        = {};
// SQFM_fnc_groupStrengthCoef           = {};
// SQFM_fnc_groupNearEnemyGrp           = {};
// 
// SQFM_fnc_groupAddWayPoint            = {};

// SQFM_fnc_groupMergeWithGroup         = {};
// SQFM_fnc_groupAttackGroup            = {};
// SQFM_fnc_groupEndReinforcing = {};

SQFM_fnc_groupInitReinforceTask = { 
_self call ["deleteWaypoints"];
_this pushBack _self;
_this spawn{
params[
    ["_callPos",   nil,            [[]]], // The position the call was made from.
    ["_callerGrp", nil,       [grpNull]], // The group who made the request. 
    ["_time",      nil,             [0]], // Time when the request for reinforcement was made.
    ["_self",      nil, [createHashmap]]  // the hashmapObject belonging to the responding group (this group)
];
private _canTravel = _self call ["initTravel",[_callPos]];
if!(_canTravel)
exitWith{"Could not travel to reinforce squad." call dbgm;};

private _group       = _self get "grp";
private _posName     = [_callPos] call SQFM_fnc_areaName;
private _callerData  = _callerGrp call getData;
private _battlefield = _callerData call ["getBattle"];
private _taskName    = ["Reinforce ", (_callerData get "groupType"), " at ", _posName]joinString"";
private _taskParams  = [_callPos, _callerGrp];
private _zone        = [_callPos, 300];
private _arrivalCode = {(_self call ["ownerData"]) call ["onReinforceArrival"]};
private _endCode     = {(_self call ["ownerData"]) call ["endReinforcing"]};

if!(isNil "_battlefield")
then{
    _taskParams pushBack _battlefield;
    (_battlefield get "activeReinforcements") pushBackUnique _group;
};

private _task = _self call ["initTask",
[
    _taskName,     // Taskname     ["name"]
    _zone,         // Task zone    ["zone"]
    [_callPos],    // Positions    ["positions"]
    _taskParams,   // TaskParams   ["params"]
    _arrivalCode,  // Arrival-code ["arrivalCode"]
    _endCode       // End-code     ["endCode"]
]];

sleep 2;
private _travelData       = _self get "travelData";
private _transportVehicle = _self get "transportVehicle";
private _validVehicle     = (!isNil "_transportVehicle")&&{alive _transportVehicle};

if((isNil "_travelData")
&&{_validVehicle isEqualTo false})
exitWith{"No traveldata" call dbgm};


if(_validVehicle isEqualTo false)
exitWith{[_group, (currentWaypoint _group)] setWaypointCompletionRadius 300};

private _transportGroup  = group driver _transportVehicle;
private _wpG = (waypoints _group)#2;
private _wpT = (waypoints _transportGroup)#2;

_wpG setWaypointCompletionRadius 300;
_wpT setWaypointCompletionRadius 300;

"wayPoint comp rad has been set to 300" call dbgm;

true;
}
};

SQFM_fnc_groupSetDataDelayed = { 
params[
    "_key",
    "_value", 
    ["_delay",0,[0]]
];
[_self, _key, _value, _delay]spawn{
params["_self","_key","_value", "_delay"];
sleep _delay;
_self set [_key, _value];
true;
}};


SQFM_fnc_assignGroupObjectivesAllSides = { 
params[
    ["_groupMap",  nil,[createHashmap]],
    ["_groupType", nil,           [""]]
];
private _groups = [];

_groups append([_groupMap, _groupType, east]        call SQFM_fnc_assignGroupsAndObjectives);
_groups append([_groupMap, _groupType, west]        call SQFM_fnc_assignGroupsAndObjectives);
_groups append([_groupMap, _groupType, independent] call SQFM_fnc_assignGroupsAndObjectives);

_groupMap call ["removeMultiple",[_groups]];

true;
};

SQFM_fnc_assignAllGroupTasks = { 
if (true) exitWith {};

private _allSentMsg = { "All Available groups have been assigned" call dbgm;nil;};
private _groupMap   = call SQFM_fnc_getCategorizedGroups;

[_groupMap, "recon"] call SQFM_fnc_assignGroupObjectivesAllSides;
if(_groupMap get "all" isEqualTo [])
exitWith _allSentMsg;

[_groupMap, "attackSquads"] call SQFM_fnc_assignGroupObjectivesAllSides;
if(_groupMap get "all" isEqualTo [])
exitWith _allSentMsg;

[_groupMap, "defenseSquads"] call SQFM_fnc_assignGroupObjectivesAllSides;
if(_groupMap get "all" isEqualTo [])
exitWith _allSentMsg;


[_groupMap] call SQFM_fnc_assignAllReinforcements;

"Some groups are still available for tasks." call dbgm;

_groupMap;
};

SQFM_fnc_assignAllReinforcements = { 
params[
    ["_groupsMap", nil, [createHashmap]]
];

if(isNil "_groupsMap")
then{_groupsMap = call SQFM_fnc_getCategorizedGroups};

private _groups = [];

_groups append([_groupsMap, east]        call SQFM_fnc_assignReinforcementsBySide);
_groups append([_groupsMap, independent] call SQFM_fnc_assignReinforcementsBySide);
_groups append([_groupsMap, west]        call SQFM_fnc_assignReinforcementsBySide);

_groupsMap call ["removeMultiple",[_groups]];

_groupsMap;
};

SQFM_fnc_groupOnReinforceArrival = { 
private _group    = _self get "grp";
private _taskData = _self get "taskData";
(_taskData get "params")
params[
    ["_callPos",     nil,           [[]]],
    ["_callerGrp",   nil,      [grpNull]],
	["_battleField", nil,[createHashmap]]
];

if!(isNil "_battleField")then{ 
    (_battlefield get "activeReinforcements") deleteAt 
    (_battlefield get "activeReinforcements") find _group;
};

if!([_callerGrp]call SQFM_fnc_validGroup)
exitWith{_taskData call ["endTask", ["invalid caller",grpNull]]};

private _callerData     = _callerGrp call getData;
private _callerStrength = _callerData call ["strengthCoef"];
if(_callerStrength <= 0.25)
exitWith{_taskData call ["endTask", ["replenish caller",_callerGrp]]};

private _callersEnemy = _callerData call ["nearEnemyGrp"];
if(!isNull _callersEnemy)
exitWith{_taskData call ["endTask", ["attack callers enemy",_callersEnemy]]};

private _ownEnemy = _self call ["nearEnemyGrp"];
if(!isNull _ownEnemy)
exitWith{_taskData call ["endTask", ["attack own enemy",_ownEnemy]]};

_taskData call ["endTask", ["move to callerPos",grpNull]];
};

SQFM_fnc_groupEndReinforcing = { 
params[
    ["_status",      nil,      [""]],
    ["_targetGroup", nil, [grpNull]]  // Can be either a hostile group, or the group that called for reinforcments
];

private _callerPos = (_self get"taskData"get"params")#0;
private _callerGrp = (_self get"taskData"get"params")#1;

_self call ["setDataDelayed", ["action",     ""]];
_self call ["setDataDelayed", ["state",      ""]];

if(_status isEqualTo "invalid caller")
exitWith{};

private _grpName = groupId _callerGrp;
private _side    = side _callerGrp;
private _msg     = [_grpName, ": Reinforcments arrived."]joinString"";

if(_status isEqualTo "replenish caller")
exitWith{
    _self call ["setDataDelayed", ["action", "Merging"]];
    _msg = [_msg, " They will replenish your squad now"]joinString"";
    [[_side, "base"], _msg] remoteExecCall ["sideChat"];
    _self call ["mergeWithGroup",[_callerGrp]];
};

if("attack" in _status)
exitWith{ 
    _self call ["setDataDelayed", ["action", "Attacking enemy"]];
    _msg = [_msg, " They are engaging the enemy!"]joinString"";
    [[_side, "base"], _msg] remoteExecCall ["sideChat"];
    _self call ["attackGroup",[_targetGroup]];
};

_msg = [_msg, " They are moving into position"]joinString"";
[[_side, "base"], _msg] remoteExecCall ["sideChat"];

_self call ["addWaypoint",[_callerPos, 50]];
};

SQFM_fnc_getNearestGroup = { 
params[
    ["_pos",     nil, [[],objNull]],
    ["_grpList", nil,         [[]]]
];

private _validList  = _grpList select {
    private _data  = _x call getData;
    private _valid = (!isNil "_data")&&{[_x] call SQFM_fnc_validGroup};
    _valid;
};

private _men        = _validList apply {[_x] call SQFM_fnc_firstValidGroupMember};//{leader _x};//select{!isNull _x};
private _nearestMan = [_pos, _men] call SQFM_fnc_getNearest;

if(isNil "_nearestMan")exitWith{grpNull};

private _index        = _men find _nearestMan;
private _nearestGroup = _validList#_index;
_nearestGroup;
};

SQFM_fnc_assignReinforcementsBySide = { 
params[
    ["_groupsMap", nil, [createHashmap]],
    ["_side",      nil,          [west]]
];


private _available = _groupsMap call ["getAvailable",["reinforcements", _side]];
if(_available isEqualTo [])exitWith{};

private _requestList      = SQFM_reinforRequests get _side;
private _sortedRequests   = [_requestList, [], {_x#2}, "ASCEND"] call BIS_fnc_sortBy;
private _assignedGroups   = [];
private _assignedRequests = [];
private _requestResponses = [];

{
    _available = _available select {!(_x in _assignedGroups)};
    if(_available isEqualTo [])exitWith{};

    private _pos     = _x#0;
    private _responder = [_pos, _available] call SQFM_fnc_getNearestGroup;
    private _data    = _responder call getData;
    
    _assignedGroups   pushBackUnique _responder;
    _assignedRequests pushBackUnique _x;
    _data call ["reinforce", _x];
    
} forEach _sortedRequests;


private _deniedRequests = _requestList select {!(_x in _assignedRequests)};
[_assignedRequests, true, _side] call SQFM_fnc_sendReinfRadioResponse;
[_deniedRequests, false, _side]  call SQFM_fnc_sendReinfRadioResponse;

call SQFM_fnc_initReinforRequestsMap;

_assignedGroups;
};


SQFM_fnc_groupAddToReinfRequests = { 
private _group       = _self get"grp";
private _side        = _self get"side";
private _pos         = _self get"groupCluster"get"position";
private _request     = [_pos, _group, round time];

SQFM_reinforRequests call ["addRequest", _request];


true;
};


SQFM_fnc_addReinfReq = { 
params[
    ["_pos",   nil,      [[]]],
    ["_group", nil, [grpNull]],
    ["_time",  nil,       [0]]
];
private _side        = side _group;
private _requestList = SQFM_reinforRequests get _side;
private _reqGroups   = _requestList apply {_x#1};

if(_group in _reqGroups)exitWith{
    [["Double request for reinf ", str _group, " deleting last"]] call dbgm;
    false;
};

_requestList pushBackUnique _request;
};

SQFM_fnc_initReinforRequestsMap = { 
private _dataArr = [
    [east,        []],
    [west,        []],
    [independent, []],
    
    /*METHODS*/
    ["addRequest", SQFM_fnc_addReinfReq]
];

SQFM_reinforRequests = createHashMapObject [_dataArr];

SQFM_reinforRequests;
};

SQFM_fnc_groupCombatZone = { 
private _pos         = _self get "cluster"get"position";
private _rad         = 400;
private _defaultZone = [_pos, _rad];
private _battlefield = _self call ["getBattle"];

if(isNil "_battlefield")exitWith{_defaultZone};
private _battleZone = [
    _battlefield get "position",
    _battlefield get "radius"
];

_battleZone;
};


SQFM_fnc_zoneStrengthBySide = { 
params[
    ["_zone",   nil,[[]]],
    ["_groups", nil,[0]]
];
if(isNil "_groups")
then{_groups = _zone call SQFM_fnc_groupsInZone};
private _strengthEast = 0;
private _strengthGuer = 0;
private _strengthWest = 0;

{
    private _strength = _x call getData call ["getStrength"];
    private _side     = side _x;
    if(_side isEqualTo east)        then{_strengthEast = _strengthEast+_strength};
    if(_side isEqualTo independent) then{_strengthGuer = _strengthGuer+_strength};
    if(_side isEqualTo west)        then{_strengthWest = _strengthWest+_strength};
    
} forEach _groups;


private _friendlyStrength = { 
params["_ownSide"];
private _ownStrength = 0;
{
    if!([_ownSide, _x]call SQFM_fnc_hostile)
    then{_ownStrength = _ownStrength+_y};
  
} forEach _self;

_ownStrength;
};

private _enemyStrength = { 
params["_ownSide"];
private _enemyStrength = 0;
{
    if([_ownSide, _x]call SQFM_fnc_hostile)
    then{_enemyStrength = _enemyStrength+_y};
  
} forEach _self;

_enemyStrength;
};

private _strengthCoef = { 
params["_ownSide"];
private _enemyStrength = _self call ["enemyStrength",    [_ownSide]];
private _ownStrength   = _self call ["friendlyStrength", [_ownSide]];
private _totalStrength = _enemyStrength+_ownStrength;

if(_enemyStrength isEqualTo 0) exitWith{1};
if(_ownStrength isEqualTo 0)   exitWith{-1};
private _coef = _ownStrength/_totalStrength;

_coef;
};

private _dataArr = [
    [east,                   _strengthEast],
    [independent,            _strengthGuer],
    [west,                   _strengthWest],

                  /*METHODS*/
    ["friendlyStrength", _friendlyStrength]
    ["enemyStrength",       _enemyStrength],
    ["strengthCoef",         _strengthCoef]
];

};

SQFM_fnc_initBattleMap = { 
params[ 
    ["_pos",    nil, [[]]],
    ["_rad",    nil,  [0]]
];
private _zone         = [_pos,_rad];
private _entities     = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr   = [_entities] call SQFM_fnc_objArrData;
private _sides        = _objDataArr#3;
private _groups       = _objDataArr#4;
private _grid         = [_pos, _rad]   call SQFM_fnc_getBattleGrid;
private _edgeLines    = [_pos, _rad]   call SQFM_fnc_getCircleLines;
private _strengthData = [nil, _groups] call SQFM_fnc_zoneStrengthBySide;
private _reinforData  = createHashmap;

private _dataArr = [
    /******************Data*************************/
    ["position",                _pos],
    ["radius",                  _rad],
    ["zone",                   _zone],
    ["startTime",               time],
    ["sides",                 _sides],
    ["groups",               _groups],
    ["buildings",                 []],
    ["grid",                   _grid],
	["edgeLines",         _edgeLines],
    ["groupShots",                []],
    ["shotsFired",             false],
	["urbanZones",                []],
    ["strengthData",   _strengthData],
    ["reinforData",     _reinforData],
    ["reinForTime",           time],
    ["activeReinforcements",      []],

    /******************Methods*************************/
    ["initGroups",                    SQFM_fnc_initBattleGroups],
    ["postInit",          {_self spawn SQFM_fnc_postInitBattle}],
	["update",                            SQFM_fnc_updateBattle],
    ["updateBuildings",          SQFM_fnc_updateBattleBuildings],
    ["endGroups",                      SQFM_fnc_endBattleGroups],
    ["handleInvalidGrps",    SQFM_fnc_handleInvalidBattleGroups],
    ["handleNewGroups",          SQFM_fnc_handleNewBattleGroups],
    ["endBattle",                            SQFM_fnc_endBattle],
    ["drawBattle",                          SQFM_fnc_drawBattle],
    ["reinforcements",            SQFM_fnc_battleReinforcements],
    ["sideNeedReforce",  SQFM_fnc_battleSideNeedsReinforcements],
    ["reinforceSide",              SQFM_fnc_battleReinforceSide],
    ["onFirstShot",                  SQFM_fnc_onBattleFirstShot],
	["timeSinceShot",          SQFM_fnc_timeSinceLastBattleShot],
	["initBuildings",{_self spawn SQFM_fnc_initBattleBuildings}]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap call ["initBuildings"];

_battleMap;
};


SQFM_fnc_handleNewBattleGroups = { 
params[
    ["_groups",nil,[[]]]
];
private _oldGroups  = _self get "groups" select {[_x] call SQFM_fnc_validGroup};
private _newGroups  = _groups select {(!(_x in _oldGroups)) && {[_x] call SQFM_fnc_validGroup}};
{
	private _grpData = _x getVariable "SQFM_grpData";
	if(!isNil "_grpData")
	then{_grpData call ["battleInit", [_pos]]};
	
} forEach _newGroups;

true;
};



SQFM_fnc_handleInvalidBattleGroups = { 
params[
    ["_groups",nil,[[]]]
];
private _invalidGroups = _groups select {(!isNull _x)&& {!([_x] call SQFM_fnc_validGroup)}};
{
	private _grpData = _x getVariable "SQFM_grpData";
	if(!isNil "_grpData")
	then{_grpData call ["battleEnd"]};
	
} forEach _invalidGroups;

true;
};



SQFM_fnc_updateBattle = { 
private _pos         = _self get "position";
private _rad         = _self get "radius";
private _entities    = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr  = [_entities] call SQFM_fnc_objArrData;
private _sides       = _objDataArr#3;
private _groups      = _objDataArr#4;
private _reinforGrps = _self get "activeReinforcements";
private _allGroups   = [];

_allGroups insert [0, (_self get "groups"), true];
_allGroups insert [0, _groups, true];

_self call ["handleNewGroups",[_groups]];
_self call ["handleInvalidGrps",[_allGroups]];



private _strengthData      = [nil, _allGroups] call SQFM_fnc_zoneStrengthBySide;
private _reinforcementData = [nil, _reinforGrps] call SQFM_fnc_zoneStrengthBySide;

_self set  ["strengthData",      _strengthData];
_self set  ["reinforData", _reinforcementData];
_self set  ["sides",               _sides];
_self set  ["groups",             _groups];
_self call ["updateBuildings"];
_self call ["reinforcements"];

true;
};

SQFM_fnc_battleReinforcements = { 
private _tooSoon = time-(_self get "reinForTime")< 60;
if(_tooSoon)exitWith{};
private _sides = _self get "sides";
if(count _sides < 2)exitWith{};

{_self call ["reinforceSide", [_x]]} forEach _sides;
};

SQFM_fnc_battleSideNeedsReinforcements = { 
params[
    ["_side",nil,[east]]
];
private _strengthData      = _self get "strengthData";
private _reinforcementData = _self get "reinforData";
private _baseCoef          = _strengthData call ["strengthCoef", [_side]];
if(_baseCoef > 0.4)        exitWith{
    [[_side," does not need reinforcements at battle"]] call dbgm;
    false;
};
if(_baseCoef isEqualTo -1) exitWith{
    [[_side," is eliminated in a battle"]] call dbgm;
    false;
};

private _strength      = _strengthData      call ["friendlyStrength",[_side]];
private _reforce       = _reinforcementData call ["friendlyStrength",[_side]];
private _enemyStrength = _strengthData      call ["enemyStrength",   [_side]];
private _allyStrength  = _strength+_reforce;
private _totalStrength = _enemyStrength+_allyStrength;
private _finalCoef     = _ownStrength/_totalStrength;
if(_finalCoef > 0.6)exitWith{
    [[_side," has enough reinforcements for battle"]] call dbgm;
    false;
};

true;
};

SQFM_fnc_battleReinforceSide = { 
params[
    ["_side",nil,[east]]
];
if!(_self call ["sideNeedReforce",[_side]])exitWith{};

private _groups   = (_self get "groups")select{side _x isEqualTo _side};
private _sortAlgo = { 
    // This algorythm will prioritize groups closer to the center of battle, and groups with losses.
    private _data         = _x call getData;
    private _strengthCoef = _data call ["strengthCoef"];
    private _pos          = _data call ["getAvgPos"];
    private _battlePos    = _self get "position";
    private _distance     = _pos distance2D _battlePos;
    private _sortingValue = _distance*_strengthCoef;
    _sortingValue;
};
_groups = [_groups, [], _sortAlgo, "ASCEND"] call BIS_fnc_sortBy;

{
    private _data = _x call getData;
    if(_data call   ["canCallReinforcements"])
    then{_data call ["callReinforcements"]};
    
} forEach _groups;

};


SQFM_fnc_groupCanCallReinforcements = { 
private _prevCall = _self get ["lastReinfReq"];
if(time - _prevCall < 60)   exitWith{false;};
if!(_self call ["isValid"]) exitWith{false;};

true;
};

SQFM_fnc_groupRequestReinforcements = { 
_self call ["callReinforcementRadio"];
_self call ["addToReinfRequests"];

_self set ["lastReinfReq", round time];

true;
};

// ["canCallReinforcements"]
/**************Update group and objective methods***********************/
// call SQFM_fnc_initReinforRequestsMap;
// call SQFM_fnc_updateMethodsAllGroups;
// call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

// private _data = grpA call getData;
// _data call ["callReinforcements"];
// [_pos, _group, round time]

private _callerGroup = group player;
private _callerData  = _callerGroup call getData;
private _pos         = getPos player;
private _respondGrp  = grp_5;
private _time        = round time;
private _request     = [_pos, _callerGroup, _time];

private _data = _respondGrp call getData;
// _data call ["reinforce", _request];
// call SQFM_fnc_initReinforRequestsMap;
_callerData call ["callReinforcements"];
sleep 2;
// hint "";
call SQFM_fnc_assignAllReinforcements;
// hint str(_data get "groupCluster"get"position");

// call SQFM_fnc_assignAllGroupTasks;
// private _time    = time;
// private _data    = group player call getData;
// private _objData = obj_2 call getData;
// private _pos     = getPos player;
// private _zone    = _objData get"zone";
// private _side    = side player;
// private _buffer  = 100;


systemChat "devfiled read";