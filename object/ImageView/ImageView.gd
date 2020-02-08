extends Node2D
class_name ImageView

#signal children_changed

onready var fsm = $state

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"


#var index := 0
var image_list := PoolStringArray()
var image_textures := []
var image_size := []


var size := Vector2()
var margin := Vector2(20, 10)

var box := Rect2()


#func _ready() -> void:
#	share.set_value('image_loader', Thread.new())

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
		
#		if i == get_child_count()-1:
#			size.y = child.get_pos().y + child.size.y
	
	set_camera_limit()
	sort()


func sort():
	var hp = 0
	
	for i in get_child_count():
		
		var child = get_children()[i]
		if child.name == 'state':
			continue
#		child.set_margin(50, 50)
		
		# set center
		child.position.x = size.x/2
		
		# set vertical position
		var fix = child.margin.y/2 if i == 1 else 0
		child.position.y = hp + fix
		
#		print(child.position)
		hp += child.size.y


func sort_to_last(index: int):
	var hp = 0
	
	for i in get_child_count():
		
		var child = get_children()[i]
		
		if child.name == 'state':
			continue
		
		if i >= index:
			# set center
			var x = size.x /2
			child.position.x = size.x/2
			
			# set vertical position
			var fix = child.margin.y/2 if i == 1 else 0
			child.position.y = hp + fix
			
		
		
#		print(child.position)
		hp += child.size.y


func _process(delta: float) -> void:
	update()


func _draw() -> void:

	var rect = Rect2(Vector2(), size)

	draw_rect(rect, Color.white, false, 10)

