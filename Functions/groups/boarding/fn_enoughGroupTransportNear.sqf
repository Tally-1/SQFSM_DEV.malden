private _men         = _self call ["getUnitsOnfoot"];
private _vehicles    = _self call ["allAvailableVehicles"];
private _hasCapacity = [_men, _vehicles] call SQFM_fnc_vehiclesCanTransportMen;

_hasCapacity;