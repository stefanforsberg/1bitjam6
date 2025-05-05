extends Node

var save_data = {
	"right_arrow_start": 1,
	"down_arrow_start": 1,
	"left_arrow_start": 1,
	"up_arrow_start": 1,
	"right_arrow": 0,
	"down_arrow": 0,
	"left_arrow": 0,
	"up_arrow": 0,
}

const level_scene = preload("res://scenes/level.tscn")
var level_arr = []
signal level_start(x: int, y: int)
signal level_started()
signal level_completed()
signal level_changed()
signal level_selected(id: String)

var current_running_level: LevelBase

# Called when the node enters the scene tree for the first time.
func _ready():
	
	save_data["right_arrow"] = save_data["right_arrow_start"]
	save_data["left_arrow"] = save_data["left_arrow_start"]
	save_data["down_arrow"] = save_data["down_arrow_start"]
	save_data["up_arrow"] = save_data["up_arrow_start"]
	
	for y in range(0, 5):
		var levels_for_row = []
		
		for x in range(0, 5):
		
			# Instantiate the scene (Godot 4 uses instantiate() instead of instance())
			var level: Level = level_scene.instantiate()
			# Position it at (100*x, 100*y)
			
			if x == 0 and y == 0:
				level.unlocked = true
			
			level.position = Vector2(50 + x * 80, 50 + y * 80)
			level.x = x;
			level.y = y
			# Add it to this node (you can also add to a dedicated container)
			
			levels_for_row.append(level)
		print("levels_for_row", levels_for_row)
		level_arr.append(levels_for_row)
		
func level_event_probability(y: int):
	var probability := float(5 - y) / 4.0  # map 0→1, 4→0
	return randf() < probability
