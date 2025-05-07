extends LevelBase
@onready var bumper_1 = $Bumper1

@onready var rigid_body_2d = $Pinball
@onready var aim:Line2D = $Pinball/Aim
const COIN = preload("res://scenes/levels/platformer/coin.tscn")
var power = -1
var aiming = false
var shooting = false
var shoot_timer = 0
var dontSpawnHere = Rect2(Vector2(210, 0), Vector2(290, 100))

func _ready():
	super()
	
	if y <= 1: 
		bumper_1.visible = false
		bumper_1.process_mode = Node.PROCESS_MODE_DISABLED
	
	for x in range(0,3):
		
		var c = COIN.instantiate()
		c.scale *= 2
		
		var xPos = randi_range(40, 480)
		var yPos = randi_range(40, 480)
		
		while(dontSpawnHere.has_point(Vector2(xPos, yPos))):
			xPos = randi_range(40, 480)
			yPos = randi_range(40, 480)
		
		c.position.x = xPos
		c.position.y = yPos
		
		if Startup.level_event_probability(y):
			c.minRng = 0
			c.maxRng = 3
		else:
			c.minRng = 4
			c.maxRng = 7
			
		self.add_child(c)

func _process(delta):
	
	if y > 2:
		bumper_1.rotation += delta/2
	elif y > 3:
		bumper_1.rotation += delta	
	
	if power != 0:
		aim.points[1].y += 0.2 * power
		
		if aim.points[1].y < -70: 
			power = 1
		if aim.points[1].y > -30: power = -1
	
	if aiming:
		aim.rotation_degrees += delta*100
		
	if shooting:
		shoot_timer += delta
		if rigid_body_2d.linear_velocity.length() < 15 and shoot_timer > 4:
			Startup.level_completed.emit()
	


func _on_area_2d_input_event(viewport, event, _shape_idx):
	if shooting: return
		
	if event is InputEventMouseButton:
		if Input.is_action_just_pressed('Click'):
			if power != 0:
				power = 0
				aiming = true
				return
				
			aim.visible = false
			
			var r = (abs(aim.points[1].y) - 30) / 10
			
			var v = Vector2.RIGHT.rotated(aim.rotation - PI/2).normalized()
			rigid_body_2d.apply_impulse(v*300*r)
			
			shooting = true
