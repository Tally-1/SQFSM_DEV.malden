params [
	["_group", nil, [grpNull]]
];

private _getGrpMembers = {
	private _grpVehMen = []; // all men and vehicles in the group
	{_grpVehMen pushBackUnique vehicle _x;} forEach units (_self get "grp");
	_grpVehMen;
};
private _getUnits = {units (_self get "grp") select {alive _x}};

private _dataArr = [
	["birth",              time],
	["grp",              _group],
	["action",           "idle"],
	["state",                ""],
	["taskData",  createHashmap],
	["traveling",         false],
	["available",          true],
	["enemies",              []],
	["battlefield",  [-1,-1,-1]],
	["shots",                []],

	/******************************/
	["getUnits",                                      _getUnits],
	["getGrpMembers",                            _getGrpMembers],
	["battleInit",                     SQFM_fnc_groupBattleInit],
	["battleEnd",                       SQFM_fnc_groupBattleEnd],
	["addShot",                          SQFM_fnc_addGroupShots],
	["getBattle",  {SQFM_battles get (_self get "battlefield")}],
	["inBattle",                         SQFM_fnc_groupInBattle]
];

private _data = createHashmapObject [_dataArr];

_group setVariable ["SQFM_grpData", _data, true];

_data;