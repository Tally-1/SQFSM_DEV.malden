params["_projectile"];
private _startTime = time;


while {alive _projectile} do {
    if(!alive _projectile)exitWith{};
    (_projectile getVariable "Talib_track") pushBackUnique (getPosATLVisual _projectile);
};

private _endTime = time - _startTime;

systemChat str _endTime;

true;