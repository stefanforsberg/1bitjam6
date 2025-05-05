extends CharacterBody2D

var coyote_time: float = 0.0
const SPEED = 120.0
const JUMP_VELOCITY = -320.0
@onready var animated_sprite_2d = $AnimatedSprite2D
var coyote_time_max: float = 0.2

func _physics_process(delta):
	
	if is_on_floor():
		coyote_time = coyote_time_max
	else:
		coyote_time = max(coyote_time - delta, 0.0)
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and coyote_time > 0.0:
		velocity.y = JUMP_VELOCITY
		coyote_time = 0.0
		
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.35

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor() and Input.is_action_just_pressed("move_down"):
		position.y = position.y+3
		
	

	move_and_slide()

	if velocity.x == 0:
		animated_sprite_2d.play("idle")
	else: 
		animated_sprite_2d.play("run")
		animated_sprite_2d.flip_h = velocity.x < 0
		
