params[
    ["_status",      nil,      [""]],
    ["_targetGroup", nil, [grpNull]]  // Can be either a hostile group, or the group that called for reinforcments
];

private _callerPos = (_self get"taskData"get"params")#0;
private _callerGrp = (_self get"taskData"get"params")#1;

_self set ["action", ""];
_self set ["state", ""];

if(_status isEqualTo "invalid caller")
exitWith{};

private _grpName = groupId _callerGrp;
private _side    = side _callerGrp;
private _msg     = [_grpName, ": Reinforcments arrived."]joinString"";

if(_status isEqualTo "replenish caller")
exitWith{
    _self set ["action", "Merging"];
    _msg = [_msg, " They will replenish your squad now"]joinString"";
    [[_side, "base"], _msg] remoteExecCall ["sideChat"];
    _self call ["mergeWithGroup",[_callerGrp]];
};

if("attack" in _status)
exitWith{ 
    _self set ["action", "Attacking enemy"];
    _msg = [_msg, " They are engaging the enemy!"]joinString"";
    [[_side, "base"], _msg] remoteExecCall ["sideChat"];
    _self call ["attackGroup",[_targetGroup]];
};

_msg = [_msg, " They are moving into position"]joinString"";
[[_side, "base"], _msg] remoteExecCall ["sideChat"];

_self call ["addWaypoint",[_callerPos, 50]];