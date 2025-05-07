extends Node2D
@onready var description = $Description

signal bought

var tween: Tween

var arr := [
	#["Exchange two random arrows for another random arrow",2,0],
	#["Exchange two random arrows for another random arrow",2,0],
	#["Exchange three random arrows for another random arrow",2,0],
	#["Exchange two random arrows for another two random arrow",2,0],
	["Give 20 seconds to permanently add one right arrow to start of run",0,20]
	
	
]

var item

func _ready():
	item = arr.pick_random()
	update()
	

func update():
	description.text = item[0]


func _on_area_2d_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops(5)
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.4)
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 0.4)


func _on_area_2d_mouse_exited():
	tween.stop()
	scale = Vector2(1,1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_area_2d_input_event(_viewport, event, _shape_idx):
	
	item[1]
	
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			self.visible = false
			
			bought.emit()
	
