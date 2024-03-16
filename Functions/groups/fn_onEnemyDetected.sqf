params [
	["_group",     nil, [grpNull]],
	["_newTarget", nil, [objNull]]
];
private _data = _group getVariable "SQFM_grpData";

if(isNil "_data")           exitWith{};
if(_data call ["inBattle"]) exitWith{};

private _man = [_group] call SQFM_fnc_firstValidGroupMember;
if!(alive _man)                                exitWith{};
if([_man] call SQFM_fnc_posInBattleZone)       exitWith{};
if([_newTarget] call SQFM_fnc_posInBattleZone) exitWith{};

if!([_group] call SQFM_fnc_validGroup)     exitWith{};
if!([_newTarget] call SQFM_fnc_validEnemy) exitWith{};

[_man, _newTarget] call SQFM_fnc_initBattle;

true;