extends Node
class_name Manager

enum {
	none,
	selected
}

var ioutil := IOUtil.new()
var setting :ImagesSetting

var path := ''


func open(_path):
	# init
	path = _path
	setting = ImagesSetting.new(_path)
	ioutil.be(_path)
	
	# if path exist set it
	if not ioutil.dir_exists():
		print("An error occurred when trying to access the path.")
		return
	
	
	
	setting.active()
	
	
	# check change's
	check_change()
	
#	set_sort()
	
	# use config's
#	read_config()
	
	
	
	# get images
#	var image_list = setting.get_name_list()
	var image_list = ioutil.list_by_type('png|jpg')
	
	share.set_value('image_list', image_list)
	share.set_value('local_files', setting.files)



#func first_set():
#	setting.active()


func check_change():
	var files :Dictionary= setting.files
	
#	var loc_names := []
#	for n in ioutil.list_by_type('png|jpg'):
#		loc_names.append(n.title)
	
	var loc_files := []
	for n in ioutil.list_by_type('png|jpg'):
		
		var item = {
			title = n.title,
			type = n.type
		}
		
		loc_files.append(item)
	
	
	if files.empty():
		# set all image names
		for n in loc_files:
			files[files.size()] = n
		
		save('files', files)
	
	else:
		# check change
		var mach := true
		
		for f in files:
			if loc_files.find(f) == -1:
				mach = false
				break
		
		# if names was change then save new names
		if not mach:
			save('files', loc_files)
	
	
#	setting.show_text()
	pass


#func set_sort():
#
#	var sort = setting.get_date('sort')
#
#	if sort.size() == 0:
#		sort = bubble_sort(setting.get_data('names'))
#
#		save('sort', sort)


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


func files() -> Array:
	return setting.files

func sort_list() -> Array:
	return setting.sort


func save(key, value):
	setting.set_data(key, value)
	setting.save()
