extends "res://stages/loadout/RelichuntPopup.gd"

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")
const TORMENT_BUTTON_NAME = "TormentButton"

var tormentButton

func init():
	.init()
	GameWorld.tormentDifficulty = 0
	
	if get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TormentButton") == null:
		var yafiButton = find_node("DifficultyButton3")
		tormentButton = Button.new()
		tormentButton.name = TORMENT_BUTTON_NAME
		tormentButton.text = "Torment"
		tormentButton.visible = GameWorld.isUnlocked(CONST.DIFFICULTY_YAFI)
		tormentButton.toggle_mode = true
		tormentButton.group = yafiButton.group
		tormentButton.rect_min_size = Vector2(150, 0)
		tormentButton.connect("pressed", self, "_on_tourmentButton_pressed", [])
		
		var buttonsNode = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer") 
		
		if buttonsNode != null:
			buttonsNode.add_child(tormentButton)
		
		yafiButton.text = "YAFI"
		yafiButton.rect_min_size = Vector2(150, 0)
		find_node("DifficultyButton1").rect_min_size = Vector2(150, 0)
		find_node("DifficultyButton2").rect_min_size = Vector2(150, 0)
		find_node("DifficultyButton4").rect_min_size = Vector2(150, 0)
		
		
		Style.init(self)
	
func _on_tourmentButton_pressed():
	Audio.sound("gui_select")
	find_node("DifficultyIcon").texture = preload("res://mods-unpacked/Arrcival-Torment/content/torment_loadout_diff.png")
	find_node("DifficultyExplanationLabel").text = "loadout.difficulty.torment.description"
	GameWorld.loadoutStageConfig.difficulty = 2
	
	
	var i = preload("res://gui/PopupInput.gd").new()
	i.popup = preload("res://mods-unpacked/Arrcival-Torment/content/TormentCarouselPopup.tscn").instance()
	i.popup.relichuntPopup = self
	get_parent().add_child(i.popup)
	i.popup.ready()

func updateTormentButton():
	var text = "Torment"
	if GameWorld.tormentDifficulty > 0:
		text += " " + CONSTARRC.toRoman(GameWorld.tormentDifficulty)
	tormentButton.text = text
