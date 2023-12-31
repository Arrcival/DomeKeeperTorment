extends Node

const MYMODNAME_MOD_DIR = "Arrcival-Torment/"
const MYMODNAME_LOG = "Arrcival-Torment"

const EXTENSIONS_DIR = "extensions/"

func _init(modLoader = ModLoader):
	ModLoaderLog.info("init starting", MYMODNAME_LOG)
	var dir = ModLoaderMod.get_unpacked_dir() + MYMODNAME_MOD_DIR
	var ext_dir = dir + EXTENSIONS_DIR
	
	# Add extensions
	loadExtension(ext_dir, "Dome.gd")
	loadExtension(ext_dir, "GameWorld.gd")
	loadExtension(ext_dir, "Map.gd")
	loadExtension(ext_dir, "Monster.gd")
	loadExtension(ext_dir, "RelichuntPopup.gd")
	loadExtension(ext_dir, "RunStats.gd")
	loadExtension(ext_dir, "TileDataGenerator.gd")
	
	ModLoaderMod.add_translation(dir + "localization/torment.en.translation")
	
	ModLoaderLog.info("init done", MYMODNAME_LOG)

func _ready():
	ModLoaderLog.info("_ready starting", MYMODNAME_LOG)
	add_to_group("mod_init")
	StageManager.connect("level_ready", self, "addTormentHud")
	ModLoaderLog.info("_ready done", MYMODNAME_LOG)

func loadExtension(ext_dir, fileName):
	ModLoaderMod.install_script_extension(ext_dir + fileName)

func modInit():
	pass

func addTormentHud():
	if GameWorld.corruptions.getTotalScore() > 0:
		Level.hud.addHudElement({"hud": "mods-unpacked/Arrcival-Torment/content/TormentHUD.tscn"})
