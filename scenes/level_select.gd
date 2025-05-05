extends Node2D

@onready var level_render = $LevelRender

@onready var level_selector = $LevelSelector
@onready var right_arrow_amount = $Inventory/RightArrowAmount
@onready var down_arrow_amount = $Inventory/DownArrowAmount
@onready var left_arrow_amount = $Inventory/LeftArrowAmount
@onready var up_arrow_amount = $Inventory/UpArrowAmount

var lastX: int
var lastY: int

const level_scene = preload("res://scenes/level.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	Startup.level_start.connect(_on_level_start)	
	Startup.level_completed.connect(_on_level_completed)	
	Startup.level_changed.connect(_on_level_changed)
	
	for r in Startup.level_arr:
		for c in r:
			level_render.add_child(c)
			
	update()
	
func _process(delta):
	pass
	
func update():
	
	print(Startup.save_data)
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
			if y == 0:
				level_selector.position.y = 200
				
			level_selector.visible = true
			level_render.get_tree().paused = true

		var res = await Startup.level_selected
		
		level_selector.visible = false
		
		  # 1) Load & instance the level
		
		if res == "A":
			levelStart = load("res://scenes/levels/level_test.tscn").instantiate()
		elif res == "B":
			levelStart = load("res://scenes/levels/level_platformer_avoid_obstacles.tscn").instantiate()
		# 2) Make it run even when the Tree is paused:
	levelStart.process_mode  = Node.PROCESS_MODE_ALWAYS
	levelStart.x = x
	levelStart.y = y
	Startup.current_running_level = levelStart

	# 3) Add it as a child of the SceneTree root (so it draws/receives input on top)
	get_tree().root.add_child(levelStart)
	# 4) Pause the whole tree – this stops your LevelSelect (and any STOP-mode nodes)
	get_tree().paused = true
	
	PhysicsServer2D.set_active(true)

	# (Optionally keep a reference so you can free it when done)
	#self.current_level = level

func _on_level_completed():
	print("done")
	var x = Startup.current_running_level.x
	var y = Startup.current_running_level.y
	Startup.level_arr[y][x].completed = true
	update()
	Startup.current_running_level.queue_free()
	get_tree().paused = false


func _on_level_level_selector_a_clicked():
	Startup.level_selected.emit("A")


func _on_level_level_selector_b_clicked():
	Startup.level_selected.emit("B")
