extends Resource
class_name IOUtil


var path := ''
var directory := Directory.new()
var regex = RegEx.new()


func is_dir(_path = path):
	return directory.open(_path) == OK



func list(_path = path):
	
	if not dir_exists(_path):
		return []
	
	var list := []
	
	directory.open(_path)
	directory.list_dir_begin()
	var file_name = directory.get_next()
	while (file_name != ""):
		
		list.append(file_name)
		
		file_name = directory.get_next()
	
	clean()
	
	return list


func file_list(_path = path):
	
	if not dir_exists(_path):
		return []
	
	var list := []
	
	
	directory.open(_path)
	directory.list_dir_begin()
	
	var file_name = directory.get_next()
	
	while (file_name != ""):
		
		if not directory.current_is_dir():
			list.append(file_name)
			
		file_name = directory.get_next()
	
	clean()
	
	return list


func dir_list(_path = path):
	
	if not dir_exists(_path):
		return []
	
	var list := []
	
	directory.open(_path)
	directory.list_dir_begin()
	
	var file_name = directory.get_next()
	
	while (file_name != ""):
		
		if directory.current_is_dir():
			list.append(file_name)
			
		file_name = directory.get_next()
	
	clean()
	
	return list


func list_by_pattern(_pattern = '*',_path = path):
	
	if not dir_exists(_path):
		return []
	
	var list := []
	
	directory.open(_path)
	directory.list_dir_begin()
	
	var file_name = directory.get_next()
	
	while (file_name != ""):
		
		if not directory.current_is_dir():
			regex.compile(_pattern)
			var result = regex.search(file_name)
			
			if result:
				list.append(file_name)
			
		file_name = directory.get_next()
	
	clean()
	
	return list


func list_by_type(_types, _path = path):
	
	if not dir_exists(_path):
		return []
	
	var list := []
	var types := ''
	
	# set type for matching
	if typeof(_types) == TYPE_ARRAY:
		for index in _types.size():
			types += _types[index]
			
			if index != _types.size() - 1:
				types += '|'
	
	elif typeof(_types) == TYPE_STRING:
		types = _types
	
	else:
		return []
	
	
	directory.open(_path)
	directory.list_dir_begin()
	
	var file_name = directory.get_next()
	while (file_name != ""):
		
		if not directory.current_is_dir():
			regex.compile("[*.](" + types + ")$")
			var result = regex.search(file_name)
			
			if result:
				list.append(file_name)
			
		file_name = directory.get_next()
	
	clean()
	
	return list


func dir_exists(_path):
	return directory.dir_exists(_path)


func file_exists(_path):
	return directory.file_exists(_path)


func clean():
	directory = Directory.new()
	regex = RegEx.new()
