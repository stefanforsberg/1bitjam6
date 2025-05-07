extends Node
class_name LevelBase
const STOP_WATCH = preload("res://scenes/stop_watch.tscn")
var x: int
var y: int
var time_limit: int
var stopwatch

func _ready():
	stopwatch = STOP_WATCH.instantiate()
	add_child(stopwatch)
	print("startin sw", time_limit)
	stopwatch.set_limit(time_limit)
	stopwatch.start()
