class CfgFunctions
{
	class SQFM
	{
		
		class battlefield
		{
			file = "functions\battlefield";
			class initBattle                    {};
			class posRadInitBattle              {};
			class initBattleMap                 {};
			class initBattleBuildings           {};
			class updateBattleBuildings         {};
			class getUrbanZones                 {};
			class postInitBattle                {};
			class updateBattle                  {};
			class battleUpdateStrengthData      {};
			class battleUpdateReforData         {};
			class handleNewBattleGroups         {};
			class handleInvalidBattleGroups     {};
			class battlefieldRadius             {};
			class battlefieldDimensions         {};
			class battlefieldCenter             {};
			class getBattleGrid                 {};

			class posInBattleZone               {};
			class nearestBattlePosRad           {};
			class distanceToNearestBattle       {};
			class initBattleGroups              {};
			class endBattleGroups               {};
			class onBattleFirstShot             {};
			class timeSinceLastBattleShot       {};
			
			class endBattle                     {};
			class globalizeBattles              {};
			class battleReinforcements          {};
			class battleReinforceSide           {};
			class battleSideNeedsReinforcements {};

			// class battleHudBroadcast            {};
			class updateBattleHudGlobal         {};
			class battleReplenishGroups         {};

		};

		class battleHud { 
			file = "functions\battleHud";
			class initBattleHud               {};
			class BattleProgressBars          {};
			class updateAllBattleProgressBars {};
			class setBattleBarProgress        {};
			class setBattleHudStrengthBar     {};
			class toggleBattleHud             {};
			class updateBattleHud             {};

			
		};

		class building
		{
			file = "functions\building";
			class isHouse            {};
			class nearBuildings      {};
			class manGetBuilding     {};
			class menInsideBuilding  {};
			class buildingPosCount   {};
			class buildingArrData    {};
			class getBuildingScore   {};
			class sortBuildings      {};
		};

		class clusters
		{
			file = "functions\clusters";
			class clusterRadius           {};
			class objArrData              {};
			class hashifyClusterData      {};
			class cluster                 {};
			class setClusterGrid          {};
			class clustersFromObjArr      {};

		};
		
		class debug
		{
			file =    "functions\debug";
			// class clientLoop             {};
			class debugMessage              {};
			class serverDebugMsg            {};
			class sendDbgMsg                {};
			class debug3D                   {};
			class custom3Dmarkers           {};

			class objective3D               {};
			class drawObjectiveModule       {};
			class setModuleLineColor        {};
			class sideColor                 {};

			class battle3D                  {};
			class drawBattle                {};
			class drawBuilding              {};
			class draw3dMarker              {};
			class multi3dMarkers            {};
			class transportModules3D        {};
			class drawTransportModule       {};
			class drawTransportModuleNoInit {};

		};

		

		class misc
		{
			file = "functions\misc";
			class copyHashmap            {};
			class sideToStrSide          {};
			class removeNull             {};
			class getData                {};
			class sidesFromGroupArr      {};
			class getTextTexture         {};
			class enemiesInZone          {};
			class getLocationNamePos     {};
			class closestLocationName    {};
			class areaName               {};
			class validEnum              {};
			class delayedBaseSideChat    {};
			class zoneStrengthBySide     {};
			class posIsHostile           {};
			class formatCtrlPos          {};
			class newDisplayCtrl         {};
			class allWaypointPositions   {};

		};

		class math
		{
			file = "functions\math";
			class module3dData           {};
			class getModuleArea          {};
			class getAreaCorners         {};
			class areaCornerLines        {};
			class sinCosPos              {};
			class AddZ                   {};
			class roundPos               {};
			class average                {};
			class avgPos2D               {};
			class getMidpoint            {};
			class straightPosArr         {};
			class squareGrid             {};
			class getNearest             {};
			class pos360                 {};
			class getCircleLines         {};
			class clearPos               {};
			class clearPosSqrArea        {};
			class clearPosInArea         {};
			class posHasTerrainCover     {};
			class posIsHidden            {};
			class numDiff                {};
			class decimals               {};
			class objectShape            {};
			class shapeFitsShape         {};

			class roadsInArea            {};
			class findParkingSpot        {};
			class getAreaParkingPos      {};
			class formatDir              {};
			class lineBroken             {};
			class selectSafePositions    {};
			class semiCirclePosArr       {};
			class formatDirRanges        {};
			class inDirRange             {};
			class dangerZoneSafePositions{};
			class describeDistance       {};
			class describeDir            {};

		};

		class objectiveModule
		{
			file =       "functions\objectiveModule";
			class initObjective                   {};
			class setObjectiveData                {};
			class setObjectiveMethods             {};
			class updateMethodsAllObjectives      {};
			class objectiveDescription            {};
			class assetTypesMatch                 {};
			class objectiveAssignGroup            {};
			class objectiveUnAssignGroup          {};
			class objectiveGetAssignedAssets      {};
			class objectiveNeedsTroops            {};
			class objectiveGetContested           {};
			class objectiveSetContested           {};
			class objectiveGetSidesInZone         {};
			class objectiveUpdate                 {};
			class updateAllObjectives             {};
			class objectiveCountAssignedAssets    {};
			class objectivesSorted                {};
			class nearestObjective                {};
			class objectiveStoreSafePosSearch     {};
			class objectiveGetStoredSafePositions {};
			class objectiveSafeposMatch           {};
			class objectiveRemoveSafePosSearches  {};
			class objectiveOnCapture              {};

		};

		class transportModule
		{
			file = "functions\transportModule";
			class initTransportSpawner    {};
			class transportVehicleData    {};
			class transportSpawnPosClear  {};
			class spawnerGetVehicleType   {};
			class transportSpawnPos       {};
			class spawnTransport          {};
			class initAllTransportModules {};
			class transportCrewGetOutEh   {};
			class onTransportCrewGetOut   {};
		};

		class transportTask
		{
			file = "functions\transportModule\transportTask";
			class sendTransport           {};
			class transportInitTask       {};
			class transportAvailability   {};
			class onPickupWpTransporter   {};
			class onDropOffWpTransporter  {};
			class onReturnWpTransporter   {};
			class transportPostboarding   {};
			class transportUnload         {};
			class transportUnloadStatus   {};
			class transportCondition      {};
			class updateTransport         {};
			class onTransportCombatDrop   {};
			class onPassengerCombatDrop   {};
			class emergencyParking        {};
			class transportAborted        {};
			class transportEnded          {};
			class setTransportGrpData     {};

		};

		class transportTask_events
		{
			file = "functions\transportModule\transportTask\events";
			class setTransportEvents    {};
			class removeTransportEvents {};
			class onTransportCrewHit    {};
			class onPassengerHit        {};
			class onPassengerFired      {};
			class onTransportCrewFired  {};
			class onTransportDamaged    {};

		};

		class man
		{
			file = "functions\man";
			class unconscious                 {};
			class isRealMan                   {};
			class functionalMan               {};
			class hostile                     {};
			class validEnemy                  {};
			class firstValidGroupMember       {};
			class getAssignedVehicles         {};
			class teleportIntoAssignedVehicle {};
			class manForceMoveToPos           {};
		};

		class vehicle
		{
			file = "functions\vehicle";
			class deadCrew                 {};
			class crewSize                 {};
			class validVehicle             {};
			class isLandVehicle            {};
			class vehiclesCanTransportMen  {};
			class validEnemyVehicle        {};
			class validLandEntity          {};
			class getNearAvailVehicles     {};
			class validAvailableVehicle    {};
			class menGetInSingleVehicle    {};
			class manGetInvehicle          {};
			class menCanTeleportBoard      {};
			class sortTravelVehicleList    {};
			class menOrderGetInVehicles    {};
			class vehicleEjectDeadAndUncon {};
			class vehicleDescription       {};
			class vehicleClass             {};
			class isArmedCar               {};
			class isLightArmor             {};
			class isHeavyArmor             {};

		};

		class vehicle_crwData
		{
			file = "functions\vehicle\crwData";
			class crewData                  {};
			class cargoSeatData             {};
			class hashifySeatData           {};
			class clearSeat                 {};
			class seatStatus                {};
		};

		class groups_global
		{
			file =    "functions\groups";
			class validGroup               {};
			class initGroup                {};
			class initGroupData            {};
			class setGroupMethods          {};
			class addToDataAllGroups       {};
			class getGroupsZone            {};
			class groupsInZone             {};
			class updateMethodsAllGroups   {};
			class isPlayerGroup            {};
			class groupBehaviourSettings   {};
			class groupGetBehaviorModule   {};
			class getNearestGroup          {};
			class setGroupOwner            {};
		};

		class groups_abilities
		{
			file = "functions\groups\abilities";
			class getGroupAbilities          {};
			class groupAttackOnly            {};
			class groupDefendOnly            {};
		}

		class groups_combat
		{
			file = "functions\groups\combat";
			class groupInBattle             {};
			class groupCanInitBattle        {};
			class addGroupShots             {};
			class groupBattleInit           {};
			class groupBattleEnd            {};
			class timeSinceLastGroupBattle  {};
			class groupNearEnemyGrp         {};
			class groupAttackGroup          {};
			class groupCombatZone           {};
			class groupUpdateBattleStrength {};
		};
		
		class groups_suppress
		{
			file = "functions\groups\suppress";
			class groupReturnFire     {};
			class grpIsNotSuppressing {};
			class endGrpReturnFire    {};
		};

		class groups_events
		{
			file = "functions\groups\events";
			class grpEvents                   {};
			class onEnemyDetected             {};
			class onKnowsAboutChanged         {};
			class onSquadManFired             {};
			class onSquadManSuppressed        {};
			class onUnitJoined                {};
			class groupAddUnitEventHandler    {};
			class groupRemoveUnitEventHandler {};
			class handleNoCrashDamage         {};
			class noCrashDamage               {};
			class onWaypointComplete          {};
			
		};

		class groups_travel
		{
			file = "functions\groups\travel";
			class validGroupVehicle          {};
			class leaveInvalidVehicles       {};
			class nearGroupVehicles          {};
			class allAvailableGroupVehicles  {};
			class onArrival                  {};
			class deleteWps                  {};
			class initGroupTravel            {};
			class execGroupTravel            {};
			class groupPickupPos             {};
			class groupGetTransportSpawner   {};
			class groupCanCallTransport      {};
			class groupCallTransport         {};
			class groupIsTraveling           {};
			class groupAddWayPoint           {};
			class groupWaitForTransportSpawn {};
		};

		class groups_boarding
		{
			file = "functions\groups\boarding";
			class groupCanSelfTransport     {};
			class groupBoardOwnVehicles     {};
			class groupBoardAllAvailable    {};
			class enoughGroupTransportNear  {};
			class groupBoardingStatus       {};
			class groupcanBoardNow          {};
			class getGroupBoardingMen       {};
			class groupBoardingStarted      {};
			class groupBoardingEnded        {};
			class groupBoardingFailed       {};
			class groupBoardVehicles        {};
			class postGroupBoarding         {};
			class endGroupBoarding          {};
			class groupBoardThenTravel      {};
			class groupEjectFromAllVehicles {};
		};

		class groups_members
		{
			file = "functions\groups\members";
			class getGrpMembers            {};
			class getGroupUnits            {};
			class getGroupUnitsOnFoot      {};
			class getGroupCluster          {};
			class setGroupCluster          {};
			class groupAvgPos              {};
			class getGroupVehicles         {};
			class groupCrew                {};
			class groupNonCrew             {};
			class groupTallyAssets         {};
			class groupIsUnarmedMotorized  {};
			class groupIsInfantrySquad     {};
			class groupType                {};
			class groupGetStrSide          {};
			class groupSetStrengthIcon     {};
			class getGroupStrength         {};
			class groupStrengthCoef        {};
			class groupMergeWithGroup      {};
			class initSquadMembers         {};

		};

		class groups_tasks
		{
			file = "functions\groups\tasks";
			class initTaskData            {};
			class endTask                 {};
			class endTaskGroup            {};
			class abortTask               {};
			class reapplyTask             {};
			class addTaskWaypoint         {};
			class groupRemoveTask         {};
			class removeFromTaskList      {};
			class getGroupTask            {};
			class groupCanRecieveNewTask  {};
			class groupActionStatus       {};
			
		};

		class groups_debug
		{
			file = "functions\groups\debug";
			class groups3D                {};
			class group3D                 {};
			class group3DNoData           {};
			class group3DIcon             {};
			class group3DColor            {};
			class group3DText             {};
			class units3D                 {};
			class groupDebugText          {};
			class groupDebugTextAbilities {};
			class groupFlashAction        {};
		};

		class groups_objectives
		{
			file = "functions\groups\objectives";
			class group_validObjective            {};
			class groupObjectiveInRange           {};
			class groupGetNearObjectives          {};
			class groupIsInsideObjective          {};
			class groupAssignObjective            {};
			class groupUnAssignObjective          {};
			class groupOnObjectiveArrival         {};
			class groupInitObjectiveTask          {};
			class groupTakeObjective              {};
			class groupGuardObjective             {};
			class groupObjectiveData              {};
			class groupAutoAssignObjective        {};
			class groupTypeMatchObjective         {};
			class groupObjectiveHostile           {};
			class groupObjectiveInsertPosStandard {};
			class groupObjectiveInsertPosDanger   {};
			class groupObjectiveInsertPos         {};
			class groupObjectiveAssignedHostiles  {};
			class groupCanLeaveObjective          {};
			class groupCanAssignObjective         {};

			/*Attack*/
			class assignGroupObjectivesAllSides   {};
			class assignGroupsAndObjectives       {};
			class groupAssignAttackObjective      {};
			class groupObjectiveAttackLoop        {};
			class groupEndObjectiveAttack         {};
			class groupAttackObjective            {};
			class groupAssignDefenseObjective     {};


		};

		class groups_tactics
		{
			file = "functions\groups\tactics";
			class groupGarrison            {};
			class groupGetNearUrbanZones   {};
			class groupCanIdleGarrison     {};
			class groupInitIdleGarrison    {};
			class groupGetInBuilding       {};
			class groupIdleGarrison        {};
			class waypointIdleGarrison     {};
			
		};

		class groups_misc
		{
			file = "functions\groups\misc";
			class groupIsIdle              {};
			class groupUpdate              {};
			class activeWp                 {};
			class getIdleGroups            {};
			class getCategorizedGroups     {};
			class assignAllGroupTasks      {};
			class assignGroupsMapIdleCover {};
			class assignGroupsIdleCover    {};
			class groupSetDataDelayed      {};
			class groupUnstop              {};
			
		};

		class groups_reinforcement_radio
		{
			file = "functions\groups\reinforcement\radio";
			class groupCallReinforcementRadio {};
			class reinfRequestRadioResponse   {};
			class sendReinfRadioResponse      {};
		};
		
		class groups_reinforcement
		{
			file = "functions\groups\reinforcement";
			class groupAddToReinfRequests     {};
			class groupOnReinforceArrival     {};
			class groupEndReinforcing         {};
			class assignReinforcementsBySide  {};
			class assignAllReinforcements     {};
			class groupReinforceInsertPos     {};
			class groupInitReinforceTask      {};
			class groupCanCallReinforcements  {};
			class groupRequestReinforcements  {};
			class groupAbleToReinforce        {};
		};

		class groups_replenish
		{
			file = "functions\groups\replenish";
			class groupCanReplenish             {};
			class groupCanBeReplenished         {};
			class groupCanReplenishGroup        {};
			class groupReplenishGroupDirect     {};
			class groupReplenishTaskEnd         {};
			class groupReplenishGroup           {};
			class groupNeedsCombatReplenish     {};
			class groupCanCombatReplenish       {};
			class groupCombatReplenishAlgorythm {};
			class groupCombatReplenish          {};
		
		};

		class groups_pushNear
		{
			file = "functions\groups\pushNear";
			class groupAbleToHunt             {};
			class isHuntGroup                 {};
			class sendHuntGroups              {};
			class groupHuntCondition          {};
			class groupInitHunt               {};
			class groupInitHuntTask           {};
			class onGroupHuntWp               {};
			class onGroupHuntEnd              {};
		};

		class reinforcements
		{
			file = "functions\reinforcements";
			class initReinforRequestsMap   {};
			class addReinfReq              {};
		};

		class init
		{
			file = "functions\init";
			class initSQFSM     {postInit = 1};
			class serverInit    {};
			class initSettings  {};
			class clientInit    {};
			class initgameState {};
			// class CBAOptions    {preInit = 1; file = "CBA_Options\main.sqf"};
		};

		class globalEvents
		{
			file = "functions\globalEvents";
			class groupSpawnedEh             {};
			class projectileCreated          {};
			class onProjectileCreated        {};
			class entityKilledEh             {};
			class ACE_MedicalEvents          {};
			class ACE_Medical_OnStatusChange {};
			class curatorEvents              {};
			class onCuratorGroupSelection    {};
			class buildingChangedEh          {};
			class onCuratorWaypoint          {};
		};

		class taskManager
		{
			file = "functions\taskManager";
			class taskManager     {};
			class tenSecondTasks  {};
			class minuteTasks     {};
			class fiveMinTasks    {};
		};

		class tasks
		{
			file = "functions\taskManager\tasks";
			class handleNewGroups  {};
			class handleDeadGroups {};
			class updateAllGroups  {};
		};
		
	};
};