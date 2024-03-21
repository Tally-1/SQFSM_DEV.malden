// Contains global variables used all over the mod.
// I may turn it into a hashmap to allow for OOP programming.
SQFM_newGroups  = [];
SQFM_deadGroups = [];
SQFM_battleList = [];
SQFM_validSides = [east, west, independent];

SQFM_battles = createHashmapObject [[["GameStart", systemTimeUTC]]];
SQFM_battles deleteAt "GameStart";