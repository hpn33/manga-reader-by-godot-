tool
extends VBox2D


var image_holder :PackedScene= preload("res://object/ImageHolder2D/ImageHolder2D.tscn")


func render(image_list):
	
	
	# check exist image
	if image_list.empty():
		return
	
	
	# remove children and resize
	reset()
	
	
	# add
	for image in image_list:

		var new :Node2D= image_holder.instance()

		new.init(self, image)
		new.set_margin(Vector2.ONE * 10)
		
		new.position.y = in_rect().size.y
		
		add_child(new)
		
		resize()
	
	# sort
	sort_children()
	
	owner.reset()
	
	# load
	for child in get_children():
		child.loading()




func perhundred() -> float:
	return height() / 100.0




# get index take height
func child_position(_index: int):
	
	if get_children().empty():
		return
	
	var index := _index - 1
	
	var _height := 0.0
	
	if 0 <= index and index < get_child_count():
		_height = get_child(index).position.y
	
	return _height


func find_child_index(camera_height):
	
	if get_children().empty():
		return -1
	
	for child in get_children():
		
		if child.position.y <= camera_height and camera_height <= child.position.y + child.height():
			
			return child.get_position_in_parent()
	
	return -1

