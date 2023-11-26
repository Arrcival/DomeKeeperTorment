extends HudElement

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")

func _ready():
	hide()
	if GameWorld.corruptions.getTotalScore() > 0:
		var text = "Corruptions " + str(GameWorld.corruptions.getTotalScore())
		if GameWorld.corruptions.preset > 0:
			text += " (" + CONSTARRC.toRoman(GameWorld.corruptions.preset) + ")"
		$TierDisplay.text = text
		show()
