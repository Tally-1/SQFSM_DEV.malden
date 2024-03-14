params [
	["_group", nil, [grpNull]]
];

private _dataArr = [
	["birth",              time],
	["taskName",         "idle"],
	["taskData",  createHashmap],
	["traveling",         false],
	["available",         true],
	["enemies",              []],
	["battlefield",      "none"]/*,
	["inBattle", SQFM_fnc_groupInBattle]*/
];

private _data = createHashmapObject [_dataArr];

_group setVariable ["SQFM_grpData", _data, true];

_data;