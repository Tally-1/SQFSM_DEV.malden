{
   _x params [
        "_pos",
        ["_txt", ""],
        ["_color", [0.6,0.6,0.1,1]],
        ["_icon",  "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa"],
        ["_size", 1]
    ];

    drawIcon3D [
        _icon,
        _color,
        _pos,
        _size, 
        _size, 
        0,  
        _txt, 
        2, 
        0.035
    ];

} forEach Talib_customMarkers;