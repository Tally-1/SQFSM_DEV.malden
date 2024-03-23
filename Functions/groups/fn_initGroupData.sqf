
params [
	["_group", nil, [grpNull]]
];
private _emptyMap = createHashmapObject[[]];
private _dataArr = [ 

	["birth",              time],
	["grp",              _group],
	["action",               ""],
	["state",                ""],
	["travelData",          nil],
	["available",          true],
	["battlefield",  [-1,-1,-1]],
	["battleTimes",          []],
	["shots",                []],
	["groupCluster",        nil],
	["transportCrew",     false],
	["transportVehicle",objNull],
	["taskData",      _emptyMap], 

//  {METHODS}

	["3DIcon",                             SQFM_fnc_group3DIcon],
	["3DColor",                           SQFM_fnc_group3DColor],
	["initTask",                          SQFM_fnc_initTaskData],
	
	/**********************{TRAVEL}*****************************/
	["initTravel",                     SQFM_fnc_initGroupTravel],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["onTravelWpComplete",          SQFM_fnc_onTravelWpComplete],
	["deleteWaypoints",                      SQFM_fnc_deleteWps],
	["execTravel",                     SQFM_fnc_execGroupTravel],
	["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
	["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
	["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
	["callTransport",                SQFM_fnc_validGroupVehicle],
	["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
	["validVehicle",                 SQFM_fnc_validGroupVehicle],
	["getPickupPos",                 SQFM_fnc_groupPickupPos],


                      /*{boarding}*/
	["canSelfTransport",         SQFM_fnc_groupCanSelfTransport],
	["enoughTransportNear",   SQFM_fnc_enoughGroupTransportNear],
	["canBoardNow",                   SQFM_fnc_groupcanBoardNow],
	["boardingStatus",             SQFM_fnc_groupBoardingStatus],
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
	
	/********************{GROUP MEMBERS}************************/
	["getUnits",                         SQFM_fnc_getGroupUnits],
	["getUnitsOnfoot",             SQFM_fnc_getGroupUnitsOnFoot],
	["getVehiclesInUse",    {(_self call ["getOwnVehicles"])#2}],
	["getGrpMembers",                    SQFM_fnc_getGrpMembers],
	["getGroupCluster",                SQFM_fnc_getGroupCluster],
	["setGroupCluster",                SQFM_fnc_setGroupCluster],
	["getAvgPos",                          SQFM_fnc_groupAvgPos],

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

_group setVariable ["SQFM_grpData", _data, true];
_data call ["setGroupCluster"];
private _veh1 = (_data call ["getVehiclesInUse"])#0;
if((!isNil "_veh1")
&&{_veh1 getVariable ["SQFM_transport", false]})
then{
	_data set ["transportCrew",    true];
	_data set ["transportVehicle", true];
};

_data;