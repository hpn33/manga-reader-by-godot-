extends ImageView


func _ready() -> void:
	share.add_hook('target_dir', self, '_target_dir_changed')

var path := ''

func _target_dir_changed(value):
	if path == value:
		return
	
	path = value
	_find_image_path()


func _find_image_path() -> void:
	
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
	
#	share.set_value('page_count', image_list.size())
	share.set_value('image_list', image_list)
	
	start(image_list)

