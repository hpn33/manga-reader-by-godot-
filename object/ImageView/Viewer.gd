tool
extends VBox2D


var image_holder :PackedScene= preload("res://object/ImageHolder2D/ImageHolder2D.tscn")


func render(image_list):
	
	# remove_children
	for child in get_children():
		remove_child(child)
	
	# 
	resize()
	
	# check exist image
	if image_list.empty():
		return
	
	# add
#	for image in image_list:
#
#		var new :Node2D= image_holder.instance()
#
#		new.init(self, image)
#		new.margin = Vector2.ONE * 10
#
#		add_child(new)
	
	# sort
	sort_children()
	
	# load
	for child in get_children():
		child.loading()



# not count state
func child_height(_index):
	var index = _index + 1
	print(index)
	
	if index >= 2 or index < get_child_count():
		return get_child(index).position.y
	
	return null



