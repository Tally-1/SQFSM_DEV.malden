(str SQFM_fnc_groupObjectiveInsertPos splitString " = ") findIf {
"'SQFM_fnc_" in _x}



SQFM_fnc_groupInitMechClearingFormation = { 
private _vehicles  = _self call ["getVehiclesInUse"];
private _men       = _self call ["getUnitsOnfoot"];
private _group     = _self get "grp";
private _formation = formation _group;
private _leaderVeh = vehicle formLeader leader _group;

{_x lockCargo true} forEach _vehicles;
_leaderVeh forceSpeed 3;
_men allowGetIn false;
_group setFormation "FILE";

if(count _men < 6)exitWith{};

private _formationScript = [_leaderVeh] spawn SQFM_fnc_mechFileFormationLoop;

_leaderVeh setVariable ["SQFM_mechFormationScript", _formationScript];

true;
};


SQFM_fnc_mechCanMaintainFormation = { 
params[
    ["_vehicle", nil, [objNull]]
];
private _group = group _vehicle;
if(isNil "_group")   exitWith{"nil group" call dbgm;   false};
if(isNil "_vehicle") exitWith{"nil vehicle" call dbgm; false};
if(isNull _group)    exitWith{"null group" call dbgm;  false};

private _badVehicle = !([_vehicle]call SQFM_fnc_validVehicle);
if(_badVehicle)exitWith{"vehicle invalid" call dbgm; false};


true;
};

SQFM_fnc_mechFileFormationLoop = { 
params[
    ["_vehicle", nil, [objNull]]
];
private _keepFormation = [_vehicle] call SQFM_fnc_mechCanMaintainFormation;
while {_keepFormation} do {

    _keepFormation = [_vehicle] call SQFM_fnc_mechCanMaintainFormation;
    [_vehicle] call SQFM_fnc_mechFileFormation;
    if!(_keepFormation)exitWith{};

    sleep 1;
};

};

SQFM_fnc_mechFileFormationPositions = { 
params[
    ["_vehicle",nil, [objNull]],
    ["_posCount",nil,      [0]]
];
private _posDist    = 2;
private _corners    = [_vehicle] call SQFM_fnc_getObjectCorners;
private _dir        = [(getDirVisual _vehicle)-180] call SQFM_fnc_formatDir;
private _rightCount = round(_posCount/2);
private _leftCount  = round(_rightCount % _posCount);

private _rightStart = _corners#1;
private _rightEnd   = [_rightStart, _dir, _posCount*_posDist] call SQFM_fnc_sinCosPos;
private _rightArr   = [_rightStart, _rightEnd, _rightCount,false] call SQFM_fnc_straightPosArr;

private _leftStart = _corners#0;
private _leftEnd   = [_leftStart, _dir, _posCount*_posDist] call SQFM_fnc_sinCosPos;
private _leftArr   = [_leftStart, _rightEnd, _rightCount,false] call SQFM_fnc_straightPosArr;


[_rightArr] call SQFM_fnc_showPosArr3D;


};

SQFM_fnc_mechFileFormation = { 
params[
    ["_vehicle",nil,[objNull]]
];

private _group     = group _vehicle;
private _men       = units _group select{vehicle _x isEqualTo _x};
private _teamR     = _men select [0, round (count _men/2)];
private _teamL     = _men select {!(_x in _teamR)};





true;
};


SQFM_fnc_switchUnit_exit = { 
/*
	Function:
		SQFM_fnc_switchUnit_exit
	
	Authors:
		Kex
	
	Description:
		terminates "Achilles_fnc_switchUnit_start"
	
	Parameters:
		_unitDies	- <BOOLEAN> [false] True if the unit dies after the exit.
	
	Returns:
		nothing
	
	Examples:
		(begin example)
		[] call SQFM_fnc_switchUnit_exit;
		(end)
*/

#include "\A3\ui_f_curator\ui\defineResinclDesign.inc"

params
[
	["_unitDies", false, [false]]
];

private _unit = bis_fnc_moduleRemoteControl_unit;
if (isNull _unit) exitWith {bis_fnc_moduleRemoteControl_unit = nil};
(_unit getVariable "Achilles_var_switchUnit_data") params ["_","_playerUnit","_damageAllowed", "_face", "_speaker", "_goggles"];
if (isNull _playerUnit) exitWith {_unit setVariable ["Achilles_var_switchUnit_data", nil, true]};
// reset camera positions
private _unitPos = getposatl _unit;
private _camPos = [_unitPos,10,direction _unit + 180] call bis_fnc_relpos;
_camPos set [2,(_unitPos select 2) + (getterrainheightasl _unitPos) - (getterrainheightasl _camPos) + 10];
(getassignedcuratorlogic _playerUnit) setvariable ["bis_fnc_modulecuratorsetcamera_params",[_camPos,_unit]];
_unit removeEventHandler ["HandleDamage", _unit getVariable "Achilles_var_switchUnit_damageEHID"];

// remove actions
private _addActionID = _unit getVariable ["Achilles_var_switchUnit_addAction", nil];
if (!isNil "_addActionID") then {_unit removeAction _addActionID};
_addActionID = _unit getVariable ["Achilles_var_switchUnit_addBreachDoorAction", nil];
if (!isNil "_addActionID") then {[_unit, _addActionID] call BIS_fnc_holdActionRemove};

if(isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	private _eh_id = _unit getVariable ["Achilles_var_switchUnit_ACEdamageEHID", -1];
	if (_eh_id != -1) then 
	{
		["ace_unconscious", _eh_id] call CBA_fnc_removeEventHandler;
		_unit setVariable ["Achilles_var_switchUnit_ACEdamageEHID", nil];
	};
};
selectPlayer _playerUnit;
_playerUnit enableAI "ALL";
_playerUnit allowDamage _damageAllowed;
// open curator interface and reset position on map
openCuratorInterface;
private _curatorMapCtrl = ((findDisplay IDD_RSCDISPLAYCURATOR) displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP);
_curatorMapCtrl ctrlMapAnimAdd [0, 0.1, _camPos]; 
ctrlMapAnimCommit _curatorMapCtrl;
[_unit, _face] remoteExecCall ["setFace", 0];
[_unit, _speaker] remoteExecCall ["setSpeaker", 0];
_unit addGoggles _goggles;
_unit setVariable ["Achilles_var_switchUnit_data", nil, true];
bis_fnc_moduleRemoteControl_unit = nil;
if (_unitDies) then {_unit setDamage 1};

};

SQFM_switchUnit_start = { 
/*
	This is a modified version of the "Achilles_fnc_switchUnit_start" function.
    The original work can be found at:
    https://github.com/ArmaAchilles/Achilles/releases/tag/v1.3.1

    Usage example:
    [_man] call SQFM_switchUnit_start;

*/

private _error = "";
private _man = effectiveCommander (param [0]);
if (!(side group _man in [east,west,resistance,civilian])) then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorEmpty";};
if (isPlayer _man)                                         then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer";};
if (!alive _man)                                           then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorDestroyed";};
if (isClass (configfile >> "CfgPatches" >> "ace_medical") 
&& {_man getVariable ["ACE_isUnconscious", false]})        then {_error = localize "STR_AMAE_ERROR_man_IS_UNCONSCIOUS";};
if (isNull _man)                                           then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorNull";};
if (isUAVConnected vehicle _man)                           then {_error = localize "str_a3_cfgvehicles_moduleremotecontrol_f_errorControl";};
if (unitIsUAV vehicle _man)                                then {_error = localize "STR_AMAE_ERROR_VEHICLE_IS_A_DRONE";};
if (_error != "")                                           exitWith {[_error] call Achilles_fnc_ShowZeusErrorMessage; nil};

private _player = player;
private _damage_allowed = isDamageAllowed _player;
private _face = face _man;
private _speaker = speaker _man;
private _goggles = goggles _man;
_man setVariable ["Achilles_var_switchUnit_data",[name _man, _player, _damage_allowed, _face, _speaker, _goggles], true];
bis_fnc_moduleRemoteControl_man = _man;

// fix teleportation bug: for some unkown reason the unit may get teleported to the camera position
curatorCamera setDir getDir _man;
curatorCamera setPosWorld getPosWorld _man;

selectPlayer _man;
[_man, _face] remoteExecCall ["setFace", 0];
[_man, _speaker] remoteExecCall ["setSpeaker", 0];
[_man, _goggles] spawn {params ["_man", "_goggles"]; sleep 1; _man addGoggles _goggles};

[_player] call SQFM_fnc_switchUnitDeactivatePlayer;
[_man]    call SQFM_fnc_switchUnitReleaseAction;
[_man]    call SQFM_fnc_switchUnitEh;

if(isClass (configfile >> "CfgPatches" >> "ace_medical")) then
{
	_eh_id = ["ace_unconscious", {if (_this select 1 and {_this select 0 == player}) then {[] call SQFM_fnc_switchUnit_exit}}] call CBA_fnc_addEventHandler;
	_man setVariable ["Achilles_var_switchUnit_ACEdamageEHID", _eh_id];
};

};


SQFM_fnc_switchUnitDeactivatePlayer = { 
params[
    ["_player",nil,[objNull]]
];

_player disableAI "ALL";
_player enableAI "ANIM";
_player allowDamage false;

true;
};

SQFM_fnc_switchUnitReleaseAction = { 
params[
    ["_man",nil,[objNull]]
];
private _addActionID = _man addAction [
"Release Direct control", 
{
	params["_target", "_caller", "_id"];
	disableSerialization;
	_target removeAction _id;
	[] call SQFM_fnc_switchUnit_exit;
}, nil, 0, false];

_man setVariable ["Achilles_var_switchUnit_addAction", _addActionID];

_addActionID;
};


SQFM_fnc_switchUnitEh = { 
params[
    ["_man",nil,[objNull]]
];
private _eh = _man addEventHandler ["HandleDamage",
{
	params ["_man", "_selection", "_handler"];
	
	if (_handler >= 0.999) then
	{
		if (_selection in ["","body","head"]) then
		{[true] call SQFM_fnc_switchUnit_exit};
		_handler = 0.999;
	};

	_handler;
}];

_man setVariable ["Achilles_var_switchUnit_damageEHID", _eh];

true;
};