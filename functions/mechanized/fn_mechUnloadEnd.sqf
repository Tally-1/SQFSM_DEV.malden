params[
    ["_vehicle",   nil,[objNull]],
    ["_men",       nil,     [[]]],
    ["_menDelay",    0,      [0]]
];
private _group  = group (_men#0);
private _driver = driver _vehicle;

_group enableAttack true;
_driver enableAI "path";
[_men, _menDelay] spawn SQFM_fnc_mechUnloadActivateMen;

true;