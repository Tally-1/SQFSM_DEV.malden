params[
    ["_group", nil, [grpNull]]
];
private _module = [_group] call SQFM_fnc_groupGetBehaviorModule;
if(isNil "_module")exitWith{SQFM_defaultBehaviour};

private _squadType       = _module getVariable "squadtype"; //"standard";
private _defend          = _module getVariable "allowobjectivedefense";
private _attack          = _module getVariable "allowobjectivecapture";
private _hunt            = _module getVariable "canhunt";
private _huntDistance    = _module getVariable "SQFM_huntDistance";
private _huntKnowledge   = _module getVariable "SQFM_huntKnowledge";
private _reinforce       = _module getVariable "isreinforcement";
private _callReinforce   = _module getVariable "allowreinforcementcall";
private _callAir         = _module getVariable "allowairsupportcall";
private _callArty        = _module getVariable "allowartysupportcall";
private _exclude         = _module getVariable "exclude";
private _clearObjectives = _module getVariable "allowobjectiveclearing";
private _idleCover       = _module getVariable "idlecover";

if(_squadType isEqualTo "support")then{
    _defend       = false;
    _attack       = false;
    _hunt         = false;
    _reinforce    = false;
    _idleCover    = false;
    _huntDistance = 0;
};

// to avoid problems use the walk distance setting as a max distance for hunting.
_huntDistance = selectMin [_huntDistance, SQFM_travelWalkDist];

[
    _squadType, 
    _defend, 
    _attack, 
    _hunt, 
    _huntDistance,
    _huntKnowledge,
    _reinforce, 
    _callReinforce, 
    _callAir, 
    _callArty,
	_exclude,
	_clearObjectives,
    _idleCover
];