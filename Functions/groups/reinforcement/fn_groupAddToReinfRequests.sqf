private _group       = _self get"grp";
private _side        = _self get"side";
private _pos         = _self get"groupCluster"get"position";
private _request     = [_pos, _group, round time];
private _requestList = SQFM_reinforRequests get _side;
private _reqGroups   = _requestList apply {_x#1};

if(_group in _reqGroups)exitWith{
    [["Double request for reinf ", str _group, " deleting last"]] call dbgm;
    false;
};

_requestList pushBackUnique _request;

true;