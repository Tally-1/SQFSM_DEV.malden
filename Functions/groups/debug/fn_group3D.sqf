params [
	["_group", nil, [grpNull]]
];
private _data      = _group getVariable "SQFM_grpData";
if(isNil "_data")
exitwith{[_group] call SQFM_fnc_group3DNoData;};

private _eyePos  = ASLToATL aimPos vehicle leader _group;
private _iconPos = [_eyePos, 5.5] call SQFM_fnc_AddZ;
private _icon    = "\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa";
private _color   = [side _group] call SQFM_fnc_sideColor;;
private _text    = _data get "action";
private _camPos  = (positionCameraToWorld [0,0,0]);


drawIcon3D[
    _icon,            
    _color,
    _iconPos,    
    2,         
    2,         
    0,              
    _text, 
    2,             
    0.04
];
drawLine3D [_eyePos, _iconPos, _color];

if(!isNull (findDisplay 312))then{ 

private _units = units _group select {
       _camPos distance2D _x < 100 
    &&{currentCommand _x isNotEqualTo ""
    &&{vehicle _x isEqualTo _x}}};

    {
        drawIcon3D[
        "",            
        [1,1,1,1],
        getPosATLVisual _x,    
        1,         
        1,         
        0,              
        currentCommand _x, 
        2,
        0.035
    ];
        
    } forEach _units;
};
