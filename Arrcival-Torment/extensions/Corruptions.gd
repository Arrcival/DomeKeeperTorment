var harderRelicSwitchTiles = false
var limitedCobalt = false
var bonusTimeHalved = false
var ironDisappears = false
var limitedWater = false
var harderRelicTiles = false

var bonusHealth = 0.0
var removedTime = 0.0
var increasedDamage = 0.0
var hardnessTier = 0.0

var preset = 0

const CONSTARRC = preload("res://mods-unpacked/Arrcival-Torment/Consts.gd")

func getTotalScore():
	var score = 0
	if harderRelicSwitchTiles == true: score += 1
	if harderRelicTiles == true: score += 1
	if limitedCobalt == true: score += 3
	if limitedWater == true: score += 3
	if bonusTimeHalved == true: score += 2
	if ironDisappears == true: score += 2
	score += bonusHealth
	score += removedTime
	score += increasedDamage
	score += hardnessTier * 2
	return score


func getHPIncrease():
	return bonusHealth * CONSTARRC.HEALTH_PER_TIER
	
func getTimeDecrease():
	return removedTime * CONSTARRC.LENGTH_PER_TIER

func getDamageIncrease():
	return increasedDamage * CONSTARRC.DAMAGE_PER_TIER
	
func getHardnessTier():
	return hardnessTier
