private _orange = [0.85,0.4,0,1];
private _green  = [0.3,1,0.3,1];
drawIcon3D [
        "\a3\ui_f\data\igui\cfg\simpletasks\types\destroy_ca.paa",            
        _orange,
        (_self get "position"),
        1,
        1,
        0,       
        "Battle",
        2,             
        0.04
    ];

{drawLine3D _x}forEach(_self get "edgeLines");

if(!isNull (findDisplay 312))then{ 
	{[_x] call SQFM_fnc_drawBuilding} forEach (_self get "buildings");	
	{_x call ["drawLines"]}           forEach (_self get "urbanZones");
};

true;