extends State


func enter(msg: Dictionary = {}) -> void:
	_sort()
	change_state('idle')


func _sort():
	if owner.get_child_count() == 1:
		return
	
#	var child:Sprite
	var sum = 0
	var max_width :float= owner.size.x
	var seperation = 0
	
	for i in owner.get_child_count():
		
		var child = owner.get_child(i)
		
		if _is_fsm(child):
			continue
		
		child.position.x = max_width/2
		child.position.y = sum if not i in [0, 1] else 0
		
		
		if i >= 1 and (not i >= owner.get_child_count()-1):
			seperation = owner.seperation
		
#		print('i:\t', i, ':', owner.get_child_count()-1)
		
		sum += child.texture.get_height() + seperation
		
#		owner.set_box(max_width, sum)


func _is_fsm(node):
	return node is StateMachine

