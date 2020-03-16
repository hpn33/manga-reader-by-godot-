extends Node
class_name IOUtil



## var

var path := ''

var directory := Directory.new()
var file := File.new()

var regex = RegEx.new()


## method

func be(_path):
	directory.open(_path)
	print(directory.current_is_dir())
	
	path = _path


func current():
	return path


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
			regex.compile("(?<title>[\\w]*).(?<type>(" + types + "))$")
			var result = regex.search(file_name)
			
			if result:
				var file_info = FileInfo.new(
					_path,
					result.get_string('title'),
					result.get_string('type'))
				
				list.append(file_info)
			
		file_name = directory.get_next()
	
	return list


func dir_exists(_path):
	return directory.dir_exists(_path)


func file_exists(file) -> bool:
	return directory.file_exists(path + '/' + file)


func make_dir(_dir_name):
	return directory.make_dir(path + '/' +_dir_name)

func make_file(_file_name):
	var result = file.open(path + '/' + _file_name, File.WRITE)
	
	file.close()
	
	return result == OK

