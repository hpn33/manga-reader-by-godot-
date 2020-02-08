extends Sprite


var thread = null

var file_path := ''
var adapter

signal update

var size := Vector2()
var margin := Vector2()


func _ready() -> void:
	set_size()


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
	
#	adapter.set_size()




func set_margin(x, y):
	margin.x = x
	margin.y = y
	set_size()


func set_size():
	size = texture.get_size() + margin
	fix_offset()
	emit_signal("update")


func fix_offset():
	if size.y != 0:
		offset.y = size.y / 2.0


func _draw() -> void:
	
	# draw texture box
	var pos := Vector2(-texture.get_size().x /2 , margin.y/2)
	var box := Rect2(pos, texture.get_size())
	draw_rect(box, Color.green, false)
	
	# draw full box
	pos = Vector2(-size.x/2, 0)
	box = Rect2(pos, size)
	draw_rect(box, Color.red, false)
	
	# final position
	draw_circle(Vector2(), 5, Color.red)
	
	# without offset ( center of box )
	draw_circle(offset, 5, Color.yellow)
	
	# just texture size ( on lap of texture )
	draw_circle(Vector2(0, margin.y/2), 5, Color.green)
	
	





