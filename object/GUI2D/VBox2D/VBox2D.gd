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


func add_child(node: Node, legible_unique_name: bool = false):
	print(node)
	if not node is Box2D:
		.add_child(node)
		return

	var y = 0
	for child in get_children():
		y += child.out_rect().size.y
	
	node.position.y = y
	node.position.x = get_x_position()
	
	.add_child(node)

func sort_children():
	var y = 0
	for child in get_children():
		
		if not child is Box2D:
			continue
		
		child.position.y = y
		child.position.x = get_x_position()
		
		y += child.out_rect().size.y


func sort_to_last(index: int, diff):
	
	for i in get_child_count():
		
		var child = get_children()[i]
		
		child.position.x = offset.x
		
		if i > index:
			child.position.y += diff
	
#	camera.moved()
	




func resize():
	var y = 0
	var x = 0
	
	for child in get_children():
		x = max(x, child.size.x)
		y += child.size.y
	
	size.x = x
	size.y = y
