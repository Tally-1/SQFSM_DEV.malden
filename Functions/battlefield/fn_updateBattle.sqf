private _pos        = _self get "position";
private _rad        = _self get "radius";
private _entities   = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr = [_entities] call SQFM_fnc_objArrData;
private _sides      = _objDataArr#3;
private _groups     = _objDataArr#4;
private _oldGroups  = _self get "groups" select {[_x] call SQFM_fnc_validGroup};
private _newGroups  = _groups select {(!(_x in _oldGroups)) && {[_x] call SQFM_fnc_validGroup}};

{
	private _grpData = _x get "SQFM_grpData";
	if(!isNil "_grpData")then{_grpData call ["battleInit", [_pos]]}
	
} forEach _newGroups;

_self set ["sides",   _sides];
_self set ["groups", _groups];

true;