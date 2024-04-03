params[
    ["_side", nil,[""]]
];
private _assetCount = (_self call["getAssignedAssets",[_side]])get"sum";

_assetCount;