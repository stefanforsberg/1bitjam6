extends RigidBody2D
class_name Bullet

var move: Vector2
var speed: int
var bounce_count: int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	var velocity = move * delta * speed
	var col := move_and_collide(velocity)
	if col:
		
		if col.get_collider().name == "PlatformerAvoidObstaclesPlayer":
			print("YES!!!")
			Startup.level_completed.emit()
			
		if bounce_count > 0:
			# Perfect elastic bounce: reflect your velocity around the surface normal
			move = move.bounce(col.get_normal())
			bounce_count -= 1
		else:
			queue_free()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#self.position += move*delta*speed
#
#
#func _on_area_2d_body_entered(body):
	#if bounce_count > 0:
		#move = -move
	#else:
		#self.queue_free()
