extends Camera2D


export var scroll := 0.0







func reset():
	
	set_pos(Vector2())







func snap_to_limits_util(target = position):
	
	var limit_rect = owner.limit_rect
	
	target.x = clamp(target.x, limit_rect.position.x, limit_rect.end.x)
	target.y = clamp(target.y, limit_rect.position.y, limit_rect.end.y)
	
	return target


func snap_to_limits(fix_position = true, can_moving = true):
	position = snap_to_limits_util()
	
	if fix_position:
		$movement.target = position
	
	
	if can_moving:
		moved()




func moved():
	
	if position.y == 0:
		scroll = 0
	
	elif position.y != 0 and owner.perhundred() != 0:
		scroll = position.y / owner.perhundred()
	
	owner.notify(self)


func set_pos(pos):
	position = pos
	
	snap_to_limits()


func goto(height):
	
	set_pos(Vector2(0, height))




func viewport_height() -> float:
	return get_tree().root.get_viewport().size.y






func get_scroll_by_height(height):
	
	if height != 0 and owner.perhundred() != 0:
		scroll = height / owner.perhundred()
	
	return scroll








func notify(last):
	
	if last.name == 'Navigate':
		position.y = owner.get_index_position()
		
		snap_to_limits(true, false)
	
	elif last.name == 'scroll_bar':
		
		position.y = owner.perhundred() * owner.get_scroll(self)
		
		snap_to_limits(true, false)

