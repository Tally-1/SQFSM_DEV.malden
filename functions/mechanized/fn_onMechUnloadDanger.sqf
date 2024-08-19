params[
    ["_vehicle", nil,[objNull]],
    ["_men",     nil,     [[]]],
    ["_targets", nil,     [[]]]
];
[_vehicle] call SQFM_fnc_deployVehicleSmoke;

private _gunners = (allTurrets _vehicle)apply{_vehicle turretUnit _x};
{
    if(_targets isEqualTo [])exitWith{};

    private _target = _targets#0;

    if(typeName _target isEqualTo "OBJECT"
    &&{_target isKindOf "house"})
    then{
        _target = [aimPos _x, _target] call SQFM_fnc_getBuildingSuppressionPos;
    };
    
    _x doSuppressiveFire _target;

    _targets deleteAt 0;
} forEach _gunners;

if(_targets isEqualTo [])exitWith{};

private _targetIndex = 0;
private _endIndex    = count _targets;
{
    if(_targetIndex >= _endIndex)
    then{_targetIndex = 0};

    private _target = _targets#_targetIndex;
    _x setVariable ["SQFM_suppressionTarget", _target];
    
    _targetIndex=_targetIndex+1;
    
} forEach _men;