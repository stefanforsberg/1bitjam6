extends Node2D

var active = true

@export var angleMin: int
@export var angleMax: int
@export var speed: int = 100
@export var timeOut: float = 3.0
@export var bounces: int = 0

@onready var bullets = $Bullets
@onready var gpu_particles_2d = $GPUParticles2D


const BULLET = preload("res://scenes/levels/platformer/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	gpu_particles_2d.restart()
	
	await get_tree().create_timer(randf()).timeout
	
	await get_tree().create_timer(1).timeout
	
	newBullet()


func newBullet():
	
	if active:
	
		var b: Bullet = BULLET.instantiate()
		var angle = randi_range(angleMin, angleMax)
		b.move = Vector2.RIGHT.rotated(deg_to_rad(angle)).normalized()
		b.speed = speed
		b.position = self.global_position
		b.bounce_count = bounces
		bullets.add_child(b)
		
		Sound.shoot.play()
	
	await get_tree().create_timer(timeOut-1).timeout
	
	gpu_particles_2d.restart()
	
	await get_tree().create_timer(1).timeout
	
	
	

	
	newBullet()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
