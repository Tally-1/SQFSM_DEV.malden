class CfgFunctions
{
	class SQFM
	{
		
		class battlefield
		{
			file = "Functions\battlefield";
			class initBattle            {};
			class initBattleMap         {};
			class battlefieldRadius     {};
			class battlefieldDimensions {};
			class getBattleGrid         {};

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
			class clusterRadius {};
			class objArrData    {};
			class cluster       {};

		};
		
		class debug
		{
			file = "Functions\debug";
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

		};

		class misc
		{
			file = "Functions\misc";

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

		};
		
		class init
		{
			file = "Functions\init";
			class initSQFSM    {postInit = 1};
			class serverInit   {};
			class initSettings {};
			class clientInit   {};
		};

		class globalEvents
		{
			file = "Functions\globalEvents";
			class groupSpawnedEh {};

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