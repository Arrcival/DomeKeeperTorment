extends "res://stages/loadout/RelichuntPopup.gd"

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")
const TORMENT_BUTTON_NAME = "TormentButton"
const CONTAINER_NAME = "TormentContainer"

var tormentButton
var tormentText

func init():
	.init()
	
	if get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3/TormentContainer") == null:
		var yafiButton = find_node("DifficultyButton3")
		tormentButton = Button.new()
		tormentButton.name = TORMENT_BUTTON_NAME
		tormentButton.text = "Corruptions"
		tormentButton.visible = GameWorld.isUnlocked(CONST.DIFFICULTY_YAFI)
		tormentButton.toggle_mode = true
		tormentButton.rect_min_size = Vector2(150, 0)
		tormentButton.connect("pressed", self, "_on_tourmentButton_pressed", [])
		
		tormentText = Label.new()
		tormentText.set_align(Label.ALIGN_CENTER)
		tormentText.set_valign(Label.VALIGN_CENTER)
		
		var buttonsNode = get_node_or_null("PanelContainer/MarginContainer/VBoxContainer/HBoxContainer5/VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer3") 
		
		var fullContainer = VBoxContainer.new()
		fullContainer.name = CONTAINER_NAME
		fullContainer.add_child(tormentText)
		fullContainer.add_child(tormentButton)
		
		
		if buttonsNode != null:
			buttonsNode.add_child(fullContainer)
				
		Style.init(self)
	
func _on_tourmentButton_pressed():
	Audio.sound("gui_select")
	
	
	var i = preload("res://gui/PopupInput.gd").new()
	#i.popup = preload("res://mods-unpacked/Arrcival-Torment/content/TormentCarouselPopup.tscn").instance()
	i.popup = preload("res://mods-unpacked/Arrcival-Torment/content/TormentCorruptionsPopup.tscn").instance()
	i.popup.relichuntPopup = self
	get_parent().add_child(i.popup)
	i.popup.ready()

func tormentLeave():
	InputSystem.grabFocus(tormentButton)
	var text = ""
	var score = GameWorld.corruptions.getTotalScore()
	if score > 0:
		text += "Score : " + str(score) + "\n"
	var preset = GameWorld.corruptions.preset
	if preset > 0:
		text += "Tier " + CONSTARRC.toRoman(preset)
	tormentText.text = text
	
