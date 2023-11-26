extends "res://content/map/generation/TileDataGenerator.gd"

func generate():
	.generate()
	
	if finishedSuccessful == false:
		return
	
	finishedSuccessful = false
	
	var tdResources = $TileData / Resources
	var tdHardness = $TileData / Hardness
	
	if GameWorld.corruptions.harderRelicSwitchTiles:
		var switchCells = tdResources.get_used_cells_by_id(Data.TILE_RELIC_SWITCH)
		for c in switchCells:
			tdHardness.set_cellv(c, 17) # 13 to 17
			
	# to upgrade
	if GameWorld.corruptions.getHardnessTier() == 2:
		var softCells = tdHardness.get_used_cells_by_id(13)
		for c in softCells:
			tdHardness.set_cellv(c, 15) # 13 to 17
		softCells = tdHardness.get_used_cells_by_id(14)
		for c in softCells:
			tdHardness.set_cellv(c, 15) # 13 to 17
	elif GameWorld.corruptions.getHardnessTier() == 1:
		var softCells = tdHardness.get_used_cells_by_id(13)
		for c in softCells:
			tdHardness.set_cellv(c, 14) # 13 to 17
	
	if GameWorld.corruptions.ironDisappears:
		var ironCells = tdResources.get_used_cells_by_id(Data.TILE_IRON)
		for c in ironCells:
			if randf() < 0.1:
				tdResources.set_cellv(c, Data.TILE_DIRT_START)

	if GameWorld.corruptions.harderRelicTiles:
		var relicCells = tdResources.get_used_cells_by_id(Data.TILE_RELIC)
		for c in relicCells:
			var hardness = tdHardness.get_cellv(c)
			if hardness >= 13 and hardness <= 15:
				tdHardness.set_cellv(c, 16)
	
	finishedSuccessful = true
