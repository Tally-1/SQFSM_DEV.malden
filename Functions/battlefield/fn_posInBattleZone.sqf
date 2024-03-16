params [
	["_pos", nil,[[],objNull]]
];
private _nearBattlePosRad = [_pos] call SQFM_fnc_nearestBattlePosRad;

if(isNil "_nearBattlePosRad")exitWith{false;};

private _battlePos = _nearBattlePosRad#0;
private _radius    = _nearBattlePosRad#1;
private _distance  = _pos distance2D _battlePos;
private _inZone    = _distance < _radius;

_inZone;