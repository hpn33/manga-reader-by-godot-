extends Node2D
class_name ImageView

export var debug := false

onready var fsm = $state

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"


var image_list := PoolStringArray()
var image_textures := []
var image_size := []


var size := Vector2()
var margin := Vector2(20, 10)


func start(_image_list):
	image_list = _image_list

	fsm.transition_to('add')


func set_camera_limit():
	
	var rect = Rect2(position, size)
	
	share.set_value('camera_limit', rect)


func set_size():
	
	size.y = 0
	for i in get_child_count():
		var child = get_children()[i]
		
		if child.name == 'state':
			continue
		
		size.x = max(size.x, child.size.x)
		
		size.y += child.size.y
	
	set_camera_limit()


func set_size_zero():
	size = Vector2()


func sort():
	var hp = 0
	var center_x = size.x/2
	
	for i in get_child_count():
		
		var child = get_children()[i]
		if child.name == 'state':
			continue
		
		# set center
		child.position.x = center_x
		
		# set vertical position
		child.position.y = hp
		
		hp += child.size.y


func fix_pos_to_last(index: int, diff):
	set_size()
	var center_x = size.x/2
	
	for i in get_child_count():
		
		var child = get_children()[i]
		
		if child.name == 'state':
			continue
		
		child.position.x = center_x
		
		if i > index:
			child.position.y += diff


func sorting():
	set_size()
	sort()


func _process(delta: float) -> void:
	update()


func _draw() -> void:

	if not debug:
		return

	var rect = Rect2(Vector2(), size)

	draw_rect(rect, Color.white, false, 10)

