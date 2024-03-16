call SQFM_fnc_initgameState;
call SQFM_fnc_initSettings;
call SQFM_fnc_groupSpawnedEh;
call SQFM_fnc_projectileCreated;

{[_x] call SQFM_fnc_initGroup;} forEach allGroups;
{[_x] call SQFM_fnc_initObjective;} forEach entities "SQFSM_Objective";
[] spawn SQFM_fnc_taskManager;


true;