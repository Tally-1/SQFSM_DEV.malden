params[
	["_objModul",nil,[objNull]]
];
private _objData       = _objModul call getData;
private _allowedAssets = _objData get "allowedAssets";
private _groupType     = _self    get "groupType";

if(_groupType in _allowedAssets)exitWith{true;};

private _match = false;
{
    if(_x in _groupType)exitWith{_match = true;};
    systemChat str [_groupType, _x];
    
} forEach _allowedAssets;

_match;