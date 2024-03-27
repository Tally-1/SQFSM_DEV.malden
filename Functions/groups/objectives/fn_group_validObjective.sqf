params[
	["_objectiveModule",nil,[objNull]]
];
private _objctvData  = _objectiveModule getVariable "SQFM_objectiveData";
private _assetWanted = _objctvData get "asset";
private _groupType   = _self       get "groupType";
private _matches     = [_assetWanted, _groupType] call SQFM_fnc_assetTypesMatch;

if!(_matches)exitWith{false;};

true;