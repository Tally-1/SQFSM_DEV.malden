params [
    ["_group", nil, [grpNull]]
]; 
[_group] call SQFM_fnc_groupBehaviourSettings
params[
    ["_squadClass",    nil,    [""]],
    ["_defend",        nil,  [true]],
    ["_attack",        nil,  [true]],
    ["_hunt",          nil,  [true]],
    ["_huntDistance",  nil,     [0]],
    ["_huntKnowledge", nil,     [0]],
    ["_reinforce",     nil,  [true]],
    ["_callReinforce", nil,  [true]],
    ["_callAir",       nil,  [true]],
    ["_callArty",      nil,  [true]]
];

private _3Dtxt    = ["100%", 0.546, "#ffffff", "#00000000", "PuristaBold"]call SQFM_fnc_getTextTexture;
private _emptyMap = createHashmapObject[[]];
private _dataArr  = [ 

    ["birth",             round time],
    ["lastTransportCall", round time],
    ["huntCoolDown",      round time],
    ["lastReinfReq",           0-300],
    ["lastFireCheck",          0-300],
    ["grp",                   _group],
    ["owner",      groupOwner _group],
    ["side",             side _group],
    ["action",                    ""],
    ["state",                     ""],
	["groupType",          "unknown"],
    ["squadClass",       _squadClass],
    ["travelData",               nil],
    ["available",               true],
    ["awaitingReforce",        false],
    ["awaitingReplenish",      false],
    ["battlefield",       [-1,-1,-1]],
    ["battleTimes",               []],
    ["shots",                     []],
    ["groupCluster",             nil],
    ["transportCrew",          false],
    ["transportVehicle",     objNull],
    ["initialStrength",            0],
    ["strengthIndicator",     _3Dtxt],
    ["objective",            objNull],
    ["taskData",           _emptyMap],
    ["unitEvHandlers",            []],

    /******Behaviour settings*******/
    ["canDefend",                    _defend],
    ["canAttack",                    _attack],
    ["canHunt",                        _hunt],
    ["huntDistance",           _huntDistance],
    ["huntKnowledge",         _huntKnowledge],
    ["canReinforce",              _reinforce],
    ["canCallReinforcements", _callReinforce],
    ["canCallAir",                  _callAir],
    ["canCallArty",                _callArty]
];

private _data = createHashmapObject [_dataArr];

// All methods(functions) related to this hashmap is found at "functions\groups\fn_setGroupMethods.sqf"
[_data] call SQFM_fnc_setGroupMethods;

_data call ["setGroupCluster"];
_data call ["setGroupType"];

private _veh1     = (_data call ["getVehiclesInUse"])#0;
private _strength = _data call ["getStrength"];

if((!isNil "_veh1")
&&{_veh1 getVariable ["SQFM_transport", false]})
then{
    _data set ["transportCrew",    true];
    _data set ["transportVehicle", _veh1];
};

_data set  ["initialStrength", _strength];
_data call ["update"];

_group setVariable ["SQFM_grpData", _data, true];

_data;