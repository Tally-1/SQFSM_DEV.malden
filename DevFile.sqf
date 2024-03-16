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
// SQFM_fnc_addGroupShots         = {};
// SQFM_fnc_getNearest            = {};
// SQFM_fnc_onProjectileCreated   = {};
// SQFM_fnc_posInBattleZone       = {};
// SQFM_fnc_copyHashmap           = {};
// SQFM_fnc_nearestBattlePosRad   = {};
// SQFM_fnc_groupBattleEnd        = {};

SQFM_fnc_initBattleMap = { 
params[ 
	["_pos",    nil, [[]]],
	["_rad",    nil,  [0]],
	["_sides",  nil, [[]]],
	["_groups", nil, [[]]]
];

private _entities   = (_pos nearEntities ["land", _rad])select {[_x] call SQFM_fnc_validLandEntity};
private _objDataArr = [_entities] call SQFM_fnc_objArrData;
private _sides      = _objDataArr#3;
private _groups     = _objDataArr#4;
private _buildings  = [_pos, _rad] call SQFM_fnc_nearBuildings;
private _grid       = [_pos, _rad] call SQFM_fnc_getBattleGrid;

private _dataArr = [
	["position",        _pos],
	["radius",          _rad],
	["startTime",       time],
	["sides",         _sides],
	["groups",       _groups],
	["buildings", _buildings],
	["grid",           _grid],
	["groupShots",        []],
	["shotsFired",     false],

	["initGroups",  SQFM_fnc_initBattleGroups],
	["endGroups",   SQFM_fnc_endBattleGroups],
	["endBattle",   SQFM_fnc_endBattle],
	["onFirstShot", SQFM_fnc_onBattleFirstShot]
];

private _battleMap = createHashmapObject [_dataArr];

_battleMap;
};

SQFM_fnc_initBattleGroups = {

{
	private _groupData = _x getVariable "SQFM_grpData";
	if  (!isNil "_groupData")
	then{
		_groupData call ["battleInit",[(_self get "position")]];
	};

} forEach (_self get "groups");

true;
};

SQFM_fnc_endBattleGroups = { 
{
	private _groupData = _x getVariable "SQFM_grpData";
	if  (!isNil "_groupData")
	then{_groupData call ["battleEnd"];};

} forEach (_self get "groups");

true;
};


SQFM_fnc_initBattle = { 
params [
	["_man",    nil, [objNull]],  // a man from the group that spotted the enemy
	["_target", nil, [objNull]]   // The man who was spotted.
];

[["Battle initializing | ", round time]] call dbgm;

private _spotterGroup = group _man;
private _dimensions   = [_man, _target] call SQFM_fnc_battlefieldDimensions;
private _pos          = _dimensions#0;
private _rad          = _dimensions#1;

SQFM_battleList pushBackUnique [_pos, _rad];

private _battleMap = [
	_pos, 
	_rad
] call SQFM_fnc_initBattleMap;

SQFM_battles set [_pos, _battleMap];

_battleMap call  ["initGroups"];
_battleMap spawn SQFM_fnc_postInitBattle;
};

SQFM_fnc_groupReturnFire = { 
params[
	["_enemy", nil, [objNull]] // can be man or vehicle
];
private _enemyCluster  = [_enemy, 100, [], true] call SQFM_fnc_cluster;
private _grid          = _enemyCluster get "grid";
private _enemyVehicles = _enemyCluster call ["getVehicles"];
private _enemyMen      = _enemyCluster call ["getMen"];

if(_enemyVehicles isEqualTo []
&&{_enemyMen      isEqualTo []})
exitWith{};

SFSM_Custom3Dpositions = _grid apply {[_x]};

[["Initial suppression started ", round time]] call dbgm;
_self set["action", "Returning fire"];

private _gridCount = count _grid;
private _j         = 0;
private _grpVehMen = _self call ["getGrpMembers"];

for "_i" from 0 to (count _grpVehMen -1)do{ 

	if(_j>_gridCount)
	then{_j = 0};

	private _grpMember   = _grpVehMen#_i;
	private _suppressPos = _grid#_j;
	_grpMember doSuppressiveFire _suppressPos;
	_j=_j+1;
};

_self call ["endReturnFire"];

true;
};

SQFM_fnc_endGrpReturnFire = { 
private _self = _this;
private _timer = time + 15;
sleep count (_self call ["getUnits"]);

waitUntil { 
	sleep 1; 
	private _grpVehMen       = _self call ["getGrpMembers"];
	private _shooters        = _grpVehMen select {currentCommand _x == "Suppress";};

	if(_shooters isEqualTo []) exitWith{true;};
	if(time > _timer)          exitWith{true;};

	false;
};

[["Initial suppression ended ", round time]] call dbgm;

if(_self call ["inBattle"])
then{_self set["action", "Fighting"];}
else{_self set["action", "idle"];};

true;
};



SQFM_fnc_onBattleFirstShot = { 
params[
	["_shooter",    nil, [objNull]],
	["_projectile", nil, [objNull]],
	["_target",     nil, [objNull]]
];

if(isNull _target)exitWith{};
private _targetData = (group _target) getVariable "SQFM_grpData";
if(isNil "_targetData")exitWith{};

_self set ["shotsFired", true];
_targetData call ["returnFire", [_shooter]];

};

SQFM_fnc_postInitBattle = { 
private _self = _this;
// waitUntil{count (_self get "groupShots") > 0};

};


SQFM_fnc_endBattle = { 

private _pos = _self get "position";
private _rad = _self get "radius";

SQFM_battleList deleteAt (SQFM_battleList find [_pos, _rad]);
SQFM_battles    deleteAt _pos;

_self call ["endGroups"];

[["Battle ended | ", round time]] call dbgm;
};


["returnFire",      SQFM_fnc_groupReturnFire]                call addToGroups;
["endReturnFire",  {_self spawn SQFM_fnc_endGrpReturnFire}] call addToGroups;
// ["battleInit", SQFM_fnc_groupBattleInit] call addToGroups;
/**************************************************************/

/*********************************/
systemChat "devfiled read";