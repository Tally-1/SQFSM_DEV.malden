{
	private _vehicle = vehicle _x;
	_x action ["Eject", _vehicle];
	_x leaveVehicle _vehicle;	
} forEach (_self call ["getUnits"]);

true;