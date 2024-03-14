private _count = count SQFM_newGroups-1;
if(_count < 0)exitWith{};

for "_i"from 0 to _count do{
	private _grp  = SQFM_newGroups#0;
	private _data = _grp getVariable "SQFM_grpData";

	if (isNil "_data"
	&& {!isNull _grp})
	then{[_grp] call SQFM_fnc_initGroup;};

	SQFM_newGroups deleteAt 0;
};

true;