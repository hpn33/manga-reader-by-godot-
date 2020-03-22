class_name ImageItem


var path := ''
var title := ''
var type := ''

func _init(_path, _title, _type):
	path = _path
	title = _title
	type = _type
	

func full_path():
	return path + '/' + title + '.'+ type
	
