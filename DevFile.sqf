scr = [] execVM "devFile2.sqf";
waitUntil {scriptDone scr;};

systemChat "devfiled found";
addToGroups = SQFM_fnc_addToDataAllGroups;
// SQFM_Custom3Dpositions = [[getPosATL player, "playerPos"]];
// SQFM_fnc_
// SQFM_battles

/*********************************/
/*


*/


// ["battleInit", SQFM_fnc_groupBattleInit] call addToGroups;
/**************************************************************/

/*********************************/
systemChat "devfiled read";