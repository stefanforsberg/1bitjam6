extends Node2D

var regex := RegEx.new()
@onready var line_edit = $LineEdit
var time: int = Startup.save_data["time"]
func _ready():
	regex.compile(r"[^0-9]")
	updateLimits();

func updateLimits():
	time = Startup.save_data["time"]
	print("time_input ", time)
	
	line_edit.text = str(time / 2)

func get_time():
	return int(line_edit.text)

func _on_line_edit_text_changed(new_text):
	var previous = line_edit.caret_column
	line_edit.text = regex.sub(new_text, "", true)
	
	var selectedTime = int(line_edit.text)
	line_edit.text = str(min(selectedTime, time))
	
	line_edit.caret_column = previous
	
