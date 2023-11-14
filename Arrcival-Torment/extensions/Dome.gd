extends "res://content/dome/Dome.gd"

func requestProjectileDamage(rawDamage:int, pos:Vector2, requester):
	var tormentDamage = getTormentDamage(rawDamage)
	.requestProjectileDamage(tormentDamage, pos, requester)

func requestMeleeDamage(rawDamage:int, pos:Vector2, requester):
	var tormentDamage = getTormentDamage(rawDamage)
	.requestMeleeDamage(tormentDamage, pos, requester)

func getTormentDamage(rawDamage)->int:
	var multiplier = 1 + GameWorld.tormentDifficulty * 0.05
	return int(rawDamage * multiplier)
