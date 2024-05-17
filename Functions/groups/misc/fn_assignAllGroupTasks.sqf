private _groupMap     = call SQFM_fnc_getCategorizedGroups;

private _groups = [_groupMap, "recon"] call SQFM_fnc_assignAttackGroups;
_groupMap call ["removeMultiple",[_groups]];

_groups = [_groupMap, "attackSquads"] call SQFM_fnc_assignAttackGroups;
_groupMap call ["removeMultiple",[_groups]];