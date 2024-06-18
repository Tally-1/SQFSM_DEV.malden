params[
    ["_pos",     nil, [[],objNull]],
    ["_grpList", nil,         [[]]]
];
private _men          = _grpList apply {[_x] call SQFM_fnc_firstValidGroupMember};//select{!isNull _x};
private _nearestMan   = [_pos, _men] call SQFM_fnc_getNearest;

if(isNil "_nearestMan")exitWith{grpNull};

private _index        = _men find _nearestMan;
private _nearestGroup = _grpList#_index;

_nearestGroup;