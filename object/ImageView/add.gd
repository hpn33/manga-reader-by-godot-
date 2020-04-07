extends State

var image_holder :PackedScene= preload("res://object/ImageHolder2D/ImageHolder2D.tscn")


func enter(msg: Dictionary = {}) -> void:
	_add_image()
	
	change_state('sort')


func _add_image():
	 
	_remove_children()
	
	get_parent().get_parent().set_size_zero()
	
	if not _has_image():
		return
	
	_add()


func _add():
	
	for image in get_parent().get_parent().image_list:
		
		var new :Sprite= image_holder.instance()
		
		new.init(get_parent().get_parent(), image)
		new.set_margin(10, 10)
		
		get_parent().get_parent().add_child(new)
		
		new.loading()
	


func _remove_children():
	for child in get_parent().get_parent().get_children():
		
		if not child.name in ['state', 'Camera2D', 'CanvasLayer']:
			get_parent().get_parent().remove_child(child)


func _has_image():
	return get_parent().get_parent().image_list.size() != 0
