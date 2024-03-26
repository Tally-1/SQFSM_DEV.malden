private _desc  = _self get "description";
private _asset = _self get "asset";
private _count = _self get "count";
private _text  = [_desc," (",_count," ",_asset,")"]joinString"";

drawIcon3D[
    _self get "3dIcon",            
    _self get "3dColor",
    _self get "position",    
    1,         
    1,         
    0,              
    _text, 
    2,             
    0.035
];

(_self get "3dData") call ["drawLines"];

true;