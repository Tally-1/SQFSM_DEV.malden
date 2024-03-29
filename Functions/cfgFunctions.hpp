class CfgFunctions
{
	class SQFM
	{
		
		class battlefield
		{
			file = "Functions\battlefield";
			class initBattle              {};
			class initBattleMap           {};
			class initBattleBuildings     {};
			class getUrbanZones           {};
			class postInitBattle          {};
			class updateBattle            {};
			class battlefieldRadius       {};
			class battlefieldDimensions   {};
			class getBattleGrid           {};

			class posInBattleZone         {};
			class nearestBattlePosRad     {};
			class initBattleGroups        {};
			class endBattleGroups         {};
			class onBattleFirstShot       {};
			class timeSinceLastBattleShot {};
			
			class endBattle               {};

		};

		class building
		{
			file = "Functions\building";
			class isHouse       {};
			class nearBuildings {};
		};

		class clusters
		{
			file = "Functions\clusters";
			class clusterRadius      {};
			class objArrData         {};
			class hashifyClusterData {};
			class cluster            {};
			class setClusterGrid     {};

		};
		
		class debug
		{
			file = "Functions\debug";
			// class clientLoop             {};
			class debugMessage              {};
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
			file = "Functions\misc";
			class copyHashmap   {};
			class sideToStrSide {};
			class removeNull    {};

		};

		class math
		{
			file = "Functions\math";
			class module3dData    {};
			class getModuleArea   {};
			class getAreaCorners  {};
			class areaCornerLines {};
			class sinCosPos       {};
			class AddZ            {};
			class roundPos        {};
			class average         {};
			class avgPos2D        {};
			class getMidpoint     {};
			class straightPosArr  {};
			class squareGrid      {};
			class getNearest      {};
			class pos360          {};
			class getCircleLines  {};
			class clearPos        {};
			class clearPosSqrArea {};
			class clearPosInArea  {};
			class findParkingSpot {};
			class numDiff         {};
			class decimals        {};
			class objectShape     {};
			class shapeFitsShape  {};

		};

		class objectiveModule
		{
			file = "Functions\objectiveModule";
			class initObjective              {};
			class setObjectiveData           {};
			class objectiveDescription       {};
			class assetTypesMatch            {};
			class objectiveAssignGroup       {};
			class objectiveUnAssignGroup     {};
			class objectiveGetAssignedAssets {};
			class objectiveNeedsTroops       {};
		};

		class transportModule
		{
			file = "Functions\transportModule";
			class initTransportSpawner    {};
			class transportVehicleData    {};
			class transportSpawnPosClear  {};
			class spawnerGetVehicleType   {};
			class transportSpawnPos       {};
			class spawnTransport          {};
			class initAllTransportModules {};
		};

		class transportTask
		{
			file = "Functions\transportModule\transportTask";
			class sendTransport           {};
			class transportAvailability   {};
			class onPickupWpTransporter   {};
			class onDropOffWpTransporter  {};
			class onReturnWpTransporter   {};
			class transportPostboarding   {};
		};

		class man
		{
			file = "Functions\man";
			class unconscious                 {};
			class isRealMan                   {};
			class functionalMan               {};
			class hostile                     {};
			class validEnemy                  {};
			class firstValidGroupMember       {};
			class getAssignedVehicles         {};
			class teleportIntoAssignedVehicle {};
		};

		class vehicle
		{
			file = "Functions\vehicle";
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
			file = "Functions\vehicle\crwData";
			class crewData                  {};
			class cargoSeatData             {};
			class hashifySeatData           {};
			class clearSeat                 {};
			class seatStatus                {};
		};

		class groups_global
		{
			file =    "Functions\groups";
			class validGroup               {};
			class initGroup                {};
			class initGroupData            {};
			class addToDataAllGroups       {};
			class getGroupsZone            {};
			class groupsInZone             {};
		};

		class groups_combat
		{
			file = "Functions\groups\combat";
			class groupInBattle            {};
			class groupCanInitBattle       {};
			class addGroupShots            {};
			class groupBattleInit          {};
			class groupBattleEnd           {};
			class timeSinceLastGroupBattle {};

		};
		
		class groups_suppress
		{
			file = "Functions\groups\suppress";
			class groupReturnFire     {};
			class grpIsNotSuppressing {};
			class endGrpReturnFire    {};
		};

		class groups_events
		{
			file = "Functions\groups\events";
			class grpEvents           {};
			class onEnemyDetected     {};
			class onKnowsAboutChanged {};
			
		};

		class groups_travel
		{
			file = "Functions\groups\travel";
			class validGroupVehicle         {};
			class leaveInvalidVehicles      {};
			class nearGroupVehicles         {};
			class allAvailableGroupVehicles {};
			class onArrival                 {};
			class deleteWps                 {};
			class initGroupTravel           {};
			class execGroupTravel           {};
			class groupPickupPos            {};
			class groupGetTransportSpawner  {};
			class groupCanCallTransport     {};
			class groupCallTransport        {};
		};

		class groups_boarding
		{
			file = "Functions\groups\boarding";
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
			file = "Functions\groups\members";
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
		};

		class groups_tasks
		{
			file = "Functions\groups\tasks";
			class initTaskData    {};
			class endTask         {};
			class addTaskWaypoint {};
		};

		class groups_debug
		{
			file = "Functions\groups\debug";
			class groups3D             {};
			class group3D              {};
			class group3DNoData        {};
			class group3DIcon          {};
			class group3DColor         {};
			class group3DText          {};
			class units3D              {};
		};

		class groups_objectives
		{
			file = "Functions\groups\objectives";
			class group_validObjective {};
		};

		class init
		{
			file = "Functions\init";
			class initSQFSM     {postInit = 1};
			class serverInit    {};
			class initSettings  {};
			class clientInit    {};
			class initgameState {};
		};

		class globalEvents
		{
			file = "Functions\globalEvents";
			class groupSpawnedEh      {};
			class projectileCreated   {};
			class onProjectileCreated {};

		};

		class taskManager
		{
			file = "Functions\taskManager";
			class taskManager     {};
			class tenSecondTasks  {};
			class minuteTasks     {};
			class fiveMinTasks    {};
		};

		class tasks
		{
			file = "Functions\taskManager\tasks";
			class handleNewGroups  {};
			class handleDeadGroups {};
			class updateAllGroups  {};
		};

	};
};