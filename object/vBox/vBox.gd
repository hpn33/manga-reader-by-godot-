extends Node2D
class_name vBox

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"

export(int) var seperation = 10

var index := 0
var path := ''
var image_names := []
var image_textures := []

var load_thread :Thread 

var size := Vector2()


func _process(delta: float) -> void:
	update()


func add_images(_path, _image_names):
	
	# clear
	for child in get_children():
		remove_child(child)
	
	path = _path
	image_names = _image_names
	
	if image_names.size() == 0:
		print('no image')
		return
	
	for i in image_names.size():
		var image_path = path + '/' + image_names[i]
		image_names[i] = image_path
	
	
	_load_images()


func _load_images():
	load_thread = Thread.new()
	load_thread.start( self, "_thread_load_image", image_names)


func _thread_load_image(paths):
	
	for _path in paths:
		print(_path)
		
		var image = Image.new()
		image.load(_path)
		var res = ImageTexture.new()
		res.create_from_image(image)
		image_textures.append(res)
		
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done")


func _thread_done():
	# Always wait for threads to finish, this is required on Windows
	load_thread.wait_to_finish()
	print('done')


func add_image():
	
	var new = image_holder.instance()
	new.connect("done", self, 'advance')
	
	add_child(new)
	
	new.loading(path + '/' + image_names[index])
	last_sort()


func advance():
	sort()
	
	var child = get_child(index)
	if child.is_connected("done", self, 'advance'):
		child.disconnect("done", self, 'advance')
	
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

		sum += last.texture.get_height() + seperation
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
		
		sum += child.texture.get_height() + seperation
	
	
	size = Vector2(max_width, sum)
	var rect = Rect2(position, size)
	camera2d.limit_rect = rect
	camera2d.position.x = size.x/2


func _draw() -> void:
	
#	var rect = Rect2(Vector2(), size)
	
#	draw_rect(rect, Color.white, false, 2)
	pass

