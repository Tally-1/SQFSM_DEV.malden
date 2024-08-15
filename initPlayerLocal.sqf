enableEnvironment false;
[] spawn{
waituntil {!isNull (findDisplay 46)};

(findDisplay 46) displayAddEventHandler 
["KeyDown", "
			private _Pressed = false;
			if ((_this # 1) == 79) then {execVM 'devFile.sqf'; _Pressed = true};
_Pressed"];

(findDisplay 46) displayAddEventHandler ["KeyDown", {

    if (inputAction "CuratorInterface" > 0)then{[]spawn{sleep 0.5;
		(findDisplay 312)displayAddEventHandler ["KeyDown", "
		private _Pressed = false;
		if((_this#1) isEqualTo 79)then{
			execVM 'devFile.sqf'; 
			_Pressed = true;
		};
		_Pressed;
		"];
	}};

    false;
}];
};



//if ((_this # 1) == 80) then {hint 'reCompiling...'; [5] call BIS_fnc_recompile; _Pressed = true};