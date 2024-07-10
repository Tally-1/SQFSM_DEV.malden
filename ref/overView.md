 unit: Object - object the event handler is assigned to
 selection: String - name of the selection where the unit was damaged.
 damage: Number - resulting level of damage for the selection
 source: Object - the source unit that caused the damage
 projectile: String - classname of the projectile that caused inflicted the damage. ("" for unknown)
 hitPartIndex: Number - hit part index of the hit point, -1 otherwise
 instigator: Object - person who pulled the triggerision damage, etc.
 context: Number - some additional context for the event:

0 : TotalDamage - total damage adjusted before iteration through hitpoints
1 : HitPoint - some hit point processed during iteration
2 : LastHitPoint - the last hitpoint from iteration is processed
3 : FakeHeadHit - head hit that is added/adjusted
4 : TotalDamageBeforeBleeding - total damage is adjusted before calculating bleeding