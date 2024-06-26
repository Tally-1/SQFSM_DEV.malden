private _display = uiNameSpace getVariable ["SQFM_BattleHUD",displayNull]; 
if(isNil "SQFM_currentBattle")
exitWith{_display closeDisplay 1};


private _battle  = SQFM_currentBattle;
private _zone    = _battle get "zone";
private _camPos  = (positionCameraToWorld [0,0,0]);
private _inZone  = (_camPos distance2D (_zone#0))<(_zone#1);

if!(_inZone) exitWith{_display closeDisplay 1};

if(isNull _display)
then{_display = [_zone] call SQFM_fnc_initBattleHud};

private _strengthData = _battle get "strengthData";
if(isNil "_strengthData")exitWith{};

private _strengthBar = _display getVariable "SQFM_HUD"get"strengthBar";
[_strengthData, _strengthBar] call SQFM_fnc_setBattleHudStrengthBar;

true;