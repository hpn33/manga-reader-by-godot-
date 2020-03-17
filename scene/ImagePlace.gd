extends ImageView


var can_sort := true
var path := ''
var iou := IOUtil.new()


func _ready() -> void:
	share.add_hook('target_dir', self, '_target_dir_changed')
	share.add_hook('image_list', self, 'start')

func _target_dir_changed(value):
	if path == value:
		return
	
	path = value
	
	_find_image()


func _find_image():
	
	var image_list := []
	
	if not iou.is_dir(path):
		print("An error occurred when trying to access the path.")
		return
	
	image_list = iou.list_by_type('png|jpg', path)
	
	if can_sort:
		image_list = bubble_sort(image_list)
	
	start(image_list)


func bubble_sort(array):
	var index = len(array) - 1
	while index >= 0:
		
		for j in range(index):
			
			if int(array[j].title) > int(array[j+1].title):
				var temp = array[j]
				array[j] = array[j+1]
				array[j+1] = temp
		
		index -= 1
	return array
	
