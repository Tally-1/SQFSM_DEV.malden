if(true)exitWith{};
SQFM_fnc_group3D = { 
params [
	["_group", nil, [grpNull]]
];
private _data      = _group getVariable "SQFM_grpData";
if(isNil "_data")
exitwith{[_group] call SQFM_fnc_group3DNoData;};

private _eyePos  = ASLToATL aimPos vehicle leader _group;
private _iconPos = [_eyePos, 5.5] call SQFM_fnc_AddZ;
private _icon    = [_group] call SQFM_fnc_group3DIcon;//"\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa";
private _color   = [_group] call SQFM_fnc_group3DColor;
private _text    = [_group] call SQFM_fnc_group3DText;
private _camPos  = (positionCameraToWorld [0,0,0]);

//Main 3D Icon.
drawIcon3D[_icon,_color,_iconPos,2,2,0,_text,2,0.04];

// Inner text.
drawIcon3D["",[1,1,1,1],_iconPos,0,0,0,(_data get"groupType"),2,0.03];

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
};


// SQFM_fnc_group3DIcon = {
// 	"\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa";
// };

// SQFM_fnc_group3DColor = { 

// };