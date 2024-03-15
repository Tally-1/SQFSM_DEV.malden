params [    
    ["_target",          nil,      [objNull]],
    ["_Radius",          50,             [0]],
    ["_excludedUnits",   [],            [[]]]
];
private _side   = side _target;
Private _pos    = getPos _target;
private _filter = {side _x isEqualTo _side && {(!(_x in _excludedUnits))  &&{[_x] call SQFM_fnc_validLandEntity}}};
private _list   = (_pos nearEntities ["land", _radius])select _filter;
private _data   = [_list] call SQFM_fnc_objArrData;

private _dataArr = [
	["position", _data#0],
	["radius",   _data#1],
	["objects",  _data#2],
	["sides",    _data#3],
	["groups",   _data#4]
];

private _hashmap = createHashmapObject [_dataArr];

_hashmap;