extends CharacterBody2D

var coyote_time: float = 0.0
const SPEED = 120.0
const JUMP_VELOCITY = -310.0
@onready var animated_sprite_2d = $AnimatedSprite2D
var coyote_time_max: float = 0.2
@onready var land = $Land

func _physics_process(delta):
	
	if is_on_floor():
		coyote_time = coyote_time_max
	else:
		coyote_time = max(coyote_time - delta, 0.0)
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and coyote_time > 0.0:
		Sound.jump.play()
		velocity.y = JUMP_VELOCITY
		coyote_time = 0.0
		land.restart()
		
	#if Input.is_action_just_released("jump") and velocity.y < 0:
		#velocity.y *= 0.35

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if is_on_floor() and Input.is_action_just_pressed("move_down"):
		position.y = position.y+3
		
	

	move_and_slide()

	if velocity.y != 0:
		animated_sprite_2d.play("jump")
	else:
		if animated_sprite_2d.animation == "jump":
			land.restart()
			
		if velocity.x == 0:
			animated_sprite_2d.play("idle")
		else: 
			animated_sprite_2d.play("run")
			animated_sprite_2d.flip_h = velocity.x < 0
			
