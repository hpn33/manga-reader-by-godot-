extends Node


onready var camera = $Camera2D
onready var background = $background
onready var image_holder = $vBox 
onready var ui = $UI


func _ready() -> void:
	data.connect("data_changed", self, '_data_changed')

func fix_background():
	background.fix_by_camera(camera)




func find_image_path(path: String) -> void:
	
	var regex = RegEx.new()
	var image_list:= []
	var dir := Directory.new()
	
#	print('path: ' + di)
	if dir.open(path) == OK:
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
				
#				print(file_name)
				regex.compile('[*.](png|jpg)$')
				var result = regex.search(file_name)
				
				if result:
					image_list.append(file_name)
				
#				
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	image_holder.add_images(path, image_list)


func _data_changed(_data):
	
	find_image_path(_data['path'])
