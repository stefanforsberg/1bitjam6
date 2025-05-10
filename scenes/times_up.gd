extends Node2D

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and Input.is_action_just_pressed('Click'):
		get_tree().change_scene_to_file("res://scenes/level_select.tscn")
		
