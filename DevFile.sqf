scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
scr = [] execVM "SFSM_Devfile.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;

// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap     = {};
// SQFM_fnc_setObjectiveData   = {};
// SQFM_fnc_setObjectiveMethods = {};
// SQFM_fnc_initTransportSpawner = {};
// SQFSM_fnc_endDirectControl = {};
// call SQFM_fnc_switchUnit_exit;
// SQFM_fnc_assignAllGroupTasks = {};


// DCO_check = false;
// sleep 1;
// DCO_check = true;

// while {DCO_check} do {
//     hint str SQFM_clickDc;
//     sleep 0.3;
// };

// path = "\a3\editor_f\Data\Scripts\dikCodes.h";


// SQFM_fnc_addCuratorGroupMenuButton = {};
// SQFM_fnc_isCuratorGroupMenuDisplay = {};
// SQFM_fnc_onCuratorObjectDoubleClicked = { 
// params [
//     ["_curator", nil, [objNull]],
//     ["_entity",  nil, [objNull]]
// ];

// // [_entity] call SQFM_fnc_initDirectControlOptions;

// true;
// };
// SQFM_fnc_validSwitchEntity         = {};
// if(true)exitWith{"aborted" call dbgm};
// SQFM_fnc_isCuratorEntityMenuDisplay = {};
// SQFM_fnc_addCuratorControlEntityButton = {};
// SQFM_fnc_endDirectControlAction = {};
// SQFM_fnc_virtualManGetVehicle = {};
// SQFM_fnc_virtualManGetInVehicle = {};
// SQFM_fnc_virtualVehicleSpawnIn = {};
// SQFM_fnc_virtualManSpawnIn = {};
// SQFM_fnc_virtualizeMan = {};
// SQFM_fnc_virtualizeVehicle  = {};
// SQFM_fnc_virtualizeSquad = {};
// SQFM_fnc_virtualSquadSpawnIn = {};
// SQFM_fnc_virtualizeSquadsWhenReady = {};
// SQFM_fnc_initReforceModule = {};
// SQFM_fnc_setReforceModuleMethods = {};
// SQFM_fnc_reforceModuleCanSpawn = {};
// SQFM_fnc_reforceModuleUpdateSquads = {};
// SQFM_fnc_reforceModuleSpawnSquad = {};
// SQFM_fnc_moduleSpawnOnReforceRequest = {};
// (ref_1 call getData) call ["setMethods"];
// [getPos player, group player] call SQFM_fnc_moduleSpawnOnReforceRequest;


// this addEventHandler ["CuratorGroupDoubleClicked", {
// 	params ["_curator", "_group"];
// }];

/************************TODO list*******************************/
/********************New Functions/Methods*****************************/

// SQFM_fnc_onCuratorGroupDoubleClick = {};
// SQFM_fnc_initDisplayData            = {};
// SQFM_fnc_applySquadMenuSettings      = {};
// SQFM_fnc_initCuratorSquadMenuDisplay  = {};
// SQFM_fnc_curatorSquadMenuAddCBS        = {};
// SQFM_fnc_curatorSquadMenuAddSLS         = {};
// SQFM_fnc_displayAddSlider                = {};
// SQFM_fnc_curatorSquadMenuInitSettingEdits = {};
// SQFM_fnc_openCuratorSquadMenu            = {};
// SQFM_fnc_addCuratorControlEntityButton  = {};
// SQFM_fnc_isCuratorEntityMenuDisplay    = {};
// SQFM_fnc_initDirectControlOptions     = {};
// SQFM_fnc_isCuratorGroupMenuDisplay   = {};

/*
    TODO:
        1) BACKGROUND
        2) FRAME
        3) CheckBoxes
            - "text lorem ipsum"       [x]

*/


// SQFM_fnc_reforceModules3D = {};
// SQFM_fnc_reforceModule3Ddata = {};
// SQFM_fnc_reforceObjectiveIsHostile = {};
// SQFM_fnc_tenSecondTasks = {};

// SQFM_reinforRequests call ["addRequest",[]];

/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

if(time < 3)
exitWith{systemChat "devfiled executed"};

// [ref_1] call SQFM_fnc_initReforceModule;
// [curatorSelected#1] call SQFM_fnc_virtualizeSquadsWhenReady;
// (ref_1 call getData) call ["setMethods"];
// df= (ref_1 call getData) call ["canSpawn",[getPos player, group player]];
// hint str [df];
// [getPos player, group player] call SQFM_fnc_moduleSpawnOnReforceRequest;

// private _pos      = eyePos player;
private _group    = curatorSelected#1#0;
private _grpData  = if(!isNil "_group")then{_group call getData}else{nil};

// 
// (ref_1 call getData) call ["sendSquad",[_pos]];

if(isNil "_group")exitWith{"nil group" call dbgm};
// [_positions] call SQFM_fnc_showPosArr3D;



// if(isNil "SQFM_curObj")
// exitWith{systemChat "nil module"};

// [SQFM_curObj] call SQFM_fnc_setObjectiveData;
// SQFM_switchUnit_start
if(isNil "_grpData")
exitWith{systemChat "nil grpData"};
while {true} do {
    hint str [SQFM_clickDc];
};
// _grpData call ["addToReinfRequests"];
// private _vSquad = [_group, true] call SQFM_fnc_virtualizeSquad;
// sleep 3;
// _vSquad call ["spawnIn"];

// _grpData call ["leaveUnarmedVehicles"];
// _grpData call ["mechClearUrbanObjective",[SQFM_curObj]];
// _grpData call ["initObjectiveTask",[SQFM_curObj]];

// [_data get "exitPositions"] call SQFM_fnc_showPosArr3D;
// private _groups = curatorSelected#1;
// [_groups] spawn SQFM_fnc_assignGroupsIdleCover;
/************************{FILE END}*******************************/
systemChat "devfiled read";