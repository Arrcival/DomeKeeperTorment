extends "res://content/gamemode/RunStats.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	if GameWorld.corruptions.getTotalScore() > 0:
		var box = HBoxContainer.new()
		var l = Label.new()
		l.text = "Corruption score: "
		box.add_child(l)
		l = Label.new()
		l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		l.align = Label.ALIGN_RIGHT
		l.text = str(GameWorld.corruptions.getTotalScore())
		box.add_child(l)
		$StatContainer.add_child(box)
