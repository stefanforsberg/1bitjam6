extends Node2D
class_name Bullet

var move: Vector2
var speed: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += move*delta*speed


func _on_area_2d_body_entered(body):
	self.queue_free()
