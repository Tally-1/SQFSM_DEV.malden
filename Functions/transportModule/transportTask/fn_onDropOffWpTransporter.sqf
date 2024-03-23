params[
	["_transportGroup", nil, [grpNull]]
];
private _grpData  = _transportGroup getVariable "SQFM_grpData";
private _taskData = _grpData get "taskData";
(_taskData get "params")params[
	["_passengerGrp",   nil,      [grpNull]],
	["_vehicle",        nil,      [objNull]]
];
private _psngrData = _passengerGrp getVariable "SQFM_grpData";
private _timer     = time + round(count units _passengerGrp * 2);
(driver _vehicle)disableAI "path";

_passengerGrp leaveVehicle _vehicle;
_psngrData call ["ejectAll"];

waitUntil { 
	private _onFoot   = _psngrData call ["boardingStatus"] isEqualTo "on foot";
	private _timedOut = time > _timer;
	
	(_onFoot || _timedOut);
};

(driver _vehicle)enableAI "path";

true;