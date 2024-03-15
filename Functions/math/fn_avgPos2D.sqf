params[
	["_posArr", nil, [[]]],
	["_z",      1,    [0]]
];

private _xArr = [];
private _yArr = [];

{
	private ["_pos"];
	if  (typeName _x isEqualTo "ARRAY")
	then{_pos = _x;}
	else{_pos =  getPosATLVisual _x;};
	
	_xArr pushBackUnique (_pos#0);
	_yArr pushBackUnique (_pos#1);
	
} forEach _posArr;

private _avgX   = [_Xarr] call SQFM_fnc_average;
private _avgY   = [_Yarr] call SQFM_fnc_average;
private _avgPos = [_avgX, _avgY, _z];

_avgPos;