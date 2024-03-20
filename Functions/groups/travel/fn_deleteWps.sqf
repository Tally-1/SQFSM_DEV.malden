private _group = _self get"grp";
private _count = count waypoints _group - 1;
for"_i"from 0 to _count do{deleteWaypoint [_group, 0]};

true;