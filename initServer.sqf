[] execVM "devFile.sqf";

addMissionEventHandler ["GroupCreated", {[] execVM "devFile.sqf"; lastGrp = _this;}];

true;