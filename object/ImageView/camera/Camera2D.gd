extends Camera2D


export var debug := false


func _ready() -> void:
	
	share.add_hook('scroll', self, 'set_scroll')
	
#	Console.addCommand('goto', self, 'goto_index')\
#		.setDescription('Going to image number "Number %index%!"')\
#		.addArgument('index', TYPE_INT)\
#		.register()


func init():
	
	var pos = Vector2(0, off_height())
	
	$movement.target = pos
	position = pos
	
	moved()



func snap_to_limits_util(target = position):
	
	var limit_rect = owner.limit_rect
	
	target.x = clamp(target.x, limit_rect.position.x, limit_rect.end.x)
	target.y = clamp(target.y, limit_rect.position.y, limit_rect.end.y)
	
	return target

func snap_to_limits(fix_position = false):
	position = snap_to_limits_util()
	
	if fix_position:
		$movement.target = position
	
	moved()




func moved():
	var scroll = 0
	
	if position.y != 0 and get_parent().perhundred() != 0:
		scroll = position.y / get_parent().perhundred()
	
	share.set_value('scroll', scroll)


func set_scroll(scroll):
	var perhundred = owner.limit_rect.end.y / 100.0
	var pos = perhundred * scroll
	
	position.y = pos
	position = snap_to_limits_util()







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






