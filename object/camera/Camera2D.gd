extends Camera2D


export var debug := false


## Rectangle used to limit camera panning.
## Note that the built in camera limits do not work: they don't actually constrain the position of the camera.
## They only stop the view from moving. For the player, this makes the camera appear to "stick" at the edges of the map, 
## which is bad.
var limit_rect = Rect2(Vector2(), Vector2.ONE * 100)


func _ready() -> void:
	
	share.add_hook('camera_limit', self, 'set_limit_rect')



var off := Vector2()
func set_limit_rect(rect: Rect2):
	limit_rect = rect

	off.x =(limit_rect.size.x/2) * 0.0001
	off.y =(limit_rect.size.y/2) * 0.0001



func _snap_to_limits(target = position):
	
	target.x = clamp(target.x, limit_rect.position.x+off.x, limit_rect.end.x-off.x)
	target.y = clamp(target.y, limit_rect.position.y+off.y, limit_rect.end.y-off.y)
	
	return target




func _process(delta):
	update()


func _draw() -> void:
	
	if not debug:
		return
	
	var vr = get_viewport_rect()
	
	
	draw_line(Vector2(-vr.size.x/2, 0),Vector2(vr.size.x/2, 0), Color.white, 5)
	
	
	draw_circle(Vector2.ZERO, 2, Color.brown)






