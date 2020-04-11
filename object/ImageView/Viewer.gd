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
	
	# load
#	for child in get_children():
#		child.loading()



# not count state
func child_height(_index):
	var index = _index + 1
	print(index)
	
	if index >= 2 or index < get_child_count():
		return get_child(index).position.y
	
	return null



