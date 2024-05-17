params[
    ["_excluded",[],[[]]] // Objectives excluded from the search
];
private _group      = _self get "grp";
private _side       = _self call ["getStrSide"];//side _group;
private _objectives = _self call ["getNearObjectives",[_excluded]] select {(_x call getData)call ["troopsNeeded",[_side]]};
if(_objectives isEqualTo [])exitWith{[]};

private _targetObjective = ([_objectives, _group] call SQFM_fnc_objectivesSorted)#0;

[_self, _targetObjective] spawn {(_this#0) call ["takeObjective", [(_this#1)]]};

sleep 1;

[_group, _targetObjective];