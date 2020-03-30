extends Node
class_name ConfigWraper


var path := 'user://config.cfg'

var default := {}

var section_name := 'root'

var shortget := []


var cf := ConfigFile.new()


func init():
	_make_first()
	return self.load()


func _make_first():
	# if not exist make it but need folder
	if cf.load(path) != OK:
		# making config file
		for key in default.keys():
			cf.set_value(section_name, key, default[key])
		
		save()


func show_text():
	var f =  File.new()
	f.open(path, File.READ)
	print(f.get_as_text())
	f.close()


func rebuild():
	
	for key in default.keys():
		cf.set_value(section_name, key, default[key])
	
	save()


func save(): cf.save(path)
func load(): return cf.load(path)


func get_data(key, _default = null):
	return cf.get_value(section_name, key, _default)


func set_data(key, value):
	cf.set_value(section_name, key, value)


func _get(property):
	
	
	# can make use a function
	for fun in get_method_list():
		if(fun["flags"] == METHOD_FLAG_FROM_SCRIPT+1):
			if property == fun['name']:
#				print('is func')
				return call(property)
	
	
	# if has a key can use get_data function
	if cf.has_section_key(section_name, property):
		if shortget.find(property) != -1:
#			print(section_name, ': ', cf.get_section_keys(section_name))
#			print(get_data(property))
			return get_data(property)
	
	var result = null
	
	for p in get_property_list():
		if p.name == property:
			result = ._get(property)
			break
	
	# else work by default
	return result



#func get_section_name():
#	return 'root'

