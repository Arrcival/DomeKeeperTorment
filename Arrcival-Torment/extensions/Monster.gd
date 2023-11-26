extends "res://content/monster/Monster.gd"

func _ready():
	currentHealth = getTormentBonusHealth(currentHealth)
	maxHealth = currentHealth

func getTormentBonusHealth(health):	
	var percentageBonusHealth = 1.0 + (GameWorld.corruptions.getHPIncrease() / 100.0)
	return health * percentageBonusHealth
