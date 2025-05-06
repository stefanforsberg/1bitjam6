extends LevelBase
@onready var secret_message = $SecretMessage

@onready var platformer_avoid_obstacles_player = $PlatformerAvoidObstaclesPlayer
@onready var camera_2d = $Camera2D
@onready var shooter = $Shooter
@onready var shooter_2 = $Shooter2
@onready var shooter_3 = $Shooter3
@onready var shooter_4 = $Shooter4
@onready var shooter_5 = $Shooter5
@onready var coin = $Collectables/Coin
@onready var coin_2 = $Collectables/Coin2
@onready var coin_3 = $Collectables/Coin3
@onready var coin_4 = $Collectables/Coin4
@onready var coin_5 = $Collectables/Coin5
@onready var coin_6 = $Collectables/Coin6
@onready var coin_7 = $Collectables/Coin7

const message_arr = [
	["P","A","S","S","W"],
	["O","R","D","I","S"],
	["F","O","U","R","O"],
	["N","E","N","I","N"],
	["E","Z","E","R","O"],
]

func _ready():
	super()
	
	secret_message.text = message_arr[y][x]
	
	if y == 1:
		shooter.timeOut = 5
		shooter_2.timeOut = 5
		shooter_3.timeOut = 5
		shooter_4.timeOut = 5
		shooter_5.timeOut = 5
		shooter.bounces = 1
		shooter_2.bounces = 1
		shooter_3.bounces = 1
		shooter_4.bounces = 1
		shooter_5.bounces = 1
	if y == 2:
		coin.minRng = 0
		coin.maxRng = 7
		coin.reRoll()
		shooter.timeOut = 4
		shooter_2.timeOut = 4
		shooter_3.timeOut = 4
		shooter_4.timeOut = 4
		shooter_5.timeOut = 4
		shooter.bounces = 2
		shooter_2.bounces = 2
		shooter_3.bounces = 2
		shooter_4.bounces = 2
		shooter_5.bounces = 2
	if y == 3:
		coin.minRng = 0
		coin.maxRng = 7
		coin.reRoll()
		coin_2.minRng = 0
		coin_2.maxRng = 7
		coin_2.reRoll()
		coin_3.minRng = 0
		coin_3.maxRng = 7
		coin_3.reRoll()
		shooter.timeOut = 3
		shooter_2.timeOut = 3
		shooter_3.timeOut = 3
		shooter_4.timeOut = 3
		shooter_5.timeOut = 3
		shooter.speed = 130
		shooter_2.speed = 130
		shooter_3.speed = 130
		shooter_4.speed = 130
		shooter_5.speed = 130
		shooter.bounces = 4
		shooter_2.bounces = 4
		shooter_3.bounces = 4
		shooter_4.bounces = 4
		shooter_5.bounces = 4
	if y == 4:
		coin.minRng = 0
		coin.maxRng = 7
		coin.reRoll()
		coin_2.minRng = 0
		coin_2.maxRng = 7
		coin_2.reRoll()
		coin_3.minRng = 0
		coin_3.maxRng = 7
		coin_3.reRoll()
		shooter.timeOut = 2
		shooter_2.timeOut = 1
		shooter_3.timeOut = 1
		shooter_4.timeOut = 2
		shooter_5.timeOut = 2
		shooter.speed = 180
		shooter_2.speed = 180
		shooter_3.speed = 180
		shooter_4.speed = 180
		shooter_5.speed = 180
		shooter.bounces = 8
		shooter_2.bounces = 8
		shooter_3.bounces = 8
		shooter_4.bounces = 8
		shooter_5.bounces = 8

func _process(delta):
	if platformer_avoid_obstacles_player.position.x > 500 and camera_2d.position.x != 500:
		camera_2d.position.x += 500
	elif platformer_avoid_obstacles_player.position.x < 500 and camera_2d.position.x != 0:
		camera_2d.position.x -= 500

func _on_exit_area_body_entered(body):
	if body is CharacterBody2D:
		Startup.level_completed.emit()
