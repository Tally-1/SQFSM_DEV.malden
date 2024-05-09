params[
	["_objectiveModule",nil,[objNull]]
];
private _objData       = _objectiveModule call getData;
private _allowedSides  = _objData get "allowedSides";
private _allowedAssets = _objData get "allowedAssets";
private _groupType     = _self    get "groupType";
private _side          = _self    get "side";
private _strSide       = _self call ["getStrSide"];
private _inRange       = _self call ["objectiveInRange",[_objectiveModule]];

if!(_inRange)                                  exitWith{false;};
if!(_objData call ["troopsNeeded",[_strSide]]) exitWith{false;};
if!(_side in _allowedSides)                    exitWith{false;};


true;