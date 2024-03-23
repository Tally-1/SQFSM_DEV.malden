params[
	["_pos",       nil,[[]]],
	["_statement", nil,[""]],
	["_type",      nil,[""]],
	["_speed",     nil,[""]],
	["_behaviour", nil,[""]]
];

private _group     = _self get "owner";
private _groupData = _group getVariable "SQFM_grpData";
private _wayPoint  = _group addWaypoint [_pos, 0];

if(!isNil "_type")      then {_wayPoint setWaypointType _type;};
if(!isNil "_statement") then {_wayPoint setWaypointStatements ["true", _statement];};
if(!isNil "_speed")     then {_wayPoint setWaypointSpeed _speed;};
if(!isNil "_behaviour") then {_wayPoint setWaypointBehaviour _behaviour;};

(_self get "waypoints")pushBackUnique _wayPoint;

_wayPoint;