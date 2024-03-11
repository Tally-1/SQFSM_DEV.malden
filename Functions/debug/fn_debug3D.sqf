if(!isnil "SQFM_markers3D")exitWith{};
SQFM_markers3D          = true;
SFSM_Custom3Dpositions = [];

addMissionEventHandler ["Draw3D", {
if(SQFM_debugMode)
then{
		call SQFM_fnc_custom3Dmarkers;
}}];