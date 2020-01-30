extends Node

var _path := 'user://config.json'

var _default := {
	colors = {
		'default': '1a1a1a'
	}
}

func init():
	
	var file := File.new()
	
	if not file.file_exists(_path):
		# making config file
		file.open(_path, File.WRITE)
		file.store_string(to_json(_default))
	
	file.close()















