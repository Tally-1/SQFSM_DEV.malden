params[
    ["_men",      nil,[[]]],
    ["_menDelay", 0,   [0]]
];

sleep _menDelay;

{
    _x enableAI     "path";
    _x setUnitPos   "AUTO";
    _x setVariable ["SFSM_Excluded",false,true];
    _x setVariable ["SQFM_suppressionTarget",nil];
    _x setAnimSpeedCoef 1;
    
} forEach _men;

true;