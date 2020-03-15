extends ImageView


"""
check path
find image on path
sort image's
start showing image's

"""


var can_sort := true
var path := ''
var iou : IOUtil


func _ready() -> void:
	share.add_hook('target_dir', self, '_target_dir_changed')
	
	iou = IOUtil.new()


func _target_dir_changed(value):
	if path == value:
		return
	
	path = value
	
	_find_image_path()
	


func _find_image_path() -> void:
	
	var image_list:= []
	
	if iou.is_dir(path):
		image_list = iou.list_by_type('png|jpg', path)
	
	else:
		print("An error occurred when trying to access the path.")
	
	
	if can_sort:
		image_list = sort_list(image_list)
	
#	for i in image_list:
#		print(i)
	
	image_list = add_path_to_list(image_list)
	
	start(image_list)



func sort_list(_list):
	
	var list = _list
	
	var i = list.size()
	
#	for i in list.size():
#
	
	return list


func add_path_to_list(_list):
	var list = _list

	for i in _list.size():
		var index = i - 1 
		list[index] = path + '/' + list[index]

	return list





class PathHolder:
	var path := ''
	var title := ''
	var type := ''
	
	func _init(_path, _title, _type):
		path = _path
		title = _title
		type = _type
	
	
