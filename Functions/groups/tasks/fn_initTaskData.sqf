params[
	["_taskName",   nil,      [""]], // The name of the task.
	["_zone",       nil,      [[]]],
	["_positions",  nil,      [[]]],  // [pos, rad] (where the task will take place)
	["_taskParams", nil,      [[]]]
];
private _dataArr = [
	["name",                                           _taskName],
	["zone",                                               _zone],
	["positions",                                     _positions],
	["params",                                       _taskParams],
	["state",                                     "initialized"],
	["owner",                                  (_self get "grp")],
	["ownerData", {_self get "owner" getVariable "SQFM_grpData"}],
	["active",                                              true],
	["waypoints",                                             []],
	["startTime",                                           time],
	["timeSinceStart",          {time - (_self get "startTime")}],
	["addWaypoint",                     SQFM_fnc_addTaskWaypoint],
	["endTask",                                 SQFM_fnc_endTask]
];
private _taskData = createHashmapObject [_dataArr];
_self set ["taskData", _taskData];

_self call ["deleteWaypoints"];

_taskData;