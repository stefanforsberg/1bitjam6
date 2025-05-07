extends LevelBase

@onready var shop_item = $ShopItem
@onready var shop_item_2 = $ShopItem2
@onready var shop_item_3 = $ShopItem3
@onready var right_arrow_amount = $RightArrowAmount
@onready var down_arrow_amount = $DownArrowAmount
@onready var left_arrow_amount = $LeftArrowAmount
@onready var up_arrow_amount = $UpArrowAmount

# Called when the node enters the scene tree for the first time.
func _ready():
	shop_item.bought.connect(_on_bought)
	shop_item_2.bought.connect(_on_bought)
	shop_item_3.bought.connect(_on_bought)
	
	update()
	super()
	
func update():
	right_arrow_amount.text = str(Startup.save_data["right_arrow"]).lpad(2,"0")
	down_arrow_amount.text = str(Startup.save_data["down_arrow"]).lpad(2,"0")
	left_arrow_amount.text = str(Startup.save_data["left_arrow"]).lpad(2,"0")
	up_arrow_amount.text = str(Startup.save_data["up_arrow"]).lpad(2,"0")
	
	shop_item.update()
	shop_item_2.update()
	shop_item_3.update()

func _on_bought():
	update()


func _on_exit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			
			Startup.level_completed.emit()
			


func _on_exit_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_exit_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
