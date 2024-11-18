scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};
scr = [] execVM "SFSM_Devfile.sqf";
waitUntil {scriptDone scr;};
// if(true)exitWith{systemChat "devfile exited"};
systemChat "devfile found";
addToGroups = SQFM_fnc_addToDataAllGroups;

// SQFM_fnc_validMapDrawSquad = {};

// [_pathPositions] call SQFM_fnc_showPosArr3D;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
/************************TODO list*******************************/
/*
    + Reinforcement GUI
        // - Reinforcements Active/requested:
        //   - Waiting for reply
        //   - Call rejected: <Reason>
        //   - On the way <Distance to drop>
    // + Travel end remove data.
        
    + 
*/
/********************New Functions/Methods*****************************/

// SQFM_fnc_objectName                       = {};
// SQFM_fnc_nearestTransport                 = {};
// SQFM_fnc_selectTransportDestination       = {};
// SQFM_fnc_drawNearestTransport             = {};
// SQFM_fnc_endTransportDestinationSelection = {};
// SQFM_fnc_playerCanCallTransport           = {};
// SQFM_fnc_rejectTransportCall              = {};
// SQFM_fnc_playerCallTransport              = {};
// SQFM_fnc_updateTransportInfo              = {};
// SQFM_fnc_getTransportInfoText             = {};
// SQFM_fnc_showTransportData                = {};
// SQFM_fnc_selectDestinationTip             = {};
// SQFM_fnc_endPlayerTransport               = {};
// SQFM_fnc_playerAbortTransportKeyEh        = {};
// SQFM_fnc_abortPlayerTransport             = {};
// SQFM_fnc_canGetTransportAction            = {};
// SQFM_fnc_callTransportAction              = {};
// SQFM_fnc_simpleSelfAction                 = {};
// SQFM_fnc_simpleSelfActionAce              = {};
// SQFM_fnc_callReinforcementsActionCondition = {};
// SQFM_fnc_callTransportActionCondition     = {};
// SQFM_fnc_playerCanCallReinforcement       = {};
// SQFM_fnc_rejectReinforcementCall          = {};
// SQFM_fnc_playerReforceStatus              = {};
// SQFM_fnc_initReforceDisplay               = {};
// SQFM_fnc_playerReforceType                = {};
// SQFM_fnc_getReforceInfoText               = {};
// SQFM_fnc_showReforceData                  = {};
// SQFM_fnc_groupAbortReinforcing            = {};
// SQFM_fnc_playerAbortReforceServer         = {};
// SQFM_fnc_playerAbortReforceLocal          = {};
// SQFM_fnc_playerCallReinforcements         = {};
// SQFM_fnc_callReinforcementsAction         = {};




/**************Update group and objective methods***********************/
call SQFM_fnc_updateMethodsAllGroups;
call SQFM_fnc_updateMethodsAllObjectives;
call SQFM_fnc_updateMethodsAllReforcers;
if(time < 3)    exitWith{systemChat "devfile read early"};
if(isDedicated) exitWith{systemChat "devfile read"};
/************************Code to execute*******************************/
SQFM_Custom3Dpositions = [];
// [] spawn SQFM_fnc_playerCallTransport;
// call SQFM_fnc_selectDestinationTip;
// "SQFM_reinforcementInfo"
private _pos     = getPosATLVisual player;
private _rad     = 50;
private _sort    = true;
private _man     = curatorSelected#0#0;
private _group   = curatorSelected#1#0;
private _grpData = if(!isNil "_group")then{_group call getData}else{nil};
// private _knArr   = units grp_2 apply {[_x, 0.7, 0.2]};
// call SQFM_fnc_showReforceData;
if(isNil "_group")exitWith{"nil group" call dbgm};

if(isNil "_grpData")
exitWith{systemChat "nil grpData"};

if(isNil "_man")
exitWith{"nil man" call dbgm};


/************************{FILE END}*******************************/
systemChat "devfile read";