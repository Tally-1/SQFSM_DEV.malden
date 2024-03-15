params [
    ["_center",          nil], 
    ["_size",            nil],
    ["_posCount",        100],
    ["_zValue",          0],
    ["_includeWaterPos", false]
];

if(_posCount isEqualTo 1)exitWith{[_center]};

if(_posCount isEqualTo 2)exitWith{
    private _posA = [_center, 45, (_size /4), _center#2] call SQFM_fnc_sinCosPos;
    private _posB = [_center, 225, (_size /4), _center#2] call SQFM_fnc_sinCosPos;

    [_posA, _posB];
};

private _positions     = [];
private _positions2    = [];
private _axisCount     = round(sqrt _posCount);
private _bottomLeft    = [_center, 225, (_size * 0.7071)] call SQFM_fnc_sinCosPos;
private _topLeft       = [_center, 315, (_size * 0.7071)] call SQFM_fnc_sinCosPos;
private _cToCdistance  = _bottomLeft distance2D _topLeft;
private _posDistance   = (_cToCdistance / _axisCount);

private _startPos = _bottomLeft;
private _endPos   = _topLeft;

private _counter = 0;

for "_i" from 1 to _axisCount do {
private _axis = ([_startPos, _endPos, _axisCount, false, _zValue] call SQFM_fnc_straightPosArr);

_positions append _axis;
{_positions2 pushBack _x} forEach _axis;

_startPos = [(_startPos#0 + _posDistance), _startPos#1, _startPos#2];
_endPos   = [(_endPos#0 + _posDistance), _endPos#1, _endPos#2];

_counter = _counter +_axisCount;

};

_positions = _positions select {(_includeWaterPos || (!surfaceIsWater _X))};

_positions;