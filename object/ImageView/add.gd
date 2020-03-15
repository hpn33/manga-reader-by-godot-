extends State


func enter(msg: Dictionary = {}) -> void:
	_add_image()
	
	change_state('sort')


func _add_image():
	 
	_remove_children()
	
	owner.set_size_zero()
	
	if not _has_image():
		return
	
	_add()


func _add():
	
	for image in owner.image_list:
		
		var new :Sprite= owner.image_holder.instance()
		
		new.init(owner, image.full_path())
		new.set_margin(10, 10)
		
		owner.add_child(new)
		
		new.loading()
	


func _remove_children():
	for child in owner.get_children():
		
		if child.name != 'state':
			owner.remove_child(child)


func _has_image():
	return owner.image_list.size() != 0
