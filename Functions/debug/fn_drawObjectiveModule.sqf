private _desc  = _self get "description";
private _asset = _self get "asset";
private _count = _self get "assetStrength";
private _text  = [_desc," (",_count,")"]joinString"";
private _icon  = _self get "defaultIcon";
private _color = _self get "3dColor";

if(_self get "contested")
then{
    _icon  = _self get"contestedIcon";
    _color = [0.85,0.4,0,1];
};

if(_self call ["timeSinceCapture"] <= 2)
then{
    _icon  = _self get "capturedIcon";
    _color = [0.3,1,0.3,1];
};

// If the objective is not active due to synched triggers.
if!(_self get "activated")then{
    _color = [1,0,0,1];
    _icon  = "\a3\Modules_f\data\iconSector_ca.paa";
};

drawIcon3D[
    _icon,
    _color,
    _self get "position",    
    1,         
    1,         
    0,              
    _text, 
    2,             
    0.035
];

(_self get "3dData") call ["drawLines"];
_self call ["triggers3D"];



true;