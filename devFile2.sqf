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
// SQFM_fnc_addPosMarker        = {};
// SQFM_fnc_drawObjectiveMarkers = {};
// SQFM_fnc_objectiveUpdateMarkers = {};
// SQFM_fnc_addCircleMarker       = {};
// SQFM_fnc_addRectangleMarker   = {};
// SQFM_fnc_flashActionMan       = {};
// SQFM_fnc_man3dAction           = {};
// SQFM_fnc_isUrbanArea            = {};
// SQFM_fnc_objectiveSetUrbanStatus = {};
// SQFM_fnc_posArrToPath              = {};
// SQFM_fnc_groupInfClearObjective     = {};
// SQFM_fnc_groupInfClearUrbanObjective = {};
// SQFM_fnc_groupGetUrbanObjInfSearchP = {};
// SQFM_fnc_searchNearBuildings         = {};
// SQFM_fnc_objectiveGetZoneMidPositions = {};
// SQFM_fnc_allBuildingsPositions       = {};
// SQFM_fnc_getRoadData                = {};
// SQFM_fnc_hashifyRoads               = {};
// SQFM_fnc_roadIsZoneExit               = {};
// SQFM_fnc_getZoneExitRoads              = {};
// SQFM_fnc_getZoneRoadmap                 = {};
// SQFM_fnc_groupVehicleClearUrbanObjective = {};
// SQFM_fnc_groupVehicleClearObjective     = {};
// SQFM_fnc_zonePosArr                    = {};
// SQFM_fnc_zoneCone                     = {};
// SQFM_fnc_semiCirclePosArr            = {};
// SQFM_fnc_objectiveGetZoneCone       = {};
// SQFM_fnc_lineBroken                = {};
// SQFM_fnc_manInFipo                = {};
// SQFM_fnc_validMan                = {};
// SQFM_fnc_functionalMan          = {};
// SQFM_fnc_manEjectThenCover     = {};
// SQFM_fnc_manEjectFromVehicle  = {};
// SQFM_fnc_mechUnloadActivateMen = {};
// SQFM_fnc_deployVehicleSmoke     = {};
// SQFM_fnc_getVehiclePassengers    = {};
// SQFM_fnc_mechUnloadPositions      = {};
// SQFM_fnc_mechUnloadEnd             = {};
// SQFM_fnc_manCurrentBuilding         = {};
// SQFM_fnc_validSurfaceIntersections   = {};
// SQFM_fnc_getSuppressionTargetPosition = {};
// SQFM_fnc_getBuildingSuppressionPos   = {};
// SQFM_fnc_posOnVector                = {};
// SQFM_fnc_getSuppressionTarget      = {};
// SQFM_fnc_suppressionTargetValue   = {};
// SQFM_fnc_zoneSuppressionTargets  = {};
// SQFM_fnc_getObjectCorners       = {};
// SQFM_fnc_displayCtrlSetFont    = {};
// SQFM_fnc_displayAddCtrl        = {};
// SQFM_fnc_displayAddCheckBox     = {};
// SQFM_fnc_displayAddButton        = {};
// SQFM_fnc_btnCtrlAddFunction       = {};
// SQFM_fnc_displayAddFrame           = {};
// SQFM_fnc_displayCtrlSpawnString     = {};
// SQFM_fnc_ctrlSpawnText               = {};
// SQFM_fnc_addCuratorGroupMenuButton    = {};
// SQFM_fnc_initCuratorSquadMenuButtons   = {};
// SQFM_fnc_initCuratorSquadMenuBackground = {};
// SQFM_fnc_initGroupData                 = {};
SQFM_fnc_setGroupMethods              = { 
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
    ["currentWaypoint",           SQFM_fnc_groupCurrentWayPoint],

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
    ["leaveUnarmedVehicles", SQFM_fnc_groupLeaveUnarmedVehicles],
    ["mechUnload",                     SQFM_fnc_groupMechUnload],

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
	["canInitObjectiveDefense",      SQFM_fnc_groupCanInitObjectiveDefense],
	["initObjectiveDefense",            SQFM_fnc_groupInitObjectiveDefense],
    ["objectiveData",                          SQFM_fnc_groupObjectiveData],
    ["typeMatchObjective",                SQFM_fnc_groupTypeMatchObjective],
    ["objectiveHostile",                    SQFM_fnc_groupObjectiveHostile],
    ["objectiveFriendly",                  SQFM_fnc_groupObjectiveFriendly],
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
    ["initMechClearing",                    SQFM_fnc_groupInitMechClearing],
    ["endMechClearing",                      SQFM_fnc_groupEndMechClearing],

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
    ["garrison",                                   SQFM_fnc_groupGarrison],
    ["getNearUrbanZones",                 SQFM_fnc_groupGetNearUrbanZones],
    ["getInBuilding",                         SQFM_fnc_groupGetInBuilding],
    ["idleGarrison",                           SQFM_fnc_groupIdleGarrison],
    ["initIdleGarrison",                   SQFM_fnc_groupInitIdleGarrison],
    ["canIdleGarrison",                     SQFM_fnc_groupCanIdleGarrison],
    // ["InitMechClearingFormation", SQFM_fnc_groupInitMechClearingFormation],

    /********************{GROUP MEMBERS}************************/
    ["getUnits",                                    SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",                        SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",               {(_self call ["getOwnVehicles"])#2}],
    // ["getUnarmedVehicles",                SQFM_fnc_groupGetUnarmedVehicles],
    ["isVehicleGroup",       {count(_self call ["nonCrewMen"])isEqualTo 0}],
    ["isMechanized",                            SQFM_fnc_groupIsMechanized],
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
    ["getRadius",                                  SQFM_fnc_groupGetRadius],
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
    ["ableToHunt",                     SQFM_fnc_groupAbleToHunt],

	/**********************{DEFENSE}***************************/
    ["assignFipos",                       SQFM_fnc_groupAssignFipos],
	["assignObjectiveFipos",     SQFM_fnc_groupAssignObjectiveFipos],
	["assignObjectiveTurrets", SQFM_fnc_groupAssignObjectiveTurrets]
];

{
    private _name = _x#0;
    private _code = _x#1;
    _groupData set [_name, _code];
    
} forEach _methods;

true;
};
// SQFM_fnc_setObjectiveData            = {};
// SQFM_fnc_setObjectiveMethods        = {};
// SQFM_fnc_groupBehaviourSettings    = {};
// SQFM_fnc_initGroupData            = {};