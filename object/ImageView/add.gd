extends State



func enter(msg: Dictionary = {}) -> void:
	_add_image()
	
	change_state('sort')


func _add_image():
	 
	_remove_children()
	
	if not _has_image():
		return
	
	_add()


func _remove_children():
	for child in owner.get_children():
		
		if child.name != 'state':
			owner.remove_child(child)


func _has_image():
	return owner.image_list.size() != 0


func _add():
	
	for image_path in owner.image_list:
		
		var new :Sprite= owner.image_holder.instance()
		
		new.init(owner, image_path)
		new.set_margin(0, 10)
		
#		owner.image_textures.append(new)
		owner.add_child(new)
		
		new.connect("update", owner, 'set_size')
		
#		new.loading()
	
	owner.set_size()
	
	




