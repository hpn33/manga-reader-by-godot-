extends Camera2D


export var debug := false



var pan_speed := 800




var force := Vector2()
var relative := Vector2()

## Rectangle used to limit camera panning.
## Note that the built in camera limits do not work: they don't actually constrain the position of the camera.
## They only stop the view from moving. For the player, this makes the camera appear to "stick" at the edges of the map, 
## which is bad.
var limit_rect = Rect2(Vector2(), Vector2.ONE * 100)

var mouse_captured := false


func _ready() -> void:
	
	share.add_hook('camera_limit', self, 'set_limit_rect')


func _input(event):
#
#	if event.is_action_pressed("view_click_mouse"):
#		mouse_captured = true
#		force = Vector2()
#
#	elif event.is_action_released("view_click_mouse"):
#		mouse_captured = false
#
#		print(relative)
#		# like scrolling on phone
##		force -= (relative * (relative/2)) * zoom
#		force -= relative * zoom
##		force.x *= sign(relative.x)
##		force.y *= sign(relative.y)
#
#		print(OS.get_time(), ":\t", force)
#
#	if mouse_captured && event is InputEventMouseMotion:
#		# store relative
#		relative = event.relative
#
#		#like we're grabbing the map
#		position -= relative * zoom
#		_snap_to_limits()
	
	
	
	
	
	
	


# use _process for smoother scrolling
#func _process(delta):
#	update()
#
#	if Input.is_action_pressed("view_click_mouse"):
#		#smooth keyboard zoom
#		if Input.is_action_pressed("view_pan_up"):
#			zoom /= zoom_step
#			_snap_zoom_limits()
#		if Input.is_action_pressed("view_pan_down"):
#			zoom *= zoom_step
#			_snap_zoom_limits()
#	else:
#		#smooth keyboard zoom
#		if Input.is_action_pressed("view_zoom_in"):
#			zoom /= zoom_step
#			_snap_zoom_limits()
#		if Input.is_action_pressed("view_zoom_out"):
#			zoom *= zoom_step
#			_snap_zoom_limits()
#
#
#	var panning = Vector2()
#	panning.x += int(Input.is_action_pressed("view_pan_right")) - int(Input.is_action_pressed("view_pan_left"))
#	panning.y += int(Input.is_action_pressed("view_pan_down")) - int(Input.is_action_pressed("view_pan_up"))
#
#	if panning.length_squared() > 0:
#		position += panning.normalized() * pan_speed * delta * zoom
#		if limit_rect: _snap_to_limits()
	pass

func _process(delta):
	
	
#	if not mouse_captured:
#
#		force = lerp(force, Vector2(), 0.0001)
#
##		print(force)
#
#		position += force * delta
	
	pass
	



var offx := 0.0
var offy := 0.0
# force position to be inside limit_rect
func _snap_to_limits():
	
	position.x = clamp(position.x, limit_rect.position.x+offx, limit_rect.end.x-offx)
	position.y = clamp(position.y, limit_rect.position.y+offy, limit_rect.end.y-offy)





func set_limit_rect(rect: Rect2):
	limit_rect = rect

	offx =(limit_rect.size.x/2) * 0.0001
	offy =(limit_rect.size.y/2) * 0.0001
	_snap_to_limits()


#func _set_camera_limit(value: Rect2):
#	set_limit_rect(value)

func _draw() -> void:
	
	if not debug:
		return
	
	var vr = get_viewport_rect()
	
	
	draw_line(Vector2(-vr.size.x/2, 0),Vector2(vr.size.x/2, 0), Color.white, 5)
	
	
	draw_circle(Vector2.ZERO, 2, Color.brown)






