private _emptyMap  = createHashmapObject[[]];
private _ownerData = _self call ["ownerData"];

_ownerData call ["deleteWaypoints"];
_ownerData deleteAt "taskData";
_ownerData set ["taskData", _emptyMap];

true;