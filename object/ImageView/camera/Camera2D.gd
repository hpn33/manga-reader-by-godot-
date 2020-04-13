extends Camera2D





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
	owner.notify(self)


func setting(vector:= Vector2(), fix_position = true):
	position = vector
	
	snap_to_limits(fix_position)




func init():
	setting(Vector2(0, off_height()), true)




func get_scroll() -> float:
	return get_scroll_by_position(position.y)


func get_scroll_by_position(height):
	var scroll := 0.0
	
	if height != 0 and owner.perhundred() != 0:
		scroll = height / owner.perhundred()

	return scroll



func set_pos():
	var perhundred = owner.limit_rect.end.y / 100.0
	var pos = perhundred * owner.get_scroll(self)
	
	position.y = pos
	
	snap_to_limits(true, false)


func set_pos_by_index():
	position.y = owner.get_index_position()
	
	snap_to_limits(true, false)



func goto(pos):
	
#	position.y = pos + off_height()
	position.y = pos
	
	snap_to_limits()




func viewport_height() -> float:
	return get_tree().root.get_viewport().size.y


func off_height():
	return (viewport_height() / 2) * zoom.y * 0.9


func notify(last):
	
	if last.name == 'Navigate':
		set_pos_by_index()
		pass
	elif last.name == 'scroll_bar':
		set_pos()


