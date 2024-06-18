params[
    ["_targetGroup",nil,[grpNull]]
];
_self call ["deleteWaypoints"];

private _targetData = _targetGroup call getData;
private _cluster    = _targetData get "groupCluster";
private _pos        = _cluster get "position";
private _rad        = _cluster get "radius";

_self call ["addWaypoint", _pos, _rad, "SAD"];

true;