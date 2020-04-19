tool
extends Box2D
class_name VBox2D


enum H_ALIGN { RIGHT, CENTER, LEFT }

export(H_ALIGN) var h_align := H_ALIGN.CENTER setget set_h_align

func set_h_align(_h_align):
	h_align = _h_align
	
	sort_children()



func get_x_position() -> float:
	
	var rect = in_rect()
	
	if h_align == H_ALIGN.LEFT:
		return rect.position.x
	
	elif h_align == H_ALIGN.CENTER:
		return rect.position.x + rect.size.x /2
	
	elif h_align == H_ALIGN.RIGHT:
		return rect.position.x + rect.size.x
	
	return 0.0


func remove_children():
	
	for child in get_children():
		remove_child(child)


func sort_children():
	var y = 0
	for child in get_children():
		
		child.position.y = y
		child.position.x = get_x_position()
		
		y += child.height()
	
	resize()


func sort_from(index: int, diff: float):
	
	for i in get_child_count():
		var child = get_children()[i]
		
		child.position.x = get_x_position()
		
		if i > index:
			
			child.position.y += diff
	
	resize()




func resize():
	
	var y = 0
	var x = 0
	
	for child in get_children():
		x = max(x, child.width())
		y += child.height()
	
	if x == 0:
		size = Vector2.ONE * 100
	else:
		size = Vector2(x, y)
	
	
	repivot()



func reset():
	remove_children()
	resize()


func first():
	return get_child(0)


func last():
	return get_child(get_child_count()-1)
