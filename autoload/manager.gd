extends Node
class_name Manager



func get_image_list(_path):
	
	var regex = RegEx.new()
	var image_list:= []
	var dir := Directory.new()
	
	if dir.open(_path) == OK:
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
				
				regex.compile('[*.](png|jpg)$')
				var result = regex.search(file_name)
				
				if result:
					image_list.append(_path + '/' + file_name)
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return image_list



func open(_path):
	
	var image_list = get_image_list(_path)
	
	share.set_value('image_list', image_list)



