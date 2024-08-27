// [player, aa] call SQFM_fnc_getSuppressionTargetPosition;
/*
params [
	"_intersectPosASL",    // Position where line intersects surface
	"_surfaceNormal",     //  Vector normal to the intersected surface
	"_intersectObj",     //   Object the surface belongs to (proxy-object. Ex: The current weapon of a man)
	"_parentObject",    //    Proxy-objects parent. (Ex: The man holding said weapon)- objNull if terrain
	"_selectionNames", //     Array of Strings (Names of the intersected selections) (bones).
	"_pathToBisurf"   //      String - path to intersected surface properties (.bisurf) file.
];
*/
// SQFM_fnc_battleReinforceSide     = {};
// SQFM_fnc_initBattleMap            = {};
// SQFM_fnc_handleNewBattleGroups     = {};
// SQFM_fnc_handleInvalidBattleGroups  = {};
// SQFM_fnc_updateBattle                = {};
// SQFM_fnc_battleReinforcements         = {};
// SQFM_fnc_battleSideNeedsReinforcements = {};
// SQFM_fnc_zoneStrengthBySide           = {};
// SQFM_fnc_onTransportCrewFired        = {};
// SQFM_fnc_onPassengerFired           = {};
// SQFM_fnc_onPassengerHit            = {};
// SQFM_fnc_onTransportCrewHit       = {};
// SQFM_fnc_removeTransportEvents   = {};
// SQFM_fnc_setTransportEvents     = {};
// SQFM_fnc_transportInitTask     = {};
// SQFM_fnc_transportEnded       = {};
// SQFM_fnc_transportCondition  = {};
// SQFM_fnc_updateTransport    = {};
// SQFM_fnc_manGetBuilding    = {};
// SQFM_fnc_menInsideBuilding = {};
// SQFM_fnc_buildingPosCount  = {};
// SQFM_fnc_buildingArrData   = {};
// SQFM_fnc_getBuildingScore  = {};
// SQFM_fnc_sortBuildings     = {};
// SQFM_fnc_nearBuildings     = {};
// SQFM_fnc_manForceMoveToPos = {};
// SQFM_fnc_groupFlashAction  = {};
// SQFM_fnc_groupGetInBuilding = {};
// SQFM_fnc_groupGarrison      = {};
// SQFM_fnc_onCuratorWaypoint   = {};
// SQFM_fnc_groupUnstop          = {};
// SQFM_fnc_waypointIdleGarrison = {};
// SQFM_fnc_groupIdleGarrison   = {};
// SQFM_fnc_addPosMarker = {};
// SQFM_fnc_drawObjectiveMarkers = {};
// SQFM_fnc_objectiveUpdateMarkers = {};
// SQFM_fnc_addCircleMarker = {};
// SQFM_fnc_addRectangleMarker = {};
// SQFM_fnc_flashActionMan = {};
// SQFM_fnc_man3dAction = {};
// SQFM_fnc_isUrbanArea = {};
// SQFM_fnc_objectiveSetUrbanStatus = {};
// SQFM_fnc_posArrToPath = {};
// SQFM_fnc_groupInfClearObjective = {};
// SQFM_fnc_groupInfClearUrbanObjective = {};
// SQFM_fnc_groupGetUrbanObjInfSearchP = {};
// SQFM_fnc_searchNearBuildings = {};
// SQFM_fnc_objectiveGetZoneMidPositions = {};
// SQFM_fnc_allBuildingsPositions = {};
// SQFM_fnc_getRoadData = {};
// SQFM_fnc_hashifyRoads = {};
// SQFM_fnc_roadIsZoneExit = {};
// SQFM_fnc_getZoneExitRoads = {};
// SQFM_fnc_getZoneRoadmap = {};
// SQFM_fnc_groupVehicleClearUrbanObjective = {};
// SQFM_fnc_groupVehicleClearObjective     = {};
// SQFM_fnc_zonePosArr                    = {};
// SQFM_fnc_zoneCone                     = {};
// SQFM_fnc_semiCirclePosArr            = {};
// SQFM_fnc_objectiveGetZoneCone       = {};
// SQFM_fnc_lineBroken                = {};
// SQFM_fnc_manInFipo                = {};
// SQFM_fnc_validMan                = {};
// SQFM_fnc_functionalMan          = {};
// SQFM_fnc_manEjectThenCover     = {};
// SQFM_fnc_manEjectFromVehicle  = {};
// SQFM_fnc_mechUnloadActivateMen = {};
// SQFM_fnc_deployVehicleSmoke     = {};
// SQFM_fnc_getVehiclePassengers    = {};
// SQFM_fnc_mechUnloadPositions      = {};
// SQFM_fnc_mechUnloadEnd             = {};
// SQFM_fnc_manCurrentBuilding         = {};
// SQFM_fnc_validSurfaceIntersections   = {};
// SQFM_fnc_getSuppressionTargetPosition = {};
// SQFM_fnc_getBuildingSuppressionPos   = {};
// SQFM_fnc_posOnVector                = {};
// SQFM_fnc_getSuppressionTarget      = {};
// SQFM_fnc_suppressionTargetValue   = {};
// SQFM_fnc_zoneSuppressionTargets  = {};
// SQFM_fnc_getObjectCorners       = {};
// SQFM_fnc_displayCtrlSetFont    = {};
// SQFM_fnc_displayAddCtrl        = {};
// SQFM_fnc_displayAddCheckBox     = {};
// SQFM_fnc_displayAddButton        = {};
// SQFM_fnc_btnCtrlAddFunction       = {};
// SQFM_fnc_displayAddFrame           = {};
// SQFM_fnc_displayCtrlSpawnString     = {};
// SQFM_fnc_ctrlSpawnText               = {};
// SQFM_fnc_addCuratorGroupMenuButton    = {};
// SQFM_fnc_initCuratorSquadMenuButtons   = {};
// SQFM_fnc_initCuratorSquadMenuBackground = {};
// SQFM_fnc_initGroupData                 = {};
// SQFM_fnc_setGroupMethods              = {};
// SQFM_fnc_setObjectiveData            = {};
// SQFM_fnc_setObjectiveMethods       = {};



