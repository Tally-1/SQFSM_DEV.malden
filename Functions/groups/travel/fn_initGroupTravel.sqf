params[
	["_movePos",  nil,    [[]]],
	["_taskName", "move", [""]]
];
_self call ["setGroupCluster"];
private _grpPos         = _self get"groupCluster"get"position";
private _distance       = _movePos distance2D _grpPos;
private _boardingStatus = _self call ["boardingStatus"];
private _noTransport    = _distance < 500 || {_boardingStatus isEqualTo "boarded"};
private _params         = [_movePos, _taskName];

if(_noTransport)
exitWith{_self call ["execTravel", _params]; true;};

private _canBoardNow = _self call ["canBoardNow"];
if(_canBoardNow)
exitWith{_self call ["boardThenTravel", _params]};

false;