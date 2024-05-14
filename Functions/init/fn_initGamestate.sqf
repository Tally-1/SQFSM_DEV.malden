// Contains global variables used all over the mod.
// I may turn it into a hashmap to allow for OOP programming.

private _objectiveRanges = (entities "SQFSM_Objective")apply{_x getVariable "activationDistance"};
private _maxObjRange     = selectMax _objectiveRanges;

if((-1) in _objectiveRanges)
then{_maxObjRange = worldSize;};

SQFM_manValue          = 1;
SQFM_carValue          = 3;
SQFM_ApcValue          = 5;
SQFM_MbtValue          = 9;
SQFM_maxObjectiveRange = _maxObjRange;
SQFM_newGroups         = [];
SQFM_deadGroups        = [];
SQFM_battleList        = [];
SQFM_validSides        = [east, west, independent];
SQFM_battles           = createHashmapObject [[]];