extends VBoxContainer


export(PackedScene) var image_holder = preload("res://object/ihc/ImageHolder.tscn")


func add_images(path, images_list):
	for child in get_children():
		child.free()
	
	for image_name in images_list:
		add_image(path + '/' + image_name)

func add_image(path_file):
	
	var new = image_holder.instance()
	add_child(new)
	new.loading(path_file)
	
	
	
