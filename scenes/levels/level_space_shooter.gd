extends Node2D

@onready var camera_2d = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_2d.zoom.x -= 0.0001
	camera_2d.zoom.y -= 0.0001
