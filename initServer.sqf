[] execVM "devFile.sqf";

addMissionEventHandler ["GroupCreated", {_this spawn{
	// private _script = [] execVM "devFile.sqf"; 

	// waitUntil { 
	// 		private _done = scriptDone _script;
	// 		if(isNil "_done") exitWith{true};
	// 		if(_done)         exitWith{true};
			
	// 		false;
	// 	};
	
	if(side _this in [east, west, independent])
	then{lastGrp = _this;};

}}];

true;