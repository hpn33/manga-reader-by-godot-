tool
extends Node2D
class_name ImageHolder2D


export var can_debug := false

onready var loader = $loader
onready var label = $Label


onready var sprite_box : SpriteBox = $SpriteBox setget , get_sprite_box
func get_sprite_box() -> SpriteBox:
	if sprite_box == null:
		sprite_box = get_child(0)
	
	return sprite_box


#onready var sprite :Sprite= $SpriteBox/Sprite setget , get_sprite
#func get_sprite() -> Sprite:
#	if sprite == null:
#		sprite = get_child(0).get_child(0)
#
#	return sprite

var file_info : FileInfo
var adapter


func _ready() -> void:
#	set_size()
	set_label(file_info.full_path())
#	size = self.sprite.texture.get_size()
	set_offset_half_top()
	
	


func init(_adapter, _file_info: FileInfo):
	adapter = _adapter
	file_info = _file_info
	can_debug = adapter.can_debug



func loading():
	loader.load_image(file_info.full_path())


func loaded(texture):
	
	
	var prev_size = height()
	
	set_texture(texture)
	
	var diff = height() - prev_size
	set_offset_half_top()

	
	# set label position
	
	label.rect_position = Vector2(width() / 2, height() - label.rect_size.y)
	
	
	adapter.sort_from(get_position_in_parent(), diff)


func set_margin(_margin: Vector2):
	$SpriteBox.set_margin(_margin)


#func set_size():
#	size = get_sprite().texture.get_size() + margin
#	fix_offset()


#func fix_offset():
#	if size.y != 0:
#		get_sprite().offset.y = size.y / 2.0


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


func height():
#	return self.sprite.texture.get_size().y
	return self.sprite_box.height()


func width():
#	return self.sprite.texture.get_size().x
	return self.sprite_box.width()


func set_offset_half_top():
	self.sprite_box.offset.y = height()/2


#func _on_ImageHolder2D_texture_changed() -> void:
#	set_size()

func set_texture(texture):
	sprite_box.set_texture(texture)
