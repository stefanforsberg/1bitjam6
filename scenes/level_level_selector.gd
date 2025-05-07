extends Node2D
@export var type: String
@onready var platformer_door = $PlatformerDoor
@onready var platformer_bullet = $PlatformerBullet
@onready var platformer_shop = $PlatformerShop
@onready var platformer_notes = $PlatformerNotes

signal clicked()

func updateType():
	platformer_door.visible = false
	platformer_bullet.visible = false
	platformer_shop.visible = false
	platformer_notes.visible = false
	
	if type == "platformer": platformer_door.visible = true
	elif type == "pinball": platformer_bullet.visible = true
	elif type == "shop": platformer_shop.visible = true
	elif type == "note": platformer_notes.visible = true

func _on_select_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			clicked.emit()


func _on_select_area_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_select_area_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
