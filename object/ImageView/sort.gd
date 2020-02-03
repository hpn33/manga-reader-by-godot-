extends State


func enter(msg: Dictionary = {}) -> void:
	_sort()


func _sort():
	if owner.get_child_count() == 1:
		return
	
#	var child:Sprite
	var sum = 0
	var max_width := 0.0
	
	for child in owner.get_children():
		
		if _is_fsm(child):
			continue
		
		max_width = max(float(child.texture.get_width()), max_width)
	
	for i in owner.get_child_count():
		
		var child = owner.get_child(i)
		
		if _is_fsm(child):
			continue
		
		child.position.x = max_width/2 - child.texture.size.x/2
		child.position.y = sum if i != 0 else 0
		
		sum += child.texture.get_height() + owner.seperation
		
		owner.set_box(max_width, sum)


func _is_fsm(node):
	return node is StateMachine

