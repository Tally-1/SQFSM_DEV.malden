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

SQFM_fnc_initGroupData      = { 
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


SQFM_fnc_setGroupMethods    = { 
params[
    ["_groupData",nil,[createHashmap]]
];
// 
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
SQFM_fnc_groupObjectiveAssignedHostiles = { 
params[
    ["_objective",nil,[objNull]]
];
private _side            = _self get "side";
private _objData         = _objective call getData;
private _hostileSides    = [east,west,independent] select {[_x,_side]call SQFM_fnc_hostile};
private _hostileStrength = 0;

{
    private _assets  = _objData call ["getAssignedAssets",[_x]];
    _hostileStrength = _hostileStrength+(_assets get "sum");
    
} forEach _hostileSides;

_hostileStrength;
};

SQFM_fnc_groupCanLeaveObjective = { 
private _objective = _self get "objective";
if(isNull _objective)exitWith{true};
private _side    = _self get "side";
private _objData = _objective call getData;
private _hostile = count ((_objData call ["getSidesInZone"])select{[_x,_side]call SQFM_fnc_hostile})>0;
if(_hostile)exitWith{false};

private _hostileStrength = _self call ["objectiveAssignedHostiles",[_objective]];
if(_hostileStrength > 1)exitWith{false};

true;
};


SQFM_fnc_groupCanAssignObjective = { 
params[
    ["_ignoreStatus",nil,[true]]
];
private _available = _ignoreStatus or {_self call["canRecieveTask"]};
if!(_available) exitWith{false};

private _canLeave = _self call["canLeaveObjective"];
if!(_canLeave)exitWith{false};

true;
};