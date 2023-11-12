extends "res://content/monster/Monster.gd"

func _ready():
	currentHealth = getTormentBonusHealth(currentHealth)
	maxHealth = currentHealth
	
	
	
func getTormentBonusHealth(health):	
	var percentageBonusHealth = 1.0
	if GameWorld.tormentDifficulty >= 7:
		percentageBonusHealth += 0.2
	if GameWorld.tormentDifficulty >= 3:
		percentageBonusHealth += 0.2
	return health * percentageBonusHealth
