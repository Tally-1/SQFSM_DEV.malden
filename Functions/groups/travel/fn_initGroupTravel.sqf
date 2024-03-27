params[
    ["_movePos",  nil,    [[]]],
    ["_taskName", "move", [""]]
];
// _self call ["setGroupCluster"];

private _grpPos         = _self call ["getAvgPos"];
private _distance       = _movePos distance2D _grpPos;
private _boardingStatus = _self call ["boardingStatus"];
private _travelNow      = _distance < 500 || {_boardingStatus isEqualTo "boarded"};
private _params         = [_movePos, _taskName];

if(_travelNow)
exitWith{
	_self call ["execTravel", _params]; 
	true;
};

if(_self call ["canBoardNow"]
&&{_self call ["boardThenTravel", _params]})
exitWith{true;};

if!(_self call ["canCallTransport"])
exitWith{false;};

private _transport = _self call ["callTransport", [_movePos]];
if(isNull _transport)
exitWith{false;};

true;