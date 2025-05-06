extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("times_up")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed('Click'):
		print("hsadasdasdasd")
		get_tree().change_scene_to_file("res://scenes/level_select.tscn")
		
