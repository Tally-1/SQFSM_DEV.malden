params[
    ["_side",nil,[""]] // ["west","east","independent"]
];

if(isNil "_side")exitWith{
    "Side was not passed to 'needsTroops'"call dbgm;
    false;
};

private _strengthNeeded   = _self get "assetStrength";
private _assignedStrength = (_self call ["getAssignedAssets", [_side]])get"sum";
private _moreNeeded = _assignedStrength < _strengthNeeded;

_moreNeeded;