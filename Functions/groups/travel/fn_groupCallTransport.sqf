params[
	["_dropPos",nil,[[]]]
];
private _spawner = _self call ["getTransportSpawner"];
if(isNil "_spawner")exitWith{false;};

private _group = _self get "grp";
_spawner call ["sendTransport", [_group, _dropPos]];

_self set ["lastTransportCall", round time];

true;