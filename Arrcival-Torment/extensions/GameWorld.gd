extends "res://game/GameWorld.gd"

var tormentDifficulty = 0

func prepareCleanData():
	.prepareCleanData()
	Data.apply("monsters.waveinterval", getTormentWaveInterval())
	

func getTormentWaveInterval():
	var totalRemovedTime = 0.0
	if tormentDifficulty >= 10:
		totalRemovedTime += 2
	if tormentDifficulty >= 8:
		totalRemovedTime += 2
	if tormentDifficulty >= 6:
		totalRemovedTime += 2
	if tormentDifficulty >= 4:
		totalRemovedTime += 2
	if tormentDifficulty >= 2:
		totalRemovedTime += 2
	
	return Data.of("monsters.waveinterval") - totalRemovedTime
