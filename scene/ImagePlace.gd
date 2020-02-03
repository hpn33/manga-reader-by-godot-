extends ImageView


func _ready() -> void:
	share.add_hook('path', self, '_path_changed')

var path := ''

func _path_changed(value):
	if path == value:
		return
	
	path = value
	find_image_path(path)


func find_image_path(path: String) -> void:
	
	var regex = RegEx.new()
	var image_list:= []
	var dir := Directory.new()
	
	if dir.open(path) == OK:
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
				
				regex.compile('[*.](png|jpg)$')
				var result = regex.search(file_name)
				
				if result:
					image_list.append(path + '/' + file_name)
				
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	share.set_value('page_count', image_list.size())
	
	start(image_list)

