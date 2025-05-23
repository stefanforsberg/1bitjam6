extends CharacterBody2D
@onready var gpu_particles_2d = $GPUParticles2D

# tweak these in the Inspector
@export var thrust_force: float = 200.0
@export var rotation_speed: float = 3.0    # radians per second
@export var damping: float = 0.5           # how quickly it slows when not thrusting

func _physics_process(delta: float) -> void:
	
	if position.x < 10: position.x = 510
	if position.x > 510: position.x = 10
	if position.y < 10: position.y = 510
	if position.y > 510: position.y = 10
	
	# --- ROTATION ---
	if Input.is_action_pressed("move_left"):
		rotation -= rotation_speed * delta
	elif Input.is_action_pressed("move_right"):
		rotation += rotation_speed * delta

	# --- THRUST ---
	var forward_dir = Vector2.RIGHT.rotated(rotation)
	if Input.is_action_pressed("move_up"):
		velocity += forward_dir * thrust_force * delta
		gpu_particles_2d.emitting = true
	elif Input.is_action_pressed("move_down"):
		velocity -= forward_dir * thrust_force * delta

	# --- DAMPING (friction) ---
	velocity = velocity.move_toward(Vector2.ZERO, damping * thrust_force * delta)

	# --- MOVE the ship ---
	# CharacterBody2D.move_and_slide() moves by `velocity` and handles collisions
	move_and_slide()


#extends CharacterBody2D
#
#@onready var gpu_particles_2d = $GPUParticles2D
#
#@export var acceleration: float = 800.0   # pixels/sec²
#@export var max_speed:    float = 400.0   # pixels/sec
#@export var friction:     float = 600.0   # pixels/sec²
#
#func _ready():
	#motion_mode = MotionMode.MOTION_MODE_FLOATING
	#
	#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
#
#func _physics_process(delta: float) -> void:
	 ## 1) AIM: point the ship at the mouse cursor
	#var to_mouse = get_global_mouse_position() - global_position
	#if to_mouse != Vector2.ZERO:
		#rotation = to_mouse.angle()    # same as look_at() for rotation-only
#
	## 2) THRUST: accelerate when “move_forward” is held
	#if Input.is_action_pressed("move_up"):
		## Vector2.RIGHT is (1,0), so rotated by `rotation` it points ship-forward
		#velocity += Vector2.RIGHT.rotated(rotation) * acceleration * delta
		#gpu_particles_2d.emitting = true
	#else:
		#gpu_particles_2d.emitting = false
		#
		## apply friction/inertia
		#var decel = friction * delta
		#if velocity.length() <= decel:
			#velocity = Vector2.ZERO
		#else:
			#velocity -= velocity.normalized() * decel
#
	## 3) SPEED CAP
	#velocity = velocity.limit_length(max_speed)
#
	## 4) MOVE & SLIDE – updates `velocity` directly on slide collisions :contentReference[oaicite:0]{index=0}
	#move_and_slide()
