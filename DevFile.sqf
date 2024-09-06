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
// SQFM_fnc_openCuratorSquadMenu            = {};
// SQFM_fnc_addCuratorControlEntityButton  = {};
// SQFM_fnc_isCuratorEntityMenuDisplay    = {};
// SQFM_fnc_initDirectControlOptions     = {};
// SQFM_fnc_isCuratorGroupMenuDisplay   = {};

/*
    TODO:
        1) Exclude from SQFSM 
            - Behaviour module
            - Menu
            - CBA options

        2) No clearing of friendly owned objectives.
*/


// SQFM_fnc_reforceModules3D = {};
// SQFM_fnc_groupCanInitObjectiveDefense = {};
// SQFM_fnc_groupOnObjectiveArrival = {};
// SQFM_fnc_groupAssignFipos = {};
// SQFM_fnc_groupAssignObjectiveTurrets = {};
// SQFM_fnc_groupAssignObjectiveFipos = {};
// SQFM_fnc_onInitObjectiveDefenseWp = {};
// SQFM_fnc_objectiveGetFipos = {};
// SQFM_fnc_groupForcedMoveStart = {};
// SQFM_fnc_groupForcedMoveEnd = {};
// SQFM_fnc_groupInitObjectiveDefense = {};
// SQFM_fnc_groupGetFipoMen = {};
// SQFM_fnc_groupLeaveFipos = {};
// SQFM_fnc_groupUnstop = {};


// SQFM_reinforRequests call ["addRequest",[]];

// "\A3\ui_f\data\map\markers\handdrawn\objective_CA.paa"
// SQFM_fnc_curatorSquadMenuInitSettingEdits = {};

/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

if(time < 3)
exitWith{systemChat "devfiled executed"};

private _data = defPos call getData;
private _type = _data get "type";
// hint str _type;
// copyToClipboard str _type;

// private _pos      = eyePos player;
private _group    = curatorSelected#1#0;
private _grpData  = if(!isNil "_group")then{_group call getData}else{nil};
if(isNil "_group")exitWith{"nil group" call dbgm};

if(isNil "_grpData")
exitWith{systemChat "nil grpData"};

// _grpData call ["initObjectiveDefense",[defPos]];
/************************{FILE END}*******************************/
systemChat "devfiled read";