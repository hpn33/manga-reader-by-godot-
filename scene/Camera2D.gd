extends Camera2D

var zoom_step := 1.1
var min_zoom := 0.5
var max_zoom := 10.0

var pan_speed := 800

## Rectangle used to limit camera panning.
## Note that the built in camera limits do not work: they don't actually constrain the position of the camera.
## They only stop the view from moving. For the player, this makes the camera appear to "stick" at the edges of the map, 
## which is bad.
export(Rect2) var limit_rect = Rect2(Vector2(), Vector2.ONE * 100) setget set_limit_rect

var mouse_captured := false


func _ready() -> void:
	share.add_hook('camera_limit', self, '_set_camera_limit')


func _input(event):
	if event.is_action_pressed("view_zoom_in"):
		zoom /= zoom_step
		_snap_zoom_limits()
	if event.is_action_pressed("view_zoom_out"):
		zoom *= zoom_step
		_snap_zoom_limits()
	
	if event.is_action_pressed("view_click_mouse"):
		mouse_captured = true
	elif event.is_action_released("view_click_mouse"):
		mouse_captured = false
	
	if mouse_captured && event is InputEventMouseMotion:
		position -= event.relative * zoom #like we're grabbing the map
		_snap_to_limits()

# use _process for smoother scrolling
func _process(delta):
	
	if Input.is_action_pressed("view_click_mouse"):
		#smooth keyboard zoom
		if Input.is_action_pressed("view_pan_up"):
			zoom /= zoom_step
			_snap_zoom_limits()
		if Input.is_action_pressed("view_pan_down"):
			zoom *= zoom_step
			_snap_zoom_limits()
	else:
		#smooth keyboard zoom
		if Input.is_action_pressed("view_zoom_in"):
			zoom /= zoom_step
			_snap_zoom_limits()
		if Input.is_action_pressed("view_zoom_out"):
			zoom *= zoom_step
			_snap_zoom_limits()
	
	
	var panning = Vector2()
	panning.x += int(Input.is_action_pressed("view_pan_right")) - int(Input.is_action_pressed("view_pan_left"))
	panning.y += int(Input.is_action_pressed("view_pan_down")) - int(Input.is_action_pressed("view_pan_up"))

	if panning.length_squared() > 0:
		position += panning.normalized() * pan_speed * delta * zoom
		if limit_rect: _snap_to_limits()

var offx := 0.0
var offy := 0.0
# force position to be inside limit_rect
func _snap_to_limits():
	
	position.x = clamp(position.x, limit_rect.position.x+offx, limit_rect.end.x-offx)
	position.y = clamp(position.y, limit_rect.position.y+offy, limit_rect.end.y-offy)


func _snap_zoom_limits():
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)


func set_limit_rect(rect: Rect2):
	limit_rect = rect

	offx =(limit_rect.size.x/2) * 0.20
	offy =(limit_rect.size.y/2) * 0.0001
	_snap_to_limits()


func _set_camera_limit(value: Rect2):
	set_limit_rect(value)

