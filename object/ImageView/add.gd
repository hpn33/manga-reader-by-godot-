extends State


func enter(msg: Dictionary = {}) -> void:
	_add_image()


func _add_image():
	 
	_remove_children()
	
	if not _has_image():
		return
	
	_add()
	
	change_state('sort')


func _remove_children():
	# clear
	for child in owner.get_children():
		
		if 'state' != child.name:
			owner.remove_child(child)


func _has_image():
	return owner.image_list.size() != 0


func _add():
	for texture in owner.image_textures:
		var new = owner.image_holder.instance()
	
		owner.add_child(new)
		new.texture = texture

