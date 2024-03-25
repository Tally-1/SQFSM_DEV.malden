params [
	["_group", nil, [grpNull]]
];

private _data     = _group getVariable "SQFM_grpData";
private _taskData = _data get "taskData";
private _taskName = _taskData get "name";

if(isNil "_taskName")exitWith{_data get "action";};

if(_taskName isEqualTo "transport")
exitWith{_taskData get "state"};

_data get "action";