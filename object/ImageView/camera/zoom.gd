extends Node


var zoom_step := 1.25

var min_zoom := 0.5
var max_zoom := 10.0

var zoom_target := Vector2()

var zooming := false


func _ready():
	zoom_target = get_parent().zoom


func _input(event):
	
	# zoom click
	if event.is_action("zoom_in"):
		zoom_in()
		zooming = true
	
	if event.is_action("zoom_out"):
		zoom_out()
		zooming = true


func _process(delta):
	
	if not zooming:
		if Input.is_action_pressed("zoom_in"):
			zoom_in()
	#
		if Input.is_action_pressed("zoom_out"):
			zoom_out()
	
	else:
		zooming = false
	
	# final
	get_parent().zoom = lerp(get_parent().zoom, zoom_target, 20 * delta)




func reset():
	zoom_target = Vector2.ONE
	get_parent().zoom = Vector2.ONE









func _snap_zoom_limits():
	
	zoom_target.x = clamp(zoom_target.x, min_zoom, max_zoom)
	zoom_target.y = clamp(zoom_target.y, min_zoom, max_zoom)


func zoom_in():
	zoom_target = get_parent().zoom / zoom_step
	_snap_zoom_limits()


func zoom_out():
	zoom_target = get_parent().zoom * zoom_step
	_snap_zoom_limits()

