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
#	for child in get_children():
#		child.loading()
	
	refresh()


func refresh():
	
	
	
#	for child in get_children():
#		child.visible = false

	for image in owner.image_on_the_range():
		image.loading()
	
	pass



func perhundred() -> float:
	return height() / 100.0




# get index take height
func child_position(index: int):
	
	if get_children().empty():
		return
	
	var height := 0.0
	
	if 0 <= index and index < get_child_count():
		height = get_child(index).position.y
	
	return height


func child_in_range(start, end):
	var in_range := []
	
	for child in get_children():
		var rect = child.rect()
		
		if rect.position.y in range(start, end):
			in_range.append(child)
			
		
		elif rect.end.y in range(start, end):
			in_range.append(child)
		
	
	return in_range


func find_child_index(camera_height) -> int:
	
	if get_children().empty():
		return -1
	
	for child in get_children():
		
		if child.position.y <= camera_height and camera_height <= child.position.y + child.height():
			
			return child.get_index()
	
	return -1

