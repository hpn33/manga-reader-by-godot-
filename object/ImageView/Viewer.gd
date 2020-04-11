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
	
	owner.refresh()
	
	# load
#	for child in get_children():
#		child.loading()




func perhundred() -> float:
	return height() / 100.0




# not count state
func child_position(_index):
	print('child height: ', _index, '/', get_child_count())
	
	var index = _index - 1
	if index >= 0 and index < get_child_count():
		return get_child(index).position.y
	
	return null



