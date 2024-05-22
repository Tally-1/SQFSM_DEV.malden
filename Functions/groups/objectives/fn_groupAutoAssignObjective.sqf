params[
    ["_excluded",[],[[]]] // Objectives excluded from the search
];

// Attack groups only assigns to hostile or neutral objectives.
if(_self call ["canAttackOnly"])
exitWith{_self call ["assignAttackObjective",[_excluded]]};

private _group      = _self get "grp";
private _side       = _self call ["getStrSide"];//side _group;
private _objectives = _self call ["getNearObjectives",[_excluded]] select {(_x call getData)call ["troopsNeeded",[_side]]};
if(_objectives isEqualTo [])exitWith{[]};

private _targetObjective = ([_objectives, _group] call SQFM_fnc_objectivesSorted)#0;
private _assignmentData  = [_group, _targetObjective];

_self call ["takeObjective", _targetObjective];

sleep 1;

_assignmentData;