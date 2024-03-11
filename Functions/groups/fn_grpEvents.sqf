params [["_group", nil, [grpNull]]];

_group addEventHandler ["Empty",             {"Deleting empty group" call dbgm; deleteGroup (_this#0)}];
_group addEventHandler ["EnemyDetected",     {_this call SQFM_fnc_onEnemyDetected}];
_group addEventHandler ["KnowsAboutChanged", {_this call SQFM_fnc_onKnowsAboutChanged}];

true;