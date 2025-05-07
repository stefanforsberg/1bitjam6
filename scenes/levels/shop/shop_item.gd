extends Node2D
@onready var description = $Description
@onready var chest_no = $ChestNo

signal bought

var tween: Tween

const currency = ["up_arrow","down_arrow","left_arrow","right_arrow"]

var arr := [
	["Exchange two random arrows for another random arrow",2, _add_random_arrow],
	["Exchange two random arrows for another random arrow",2, _add_random_arrow],
	["Exchange two random arrows for another random arrow",2, _add_random_arrow],
	["Exchange three random arrows for another random arrow",3, _add_random_arrow],
	["Exchange two random arrows for another random arrow",2, _add_random_arrow],
	["Exchange four random arrows for another random arrow",4, _add_random_arrow],
	["Exchange two random arrows for another random arrow",2, _add_random_arrow],
	["Exchange three random arrows for another random arrow",3, _add_random_arrow],
	["Exchange two random arrows for another two random arrow",2, _add_two_random_arrow],
	["Exchange three random arrows to permanently add one right arrow to start of run", 3, _perm_add_right],
	["Exchange three random arrows to permanently add one left arrow to start of run", 3, _perm_add_left],
	["Exchange three random arrows to permanently add one down arrow to start of run", 3, _perm_add_down],
	["Exchange three random arrows to permanently add one up arrow to start of run", 3, _perm_add_up],
	["Exchange two random arrows to permanently add 10 seconds to start of run", 2, _perm_add_time_10],
	["Exchange five random arrows to permanently add 30 seconds to start of run", 5, _perm_add_time_30]
	
	
]

var item

func _ready():
	item = arr.pick_random()
	update()
	

func update():
	description.text = item[0]
	
	chest_no.visible = arrowCount() < item[1]


func _on_area_2d_mouse_entered():
	if chest_no.visible: return
	
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT).set_loops(5)
	tween.tween_property(self, "scale", Vector2(1.1,1.1), 0.4)
	tween.tween_property(self, "scale", Vector2(1.0,1.0), 0.4)


func _on_area_2d_mouse_exited():
	if tween: tween.stop()
	scale = Vector2(1,1)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func arrowCount():
	return Startup.save_data["right_arrow"] + Startup.save_data["down_arrow"] + Startup.save_data["left_arrow"] + Startup.save_data["up_arrow"]

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	
	if chest_no.visible: return
	
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			var cost = item[1]
			
			while cost > 0:
				var charged = currency.pick_random()
				
				while(Startup.save_data[charged] <= 0):
					charged = currency.pick_random()
				
				Startup.save_data[charged]-= 1
				cost -=1
			
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			self.visible = false
			
			item[2].call()
			
			bought.emit()
			
func _perm_add_right():
	Startup.save_data["right_arrow_start"]+=1
	
func _perm_add_left():
	Startup.save_data["left_arrow_start"]+=1
	
func _perm_add_down():
	Startup.save_data["down_arrow_start"]+=1
	
func _perm_add_up():
	Startup.save_data["up_arrow_start"]+=1
	
func _add_random_arrow():
	Startup.save_data[currency.pick_random()]+=1
	
func _add_two_random_arrow():
	_add_random_arrow()
	_add_random_arrow()
	
func _perm_add_time_10():
	Startup.save_data["time_start"]+=10
	
func _perm_add_time_30():
	Startup.save_data["time_start"]+=30
	
