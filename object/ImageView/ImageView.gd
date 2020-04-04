extends Node2D
class_name ImageView


onready var fsm = $state
onready var camera = $"../Camera2D"

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")


export var can_debug := false

var image_list := []
#var image_textures := []
#var image_size := []


var size := Vector2()
var margin := Vector2(20, 10)
var offset := Vector2()





func start(_image_list):
	image_list = _image_list
	
	fsm.transition_to('add')


func set_size():
	
	size.y = 0
	for i in get_child_count():
		var child = get_children()[i]
		
		if child.name == 'state':
			continue
		
		size.x = max(size.x, child.size.x)
		
		size.y += child.size.y
	
	offset.x = box().x/2
	
	share.set_value('camera_limit', Rect2(position, size))


func set_size_zero():
	size = Vector2()


func box():
	return size + margin


func sort():
	var hp = 0
	offset.x = size.x/2
	
	for i in get_child_count():
		
		var child = get_children()[i]
		if child.name == 'state':
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
		
		if child.name == 'state':
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
func child_height(index):
	
	for i in range(1, get_child_count()):
		if i == index:
			return get_child(index).position.y
	
	return null
	


func _process(delta: float) -> void:
	update()


func _draw() -> void:

	if not can_debug:
		return

	var rect = Rect2(Vector2(), size)

	draw_rect(rect, Color.white, false, 10)
	
	draw_circle(Vector2.ZERO, 2, Color.plum)
