class_name FileInfo


var path := ''
var title := ''
var type := ''

func _init(_path, _title, _type):
	path = _path
	title = _title
	type = _type
	

func full_path():
	return path + '/' + title + '.'+ type
	


#func to_dic() -> Dictionary:
#	return {
#		title = self.title,
#		type = self.type
#	}


#func import(dic: Dictionary):
#	pass
