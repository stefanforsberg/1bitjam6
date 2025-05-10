extends LevelBase
@onready var secret_message = $SecretMessage
@onready var level_four_door = $LevelFourDoor
@onready var time_input = $Computer/ComputerArea/TimeInput
@onready var electricity_on = $Computer/ElectricityOn
@onready var end_game = $EndGame

const end_game_scene := preload("res://scenes/level_done.tscn")
@onready var trapdoor = $TrapDoor/Trapdoor
@onready var pressure = $TrapDoor/Pressure
@onready var pressure_pressed = $TrapDoor/PressurePressed

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
@onready var computer_area = $Computer/ComputerArea
@onready var player_ghost = $PlayerGhost

var player_ghost_position = 0

@onready var fence = $Fence

var positions = []

const message_arr = [
	["P","A","S","S","W"],
	["O","R","D","I","S"],
	["F","O","U","R","O"],
	["N","E","N","I","N"],
	["E","Z","E","R","O"],
]

func _ready():
	
	super()
	
	time_input.setLimits()
	time_input.validPassword.connect(_on_valid_password)
	
	if Startup.save_data["fence_opened"]:
		fence.queue_free()
	
	if y == 4:
		level_four_door.queue_free()
	
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
	
	positions.append(platformer_avoid_obstacles_player.position)
	
	if player_ghost:
		if player_ghost_position < Startup.player_positons.size():
			player_ghost.position =  Startup.player_positons[player_ghost_position]
			player_ghost_position+=1
		else:
			player_ghost.queue_free()
	
	if platformer_avoid_obstacles_player.position.x > 500 and camera_2d.position.x != 500:
		camera_2d.position.x += 500
		shooter.active = false
		shooter_2.active = false
		shooter_3.active = false
		shooter_4.active = false
		shooter_5.active = false
		shooter_5.active = false
		stopwatch._running = false
		
	elif platformer_avoid_obstacles_player.position.x < 500 and camera_2d.position.x != 0:
		camera_2d.position.x -= 500
		shooter.active = true
		shooter_2.active = true
		shooter_3.active = true
		shooter_4.active = true
		shooter_5.active = true
		shooter_5.active = true
		stopwatch._running = true
		

func _on_exit_area_body_entered(body):
	if body is CharacterBody2D:
		
		if body.position.y < 100:
			Startup.save_data["time_start"] += 5
		else:
			Startup.save_data["time_start"] += 1
		
		Startup.level_completed.emit()


func _on_computer_area_detection_body_entered(body):
	if electricity_on.visible: return
	
	if body is CharacterBody2D:
		computer_area.visible = true		


func _on_computer_area_detection_body_exited(body):
	if electricity_on.visible: return
	
	if body is CharacterBody2D:
		computer_area.visible = false

func _on_valid_password():
	electricity_on.visible = true
	computer_area.visible = false


func _on_exit_body_entered(body):
	if electricity_on.visible:
		end_game.visible = true
		Sound.good_thing.play()

var pressure_tween: Tween

func _on_trapdoor_pressure_body_entered(body):
	
	if pressure_tween: pressure_tween.stop()
	pressure.visible = false
	pressure_pressed.visible = true
	Sound.good_thing.play()
	pressure_tween = create_tween()
	pressure_tween.tween_property(trapdoor, "rotation_degrees", 60, 1)


func _on_trapdoor_pressure_body_exited(body):
	if pressure_tween: pressure_tween.stop()
	
	pressure.visible = true
	pressure_pressed.visible = false
	pressure_tween = create_tween()
	pressure_tween.tween_property(trapdoor, "rotation_degrees", 0, 1)
