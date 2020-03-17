extends Node
class_name ConfigWraper


signal init


var path := 'user://config.cfg'

var default := {}

var root_section := 'root'


var cf := ConfigFile.new()


func init():
	_make_first()
	self.load()
	emit_signal("init")


func _make_first():
	# if not exist make it but need folder
	if cf.load(path) != OK:
		# making config file
		for key in default.keys():
			cf.set_value(root_section, key, default[key])
		
		save()


func show_text():
	var f =  File.new()
	f.open(path, File.READ)
	print(f.get_as_text())
	f.close()


func rebuild():
	
	for key in default.keys():
		cf.set_value(root_section, key, default[key])
	
	save()


func save(): cf.save(path)
func load(): cf.load(path)


func get_data(key, default = null):
	return cf.get_value(root_section, key, default)


func set_data(key, value):
	cf.set_value(root_section, key, value)




