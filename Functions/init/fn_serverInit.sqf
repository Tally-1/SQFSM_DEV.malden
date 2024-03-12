SQFM_newGroups = [];

call SQFM_fnc_initSettings;
call SQFM_fnc_groupSpawnedEh;

{[_x] call SQFM_fnc_initGroup;} forEach allGroups;
{[_x] call SQFM_fnc_initObjective;} forEach entities "SQFSM_Objective";
[] spawn SQFM_fnc_taskManager;

true;