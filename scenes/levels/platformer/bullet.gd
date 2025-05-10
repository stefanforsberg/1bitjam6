extends RigidBody2D
class_name Bullet

var move: Vector2
var speed: int
var bounce_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if(position.x > 500):
		queue_free()
	else:
		var velocity = move * delta * speed
		var col := move_and_collide(velocity)
		
		if col:
			if bounce_count > 0:
				move = move.bounce(col.get_normal())
				bounce_count -= 1
			else:
				queue_free()


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		Startup.level_completed.emit()
