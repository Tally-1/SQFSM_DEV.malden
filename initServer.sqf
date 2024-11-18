[] execVM "devFile.sqf";

addMissionEventHandler ["GroupCreated", {_this spawn{
	if(side _this in [east, west, independent])
	then{lastGrp = _this;};

}}];

// bin\config.bin/CfgVehicles/ModuleRemoteControl_F

addMissionEventHandler ["EntityCreated", {_this call DEV_fnc_onEntityCreated}];

DEV_fnc_onEntityCreated = { 
params[
	["_entity",nil,[objNull]]
];
if!(_entity isKindOf "logic")exitWith{};
// copyToClipboard str configOf _entity;
// systemChat str _this;

};


true;