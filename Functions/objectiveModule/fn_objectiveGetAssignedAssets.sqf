params[
    ["_side",nil,[""]]//["west","east","independent"]
];
private _groups     = _self get"assignedGroups"get(toLower _side);
private _men        = 0;
private _armedCars  = 0;
private _lightArmor = 0;
private _heavyArmor = 0;

{
    private _assetTally=(_x call getData)call["tallyAssets"];

    _men        = _men+        (_assetTally#0);
    _armedCars  = _armedCars+  (_assetTally#1);
    _lightArmor = _lightArmor+ (_assetTally#2);
    _heavyArmor = _heavyArmor+ (_assetTally#3);
    
} forEach _groups;

private _total    = _men+(_armedCars*2)+(_lightArmor*3)+(_heavyArmor*4);
private _assetMap = createHashmapObject 
[[
    ["infantry",  _men],
    ["cars",     _armedCars],
    ["armor_l",  _lightArmor],
    ["armor_h",  _heavyArmor],
    ["sum",      _total]
]];

_assetMap;