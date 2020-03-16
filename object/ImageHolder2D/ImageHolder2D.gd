extends Sprite


var can_debug := false

onready var loader = $loader
onready var label = $Label

var file_info : FileInfo
var adapter


var size := Vector2()
var margin := Vector2()


func _ready() -> void:
	set_size()
	set_label(file_info.full_path())


func init(_adapter, _file_info: FileInfo):
	adapter = _adapter
	file_info = _file_info
	can_debug = adapter.can_debug



func loading():
	loader.load_image(file_info.full_path())


func set_margin(x, y):
	margin.x = x
	margin.y = y
	set_size()


func set_size():
	size = texture.get_size() + margin
	fix_offset()


func fix_offset():
	if size.y != 0:
		offset.y = size.y / 2.0


func set_label(text):
	label.text = text


func set_label_pos():
	
	var y = texture.get_size().y
	var x = texture.get_size().x/2
	
	var offy = label.rect_size.y
	
	label.rect_position = Vector2(x, y-offy)


func _draw() -> void:
	
	if not can_debug:
		return
	
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
	
	








func _on_ImageHolder2D_texture_changed() -> void:
	set_size()

