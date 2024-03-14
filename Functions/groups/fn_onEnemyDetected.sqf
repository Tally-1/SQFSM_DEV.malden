params [
	["_group",     nil, [grpNull]],
	["_newTarget", nil, [objNull]]
];
private _data = _group getVariable "SQFM_grpData";
private _man  = [_group] call SQFM_fnc_firstValidGroupMember;

if (isNil "_data")                         exitWith{/*"Nil data"         call dbgm;*/};
if (_data call ["inBattle"])               exitWith{/*"Already fighting" call dbgm;*/};
if!(alive _man)                            exitWith{/*"Dead man"         call dbgm;*/};
if!([_group] call SQFM_fnc_validGroup)     exitWith{/*"Invalid group"    call dbgm;*/};
if!([_newTarget] call SQFM_fnc_validEnemy) exitWith{/*"Invalid enemy"    call dbgm;*/};

[_man, _newTarget] call SQFM_fnc_initBattle;

true;