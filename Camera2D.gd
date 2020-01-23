extends Camera2D

#export(int) var speed = 18
#export(int) var extra_speed = 35
#export(float) var max_speed = 5
var speed := {
	'normal': {
		force = 18,
		mx = 3
	},
	'shift': {
		force = 75,
		mx = 18
	}
}
var move := Vector2.ZERO

func _process(delta: float) -> void:
	
	var sped = speed['shift' if Input.is_action_pressed("shift") else 'normal']
	
	var fs = sped.force * delta
	
	if Input.is_action_pressed('c'):
		if Input.is_action_just_pressed("ui_down"):
			zoom += Vector2.ONE * 0.1
		if Input.is_action_just_pressed("ui_up"):
			zoom -= Vector2.ONE * 0.1
	else:
		if Input.is_action_pressed("ui_down"):
			move.y += fs * zoom.y
		if Input.is_action_pressed("ui_up"):
			move.y += -fs * zoom.y
	
	move = lerp(move, Vector2(), delta)
	move.y = min(move.y, sped.mx)
	move.y = max(move.y, -sped.mx)
	
	position += move
	
	

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		# zoom in
		if event.button_index == BUTTON_WHEEL_UP:
			zoom -= Vector2.ONE * 0.1
		# call the zoom function
		# zoom out
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom += Vector2.ONE * 0.1
			# call the zoom function
	
	
