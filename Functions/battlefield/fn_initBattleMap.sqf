params[ 
	["_pos", nil, [[]]],
	["_rad", nil,  [0]]
];
private _entities   = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr = [_entities] call SQFM_fnc_objArrData;
private _sides      = _objDataArr#3;
private _groups     = _objDataArr#4;
private _buildings  = [_pos, _rad] call SQFM_fnc_nearBuildings;
private _grid       = [_pos, _rad] call SQFM_fnc_getBattleGrid;

private _dataArr = [
	["position",   _pos],
	["radius",     _rad],
	["sides",      _sides],
	["groups",     _groups],
	["buildings",  _buildings],
	["grid",       _grid],
	["groupShots", []]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap;