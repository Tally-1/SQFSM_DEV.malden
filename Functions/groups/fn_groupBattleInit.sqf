params [
	["_battlePos",nil,[[]]] // center of battle, used as key in the SQFM_battles hashmap.
];

_self set ["battlefield",          _battlePos];
_self set ["state",               "In battle"];
_self set ["action",    "Reacting to contact"];
_self set ["available",                 false];