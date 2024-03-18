params [
	["_group", nil, [grpNull]]
];

private _getGrpMembers = {
	private _grpVehMen = []; // all men and vehicles in the group
	{_grpVehMen pushBackUnique vehicle _x;} forEach units (_self get "grp");
	_grpVehMen;
};
private _getUnits        = {units (_self get "grp") select {alive _x}};
private _setGroupCluster = {_self set ["groupCluster", (_self call ["getGroupCluster"])]};

private _dataArr = [
	["birth",              time],
	["grp",              _group],
	["action",           ""],
	["state",                ""],
	// ["taskData",  createHashmap],
	["traveling",         false],
	["available",          true],
	["battlefield",  [-1,-1,-1]],
	["battleTimes",          []],
	["shots",                []],
	["groupCluster",        nil],

	/******************************/
	// // ["initTravel",                       SQFM_fnc_initGroupTravel],
	// ["getUnits",                                      _getUnits],
	// ["getGrpMembers",                            _getGrpMembers],
	// ["getVehicles",                   SQFM_fnc_getGroupVehicles],
	// ["getGroupCluster",                SQFM_fnc_getGroupCluster],
	// ["setGroupCluster",                        _setGroupCluster],
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

_data;