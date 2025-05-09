extends Node2D

signal validPassword

var regex := RegEx.new()
@onready var line_edit = $LineEdit
var time: int = Startup.save_data["time"]
func _ready():
	regex.compile(r"[^0-9]")
	updateLimits();

func updateLimits():
	time = Startup.save_data["time"]
	
	line_edit.text = str(time)
	
func setLimits():
	time = 9999
	line_edit.text = "0000"

func get_time():
	return int(line_edit.text)

func _on_line_edit_text_changed(new_text):
	if time == 9999:
		if new_text == "4190":
			validPassword.emit()
	else:
		var previous = line_edit.caret_column
		line_edit.text = regex.sub(new_text, "", true)
		
		var selectedTime = int(line_edit.text)
		line_edit.text = str(min(selectedTime, time))
		
		line_edit.caret_column = previous
	
