extends Node2D
@export var id: String

signal clicked()

func _on_select_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			clicked.emit()
