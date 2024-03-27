params[
    ["_group",nil,[grpNull]]
];
private _grpData = _group getVariable "SQFM_grpData";
private _side    = _grpData call ["getStrSide"];
private _grpList = _self get"assignedGroups"get _side;

_grpList pushBackUnique _group;

_grpList = [_grpList] call SQFM_fnc_removeNull;

_grpList;