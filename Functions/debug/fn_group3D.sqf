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

drawIcon3D[
    _icon,            
    _color,
    _iconPos,    
    2,         
    2,         
    0,              
    _text, 
    2,             
    0.035
];

drawLine3D [_eyePos, _iconPos, _color];