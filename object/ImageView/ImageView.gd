tool
extends Box2D
class_name ImageView


onready var camera = $Camera2D


var image_list := []

#var limit_rect := Rect2(Vector2(), Vector2.ONE * 100)


var gourded_node := []

func _ready():
	manager.connect("showing", self, 'show')
#	share.add_hook('image_list', self, 'start')
	
	for child in get_children():
		gourded_node.append(child.name)



var image_holder :PackedScene= preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

func show():
	image_list = manager.show_list()
	
	# remove_children
	for child in get_children():
		
		if child.name in gourded_node:
			return
		
		remove_child(child)
	
	# 
	size = Vector2()
	
	
	# check exist image
	if not image_list.size() != 0:
		return
	
	# add
	for image in image_list:
		
		var new :Sprite= image_holder.instance()
		
		new.init(self, image)
		new.set_margin(10, 10)
		
		add_child(new)
		
#		new.loading()
	
	# sort
	sorting()
	
	# load
	for child in get_children():
		
		if child.name in gourded_node:
			return
		
		child.loading()
	





func set_size():
	
	size.y = 0
	for i in get_child_count():
		var child = get_children()[i]
		
		if child.name in gourded_node:
			continue
		
		size.x = max(size.x, child.size.x)
		
		size.y += child.size.y
	
#	offset.x = box().x/2
	


#func box():
#	return size + margin


func sort():
	var hp = 0
#	offset.x = size.x/2
	
	for i in get_child_count():
		
		var child = get_children()[i]
		if child.name in gourded_node:
			continue
		
		# set center
		child.position.x = offset.x
		
		# set vertical position
		child.position.y = hp
		
		hp += child.size.y


func fix_pos_to_last(index: int, diff):
	set_size()
	offset.x = size.x/2
	
	for i in get_child_count():
		
		var child = get_children()[i]
		
		if child.name in gourded_node:
			continue
		
		child.position.x = offset.x
		
		if i > index:
			child.position.y += diff
	
	fix_position()
	
	camera.moved()
	


func sorting():
	set_size()
	sort()
	
	fix_position()


func fix_position():
	position = -offset


func perhundred() -> float:
	return size.y / 100.0


# not count state
func child_height(_index):
	var index = _index + 1
	print(index)
	
	if index >= 2 or index < get_child_count():
		return get_child(index).position.y
	
	return null
	


#func _process(delta: float) -> void:
#	update()


#func _draw() -> void:
#
#	if not can_debug:
#		return
#
#	var rect = Rect2(Vector2(), size)
#
#	draw_rect(rect, Color.white, false, 2)
#
#	draw_circle(Vector2.ZERO, 2, Color.plum)

