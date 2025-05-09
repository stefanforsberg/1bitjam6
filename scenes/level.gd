extends Node2D
class_name Level

@export var unlocked: bool = false
@export var completed: bool = false
@export var x: int = 0
@export var y: int = 0
@onready var activation = $ActivationArea/Activation
@onready var bg_inactive = $BgInactive
@onready var bg_unlocked = $BgUnlocked
@onready var bg_completed = $BgCompleted
@onready var bg_exit = $BgExit

@onready var arrows = $Arrows
@onready var activation_area = $ActivationArea
@onready var level_left = $Arrows/LevelLeft
@onready var level_right = $Arrows/LevelRight
@onready var level_down = $Arrows/LevelDown
@onready var level_up = $Arrows/LevelUp
@onready var level_completed = $LevelCompleted

var hover = false

func _ready():

	bg_inactive.rotation_degrees = [2, 88, 182, 268].pick_random()
	update()
			
func update():
	
	if randf() > 0.8:
		var tw = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT) 
		tw.tween_property(bg_inactive, "rotation_degrees", [2, 88, 182, 268].pick_random(), 2.3)
	
	bg_inactive.visible = true
	bg_unlocked.visible = false
	bg_completed.visible = false
	bg_exit.visible = false
	
	arrows.visible = false
	activation_area.visible = false
	
	
	if y == 4 and x == 4:
		bg_exit.visible = true
	
	if unlocked:
		bg_inactive.visible = false
		bg_unlocked.visible = true
		bg_completed.visible = false
		
		arrows.visible = true
		activation_area.visible = true
		
		level_left.visible = false
		level_right.visible = false
		level_down.visible = false
		level_up.visible = false
		
			
		
		if completed:
			
			bg_inactive.visible = false
			bg_unlocked.visible = false
			bg_completed.visible = true
			
			level_completed.visible = true
			
			activation_area.visible = false
			
			if x > 0:
				if level_left.is_selected or Startup.save_data["left_arrow"] > 0:
					level_left.visible = true
					level_left.update()
			if x < 4:
				if level_right.is_selected or Startup.save_data["right_arrow"] > 0:
					level_right.visible = true
					level_right.update()
			if y > 0:
				if level_up.is_selected or Startup.save_data["up_arrow"] > 0:
					level_up.visible = true	
					level_up.update()
			if y < 4:
				if level_down.is_selected or Startup.save_data["down_arrow"] > 0:
					level_down.visible = true
					level_down.update()

func _process(delta):
	if hover:
		if Input.is_action_just_pressed('Click'):
			Startup.level_start.emit(x,y)
		activation.rotation += 0.01


func _on_activation_area_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	hover = true


func _on_activation_area_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	hover = false


func _on_level_left_clicked():
	if level_left.is_selected: return
	
	Startup.save_data["left_arrow"] -= 1
	level_left.is_selected = true
	Startup.level_arr[y][x-1].unlocked = true
	Startup.level_arr[y][x-1].level_right.is_selected = true
	Startup.level_changed.emit()


func _on_level_right_clicked():
	if level_right.is_selected: return
	
	Startup.save_data["right_arrow"] -= 1
	level_right.is_selected = true
	Startup.level_arr[y][x+1].unlocked = true
	Startup.level_arr[y][x+1].level_left.is_selected = true
	Startup.level_changed.emit()
	


func _on_level_down_clicked():
	if level_down.is_selected: return
	
	Startup.save_data["down_arrow"] -= 1
	level_down.is_selected = true
	Startup.level_arr[y+1][x].unlocked = true
	Startup.level_arr[y+1][x].level_up.is_selected = true
	Startup.level_changed.emit()

func _on_level_up_clicked():
	if level_up.is_selected: return
	
	Startup.save_data["up_arrow"] -= 1
	level_up.is_selected = true
	Startup.level_arr[y-1][x].unlocked = true
	Startup.level_arr[y-1][x].level_down.is_selected = true
	Startup.level_changed.emit()
