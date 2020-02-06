extends Sprite


var thread = null

var file_path := ''
var adapter

signal update

#var pos := Vector2() setget , get_pos
var size := Vector2()
var margin := Vector2()


func get_off():
	return offset - Vector2(0, size.y/2)

func get_pos():
	return position + get_off()


func _ready() -> void:
	set_center_offset()


func init(_adapter, _file_path: String):
	adapter = _adapter
	file_path = _file_path


func loading():
	
	_load_image(file_path)


func _load_image(path):
	
	thread = Thread.new()
	thread.start( self, "_thread_load", path)


func _thread_load(path):
	
	var image = Image.new()
	image.load(path)
	var res = ImageTexture.new()
	
	res.create_from_image(image)
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows
	thread.wait_to_finish()
	
	texture = resource
	set_size()
	set_center_offset()
	
#	adapter.sort_children()
	adapter.set_size()




func set_margin(x, y):
	margin.x = x
	margin.y = y
	set_size()


func set_size():
	size = texture.get_size() + margin
	emit_signal("update")


func set_center_offset():
	if texture.get_size().y != 0:
		offset.y = texture.get_size().y / 2.0


func _draw() -> void:
#	var size = Vector2(texture.get_width(), texture.get_height())
#	print(offset)
	var pos = Vector2(-texture.get_size().x/2, 0)
	var tex := Rect2(pos, texture.get_size())
	
	draw_rect(tex, Color.green, false)
	
	
	pos = tex.position - (margin/2)
	var siz :Vector2= tex.size + margin
	
	var box := Rect2()
	
	box.position = pos
	box.size = siz
	
	draw_rect(box, Color.red, false)
	
	# 0, 0
	draw_circle(Vector2(), 5, Color.green)
	# offset
	draw_circle(offset, 5, Color.yellow)
	# offset - size.y/2
	draw_circle(get_off(), 5, Color.red)
	
	





