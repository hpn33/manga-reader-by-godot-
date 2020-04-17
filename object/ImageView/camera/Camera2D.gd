extends Camera2D


export var scroll := 0.0







func reset():
	
	var image = get_parent().get_focus_image()
	
	if not image:
		set_pos(Vector2())
		return
	
	var z :float= (viewport(false).y * 0.9) if image.height() > viewport(false).y else image.height()
	
	set_pos(
		Vector2(0, image.position.y + z / 2),
		true, false)
	







func snap_to_limits_util(target = position):
	
	var limit_rect = owner.limit_rect
	
	target.x = clamp(target.x, limit_rect.position.x, limit_rect.end.x)
	target.y = clamp(target.y, limit_rect.position.y, limit_rect.end.y)
	
	return target


func snap_to_limits(fix_position = true, notify = true):
	position = snap_to_limits_util()
	
	if fix_position:
		$movement.target = position
	
	
	if notify:
		moved()




func moved():
	
	if position.y == 0:
		scroll = 0
	
	elif position.y != 0 and owner.perhundred() != 0:
		scroll = position.y / owner.perhundred()
	
	owner.notify(self)


func set_pos(pos, fix_position = true, notify = true):
	position = pos
	
	snap_to_limits(fix_position, notify)


func viewport(zooming = true) -> Vector2:
	
	var viewport :Vector2= get_tree().root.get_viewport().size
	
	if zooming:
		viewport *= zoom
	
	return viewport






func get_scroll_by_height(height):
	
	if height != 0 and owner.perhundred() != 0:
		scroll = height / owner.perhundred()
	
	return scroll








func notify(last):
	
	if last.name == 'Navigate':
		
		var image = owner.get_focus_image()
		var z :float= 0.9 if image.height() > viewport(false).y else 1
		
		set_pos(
			Vector2(0, image.position.y + (viewport(false).y * z) / 2),
			true, false)
	
	elif last.name == 'scroll_bar':
		
		set_pos(
			Vector2(0, owner.perhundred() * owner.get_scroll(self)),
			true, false)


#func _process(delta):
#	update()
#
#
#func _draw():
#
#	draw_circle(Vector2.ZERO, 3, Color.white)
#
#	draw_line(Vector2.ZERO, Vector2(0, viewport(false).y), Color.white)
