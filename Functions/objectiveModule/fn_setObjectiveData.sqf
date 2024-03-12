params[
	["_module", nil, [objNull]]
];
private _data3d      = [_module] call SQFM_fnc_module3dData;
private _type        = _module getVariable "objectiveType";
private _description = [_type] call SQFM_fnc_objectiveDescription;
private _assetType   = _module getVariable "assetType";
private _assetcount  = _module getVariable "assetCount";
private _distance    = _module getVariable "activationDistance";
private _owner       = sideUnknown;
private _sides       = [];

if(_module getVariable "allowEast")        then {_sides pushBack east;};
if(_module getVariable "allowIndependent") then {_sides pushBack independent;};
if(_module getVariable "allowWest")        then {_sides pushBack west;};


private _dataArr = [
	["position",    getPosATLVisual _module],
	["3dData",                      _data3d],
	["distance",                  _distance],
	["type",                          _type],
	["description",            _description],
	["asset",                    _assetType],
	["count",                   _assetcount],
	["owner",                   sideUnknown],
	["contested",                     false],
	["draw3D", SQFM_fnc_drawObjectiveModule],
	["3dColor",                   [1,1,1,1]],
	["3dIcon",    "\A3\ui_f\data\map\markers\military\objective_CA.paa"]
];

private _data = createhashMapObject [_dataArr];

_module setVariable ["SQFM_objectiveData", _data];

_data;