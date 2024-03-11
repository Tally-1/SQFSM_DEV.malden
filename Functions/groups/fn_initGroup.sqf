params [
	["_group", nil, [grpNull]]
];

[["Initializing group ", _group]] call dbgm;

[_group] call SQFM_fnc_initGroupData;
[_group] call SQFM_fnc_grpEvents;

true;