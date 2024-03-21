dbgm = SQFM_fnc_debugMessage;

if(hasInterface) then{[] spawn SQFM_fnc_clientInit;};
if(isServer)     then{[] spawn SQFM_fnc_serverInit;};

true;