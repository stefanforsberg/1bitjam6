extends Node2D
@onready var up_arrow = $Area2D/UpArrow
@onready var down_arrow = $Area2D/DownArrow
@onready var left_arrow = $Area2D/LeftArrow
@onready var right_arrow = $Area2D/RightArrow
@onready var up_arrow_inverse = $Area2D/UpArrowInverse
@onready var down_arrow_inverse = $Area2D/DownArrowInverse
@onready var left_arrow_inverse = $Area2D/LeftArrowInverse
@onready var right_arrow_inverse = $Area2D/RightArrowInverse

var type: int
@export var minRng: int = 0
@export var maxRng: int = 3

func _ready():
	reRoll()
	
func reRoll():
	up_arrow.visible = false
	down_arrow.visible = false
	left_arrow.visible = false
	right_arrow.visible = false
	up_arrow_inverse.visible = false
	down_arrow_inverse.visible = false
	left_arrow_inverse.visible = false
	right_arrow_inverse.visible = false
	
	type = randi_range(minRng, maxRng)
	
	if type == 0: up_arrow.visible = true
	if type == 1: down_arrow.visible = true
	if type == 2: left_arrow.visible = true
	if type == 3: right_arrow.visible = true
	if type == 4: up_arrow_inverse.visible = true
	if type == 5: down_arrow_inverse.visible = true
	if type == 6: left_arrow_inverse.visible = true
	if type == 7: right_arrow_inverse.visible = true

func _on_area_2d_body_entered(body):
	
	if body.name == "PlatformerAvoidObstaclesPlayer" or body.name == "Pinball":
		
		Sound.pickup.play()
		
		if type == 0: Startup.save_data["up_arrow"]+=1
		if type == 1: Startup.save_data["down_arrow"]+=1
		if type == 2: Startup.save_data["left_arrow"]+=1
		if type == 3: Startup.save_data["right_arrow"]+=1
		if type == 4: Startup.save_data["up_arrow"] = max(0, Startup.save_data["up_arrow"]-1)
		if type == 5: Startup.save_data["down_arrow"] = max(0, Startup.save_data["down_arrow"]-1)
		if type == 6: Startup.save_data["left_arrow"] = max(0, Startup.save_data["left_arrow"]-1)
		if type == 7: Startup.save_data["right_arrow"] = max(0, Startup.save_data["right_arrow"]-1)
		
		self.queue_free()
