params [
    ["_man", nil, [objNull]]
];
private _target = getAttackTarget _man;
if(!alive _target)exitWith{};

private _valid = [_man, _target] call SQFM_fnc_validFsmMoveTarget;
if(_valid)exitWith{};

_man forgetTarget _target;
_man doWatch objNull;
_man doTarget objNull;

true;