extends Node2D

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"

export(int) var spector = 10

var index := 0
var image_names := []
var path := ''

var size := Vector2()

func _process(delta: float) -> void:
	update()

func add_images(_path, images_list):
	for child in get_children():
		child.free()
	
	index = 0
	path = _path
	image_names = images_list
	
	add_image()
	
#	for image_name in images_list:
#		add_image(path + '/' + image_name)

func add_image():
	
	var new = image_holder.instance()
	new.connect("done", self, 'advance')
	
	add_child(new)
	
	new.loading(path + '/' + image_names[index])
	last_sort()
	


func advance():
	sort()
	get_child(index).disconnect("done", self, 'advance')
	if index + 1 >= image_names.size():
		return
	
	index += 1
	add_image()

func last_sort():

	if get_child_count() == 0:
		return

	var last:Sprite
	var sum = 0
	var max_width := 0.0

	for i in get_child_count():

		last = get_child(i)

		sum += last.texture.get_height() + spector
		max_width = max(float(last.texture.get_width()), max_width)

	last.position.y = sum


	size = Vector2(max_width, sum)
	var rect = Rect2(position, size)
	camera2d.limit_rect = rect


func sort():
	if get_child_count() == 0:
		return
	
	var child:Sprite
	var sum = 0
	var max_width := 0.0
	
	for child in get_children():
		max_width = max(float(child.texture.get_width()), max_width)
	
	for i in get_child_count():
		
		child = get_child(i)
		
		child.position.x = max_width/2 - child.texture.size.x/2
		child.position.y = sum if i != 0 else 0
		
		sum += child.texture.get_height() + spector
	
	
	size = Vector2(max_width, sum)
	var rect = Rect2(position, size)
	camera2d.limit_rect = rect
	camera2d.position.x = size.x/2

func _draw() -> void:
	
#	var rect = Rect2(Vector2(), size)
	
#	draw_rect(rect, Color.white, false, 2)
	pass
