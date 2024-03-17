scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
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
// SQFM_fnc_addGroupShots         = {};
// SQFM_fnc_getNearest            = {};
// SQFM_fnc_onProjectileCreated   = {};
// SQFM_fnc_posInBattleZone       = {};
// SQFM_fnc_copyHashmap           = {};
// SQFM_fnc_nearestBattlePosRad   = {};
// SQFM_fnc_groupBattleEnd        = {};
// SQFM_fnc_initBattleGroups      = {};
// SQFM_fnc_endBattleGroups       = {};
// SQFM_fnc_groupReturnFire       = {};
// SQFM_fnc_grpIsNotSuppressing   = {};
// SQFM_fnc_endGrpReturnFire      = {};
// SQFM_fnc_onBattleFirstShot     = {};
// SQFM_fnc_initBattleMap         = {};
// SQFM_fnc_initBattle            = {};

// SQFM_fnc_draw3dMarker          = {};
// SQFM_fnc_multi3dMarkers        = {};
// SQFM_fnc_pos360                = {};
// SQFM_fnc_drawBuilding          = {};
// SQFM_fnc_drawBattle            = {};
// SQFM_fnc_getCircleLines        = {};
// SQFM_fnc_initBattleBuildings   = {};
// SQFM_fnc_battle3D              = {};
// SQFM_fnc_getUrbanZones         = {};
// SQFM_fnc_initBattleBuildings   = {};

SQFM_fnc_initBattleMap = { 
params[ 
    ["_pos",    nil, [[]]],
    ["_rad",    nil,  [0]]
];

private _entities      = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr    = [_entities] call SQFM_fnc_objArrData;
private _sides         = _objDataArr#3;
private _groups        = _objDataArr#4;
private _grid          = [_pos, _rad] call SQFM_fnc_getBattleGrid;
private _edgeLines     = [_pos, _rad] call SQFM_fnc_getCircleLines;

private _dataArr = [
/******************Data*************************/
    ["position",                _pos],
    ["radius",                  _rad],
    ["startTime",               time],
    ["sides",                 _sides],
    ["groups",               _groups],
    ["buildings",                 []],
    ["grid",                   _grid],
	["edgeLines",         _edgeLines],
    ["groupShots",                []],
    ["shotsFired",             false],
	["urbanZones",                []],

/***************Methods*************************/
    ["initGroups",    SQFM_fnc_initBattleGroups],
    ["postInit",      {_self spawn SQFM_fnc_postInitBattle}],
    ["endGroups",     SQFM_fnc_endBattleGroups],
    ["endBattle",     SQFM_fnc_endBattle],
    ["drawBattle",    SQFM_fnc_drawBattle],
    ["onFirstShot",   SQFM_fnc_onBattleFirstShot],
	["initBuildings", {_self spawn SQFM_fnc_initBattleBuildings}]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap call ["initBuildings"];

_battleMap;
};





SQFM_fnc_postInitBattle = { 
private _self  = _this;
private _timer = time + 60;
// _self call 
waitUntil{sleep 1; count (_self get "groupShots") > 0 || {_timer < time}};

};
// SQFM_debugMode
// ["battleInit", SQFM_fnc_groupBattleInit] call addToGroups;
/**************************************************************/

/*********************************/
systemChat "devfiled read";