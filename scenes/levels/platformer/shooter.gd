extends Node2D

@export var angleMin: int
@export var angleMax: int
@export var speed: int = 100


@onready var bullets = $Bullets

const BULLET = preload("res://scenes/levels/platformer/bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	newBullet()


func newBullet():
	var b: Bullet = BULLET.instantiate()
	var angle = RandomNumberGenerator.new().randi_range(angleMin, angleMax)
	print(angle)
	b.move = Vector2.RIGHT.rotated(deg_to_rad(angle)).normalized()
	b.speed = speed
	b.position = self.global_position
	bullets.add_child(b)
	
	
	
	await get_tree().create_timer(3.0).timeout
	newBullet()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
