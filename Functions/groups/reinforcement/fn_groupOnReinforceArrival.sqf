private _taskData = _self get "taskData";
(_taskData get "params")
params[
    ["_callPos",     nil,           [[]]],
    ["_callerGrp",   nil,      [grpNull]],
	["_battleField", nil,[createHashmap]]
];

if!([_callerGrp]call SQFM_fnc_validGroup)
exitWith{_taskData call [endTask, ["invalid caller",grpNull]]};

private _callerData     = _callerGrp call getData;
private _callerStrength = _callerData call ["strengthCoef"];
if(_callerStrength <= 0.25)
exitWith{_taskData call ["endTask", ["replenish caller",_callerGrp]]};

private _callersEnemy = _callerData call ["nearEnemyGrp"];
if(!isNull _callersEnemy)
exitWith{_taskData call ["endTask", ["attack callers enemy",_callersEnemy]]};

private _ownEnemy = _self call ["nearEnemyGrp"];
if(!isNull _ownEnemy)
exitWith{_taskData call ["endTask", ["attack own enemy",_ownEnemy]]};

_taskData call ["endTask", ["move to callerPos",grpNull]];