params [
	["_pos",     nil, [[]]], 
	["_baseRad", nil,  [0]]
];
private _minRad        = SQFM_minBattleSize;
private _maxRad        = SQFM_maxBattleSize;
private _nearBattleRad = [_pos] call SQFM_fnc_distanceToNearestBattle;
private _returnRad     = _baseRad;
private _checkRad      = _baseRad*3;
private _nearObj       = [_midPoint] call SQFM_fnc_nearestObjective;

// If the battle takes place inside an objective then use the objective as a battleGround.
if((!isNil "_nearObj")
&&{_nearObj distance2D _pos < 2})
then{
        private _objData = _nearObj call getData;
        private _zone    = _objData get "zone";
        private _objRad  = _zone#1;

        _minRad      = _objRad;
        _returnRad   = _objRad;
        _checkRad = selectMax[_objRad*2, _objRad+300, _baseRad*2];
};

// Make sure battlefield is within params defined above and in the initGamestate file.
if(_nearBattleRad < _maxRad) then{_maxRad   = _nearBattleRad;};
if(_checkRad      < _minRad) then{_checkRad = _minRad};
if(_checkRad      > _maxRad) then{_checkRad = _maxRad};

private _entities = _pos nearEntities ['land', _checkRad];

private _filter = {
	private _grpData = group _x getVariable "SQFM_grpData";
	private _valid   = (!isNil "_grpData" 
                    && {[_x] call SQFM_fnc_validLandEntity 
                    && {!(_grpData call ["inBattle"])}});

	_valid;
};

_entities = _entities select _filter;
private _entitiesRad = [_pos, _entities] call SQFM_fnc_clusterRadius;

// Reinforce the battlefield limits.
if  (_returnRad < _entitiesRad)
then{_returnRad = _entitiesRad};

if  (_returnRad < _minRad)
then{_returnRad = _minRad};

// Add a little padding
_returnRad = selectMax[ceil(_returnRad*1.2), ceil(_returnRad+100)];

// enforce max battlefield size.
if  (_returnRad > _maxRad)
then{_returnRad = _maxRad};

_returnRad;