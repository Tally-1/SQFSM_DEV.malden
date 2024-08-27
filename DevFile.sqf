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

// SQFM_fnc_assignAllGroupTasks = {};


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
// SQFM_fnc_onCuratorSquadMenuSettingChange = {};
// SQFM_fnc_displayAddSlider                = {};
// SQFM_fnc_curatorSquadMenuInitSettingEdits = {};
// SQFM_fnc_openCuratorSquadMenu            = {};




/*
    TODO:
        1) BACKGROUND
        2) FRAME
        3) CheckBoxes
            - "text lorem ipsum"       [x]

*/

/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
/************************Code to execute*******************************/

if(time < 3)
exitWith{systemChat "devfiled executed"};


private _pos      = eyePos player;
private _dir      = [(getDirVisual (vehicle player)-180)] call SQFM_fnc_formatDir;
private _width    = 170;
private _clearRad = 100;
private _group    = curatorSelected#1#0;
private _grpData  = if(!isNil "_group")then{_group call getData}else{nil};

if(isNil "_group")exitWith{"nil group" call dbgm};
// [_positions] call SQFM_fnc_showPosArr3D;


// if(isNil "SQFM_curObj")
// exitWith{systemChat "nil module"};

// [SQFM_curObj] call SQFM_fnc_setObjectiveData;

if(isNil "_grpData")
exitWith{systemChat "nil grpData"};
_grpData call ["leaveUnarmedVehicles"];
// _grpData call ["mechClearUrbanObjective",[SQFM_curObj]];
// _grpData call ["initObjectiveTask",[SQFM_curObj]];

// [_data get "exitPositions"] call SQFM_fnc_showPosArr3D;
// private _groups = curatorSelected#1;
// [_groups] spawn SQFM_fnc_assignGroupsIdleCover;
/************************{FILE END}*******************************/
systemChat "devfiled read";