extends "res://content/map/Map.gd"

func destroyTile(tile):
	var sound
	match tile.type:
		CONST.BORDER:
			return 
		CONST.IRON:
			sound = $TileDestroyedIron.duplicate(DUPLICATE_USE_INSTANCING)
		CONST.WATER:
			sound = $TileDestroyedWater.duplicate(DUPLICATE_USE_INSTANCING)
		CONST.SAND:
			sound = $TileDestroyedSand.duplicate(DUPLICATE_USE_INSTANCING)
		CONST.GADGET:
			sound = $TileDestroyedChamber.duplicate(DUPLICATE_USE_INSTANCING)
		CONST.POWERCORE:
			sound = $TileDestroyedChamber.duplicate(DUPLICATE_USE_INSTANCING)
		CONST.RELIC:
			sound = $TileDestroyedChamber.duplicate(DUPLICATE_USE_INSTANCING)
		_:
			sound = $TileDestroyed.duplicate(DUPLICATE_USE_INSTANCING)
	sound.setSimulatedPosition(tile.global_position)
	add_child(sound)
	sound.play()
	
	dig(tile.coord)
	
	if tile.type == CONST.IRON:
		currentIronCountByLayer[tile.layer] = currentIronCountByLayer[tile.layer] - 1
	
	if tile.type == CONST.IRON or tile.type == CONST.SAND or tile.type == CONST.WATER:
		var goalRichness = tile.richness * Data.ofOr("resourcemodifiers.richness." + tile.type, 1.0)
		var drops = floor(goalRichness - 1 + (randi() % 3))
		if tile.type == CONST.IRON:
			if isFirstDrop:
				
				isFirstDrop = false
				drops = 2
		var newDelta = dropDeltas.get(tile.type, 0) + drops - goalRichness
		if newDelta >= 3:
			drops -= 1
			newDelta -= 1
		elif newDelta <= - 3:
			drops += 1
			newDelta += 1
		dropDeltas[tile.type] = newDelta
		
		if tile.type == CONST.SAND and drops < 3 and Level.loadout.modeId == CONST.MODE_RELICHUNT and Level.loadout.difficulty <= 0:
			
			var sandWithFloating = Data.of("inventory.sand") + Data.of("inventory.floatingsand")
			if Data.of("dome.health") < 350 - 60 * sandWithFloating:
				drops += 1
		if drops < 3 and Level.difficulty() * 0.1 < - randf():
			drops += 1
			
		if GameWorld.tormentDifficulty >= 3 and tile.type == CONST.SAND and drops == 3:
			drops -= 1
		if GameWorld.tormentDifficulty >= 7 and tile.type == CONST.WATER and drops == 3:
			drops -= 1
			
		if drops == 3 and (tile.type == CONST.SAND or tile.type == CONST.WATER):
			print("uhoh")
		
		
		for _i in range(0, drops):
			var drop = Data.DROP_SCENES.get(tile.type).instance()
			drop.position = tile.global_position + 0.6 * Vector2(GameWorld.HALF_TILE_SIZE - randf() * GameWorld.TILE_SIZE, GameWorld.HALF_TILE_SIZE - randf() * GameWorld.TILE_SIZE)
			drop.apply_central_impulse(Vector2(0, 40).rotated(randf() * TAU))
			call_deferred("addDrop", drop)
			GameWorld.incrementRunStat("resources_mined")
	
	tiles.erase(tile.coord)
	for t in tilesByType.values():
		t.erase(tile)
	tilesByType.get(tile.type, {}).erase(tile)
	tile.queue_free()
	
	onTileRemoved(tile.coord)

func getProgress()->float:
	var progress = .getProgress()
	
	if GameWorld.tormentDifficulty >= 4:
		progress /= 2
	return progress
