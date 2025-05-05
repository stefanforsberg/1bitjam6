extends Node2D
@onready var up_arrow = $Area2D/UpArrow
@onready var down_arrow = $Area2D/DownArrow
@onready var left_arrow = $Area2D/LeftArrow
@onready var right_arrow = $Area2D/RightArrow

var type = RandomNumberGenerator.new().randi_range(0, 3)
# Called when the node enters the scene tree for the first time.
func _ready():
	if type == 0: up_arrow.visible = true
	if type == 1: down_arrow.visible = true
	if type == 2: left_arrow.visible = true
	if type == 3: right_arrow.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if type == 0: Startup.save_data["up_arrow"]+=1
	if type == 1: Startup.save_data["down_arrow"]+=1
	if type == 2: Startup.save_data["left_arrow"]+=1
	if type == 3: Startup.save_data["right_arrow"]+=1
	
	self.queue_free()
