_self call ["deleteWaypoints"];
_this pushBack _self;
_this spawn{
params[
    ["_callPos",   nil,            [[]]], // The position the call was made from.
    ["_callerGrp", nil,       [grpNull]], // The group who made the request. 
    ["_time",      nil,             [0]], // Time when the request for reinforcement was made.
    ["_self",      nil, [createHashmap]]  // the hashmapObject belonging to the responding group (this group)
];
private _canTravel = _self call ["initTravel",[_callPos]];
if!(_canTravel)
exitWith{"Could not travel to reinforce squad." call dbgm;};
private _group       = _self get "grp";
private _posName     = [_callPos] call SQFM_fnc_areaName;
private _callerData  = _callerGrp call getData;
private _taskName    = ["Reinforce ", (_callerData get "groupType"), " at ", _posName]joinString"";
private _taskParams  = [_callPos, _callerGrp];
private _zone        = [_callPos, 300];
private _arrivalCode = {(_self call ["ownerData"]) call ["onReinforceArrival"]};
private _endCode     = {(_self call ["ownerData"]) call ["endReinforcing"]};
private _task        = _self call ["initTask",
[
    _taskName,     // Taskname     ["name"]
    _zone,         // Task zone    ["zone"]
    [_callPos],    // Positions    ["positions"]
    _taskParams,   // TaskParams   ["params"]
    _arrivalCode,  // Arrival-code ["arrivalCode"]
    _endCode       // End-code     ["endCode"]
]];



sleep 5;
private _travelData       = _self get "travelData";
private _transportVehicle = _self get "transportVehicle";
private _validVehicle     = (!isNil "_transportVehicle")&&{alive _transportVehicle};

if((isNil "_travelData")
&&{_validVehicle isEqualTo false})
exitWith{"No traveldata" call dbgm};


if(_validVehicle isEqualTo false)
exitWith{[_group, (currentWaypoint _group)] setWaypointCompletionRadius 300};

private _transportGroup  = group driver _transportVehicle;
private _wpG = (waypoints _group)#2;
private _wpT = (waypoints _transportGroup)#2;

_wpG setWaypointCompletionRadius 300;
_wpT setWaypointCompletionRadius 300;

"wayPoint comp rad has been set to 300" call dbgm;

true;
}