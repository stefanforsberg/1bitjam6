extends Node2D

const TIMES_UP_SCENE := preload("res://scenes/times_up.tscn")
const level_scene = preload("res://scenes/level.tscn")

@onready var level_render = $LevelRender
@onready var time_amount = $Inventory/TimeAmount
@onready var time_input = $LevelSelector/TimeInput

@onready var level_selector = $LevelSelector
@onready var right_arrow_amount = $Inventory/RightArrowAmount
@onready var down_arrow_amount = $Inventory/DownArrowAmount
@onready var left_arrow_amount = $Inventory/LeftArrowAmount
@onready var up_arrow_amount = $Inventory/UpArrowAmount
@onready var level_level_selector_a = $LevelSelector/LevelLevelSelectorA
@onready var level_level_selector_b = $LevelSelector/LevelLevelSelectorB

var lastX: int
var lastY: int

func _ready():
	Startup.level_start.connect(_on_level_start)	
	Startup.level_completed.connect(_on_level_completed)	
	Startup.level_changed.connect(_on_level_changed)
	
	restart()
	
func _process(delta):
	pass
	
func restart():
	Startup.restart()
	
	for y in range(0, 5):
		var levels_for_row = []
		
		for x in range(0, 5):
		
			var level: Level = level_scene.instantiate()
			
			if x == 0 and y == 0:
				level.unlocked = true
			
			level.position = Vector2(50 + x * 80, 50 + y * 80)
			level.x = x;
			level.y = y
			
			levels_for_row.append(level)
		Startup.level_arr.append(levels_for_row)
	
	for r in Startup.level_arr:
		for c in r:
			level_render.add_child(c)
			
	update()
	
func update():
	
	time_amount.text = str("Time: ", Startup.save_data["time"])
	right_arrow_amount.text = str(Startup.save_data["right_arrow"]).lpad(2,"0")
	down_arrow_amount.text = str(Startup.save_data["down_arrow"]).lpad(2,"0")
	left_arrow_amount.text = str(Startup.save_data["left_arrow"]).lpad(2,"0")
	up_arrow_amount.text = str(Startup.save_data["up_arrow"]).lpad(2,"0")
	
	for r in Startup.level_arr:
		for c in r:
			c.update()

func _on_level_changed():
	update()

func _on_level_start(x,y):
	lastX = x
	lastY = y
	
	var levelStart: LevelBase 
	
	if x == 0 and y == 0:
		levelStart = load("res://scenes/levels/level_intro.tscn").instantiate()
	else:
		if not level_selector.visible:
			
			var levelOptions = ["platformer","pinball","platformer","pinball","platformer","pinball", "pinball", "shop"]
			
			var minIndex = 0
			var maxIndex = 0
			
			var levelIndex = randi_range(0,levelOptions.size()-1)
			level_level_selector_a.type = levelOptions[levelIndex]
			
			levelOptions.remove_at(levelIndex)
			
			print(levelOptions)
			
			levelIndex = randi_range(0, levelOptions.size()-1)
			level_level_selector_b.type = levelOptions[levelIndex]
			
			level_level_selector_a.updateType()
			level_level_selector_b.updateType()
			
			if y == 0:
				level_selector.position.y = 200
				
			time_input.updateLimits()
				
			level_selector.visible = true
			level_render.get_tree().paused = true

		var res = await Startup.level_selected
		
		print("after selected", res)
		
		
		
		level_selector.visible = false
		
		if res == "pinball":
			levelStart = load("res://scenes/levels/level_test.tscn").instantiate()
		elif res == "platformer":
			levelStart = load("res://scenes/levels/level_platformer_avoid_obstacles.tscn").instantiate()
		elif res == "shop":
			levelStart = load("res://scenes/levels/level_shop.tscn").instantiate()
			
	levelStart.process_mode  = Node.PROCESS_MODE_ALWAYS
	levelStart.x = x
	levelStart.y = y
	levelStart.time_limit = int(time_input.get_time())
	Startup.current_running_level = levelStart

	get_tree().root.add_child(levelStart)
	get_tree().paused = true
	
	PhysicsServer2D.set_active(true)

func _on_level_completed():
	print("done")
	print(Startup.current_running_level)
	
	if Startup.current_running_level.stopwatch:
		Startup.save_data["time"] = max(0, Startup.save_data["time"] - Startup.current_running_level.stopwatch.get_elapsed())
		


		time_input.updateLimits()
	
	var x = Startup.current_running_level.x
	var y = Startup.current_running_level.y
	Startup.level_arr[y][x].completed = true
	update()
	Startup.current_running_level.queue_free()
	get_tree().paused = false
	
	if(Startup.save_data["time"] <= 0):
		print("should restart")
		print("after startup restart")
		print("after update")
		get_tree().change_scene_to_packed(TIMES_UP_SCENE)


func _on_level_level_selector_a_clicked():
	Startup.level_selected.emit(level_level_selector_a.type)


func _on_level_level_selector_b_clicked():
	Startup.level_selected.emit(level_level_selector_b.type)
