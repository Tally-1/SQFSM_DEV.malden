scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
scr = [] execVM "SFSM_Devfile.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfile found";
addToGroups = SQFM_fnc_addToDataAllGroups;

// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap     = {};
// SQFM_fnc_setObjectiveData   = {};
// SQFM_fnc_setObjectiveMethods = {};
// SQFM_fnc_initTransportSpawner = {};
// SQFSM_fnc_endDirectControl   = {};
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


// SQFM_fnc_reforceModules3D            = {};
// SQFM_fnc_groupCanInitObjectiveDefense = {};
// SQFM_fnc_groupOnObjectiveArrival     = {};
// SQFM_fnc_groupAssignFipos           = {};
// SQFM_fnc_groupAssignObjectiveTurrets = {};
// SQFM_fnc_groupAssignObjectiveFipos = {};
// SQFM_fnc_onInitObjectiveDefenseWp = {};
// SQFM_fnc_objectiveGetFipos         = {};
// SQFM_fnc_groupForcedMoveStart       = {};
// SQFM_fnc_groupForcedMoveEnd          = {};
// SQFM_fnc_groupInitObjectiveDefense    = {};
// SQFM_fnc_groupGetFipoMen               = {};
// SQFM_fnc_groupLeaveFipos                = {};
// SQFM_fnc_groupUnstop                     = {};
// SQFM_fnc_curatorSquadMenuInitSettingEdits = {};
// SQFM_fnc_updateMethodsAllReforcers       = {};
// SQFM_fnc_getBattleOnPos                 = {};
// SQFM_fnc_groupInitReinforceTask        = {};
// SQFM_fnc_sendReforceToTrigger         = {};
// SQFM_fnc_reinforceTrigger            = {};
// SQFM_fnc_groupOnReinforceArrival    = {};
// SQFM_fnc_normalizeTextCtrlHeight   = {};
// SQFM_fnc_initHudDisplay            = {};
// SQFM_fnc_initMarkerFeedBackDisplay = {};
// SQFM_fnc_objectiveHudShowData       = {};
// SQFM_fnc_initObjectiveFeedbackHud    = {};
// SQFM_fnc_onObjectiveFeedbackHudClosed = {};
// SQFM_fnc_initObjectiveHudBackground  = {};
// SQFM_fnc_objectiveHudCamReady       = {};
// SQFM_fnc_objectiveHudShowCamera    = {};




/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
call SQFM_fnc_updateMethodsAllReforcers;
/************************Code to execute*******************************/

if(time < 3)
exitWith{systemChat "devfile read"};

// private _type     = _data get "type";
private _group    = curatorSelected#1#0;
private _grpData  = if(!isNil "_group")then{_group call getData}else{nil};

[obj_2] call SQFM_fnc_showObjectiveData;

if(isNil "_group")exitWith{"nil group" call dbgm};

if(isNil "_grpData")
exitWith{systemChat "nil grpData"};

/************************{FILE END}*******************************/
systemChat "devfile read";