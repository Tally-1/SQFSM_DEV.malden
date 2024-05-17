params[
    ["_groupsMap", nil,            [createHashmap]],
    ["_category",  "attackSquads",            [""]]
]; 
private _available          = _groupsMap call ["getAvailable",[_category]];
private _assignedGroups     = [];
private _assignedObjectives = [];
{
    private _grpObj = (_x call getData)call ["autoAssignObjective",[_assignedObjectives]];
    if(_grpObj isNotEqualTo [])
    then{
        _assignedGroups     pushBackUnique (_grpObj#0);
        _assignedObjectives pushBackUnique (_grpObj#1);
    };
    
} forEach _available;

_assignedGroups;