extends LevelBase


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_input_event(_viewport, event, _shape_idx):
	
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			Startup.level_completed.emit()


func _on_start_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_start_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
