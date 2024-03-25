params[
	["_module",nil,[objNull]]
];
private _data = _module getVariable "SQFM_spawnerData";
if(isNil "_data")exitWith{[_module] call SQFM_fnc_drawTransportModuleNoInit;};

private _text  = ["Transport Module | (",_data get "assetCount"," vehicles)"] joinString "";
private _color = [_data get "side"] call SQFM_fnc_sideColor;
// private _pos   = ;

drawIcon3D [
        "\A3\ui_f\data\map\markers\military\pickup_CA.paa",            
        _color,
        (getPosATL _module),
        1,
        1,
        0,       
        _text,
        2,             
        0.03
];

{
	drawIcon3D [
        "\A3\ui_f\data\map\markers\handdrawn\start_CA.paa",            
        [1,1,1,1],
        (_x get "pos"),
        0.6,
        0.6,
        0,       
        (_x get "name"),
        2,             
        0.03
	];
	
} forEach (_data get "vehicles");