scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles
// SQFSM_TransportSpawner
// SQFM_fnc_initBattleMap = {};
SQFM_fnc_initGroupData = { 

params [
    ["_group", nil, [grpNull]]
];
private _emptyMap = createHashmapObject[[]];
private _dataArr = [ 

    ["birth",             round time],
    ["lastTransportCall", round time],
    ["grp",                   _group],
    ["side",             side _group],
    ["action",                    ""],
    ["state",                     ""],
	["groupType",          "unknown"],
    ["travelData",               nil],
    ["available",               true],
    ["battlefield",       [-1,-1,-1]],
    ["battleTimes",               []],
    ["shots",                     []],
    ["groupCluster",             nil],
    ["transportCrew",          false],
    ["transportVehicle",     objNull],
    ["taskData",           _emptyMap], 

//  {METHODS}

    ["3DIcon",                             SQFM_fnc_group3DIcon],
    ["3DColor",                           SQFM_fnc_group3DColor],
    ["initTask",                          SQFM_fnc_initTaskData],
    
    /**********************{TRAVEL}*****************************/
    ["initTravel",                     SQFM_fnc_initGroupTravel],
    ["execTravel",                     SQFM_fnc_execGroupTravel],
    ["onArrival",                            SQFM_fnc_onArrival],
    ["deleteWaypoints",                      SQFM_fnc_deleteWps],
    ["execTravel",                     SQFM_fnc_execGroupTravel],
    ["getOwnVehicles",                SQFM_fnc_getGroupVehicles],
    ["getNearVehicles",              SQFM_fnc_nearGroupVehicles],
    ["allAvailableVehicles", SQFM_fnc_allAvailableGroupVehicles],
    ["callTransport",                SQFM_fnc_validGroupVehicle],
    ["leaveInvalidVehicles",      SQFM_fnc_leaveInvalidVehicles],
    ["validVehicle",                 SQFM_fnc_validGroupVehicle],
    ["getPickupPos",                    SQFM_fnc_groupPickupPos],

                      /*{transport}*/
    ["canCallTransport",           SQFM_fnc_groupCanCallTransport],
    ["callTransport",                 SQFM_fnc_groupCallTransport],
    ["getTransportSpawner",     SQFM_fnc_groupGetTransportSpawner],
    ["sinceTransportCall", {time-(_self get "lastTransportCall")}],

                      /*{boarding}*/
    ["canSelfTransport",         SQFM_fnc_groupCanSelfTransport],
    ["enoughTransportNear",   SQFM_fnc_enoughGroupTransportNear],
    ["canBoardNow",                   SQFM_fnc_groupcanBoardNow],
    ["boardingStatus",             SQFM_fnc_groupBoardingStatus],
    ["isBoarded",  {_self call ["boardingStatus"] == "boarded"}],
    ["getBoardingMen",             SQFM_fnc_getGroupBoardingMen],
    ["boardVehicles",               SQFM_fnc_groupBoardVehicles],
    ["boardOwnVehicles",         SQFM_fnc_groupBoardOwnVehicles],
    ["boardAllAvailable",       SQFM_fnc_groupBoardAllAvailable],
    ["postBoarding",                 SQFM_fnc_postGroupBoarding],
    ["boardingStarted",           SQFM_fnc_groupBoardingStarted],
    ["boardingEnded",               SQFM_fnc_groupBoardingEnded],
    ["boardingFailed",             SQFM_fnc_groupBoardingFailed],
    ["endBoarding",                   SQFM_fnc_endGroupBoarding],
    ["boardThenTravel",           SQFM_fnc_groupBoardThenTravel],
    ["ejectAll",             SQFM_fnc_groupEjectFromAllVehicles],

	/********************{OBJECTIVES}***************************/
	["takeObjective",                    SQFM_fnc_takeObjective],
    
    /********************{GROUP MEMBERS}************************/
    ["getUnits",                         SQFM_fnc_getGroupUnits],
    ["getUnitsOnfoot",             SQFM_fnc_getGroupUnitsOnFoot],
    ["getVehiclesInUse",    {(_self call ["getOwnVehicles"])#2}],
    ["getGrpMembers",                    SQFM_fnc_getGrpMembers],
	["crewMen",                              SQFM_fnc_groupCrew],
	["nonCrewMen",                        SQFM_fnc_groupNonCrew],
    ["getGroupCluster",                SQFM_fnc_getGroupCluster],
    ["setGroupCluster",                SQFM_fnc_setGroupCluster],
    ["getAvgPos",                          SQFM_fnc_groupAvgPos],

	/**********************{GROUP CLASS}************************/
	["isUnarmedMotorized",     SQFM_fnc_groupIsUnarmedMotorized],
	["isInfantrySquad",           SQFM_fnc_groupIsInfantrySquad],
	["getGroupType",                         SQFM_fnc_groupType],
	["setGroupType",{_self set["groupType",_self call["getGroupType"]]}],

    /**********************{COMBAT}****************************/
    ["battleInit",                     SQFM_fnc_groupBattleInit],
    ["battleEnd",                       SQFM_fnc_groupBattleEnd],
    ["addShot",                          SQFM_fnc_addGroupShots],
    ["getBattle",  {SQFM_battles get (_self get "battlefield")}],
    ["inBattle",                         SQFM_fnc_groupInBattle],
    ["canInitBattle",               SQFM_fnc_groupCanInitBattle],
    ["sinceBattle",           SQFM_fnc_timeSinceLastGroupBattle],
    ["isNotSuppressing",           SQFM_fnc_grpIsNotSuppressing],
    ["returnFire",                     SQFM_fnc_groupReturnFire],
    ["endReturnFire",   {_self spawn SQFM_fnc_endGrpReturnFire}]
];

private _data = createHashmapObject [_dataArr];

_data call ["setGroupCluster"];
_data call ["setGroupType"];

private _veh1 = (_data call ["getVehiclesInUse"])#0;
if((!isNil "_veh1")
&&{_veh1 getVariable ["SQFM_transport", false]})
then{
    _data set ["transportCrew",    true];
    _data set ["transportVehicle", _veh1];
};

_group setVariable ["SQFM_grpData", _data, true];

_data;
};


SQFM_fnc_setObjectiveData = { 
params[
    ["_module", nil, [objNull]]
];
private _data3d      = [_module] call SQFM_fnc_module3dData;
private _type        = _module getVariable "objectiveType";
private _description = [_type] call SQFM_fnc_objectiveDescription;
private _assetType   = _module getVariable "assetType";
private _assetcount  = _module getVariable "assetCount";
private _distance    = _module getVariable "activationDistance";
private _owner       = sideUnknown;
private _sides       = [];

if(_module getVariable "allowEast")        then {_sides pushBack east;};
if(_module getVariable "allowWest")        then {_sides pushBack west;};
if(_module getVariable "allowIndependent") then {_sides pushBack independent;};

private _dataArr = [
    ["position",    getPosATLVisual _module],
    ["distance",                  _distance],
    ["type",                          _type],
    ["description",            _description],
    ["asset",                    _assetType],
    ["count",                   _assetcount],
    ["owner",                   sideUnknown],
	["assignedGroups",                   []],
	["groupsInArea",                     []],
    ["contested",                     false],
    
    ["3dData",                      _data3d],
    ["3dColor",                   [1,1,1,1]],
    ["3dIcon",    "\A3\ui_f\data\map\markers\military\objective_CA.paa"],
    ["draw3D", SQFM_fnc_drawObjectiveModule]
];

private _data = createhashMapObject [_dataArr];

_module setVariable ["SQFM_objectiveData", _data];

_data;
};

/*********************************/
/*
TODO:
1) Battle-init/End Loop-fix
2) Objective call available units.
    -objective data includes grps under way.

3) Task FSM.
    - Task Area.
    - Task type
    - Travel data
    - Travel needed?
    - Task pause for combat-while traveling.

4) Travel FSM.
    - POST-boarding: Fix it (end state)
    - Get vehicle (if needed) 
    - transport->get out.
    - transport pause for combat 

5) BUGS.
    - crash to desktop on massive friendly fire (eventHandler?)

6) Implement FSM functionality
   - There are 2 sets of states
     1) The overAll task the group is performing
     2) The current action within the context of said task.

The task should be displayed by text.
The action should be displayed by the Icon.
The boarding status should be displayed by a second Icon
*/

SQFM_fnc_initGroupTravel = { 
params[
    ["_movePos",  nil,    [[]]],
    ["_taskName", "move", [""]]
];
// _self call ["setGroupCluster"];

private _grpPos         = _self call ["getAvgPos"];
private _distance       = _movePos distance2D _grpPos;
private _boardingStatus = _self call ["boardingStatus"];
private _travelNow      = _distance < 500 || {_boardingStatus isEqualTo "boarded"};
private _params         = [_movePos, _taskName];

if(_travelNow)
exitWith{
	_self call ["execTravel", _params]; 
	true;
};

if(_self call ["canBoardNow"]
&&{_self call ["boardThenTravel", _params]})
exitWith{true;};

if!(_self call ["canCallTransport"])
exitWith{false;};

private _transport = _self call ["callTransport", [_movePos]];
if(isNull _transport)
exitWith{false;};

true;
};

SQFM_fnc_groupCrew = { 
private _vehicles = _self call ["getVehiclesInUse"];
private _crewMen  = [];

{
	private _driver = driver    _x;
	private _gunner = gunner    _x;
	private _cmmndr = commander _x;
	if(alive _driver)then{_crewMen pushBackUnique _driver};
	if(alive _gunner)then{_crewMen pushBackUnique _gunner};
	if(alive _cmmndr)then{_crewMen pushBackUnique _cmmndr};
	
} forEach _vehicles;

_crewMen;
};

SQFM_fnc_groupNonCrew = { 
private _units   = _self call ["getUnits"];
private _crewMen = _self call ["crewMen"];
private _nonCrew = _units select {!(_x in _crewMen)};

_nonCrew;
};



SQFM_fnc_vehicleDescription = { 
params[
	["_vehicle", nil, [objNull]]
];
private _vehicleData     = [_vehicle]     call objScan_fnc_vehicleData;
private _description     = [_vehicleData] call ObjScan_fnc_vehicleDescription;
private _class           = _vehicleData get"chassis"get"chassisID";
private _classDesc       = _vehicleData get"chassis"get"chassisDescription";

if("Artillery" in _description)
then{_class = 6;};

[_class, _classDesc, _description];
};


SQFM_fnc_vehicleClass = { 
// This description is tailored for SQFSM, 
// for a more precise description use the DCO unitScanner.
params[
	["_class", nil, [0]]
];
if(_class isEqualTo 0.8)          exitwith {"static"};
if(_class>0.8  && {_class < 1.3}) exitwith {"light vehicle"};
if(_class>=1.3 && {_class < 2.6}) exitwith {"light armor"};
if(_class isEqualTo 2.6)          exitwith {"heavy armor"};
if(_class isEqualTo 6)            exitwith {"artillery"};

"unknown";
};


SQFM_fnc_groupIsUnarmedMotorized = { 
private _vehicles = _self call ["getVehiclesInUse"];
if(_vehicles isEqualTo [])exitWith{false};

private _vCount = count _vehicles;
private _mCount = count (_self call ["getUnits"]);
private _cars   = 0;
private _armed  = 0;

if(_mCount <= _vCount)exitWith{false};

{
	private _objKind = [_x] call objScan_fnc_vehicleType;
	if(_objKind isEqualTo "car"
	or{_objKind isEqualTo "MRAP"
	or{_objKind isEqualTo "truck"}})
	then{_cars=_cars+1};

	if("(" in _objKind
	or{_objKind isEqualTo "APC"
	or{_objKind isEqualTo "IFV"
	or{_objKind isEqualTo "Tank"}}})
	then{_armed=_armed+1};
	
} forEach _vehicles;

if(_armed > 0)exitWith{false;};
if(_cars  < 1)exitWith{false;};

true;
};

SQFM_fnc_groupIsInfantrySquad = { 
if(_self call ["boardingStatus"] isEqualTo "on foot") exitWith{true;};
if(_self call ["isUnarmedMotorized"])                 exitWith{true;};

false;
};

SQFM_fnc_groupType = { 
if(_self call ["isInfantrySquad"])exitWith{"infantry";};

private _vehicles   = _self call ["getVehiclesInUse"];
private _classes    = _vehicles apply {([_x] call SQFM_fnc_vehicleDescription)#0};
private _groupClass = selectMax _classes;
private _classDesc  = [_groupClass] call SQFM_fnc_vehicleClass;
private _mixedGroup = count(_self call ["nonCrewMen"])>2;

if(_mixedGroup)then{_classDesc = [_classDesc, " (infantry)"]joinString""};

_classDesc;
};

SQFM_fnc_assetTypesMatch = { 
params[
	["_assetType",nil,[""]],
	["_groupType",nil,[""]]	
];
if(_assetType isEqualTo "infantry"
&&{"infantry" in _groupType})
exitWith{true;};

if(_assetType isEqualTo "cars"
&&{"light vehicle" in _groupType})
exitWith{true;};

if(_assetType isEqualTo "armor_l"
&&{"light armor" in _groupType})
exitWith{true;};

if(_assetType isEqualTo "armor_h"
&&{"heavy armor" in _groupType})
exitWith{true;};

false;
};

SQFM_fnc_canTakeObjective = { 
params[
	["_objectiveModule",nil,[objNull]]
];
private _objctvData  = _objectiveModule getVariable "SQFM_objectiveData";
private _assetWanted = _objctvData get "asset";
private _groupType   = _self       get "groupType";
private _matches     = [_assetWanted, _groupType] call SQFM_fnc_assetTypesMatch;

if!(_matches)exitWith{false;};

true;
};


SQFM_fnc_takeObjective = { 
params[
	["_objectiveModule",nil,[objNull]]
];

};

[testGrp] call SQFM_fnc_initGroupData;
[o1]      call SQFM_fnc_setObjectiveData;
private _grpData  = testGrp getVariable "SQFM_grpData";
private _obctData = o1 getVariable "SQFM_objectiveData";
hint str (_obctData get "asset");
// SQFM_fnc_execGroupTravel = { 
// params[
// 	["_movePos",          nil,[[]]],
// 	["_transportVehicle", nil,[objNull]]
// ];
// _self call ["deleteWaypoints"];
// private _parkingSpot = [_movePos] call SQFM_fnc_findParkingSpot;
// private _targetPos   = _parkingSpot;
// private _onCompleted = '(group this getVariable "SQFM_grpData") call ["onArrival"]';
// if(_movePos distance2D _parkingSpot > 100)then{_targetPos = _movePos;};
// private _wp = (_self get "grp")addWaypoint[_targetPos, 0];



// _wp setWaypointStatements ["true", _onCompleted];
// };


/*********************************/

systemChat "devfiled read";