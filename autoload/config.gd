extends Node
class_name Config


signal init


var _path := 'user://config.cfg'

var _default := {
	current_color = '',
	colors = [
		['default', '1a1a1a'],
		['color-1', '115853']
	],
	recents = []
}

var root_section = 'setting'


var cf : ConfigFile


func init():
	cf = ConfigFile.new()
	_make_first()
	self.load()
	emit_signal("init")


func _make_first():
	if cf.load(_path) != OK:
		# making config file
		for key in _default.keys():
			cf.set_value(root_section, key, _default[key])
	
	save()


func show_text():
	var f =  File.new()
	f.open(_path, File.READ)
	print(f.get_as_text())
	f.close()


func rebuild():
	
	for key in _default.keys():
		cf.set_value(root_section, key, _default[key])
	
	save()


func save(): cf.save(_path)
func load(): cf.load(_path)


func get_data(key, default = null):
	return cf.get_value(root_section, key, default)


func set_data(key, value):
	cf.set_value(root_section, key, value)




