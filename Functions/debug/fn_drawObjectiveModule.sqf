drawIcon3D[
    _self get "3dIcon",            
    _self get "3dColor",
    _self get "position",    
    1,         
    1,         
    0,              
    _self get "description", 
    2,             
    0.035
];

(_self get "3dData") call ["drawLines"];

true;