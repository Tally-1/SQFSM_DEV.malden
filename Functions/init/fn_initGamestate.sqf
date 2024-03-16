SQFM_newGroups  = [];
SQFM_deadGroups = [];
SQFM_battleList = [];

SQFM_battles = createHashmapObject [[["GameStart", systemTimeUTC]]];
SQFM_battles deleteAt "GameStart";