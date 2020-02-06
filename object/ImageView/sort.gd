extends State


func enter(msg: Dictionary = {}) -> void:
#	_sort()
	
	var hp = 0
	
	for child in owner.get_children():
		if child.name == 'state':
			continue
		child.set_margin(50, 50)
		
		# set center
		child.position.x = owner.size.x/2
		
		# set vertical position
		child.position.y = hp -child.get_pos().y
		
#		print(child.position)
		hp += child.size.y
	
	owner.set_size()
	change_state('idle')


func _sort():
	if owner.get_child_count() == 1:
		return
	
	for i in owner.get_child_count():
		
		var child = owner.get_child(i)
		
		if _is_fsm(child):
			continue
		
		
		
		
		
		


func _is_fsm(node):
	return node is StateMachine

