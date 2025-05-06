extends Node
@onready var time = $Time

func set_limit(seconds: int) -> void:
	limit_seconds = seconds
	_alarm_emitted = false

func start() -> void:
	_elapsed = 0.0
	_elapsed_seconds = 0
	_running = true
	_alarm_emitted = false

func stop() -> void:
	_running = false

func reset() -> void:
	_running = false
	_elapsed = 0.0
	_elapsed_seconds = 0
	_alarm_emitted = false

func get_elapsed() -> int:
	return _elapsed_seconds

func is_running() -> bool:
	return _running

var limit_seconds: int = 0
var _elapsed: float = 0.0
var _elapsed_seconds: int = 0
var _running: bool = false
var _alarm_emitted: bool = false  # ensure we only emit once

func _process(delta: float) -> void:
	if not _running:
		return
	_elapsed += delta
	var new_sec = int(_elapsed)
	
	time.text = str(limit_seconds - new_sec)
	
	if new_sec != _elapsed_seconds:
		_elapsed_seconds = new_sec
		if limit_seconds > 0 and not _alarm_emitted and _elapsed_seconds >= limit_seconds:
			Startup.level_completed.emit()
