extends Node


var zoom_step := 1.1
var min_zoom := 0.5
var max_zoom := 10.0

var zoom_target := Vector2()


func _ready():
	zoom_target = owner.zoom


func _input(event):
	
	# zoom click
	if event.is_action("zoom_in"):
		
		zoom_target = owner.zoom / zoom_step
	
	if event.is_action("zoom_out"):
		
		zoom_target = owner.zoom * zoom_step



func _process(delta):
	
	owner.zoom = lerp(owner.zoom, zoom_target, 20 * delta)
	_snap_zoom_limits()


func _snap_zoom_limits():
	
	owner.zoom.x = clamp(owner.zoom.x, min_zoom, max_zoom)
	owner.zoom.y = clamp(owner.zoom.y, min_zoom, max_zoom)
