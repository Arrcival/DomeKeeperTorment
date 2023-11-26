extends "res://game/GameWorld.gd"

var tormentDifficulty = 0
var corruptions = load("res://mods-unpacked/Arrcival-Torment/extensions/Corruptions.gd").new()

func prepareCleanData():
	.prepareCleanData()
	Data.apply("monsters.waveinterval", getTormentWaveInterval())
	runStats["final.torment.corruptions"] = corruptions.getTotalScore()

func getTormentWaveInterval():	
	return Data.of("monsters.waveinterval") - corruptions.getTimeDecrease()
