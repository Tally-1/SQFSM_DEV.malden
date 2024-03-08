params["_projectile"];
private _color      = _projectile getVariable ["Talib_lineColor",[]];
private _positions  = _projectile getVariable ["Talib_track",[]];
private _track = [];

for "_i" from 0 to (count _positions - 2)do{
    private _start = _positions#_i;
    private _end   = _positions#(_i+1);
    _track pushBackUnique [_start, _end];
};

// hint str ([_color, _track]);
hint str (_projectile distance (getShotParents _projectile select 0));
Talib_trajectories pushBackUnique ([_color, _track]);