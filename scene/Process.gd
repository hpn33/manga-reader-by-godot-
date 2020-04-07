extends Node


var image_holder :PackedScene= preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

func start():
	_remove_children()
	
	get_parent().set_size_zero()
	
	if not _has_image():
		return
	
	_add()
	
	get_parent().sorting()


func _add():
	
	for image in get_parent().image_list:
		
		var new :Sprite= image_holder.instance()
		
		new.init(get_parent(), image)
		new.set_margin(10, 10)
		
		get_parent().add_child(new)
		
		new.loading()
	


func _remove_children():
	for child in get_parent().get_children():
		
		if not child.name in ['Process', 'Camera2D', 'CanvasLayer']:
			get_parent().remove_child(child)


func _has_image():
	return get_parent().image_list.size() != 0
