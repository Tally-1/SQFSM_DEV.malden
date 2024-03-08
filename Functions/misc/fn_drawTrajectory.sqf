params["_trajectory"]; _trajectory
params["_color", "_track"];

{
    private _start = _x#0;
    private _end   = _x#1;
    private _size  = 0.5;
    drawLine3D [_start, _end, _color];

    // drawIcon3D [
    // "\A3\ui_f\data\map\markers\handdrawn\dot_CA.paa",
    // [0.6,0.6,0.1,1],
    // _start,
    // _size, 
    // _size, 
    // 0,  
    // "", 
    // 2, 
    // 0.035
    // ];
    
} forEach _track;