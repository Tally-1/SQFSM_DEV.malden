params [
	["_group", nil, [grpNull]]
];

private _dataArr = [
	["birth",              time],
	["taskName",         "idle"],
	["taskData",  createHashmap],
	["traveling",         false],
	["enemies",              []]	
];

private _data = createHashmapObject [_dataArr];

_group setVariable ["SQFM_grpData", _data, true];

_data;