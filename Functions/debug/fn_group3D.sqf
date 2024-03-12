params [
	["_group", nil, [grpNull]]
];
private _data      = _group getVariable "SQFM_grpData";
if(isNil "_data")
exitwith{[_group] call SQFM_fnc_group3DNoData;};

private _pos = ASLToATL eyePos vehicle leader _group;
private _icon  = "\A3\ui_f\data\map\groupicons\selector_selectedFriendly_ca.paa";
private _color = [side _group] call SQFM_fnc_sideColor;;
private _text  = _data get "taskName";

drawIcon3D[
    _icon,            
    _color,
    _pos,    
    1,         
    1,         
    0,              
    _text, 
    2,             
    0.035
];