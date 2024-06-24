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
// SQFM_fnc_initGroupData = {};
// SQFM_fnc_setGroupMethods = {};

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
// SQFM_fnc_groupEndReinforcing         = {};
// SQFM_fnc_groupAttackGroup            = {};
// SQFM_fnc_assignReinforcementsBySide  = {};
// SQFM_fnc_posIsHostile                = {};
// SQFM_fnc_groupReinforceInsertPos     = {};
// SQFM_fnc_groupInitReinforceTask      = {};
// SQFM_fnc_groupSetDataDelayed         = {};
// SQFM_fnc_assignGroupObjectivesAllSides = {};
// SQFM_fnc_assignAllGroupTasks           = {};
// SQFM_fnc_assignAllReinforcements = {};
// SQFM_fnc_groupOnReinforceArrival = {};
// SQFM_fnc_groupEndReinforcing = {};
// SQFM_fnc_getNearestGroup = {};
// SQFM_fnc_groupAddToReinfRequests = {};
// SQFM_fnc_addReinfReq = {};
// SQFM_fnc_initReinforRequestsMap = {};
// SQFM_fnc_groupCombatZone = {};

// SQFM_latestBattle call ["reinforcements"];

// SQFM_fnc_groupCanCallReinforcements = {};
// SQFM_fnc_groupRequestReinforcements = {};
// SQFM_fnc_getCategorizedGroups       = {};
// SQFM_fnc_groupAddWayPoint           = {};
// SQFM_fnc_groupSetDataDelayed = { 
// params[
//     "_key",
//     "_value", 
//     ["_delay",0,[0]]
// ];
// [_self, _key, _value, _delay]spawn{
// params["_self","_key","_value", "_delay"];
// sleep _delay;
// _self set [_key, _value];
// true;
// }};

// ["canGetReinforcements"]
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
// _callerData call ["callReinforcements"];
// hint str (_callerData get "callReinforcements");
// sleep 2;
// hint "";
// call SQFM_fnc_assignAllReinforcements;
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