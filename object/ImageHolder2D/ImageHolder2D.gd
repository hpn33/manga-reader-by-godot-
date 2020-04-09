tool
extends Node2D
class_name ImageHolder2D


var can_debug := false

onready var loader = $loader
onready var label = $Label

onready var sprite :Sprite= $SpriteBox/Box2D/Sprite setget , get_sprite
func get_sprite():
	if sprite == null:
		sprite = get_child(0).get_child(0).get_child(0)
	
	return sprite

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


func loaded(diff):
	adapter.fix_pos_to_last(get_position_in_parent(), diff)
	
	# set label position
	var y = get_sprite().texture.get_size().y
	var x = get_sprite().texture.get_size().x/2
	
	var offy = label.rect_size.y
	
	label.rect_position = Vector2(x, y-offy)


func set_margin(x, y):
	margin.x = x
	margin.y = y
	set_size()


func set_size():
	size = get_sprite().texture.get_size() + margin
	fix_offset()


func fix_offset():
	if size.y != 0:
		get_sprite().offset.y = size.y / 2.0


func set_label(text):
	label.text = text

#
#func _draw() -> void:
#
#	if not can_debug:
#		return
#
#	# draw texture box
#	var pos := Vector2(-texture.get_size().x /2 , margin.y/2)
#	var box := Rect2(pos, texture.get_size())
#	draw_rect(box, Color.green, false)
#
#	# draw full box
#	pos = Vector2(-size.x/2, 0)
#	box = Rect2(pos, size)
#	draw_rect(box, Color.red, false)
#
#	# final position
#	draw_circle(Vector2(), 5, Color.red)
#
#	# without offset ( center of box )
#	draw_circle(offset, 5, Color.yellow)
#
#	# just texture size ( on lap of texture )
#	draw_circle(Vector2(0, margin.y/2), 5, Color.green)
#
#








func _on_ImageHolder2D_texture_changed() -> void:
	set_size()

