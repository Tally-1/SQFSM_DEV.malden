params [
	["_group",nil,[grpNull]]
];
private _men = units _group select{alive _x && {!([_x] call SQFM_fnc_unconscious)}};
if(_men isEqualTo [])exitWith{false;};


true;