private _idleGroups = [];

{
    private _data = _x call getData;

    if((!isNil "_data")
    && {_data call ["isValid"]
    && {_data call ["isIdle"]}})
    then{_idleGroups pushBack _x};
    
} forEach allGroups;

_idleGroups;