extends HudElement

func _ready():
	hide()
	if GameWorld.tormentDifficulty > 0:
		$TierDisplay.text = "Torment " + str(GameWorld.tormentDifficulty)
		show()
