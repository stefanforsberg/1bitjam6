extends Node2D

@onready var select:AudioStreamPlayer = $Select
@onready var jump:AudioStreamPlayer = $Jump
@onready var pickup:AudioStreamPlayer = $Pickup
@onready var shoot:AudioStreamPlayer = $Shoot
@onready var explode:AudioStreamPlayer = $Explode
@onready var hit:AudioStreamPlayer = $Hit
@onready var good_thing:AudioStreamPlayer = $GoodThing

@onready var song = [$Song4, $Song3, $Song1, $Song2, $Song5]
var tweens = []
# Called when the node enters the scene tree for the first time.
func _ready():
	restart()

func restart():
	for t in tweens:
		t.stop()
		
	tweens = []
	
	song[0].volume_db = -60
	song[1].volume_db = -60
	song[2].volume_db = -60
	song[3].volume_db = -60
	song[4].volume_db = -60
	
	song[0].play()
	song[1].play()
	song[2].play()
	song[3].play()
	song[4].play()

	fadeIn(0,5)
	


func fadeIn(i: int, duration: int):
	
	if song[i].volume_db != -60: return
	
	var t = get_tree().create_tween()
	t.tween_property(song[i], "volume_db", -5, duration)
	tweens.append(t)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
