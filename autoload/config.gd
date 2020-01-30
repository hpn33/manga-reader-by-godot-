extends Node
class_name Config

var _path := 'user://config.cfg'

var _default := {
	colors = [
		['default', '1a1a1a'],
	],
	recents = []
}

var root_section = 'setting'


var cf : ConfigFile


func init():
	cf = ConfigFile.new()
	_make_first()


func _make_first():
	print(_default.keys())
	if not Directory.new().file_exists(_path):
		# making config file
		for key in _default.keys():
			cf.set_value('setting', key, _default[key])
	
	_save()


func show_text():
	var f =  File.new()
	f.open(_path, File.READ)
	print(f.get_as_text())
	f.close()

#func get_data():
#
#	var dat = parse_json(file.get_as_text())
#
#	return dat


#func set_data(_data):
#	_open_file(File.WRITE)
#	cf.store_line(_data)
#	cf.close()


func rebuild():
	
	for key in _default.keys():
		cf.set_value(root_section, key, _default[key])
	
	_save()


func _save(): cf.save(_path)
func load(): cf.load(_path)


func set_data(_data: Dictionary):
	for key in _data.keys():
		cf.set_value(root_section, key, _data[key])
	





