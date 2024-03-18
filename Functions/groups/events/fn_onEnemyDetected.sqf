params [
	["_group", nil, [grpNull]],
	["_enemy", nil, [objNull]]
];
private _enemyGroup  = group _enemy;
private _spotterData = (_group getVariable "SQFM_grpData");
private _enemyData   = (_enemyGroup getVariable "SQFM_grpData");

if (isNil "_spotterData")                  exitWith{};
if (isNil "_enemyData")                    exitWith{};
if!(_spotterData call ["canInitBattle"])   exitWith{};
if!(_enemyData   call ["canInitBattle"])   exitWith{};

private _man = [_group] call SQFM_fnc_firstValidGroupMember;
if(_enemy distance2D _man > 2000) exitWith{};
if(_group knowsAbout _enemy < 4)  exitWith{};

[_man, _enemy] call SQFM_fnc_initBattle;

true;