extends "res://stages/loadout/ModePopup.gd"

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")

var relichuntPopup

var scoreNode = null
var hpNode
var lengthNode
var dmgNode
var hardnessNode

var switchNode
var cobaltNode
var bonusTimeNode
var ironNode
var waterNode
var relicNode

func init():
	Style.init(self)
	
func ready():
	scoreNode = find_node("Score")
	hpNode = find_node("totalHP")
	lengthNode = find_node("totalWaveTime")
	dmgNode = find_node("totalDamageTaken")
	hardnessNode = find_node("minimumhardness")
	switchNode = find_node("switch")
	cobaltNode = find_node("cobalt")
	bonusTimeNode = find_node("bonustime")
	ironNode = find_node("iron")
	waterNode = find_node("water")
	relicNode = find_node("relic")
	switchNode.pressed = GameWorld.corruptions.harderRelicSwitchTiles
	cobaltNode.pressed = GameWorld.corruptions.limitedCobalt
	bonusTimeNode.pressed = GameWorld.corruptions.bonusTimeHalved
	waterNode.pressed = GameWorld.corruptions.limitedWater
	ironNode.pressed = GameWorld.corruptions.ironDisappears
	relicNode.pressed = GameWorld.corruptions.harderRelicTiles
	updateEverything(false)
	updateScore()
	InputSystem.grabFocus(switchNode)

func updateScore():
	scoreNode.text = str(GameWorld.corruptions.getTotalScore())

func _on_switch_toggled(button_pressed):
	GameWorld.corruptions.harderRelicSwitchTiles = button_pressed
	updateScore()

func _on_cobalt_toggled(button_pressed):
	GameWorld.corruptions.limitedCobalt = button_pressed
	updateScore()

func _on_bonustime_toggled(button_pressed):
	GameWorld.corruptions.bonusTimeHalved = button_pressed
	updateScore()

func _on_water_toggled(button_pressed):
	GameWorld.corruptions.limitedWater = button_pressed
	updateScore()

func _on_iron_toggled(button_pressed):
	GameWorld.corruptions.ironDisappears = button_pressed
	updateScore()

func _on_relic_toggled(button_pressed):
	GameWorld.corruptions.harderRelicTiles = button_pressed
	updateScore()

func _on_lessHP_pressed():
	GameWorld.corruptions.bonusHealth -= 1
	updateHP()

func _on_moreHP_pressed():
	GameWorld.corruptions.bonusHealth += 1
	updateHP()

func updateHP():
	hpNode.text = "+" + str(GameWorld.corruptions.bonusHealth * CONSTARRC.HEALTH_PER_TIER) + "%"
	find_node("lessHP").disabled = GameWorld.corruptions.bonusHealth == 0
	find_node("moreHP").disabled = GameWorld.corruptions.bonusHealth == CONSTARRC.MAXIMUM_HEALTH
	updateScore()
	
func _on_moreTime_pressed():
	GameWorld.corruptions.removedTime -= 1
	updateTime()

func _on_lessTime_pressed():
	GameWorld.corruptions.removedTime += 1
	updateTime()

func updateTime():
	lengthNode.text = "-" + str(GameWorld.corruptions.removedTime * CONSTARRC.LENGTH_PER_TIER) + "s"
	find_node("moreTime").disabled = GameWorld.corruptions.removedTime == 0
	find_node("lessTime").disabled = GameWorld.corruptions.removedTime == CONSTARRC.MAXIMUM_LENGTH
	updateScore()

func _on_lessDmg_pressed():
	GameWorld.corruptions.increasedDamage -= 1
	updateDamage()

func _on_moreDmg_pressed():
	GameWorld.corruptions.increasedDamage += 1
	updateDamage()

func updateDamage():
	dmgNode.text = "+" + str(GameWorld.corruptions.increasedDamage * CONSTARRC.DAMAGE_PER_TIER) + "%"
	find_node("lessDmg").disabled = GameWorld.corruptions.increasedDamage == 0
	find_node("moreDmg").disabled = GameWorld.corruptions.increasedDamage == CONSTARRC.MAXIMUM_DAMAGE
	updateScore()

func _on_lessHard_pressed():
	GameWorld.corruptions.hardnessTier -= 1
	updateHardness()

func _on_moreHard_pressed():
	GameWorld.corruptions.hardnessTier += 1
	updateHardness()
	
func updateHardness():
	hardnessNode.text = CONSTARRC.getHardnessText(GameWorld.corruptions.hardnessTier)
	find_node("lessHard").disabled = GameWorld.corruptions.hardnessTier == 0
	find_node("moreHard").disabled = GameWorld.corruptions.hardnessTier == CONSTARRC.MAXIMUM_HARDNESS
	updateScore()

func updateEverything(resetPreset = true):
	updateDamage()
	updateTime()
	updateHP()
	updateHardness()
	if resetPreset:
		GameWorld.corruptions.preset = 0

func _on_tier1_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = false
	bonusTimeNode.pressed = false
	ironNode.pressed = false
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 0
	GameWorld.corruptions.removedTime = 0
	GameWorld.corruptions.increasedDamage = 1
	GameWorld.corruptions.hardnessTier = 0
	updateEverything()
	GameWorld.corruptions.preset = 1

func _on_tier2_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = false
	bonusTimeNode.pressed = false
	ironNode.pressed = false
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 0
	GameWorld.corruptions.removedTime = 1
	GameWorld.corruptions.increasedDamage = 2
	GameWorld.corruptions.hardnessTier = 0
	updateEverything()
	GameWorld.corruptions.preset = 2

func _on_tier3_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = false
	ironNode.pressed = false
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 2
	GameWorld.corruptions.removedTime = 1
	GameWorld.corruptions.increasedDamage = 3
	GameWorld.corruptions.hardnessTier = 0
	updateEverything()
	GameWorld.corruptions.preset = 3

func _on_tier4_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = false
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 2
	GameWorld.corruptions.removedTime = 2
	GameWorld.corruptions.increasedDamage = 4
	GameWorld.corruptions.hardnessTier = 0
	updateEverything()
	GameWorld.corruptions.preset = 4

func _on_tier5_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = false
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 2
	GameWorld.corruptions.removedTime = 2
	GameWorld.corruptions.increasedDamage = 5
	GameWorld.corruptions.hardnessTier = 1
	updateEverything()
	GameWorld.corruptions.preset = 5

func _on_tier6_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = true
	waterNode.pressed = false
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 2
	GameWorld.corruptions.removedTime = 3
	GameWorld.corruptions.increasedDamage = 6
	GameWorld.corruptions.hardnessTier = 1
	updateEverything()
	GameWorld.corruptions.preset = 6

func _on_tier7_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = true
	waterNode.pressed = true
	relicNode.pressed = false
	GameWorld.corruptions.bonusHealth = 4
	GameWorld.corruptions.removedTime = 3
	GameWorld.corruptions.increasedDamage = 7
	GameWorld.corruptions.hardnessTier = 1
	updateEverything()
	GameWorld.corruptions.preset = 7


func _on_tier8_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = true
	waterNode.pressed = true
	relicNode.pressed = true
	GameWorld.corruptions.bonusHealth = 4
	GameWorld.corruptions.removedTime = 4
	GameWorld.corruptions.increasedDamage = 8
	GameWorld.corruptions.hardnessTier = 1
	updateEverything()
	GameWorld.corruptions.preset = 8


func _on_tier9_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = true
	waterNode.pressed = true
	relicNode.pressed = true
	GameWorld.corruptions.bonusHealth = 6
	GameWorld.corruptions.removedTime = 4
	GameWorld.corruptions.increasedDamage = 9
	GameWorld.corruptions.hardnessTier = 1
	updateEverything()
	GameWorld.corruptions.preset = 9


func _on_tier10_pressed():
	switchNode.pressed = true
	cobaltNode.pressed = true
	bonusTimeNode.pressed = true
	ironNode.pressed = true
	waterNode.pressed = true
	relicNode.pressed = true
	GameWorld.corruptions.bonusHealth = 4
	GameWorld.corruptions.removedTime = 5
	GameWorld.corruptions.increasedDamage = 10
	GameWorld.corruptions.hardnessTier = 2
	updateEverything()
	GameWorld.corruptions.preset = 10

func _on_CancelButton_pressed():
	Audio.sound("gui_select")
	relichuntPopup.tormentLeave()
	queue_free()
