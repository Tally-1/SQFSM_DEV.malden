if(isNil "SQFM_debugMode")then{
	SQFM_debugMode = true;
	SQFM_boardTeleportDist = 100;
};

// 0.1 settings
missionNamespace setVariable ["SQFM_debugMode", SQFM_debugMode, true];
missionNamespace setVariable ["SQFM_boardTeleportDist", SQFM_boardTeleportDist, true];


/*****************/
true;