extends Sprite

signal update(index)

var thread = null

var file_path := ''
var adapter


var size := Vector2()
var margin := Vector2()


func pos_wo_offset():
	# position without offset
	return offset

func pos_wo_offset_w_size():
	# position without offset & with size
	return pos_wo_offset() - Vector2(0, size.y/2)


func set_pos_w(x = position.x, y = position.y):
	# set position with anything that need
	position.x = x
	position.y = y
	


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
	emit_signal("update", get_position_in_parent())


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
	draw_circle(pos_wo_offset(), 5, Color.yellow)
	# offset - size.y/2
	draw_circle(pos_wo_offset_w_size(), 5, Color.red)
#	draw_circle(get_pos(), 5, Color.red)
	
	








func _on_ImageHolder2D_texture_changed() -> void:
	set_size()
