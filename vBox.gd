extends Node2D

export(PackedScene) var image_holder = preload("res://object/ih2d/ImageHolder2D.tscn")

export(int) var spector = 0
#var obj_list := []

var index := 0
var image_names := []
var path := ''

func add_images(_path, images_list):
	for child in get_children():
		child.free()
	
	index = 0
	path = _path
	image_names = images_list
	
	add_image()
	
#	for image_name in images_list:
#		add_image(path + '/' + image_name)

func add_image():
	
	var new = image_holder.instance()
	new.connect("done", self, 'advance')
	
#	if get_children().size() == 0:
#		new.position.y = 0
	
#	var sum = 0
#	for obj in get_children():
#		sum += obj.texture.get_height()
	
#	new.position.y = sum
	
	add_child(new)
#	obj_list.append(new)
	new.loading(path + '/' + image_names[index])
	last_sort()
	


func _sort():
	
	var sum = 0
	
	for i in get_child_count():
		
		var child :Sprite= get_child(i)
		
		child.position.y = 0 if i == 0 else sum
		
		sum += child.texture.get_height() + spector
		
	

func advance():
	get_child(index).disconnect("done", self, 'advance')
	if index + 1 >= image_names.size():
		return
	
	index += 1
	add_image()

func last_sort():
	
	if get_child_count() == 0:
		return
	
	var last:Sprite
	var sum = 0
	
	for i in get_child_count():
		
		last = get_child(i)
		
		sum += last.texture.get_height() + spector
	
	last.position.y = sum
	


