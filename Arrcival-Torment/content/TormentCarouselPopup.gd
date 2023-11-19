extends "res://stages/loadout/ModePopup.gd"

var currentTierPicked = 1

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")

var relichuntPopup = null

var leftButton
var rightButton
var lessButton
var moreButton
var pickButton
var backButton

func init():
	Style.init(self)
	
func ready():
	leftButton = find_node("LeftButton")
	rightButton = find_node("RightButton")
	pickButton = find_node("PickButton")
	leftButton = find_node("LessButton")
	moreButton = find_node("MoreButton")
	backButton = find_node("CancelButton")
	refreshContainers()
	pickButton.grab_focus()

func refreshContainers():
	var leftNode = find_node("LeftContainer")
	var rightNode = find_node("RightContainer")
	var limitsNode = find_node("Limits")
	leftNode.visible = currentTierPicked > CONSTARRC.LOWEST_TIER and currentTierPicked <= CONSTARRC.HIGHEST_TIER
	rightNode.visible = currentTierPicked >= CONSTARRC.LOWEST_TIER and currentTierPicked < CONSTARRC.HIGHEST_TIER
	limitsNode.visible = currentTierPicked >= CONSTARRC.HIGHEST_TIER
	find_node("PreviousModifierTier").text = CONSTARRC.toRoman(currentTierPicked - 1)
	find_node("CurrentModifierTier").text = CONSTARRC.toRoman(currentTierPicked)
	find_node("NextModifierTier").text = CONSTARRC.toRoman(currentTierPicked + 1)
	find_node("LostModifier").text = "loadout.torment.tormentmodifierslowered" + str(currentTierPicked)
	find_node("TotalModifiers").text = "loadout.torment.tormentmodifiers" + str(min(currentTierPicked, CONSTARRC.HIGHEST_TIER))
	find_node("GainedModifier").text = "loadout.torment.tormentmodifiersincreased" + str(currentTierPicked)
	find_node("HPIncrease").text = str(currentTierPicked * 5) + "%"
	find_node("LessButton").visible = currentTierPicked > CONSTARRC.HIGHEST_TIER
	
	if currentTierPicked == CONSTARRC.HIGHEST_TIER:
		pickButton.grab_focus()
		pickButton.set_focus_neighbour(MARGIN_RIGHT, moreButton.get_path())
	if currentTierPicked == CONSTARRC.HIGHEST_TIER - 1:
		pickButton.set_focus_neighbour(MARGIN_RIGHT, rightButton.get_path())
	if currentTierPicked == CONSTARRC.LOWEST_TIER:
		pickButton.grab_focus()
		

func _on_LeftButton_pressed():
	Audio.sound("gui_select")
	if currentTierPicked > CONSTARRC.LOWEST_TIER:
		currentTierPicked -= 1
		refreshContainers()

func _on_RightButton_pressed():
	Audio.sound("gui_select")
	if currentTierPicked < CONSTARRC.HIGHEST_TIER:
		currentTierPicked += 1
		refreshContainers()

func _on_CancelButton_pressed():
	Audio.sound("gui_select")
	GameWorld.tormentDifficulty = 0
	if relichuntPopup != null:
		relichuntPopup._on_DifficultyButton3_pressed(false)
		var yafiNode = relichuntPopup.find_node("DifficultyButton3")
		yafiNode.pressed = true
		yafiNode.grab_focus()
		relichuntPopup.updateTormentButton()
	queue_free()

func _on_PickButton_pressed():
	Audio.sound("gui_select")
	GameWorld.tormentDifficulty = currentTierPicked
	if relichuntPopup != null:
		var tormentButton = relichuntPopup.find_node("TormentButton")
		relichuntPopup.updateTormentButton()
	queue_free()

func _on_MoreButton_pressed():
	Audio.sound("gui_select")
	if currentTierPicked < CONSTARRC.HIGHEST_TIER_CAP:
		currentTierPicked += 1
		refreshContainers()


func _on_LessButton_pressed():
	Audio.sound("gui_select")
	if currentTierPicked >= CONSTARRC.HIGHEST_TIER:
		currentTierPicked -= 1
		refreshContainers()
