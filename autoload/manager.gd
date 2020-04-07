extends Node
class_name Manager


signal showed
"""
TODO:

- when files change than update sort list 

"""

var ioutil := IOUtil.new()
var setting := ImagesSetting.new()

var path := ''


func open(_path):
	
	
	# init
	path = _path
	ioutil.be(_path)
	
	# if path exist set it
	if not ioutil.dir_exists():
		print("An error occurred when trying to access the path.")
		return
	
	
	setting.be(_path)
	print('config connected:: ', setting.active() == OK)
	
	
	# check change's
	check_change()
	
	# use config
	# ....
	
	show()



func show():
	
	if path == "":
		print('need a path')
		return
	
	
	var list := []
	var files :Array= file_list().duplicate()

	if active_list() == 'File':
		for file in files:
			list.append(FileInfo.new(path, file.title, file.type))
		
	elif active_list() == 'Sort':
		
		for item in sort_list():
			
			if not item.visiable:
				continue
			
			for index in files.size():
				if item.id == files[index].id:
					
					list.append(FileInfo.new(path, files[index].title, files[index].type))
					files.remove(index)
					
					break
	
	share.set_value('image_list', list)
	emit_signal("showed")





func check_change():
	var files := file_list()
	
	var loc_files := []
	var index := 0
	for n in ioutil.list_by_type('png|jpg'):
		
		var item = {
			id = index,
			title = n.title,
			type = n.type
		}
		
		loc_files.append(item)
		index += 1
	
	
	if files.empty():
		
		save('file_list', loc_files)
		
		set_sort()
	
	else:
		# check change
		var mach := false
		
		for f in files:
			for lf in loc_files:
				if f.title == lf.title:
					mach = true
					break
			
			if not mach:
				save('file_list', loc_files)



func set_sort():

	var sort := sort_list()

	if sort.empty():
		
		for file in file_list():
			
			var item := {
				id = file.id,
				visiable = true
			}
			
			sort.append(item)
		
		save('sort_list', sort)


#func bubble_sort(array):
#	var index = len(array) - 1
#	while index >= 0:
#
#		for j in range(index):
#
#			if int(array[j].title) > int(array[j+1].title):
#				var temp = array[j]
#				array[j] = array[j+1]
#				array[j+1] = temp
#
#		index -= 1
#	return array


func file_list() -> Array:
	return setting.file_list

func sort_list() -> Array:
	return setting.sort_list

func active_list() -> String:
	return setting.active_list


func set_active_list(name: String) -> void:
	save('active_list', name)


func save(key, value):
	setting.set_data(key, value)
	setting.save()

