private _allSquads       = [];
private _attackSquads    = [];
private _hunters         = [];
private _reinforceSquads = [];
private _reconSquads     = [];
private _supportSquads   = [];
private _getAvailable    = {
    params[["_category",nil,[""]]];
    _self get _category select { 
        private _grpDt = _x call getData;

        _grpDt call["isIdle"] &&
        {!(_grpDt call["isPlayerGroup"])};
    };
};

private _removeGroup = {isNil{
    params[["_group",nil,[grpNull]]];
    {
        private _array    = _y;
        if(typeName _array isEqualTo "ARRAY"
        &&{_group in _array})
        then{_array deleteAt (_array find _group)};
        
    } forEach _self;

}};

private _removeMultiple = { 
    params[["_groups",nil,[[]]]];
    {_self call ["remove",[_x]]} forEach _groups;
    true;
};

{isNil{
        private _abilities  = [_x] call SQFM_fnc_getGroupAbilities;
        private _notSupport = !("support" in _abilities);

        if("attack"    in _abilities &&{_notSupport}) then{_attackSquads    pushBack _x};
        if("hunt"      in _abilities &&{_notSupport}) then{_hunters         pushBack _x};
        if("reinforce" in _abilities &&{_notSupport}) then{_reinforceSquads pushBack _x};
        if("recon"     in _abilities &&{_notSupport}) then{_reconSquads     pushBack _x};
        if("valid"     in _abilities &&{_notSupport}) then{_allSquads       pushBack _x};

        if("support" in _abilities)
        then{_supportSquads pushBack _x};
        

}} forEach allGroups;

{
    // Current result is saved in variable _x
    
} forEach _supportSquads;

private _allCategories = [
    ["all",                  _allSquads],
    ["attackSquads",      _attackSquads],
    ["hunters",                _hunters],
    ["reinforcements", _reinforceSquads],
    ["recon",              _reconSquads],
    ["support",          _supportSquads],

    /*************METHODS**************/
    ["getAvailable",      _getAvailable],
    ["remove",             _removeGroup],
    ["removeMultiple",  _removeMultiple]
];
private _categoryMap = createHashmapObject [_allCategories];


_categoryMap;