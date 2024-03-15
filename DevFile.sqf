scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SFSM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
/*********************************/
/*
Basic Mod setup:
    1) Combat zones (define when combat starts and ends).
	2) Reaction to contact.
*/

// SQFM_battles


// systemChat str typeName SQFM_battles;
// SQFM_fnc_initGroupData         = {};
// SQFM_fnc_group3DNoData         = {};
// SQFM_fnc_sideColor             = {};
// SQFM_fnc_addToDataAllGroups    = {};
// SQFM_fnc_unconscious           = {};
// SQFM_fnc_validGroup            = {};
// SQFM_fnc_groupInBattle         = {};
// SQFM_fnc_inVehicle             = {typeOf _this isNotEqualTo (typeOf vehicle _this)};
// SQFM_fnc_isRealMan             = {};
// SQFM_fnc_functionalMan         = {};
// SQFM_fnc_deadCrew              = {};
// SQFM_fnc_validVehicle          = {};
// SQFM_fnc_validEnemyVehicle     = {};
// SQFM_fnc_hostile               = {};
// SQFM_fnc_validEnemy            = {};
// SQFM_fnc_firstValidGroupMember = {};
// SQFM_fnc_onEnemyDetected       = {};
// SQFM_fnc_roundPos              = {};
// SQFM_fnc_validLandEntity       = {};
// SQFM_fnc_avgPos2D              = {};
// SQFM_fnc_clusterRadius         = {};
// SQFM_fnc_objArrData            = {};
// SQFM_fnc_cluster               = {};
// SQFM_fnc_getMidpoint           = {};
// SQFM_fnc_battlefieldRadius     = {};
// SQFM_fnc_battlefieldDimensions = {};
// SQFM_fnc_isHouse               = {};
// SQFM_fnc_nearBuildings         = {};
// SQFM_fnc_straightPosArr        = {};
// SQFM_fnc_squareGrid            = {};
// SQFM_fnc_getBattleGrid         = {};
// SQFM_fnc_initBattleMap         = {};


SQFM_fnc_initBattle = { 

params [
	["_man",    nil, [objNull]],  // a man from the group that spotted the enemy
	["_target", nil, [objNull]]   // The man who was spotted.
];

["Battle initializing","hint"] call dbgm;
private _dimmentions = [_man, _target] call SQFM_fnc_battlefieldDimensions;
private _pos         = _dimmentions#0;
private _rad         = _dimmentions#1;
private _battleMap   = [_pos, _rad] call SQFM_fnc_initBattleMap;


};

/**************************************************************/

// ["inBattle", SQFM_fnc_groupInBattle] call addToGroups;

/*********************************/
systemChat "devfiled read";