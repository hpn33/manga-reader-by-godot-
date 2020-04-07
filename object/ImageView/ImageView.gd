extends Node2D
class_name ImageView


onready var proces = $Process
onready var camera = $Camera2D


export var can_debug := false

var image_list := []
#var image_textures := []
#var image_size := []


var size := Vector2()
var margin := Vector2(20, 10)
var offset := Vector2()

var box := Rect2()

var limit_rect := Rect2(Vector2(), Vector2.ONE * 100)


var gourded_node := []

func _ready():
	manager.connect("showing", self, 'showing')
#	share.add_hook('image_list', self, 'start')
	
	for child in get_children():
		gourded_node.append(child.name)


func showing():
	image_list = manager.show_list()
	
	proces.start()


func set_size():
	
	size.y = 0
	for i in get_child_count():
		var child = get_children()[i]
		
		if child.name in gourded_node:
			continue
		
		size.x = max(size.x, child.size.x)
		
		size.y += child.size.y
	
	offset.x = box().x/2

func set_size_zero():
	size = Vector2()


func box():
	return size + margin


func sort():
	var hp = 0
	offset.x = size.x/2
	
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
	


func _process(delta: float) -> void:
	update()


func _draw() -> void:

	if not can_debug:
		return

	var rect = Rect2(Vector2(), size)

	draw_rect(rect, Color.white, false, 10)
	
	draw_circle(Vector2.ZERO, 2, Color.plum)
