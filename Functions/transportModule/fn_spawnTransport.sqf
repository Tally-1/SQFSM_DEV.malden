params[
	["_capacity",nil,[]]
];
private _vehicleData = _self call ["getVehicleType", [_capacity]];
if(isNil "_vehicleData")
exitWith{};

private _spawnPosData = _self call ["selectSpawnPos", [_vehicleData]];
if(isNil "_spawnPosData")
exitWith{};

private _vehicleType = _vehicleData  get "type";
private _spawnPos    = _spawnPosData get "pos";
private _spawnDir    = _spawnPosData get "dir";


private _vehicle = createVehicle [
	_vehicleType, 
	_spawnPos, 
	[], 
	0, 
	"CAN_COLLIDE"
];

_vehicle allowDamage false;
_vehicle setDir    _spawnDir;
_vehicle setPosATL _spawnPos;


_vehicle spawn{sleep 1; _this allowDamage true;};

_vehicle;