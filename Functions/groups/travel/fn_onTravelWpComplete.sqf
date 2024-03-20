_self call ["deleteWaypoints"];

_self deleteAt "travelData";
_self set ["action", ""];
_self set ["state",  ""];

hint str "Waypond ndded";