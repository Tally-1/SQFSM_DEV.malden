params[ 
	["_pos",    nil, [[]]],
	["_rad",    nil,  [0]]
];

private _entities   = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr = [_entities] call SQFM_fnc_objArrData;
private _sides      = _objDataArr#3;
private _groups     = _objDataArr#4;
private _buildings  = [_pos, _rad] call SQFM_fnc_nearBuildings;
private _grid       = [_pos, _rad] call SQFM_fnc_getBattleGrid;

private _dataArr = [
	["position",        _pos],
	["radius",          _rad],
	["startTime",       time],
	["sides",         _sides],
	["groups",       _groups],
	["buildings", _buildings],
	["grid",           _grid],
	["groupShots",        []],
	["shotsFired",     false],

	["initGroups",  SQFM_fnc_initBattleGroups],
	["postInit",    {_self spawn SQFM_fnc_postInitBattle}],
	["endGroups",   SQFM_fnc_endBattleGroups],
	["endBattle",   SQFM_fnc_endBattle],
	["drawBattle",  SQFM_fnc_drawBattle],
	["onFirstShot", SQFM_fnc_onBattleFirstShot]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap;