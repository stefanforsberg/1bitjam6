extends Node

var saveGameUri = "user://savegame_v1.save"

var save_data = getDefaultSaveData()

var player_positons = []

func getDefaultSaveData():
	return {
		"right_arrow_start": 1,
		"down_arrow_start": 1,
		"left_arrow_start": 1,
		"up_arrow_start": 1,
		"time_start": 60,
		"pinball_secret_found": false,
		"fence_opened": false,
		"time": 0,
		"right_arrow": 0,
		"down_arrow": 0,
		"left_arrow": 0,
		"up_arrow": 0,
	}

var level_arr = []
signal level_start(x: int, y: int)
signal level_started()
signal level_completed()
signal level_changed()
signal level_selected(id: String)

var current_running_level: LevelBase

func _ready():
	loadGame()
	
func restart():
	level_arr = []
	
	Sound.restart()
	saveGame()
	
	save_data["time"] = save_data["time_start"]
	save_data["right_arrow"] = save_data["right_arrow_start"]
	save_data["left_arrow"] = save_data["left_arrow_start"]
	save_data["down_arrow"] = save_data["down_arrow_start"]
	save_data["up_arrow"] = save_data["up_arrow_start"]
		
func level_event_probability(y: int):
	var probability := float(5 - y) / 4.0
	return randf() < probability


func loadGame():
	
	save_data = getDefaultSaveData()
	
	if not FileAccess.file_exists(saveGameUri):
		return
	
	var file = FileAccess.open(saveGameUri, FileAccess.READ)
	if not file:
		return
		
	var loaded_data = file.get_var(true)
	
	for key in loaded_data.keys():
		save_data[key] = loaded_data[key]
		
	file.close()
	
func resetGame():
	DirAccess.remove_absolute(saveGameUri)
	save_data = getDefaultSaveData()
	
func saveGame():
	
	var file = FileAccess.open(saveGameUri, FileAccess.WRITE)
	file.store_var(save_data, true)
	file.close()
	
