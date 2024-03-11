dbgm = SQFM_fnc_debugMessage;

if(hasInterface) then{call SQFM_fnc_clientInit;};
if(isServer)     then{call SQFM_fnc_serverInit;};


true;