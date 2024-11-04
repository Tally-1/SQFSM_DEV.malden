#include "..\..\misc\textIncludes.sqf";
private _groupName     = str (_self get "grp");
private _title         = [_bigTxt,_aqua, _groupName, _end,_end]joinString"";
private _action        = _self get "action";
private _actionStatus  = _self call ["actionStatus"];
private _strength      = _self call ["getStrength"];
private _strengthI     = _self get "initialStrength";
private _actionText    = [_subCategoryTitle, "Action: ", _end, _subCategoryText,  (_self get "action"), _end]joinString"";
private _stateText     = [_subCategoryTitle, "State: ", _end, _subCategoryText,  (_self get "state"), _end]joinString"";
private _idleText      = _self call ["debugIdleText"];
private _statusText    = [_subCategoryTitle, "Task-Status: ", _end, _subCategoryText,  _actionStatus, _end]joinString"";
private _typeText      = [_subCategoryTitle, "Type: ", _end, _subCategoryText,  (_self get "groupType"), _end]joinString"";
private _classText     = [_subCategoryTitle, "Class: ", _end, _subCategoryText, (_self get "squadClass"), _end]joinString"";
private _strengthText  = [_subCategoryTitle, "Strength: ", _end, _subCategoryText, _strength,"/",_strengthI, _end]joinString"";
private _abilityString = call SQFM_fnc_groupDebugTextAbilities;
private _taskName      = _self get "taskData" get "name";
private _taskText      = "";

if(!isNil "_taskName")then{ 
    _taskText = [_newLine,_green,_center,_mediumTxt,"(",_taskName,")",_enddd] joinString"";
};

private _text = parseText 
([
    _outLine,
    _title,
    _taskText,
    _newLine, _actionText,
    _newLine, _stateText,
    _newLine, _idleText,
    _newLine, _statusText,
    _newLine, _typeText,
    _newLine, _classText,
    _newLine, _strengthText,
    _newLine,_abilityString,
    _newLine, _signature

] joinString "");

_text;