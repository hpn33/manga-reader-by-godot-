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

	for image in owner.image_on_the_range():
		image.loading()




func changing(image, diff: float):
	
	sort_from(image.get_index(), diff)
	
	if image.get_index() < owner.focus \
		and image.get_index() == owner.focus:

		var camera_position = owner.camera.position
		camera_position.y += diff
		
		owner.camera.set_pos(camera_position)


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


func child_in_range(start, end) -> Array:
	var in_range := []
	
	for child in get_children():
		var rect = child.rect()
		
		if start < rect.position.y and rect.position.y < end:
			in_range.append(child)
		
		
		elif start < rect.end.y and rect.end.y < end:
			in_range.append(child)
	
	
	return in_range


func find_child_index(camera_height) -> int:
	
	if get_children().empty():
		return -1
	
	for child in get_children():
		
		if child.position.y <= camera_height and camera_height <= child.position.y + child.height():
			
			return child.get_index()
	
	return -1

