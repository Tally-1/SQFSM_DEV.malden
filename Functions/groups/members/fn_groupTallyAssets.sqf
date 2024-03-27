private _men        = count (_self call ["nonCrewMen"]);
private _armedCars  = 0;
private _lightArmor = 0;
private _heavyArmor = 0;

{
    if([_x] call SQFM_fnc_isArmedCar)   then{_armedCars  = _armedCars  +1;};
    if([_x] call SQFM_fnc_isLightArmor) then{_lightArmor = _lightArmor +1;};
    if([_x] call SQFM_fnc_isHeavyArmor) then{_heavyArmor = _heavyArmor +1;};

} forEach (_self call ["getVehiclesInUse"]);

[_men, _armedCars, _lightArmor, _heavyArmor];