extends LevelBase
@onready var heading = $Heading
@onready var body = $Body

var arr = [
	["Note #1","THE REAL EXIT IS IN A PLACE WHERE SAD SQUARES FIRE AT YOU."],
	["Note #2","YOU CAN CHOOSE THE MAX TIME YOU WANT TO SPEND BEFORE STARTING A LEVEL."],
	["Note #4","A WALL LOOKS WEAK IN LOWER LEFT CORNER OF PINBALL LEVEL. COULD POINTY DEVICE HELP BREAK IT?"],
	["Note #6","I MUST HAVE DROPPED NOTE #5 SOMEWHERE ON THE WAY."],
	["Note #7","I THOUGHT A SAW A LETTER ON THE PLATFORM LEVEL BUT THE LETTER SEEMS TO CHANGE."],
	["Note #9","A LETTER CAN MEAN MULTIPLE THINGS."],
	["Note #10","I REALLY MISS COLORS."],
	["Note #11","REACHING THE DOORS IN PLATFORM LEVEL SEEMS TO PERMENANTLY ADD TIME TO NEXT DAY."],
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var note = arr.pick_random()
	
	heading.text = note[0]
	body.text = note[1]
	
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_exit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			
			Startup.level_completed.emit()

func _on_exit_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_exit_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
