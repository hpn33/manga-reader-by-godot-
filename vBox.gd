extends Node2D

export(PackedScene) var image_holder = preload("res://object/ih2d/ImageHolder2D.tscn")

export(int) var spector = 0
#var obj_list := []

func add_images(path, images_list):
	for child in get_children():
		child.free()
	
	for image_name in images_list:
		add_image(path + '/' + image_name)

func add_image(path_file):
	
	var new = image_holder.instance()
	new.connect("texture_changed", self, '_sort')
	
#	if get_children().size() == 0:
#		new.position.y = 0
	
#	var sum = 0
#	for obj in get_children():
#		sum += obj.texture.get_height()
	
#	new.position.y = sum
	
	add_child(new)
#	obj_list.append(new)
	new.loading(path_file)
	_sort()
	


func _sort():
	
	var sum = 0
	
	for i in get_child_count():
		
		var child :Sprite= get_child(i)
		
		child.position.y = 0 if i == 0 else sum
		
		sum += child.texture.get_height() + spector
		
	


