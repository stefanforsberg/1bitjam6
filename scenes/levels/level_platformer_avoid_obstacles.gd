extends LevelBase

@onready var platformer_avoid_obstacles_player = $PlatformerAvoidObstaclesPlayer
@onready var camera_2d = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if platformer_avoid_obstacles_player.position.x > 500 and camera_2d.position.x != 500:
		camera_2d.position.x += 500
	elif platformer_avoid_obstacles_player.position.x < 500 and camera_2d.position.x != 0:
		camera_2d.position.x -= 500


func _on_exit_area_body_entered(body):
	if body is CharacterBody2D:
		Startup.level_completed.emit()
