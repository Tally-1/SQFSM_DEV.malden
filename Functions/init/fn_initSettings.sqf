if(isNil "SQFM_debugMode")then{
	SQFM_debugMode         = true; // Debug-mode active 
	SQFM_boardTeleportDist = 30;   // How far away a group of men can be in order to teleport into a vehicle.
	SQFM_travelWalkDist    = 500;
};

// 0.1 settings
missionNamespace setVariable ["SQFM_debugMode", SQFM_debugMode, true];
missionNamespace setVariable ["SQFM_boardTeleportDist", SQFM_boardTeleportDist, true];
missionNamespace setVariable ["SQFM_travelWalkDist", SQFM_travelWalkDist, true];


/*****************/
true;