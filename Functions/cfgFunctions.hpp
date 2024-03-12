class CfgFunctions
{
	class SQFM
	{
		
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

		};

		class objectiveModule
		{
			file = "Functions\objectiveModule";
			class initObjective             {};
			class setObjectiveData          {};
			class objectiveDescription      {};



		};

		class groups
		{
			file =    "Functions\groups";
			class initGroup           {};
			class initGroupData       {};
			class grpEvents           {};
			class onEnemyDetected     {};
			class onKnowsAboutChanged {};

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

			class handleNewGroups {};


		};
	};
};