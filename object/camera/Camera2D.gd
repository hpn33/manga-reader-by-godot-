extends Camera2D


export var debug := false


onready var image_place = $"../ImagePlace"

## Rectangle used to limit camera panning.
## Note that the built in camera limits do not work: they don't actually constrain the position of the camera.
## They only stop the view from moving. For the player, this makes the camera appear to "stick" at the edges of the map, 
## which is bad.
var limit_rect = Rect2(Vector2(), Vector2.ONE * 100)

func _ready() -> void:
	
	manager.connect("showed", self, 'init')
	
	share.add_hook('camera_limit', self, 'set_limit_rect')
	share.add_hook('scroll', self, 'set_scroll')
	
	Console.addCommand('goto', self, 'goto_index')\
		.setDescription('Going to image number "Number %index%!"')\
		.addArgument('index', TYPE_INT)\
		.register()


func init():
	
	var pos = Vector2(0, off_height())
	
	$movement.target = pos
	position = pos
	
	moved()


var off := Vector2()
func set_limit_rect(rect: Rect2):
	limit_rect = rect

	off.x =(limit_rect.size.x/2) * 0.0001
	off.y =(limit_rect.size.y/2) * 0.0001



func snap_to_limits(target = position):
	
	target.x = clamp(target.x, limit_rect.position.x+off.x, limit_rect.end.x-off.x)
	target.y = clamp(target.y, limit_rect.position.y+off.y, limit_rect.end.y-off.y)
	
	return target


func goto_index(index):
	if not images_size() > 0:
		print('no image set')
		return
	
	
	if index <= 0 or index > images_size():
		print('index [', index ,'] out of range [0 : ',images_size(), ']')
		return
	
	print('index ', index, ' ', images_size())
	
	
	position.y = image_place.child_height(index) + off_height()
	
	position = snap_to_limits(position)
	$movement.target = position
	
	moved()
	

func images_size() -> int:
	return image_place.get_child_count() - 1


func moved():
	var scroll = 0
	
	if position.y != 0 and image_place.perhundred() != 0:
		scroll = position.y / image_place.perhundred()
	
	share.set_value('scroll', scroll)


func set_scroll(scroll):
	var perhundred = limit_rect.end.y / 100.0
	var pos = perhundred * scroll
	
	position.y = pos
	position = snap_to_limits()


func viewport_height() -> float:
	return get_tree().root.get_viewport().size.y


func off_height():
	return (viewport_height() / 2) * zoom.y * 0.9


func _process(delta):
	update()


func _draw() -> void:
	
	if not debug:
		return
	
	var vr = get_viewport_rect()
	
	
	draw_line(Vector2(-vr.size.x/2, 0),Vector2(vr.size.x/2, 0), Color.white, 5)
	
	
	draw_circle(Vector2.ZERO, 2, Color.brown)






