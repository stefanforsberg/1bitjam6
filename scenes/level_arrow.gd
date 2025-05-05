extends Node2D

@export var is_selected:bool = false
@onready var selectable = $Arrow/Selectable
@onready var selected = $Arrow/Selected

signal clicked()

# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update():
	selectable.visible = !is_selected
	selected.visible = is_selected

func _on_arrow_mouse_entered():
	if not is_selected:
		var tw = create_tween().set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT) 
		tw.tween_property(self, "scale", Vector2(1.2,1.2), 0.5)
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_arrow_mouse_exited():
	
	var tw = create_tween() .set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)                    
	tw.tween_property(self, "scale", Vector2(1.0,1.0), 0.5)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_arrow_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			clicked.emit()
