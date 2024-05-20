Params [
	"_currentDir", 
	"_targetDir", 
	"_maxDeviation"
];
_currentDIr       = [_currentDir, false] call SQFM_fnc_formatDir;
_targetDir        = [_targetDir, false]  call SQFM_fnc_formatDir;

if((_targetDir - _maxDeviation) < 0)then{
    _targetDir  = _targetDir  + _maxDeviation;
    _currentDir = _currentDir + _maxDeviation;
}else{
if((_targetDir + _maxDeviation) > 360)then{
    _targetDir  = _targetDir  - _maxDeviation;
    _currentDir = _currentDir - _maxDeviation;
}};

_currentDIr       = [_currentDir, false] call SQFM_fnc_formatDir;
_targetDir        = [_targetDir, false]  call SQFM_fnc_formatDir;

[_currentDir, _targetDir];