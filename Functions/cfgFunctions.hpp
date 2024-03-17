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
			class clusterRadius   {};
			class objArrData      {};
			class cluster         {};
			class setClusterGrid  {};

		};
		
		class debug
		{
			file = "Functions\debug";
			// class clientLoop          {};
			class debugMessage        {};
			class sendDbgMsg          {};
			class debug3D             {};
			class custom3Dmarkers     {};

			class objective3D         {};
			class drawObjectiveModule {};
			class setModuleLineColor  {};

			class groups3D            {};
			class group3D             {};
			class group3DNoData       {};
			class sideColor           {};

			class battle3D            {};
			class drawBattle          {};
			class drawBuilding        {};
			class draw3dMarker        {};
			class multi3dMarkers      {};

		};

		class misc
		{
			file = "Functions\misc";
			class copyHashmap {};

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

		};

		class objectiveModule
		{
			file = "Functions\objectiveModule";
			class initObjective             {};
			class setObjectiveData          {};
			class objectiveDescription      {};



		};

		class man
		{
			file = "Functions\man";
			class unconscious           {};
			class isRealMan             {};
			class functionalMan         {};
			class hostile               {};
			class validEnemy            {};
			class firstValidGroupMember {};
		};

		class vehicle
		{
			file = "Functions\vehicle";
			class deadCrew          {};
			class validVehicle      {};
			class validEnemyVehicle {};
			class validLandEntity   {};

		};

		class groups
		{
			file =    "Functions\groups";
			class validGroup          {};
			class initGroup           {};
			class initGroupData       {};
			class grpEvents           {};
			class onEnemyDetected     {};
			class onKnowsAboutChanged {};
			class addToDataAllGroups  {};

			class groupInBattle       {};
			class addGroupShots       {};

			class groupBattleInit     {};
			class groupBattleEnd      {};
		};
		
		class groups_suppress
		{
			file = "Functions\groups\suppress";
			class groupReturnFire     {};
			class grpIsNotSuppressing {};
			class endGrpReturnFire    {};
			
		
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
		};

	};
};