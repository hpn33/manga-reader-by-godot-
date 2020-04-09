tool
extends Node2D
class_name SpriteBox


onready var box :Box2D = $Box2D
func get_box() -> Box2D:
	if box == null:
		box = get_child(0)
	
	return box

onready var sprite :Sprite= $Box2D/Sprite setget , get_sprite
func get_sprite() -> Sprite:
	if sprite == null:
		sprite = get_box().get_child(0)
	
	return sprite



export(bool) var centered := false setget set_centered
func set_centered(_centered):
	centered = _centered
	
	if centered:
		get_box().set_horizental_pivot_align(get_box().HORIZENTAL_PIVOT_ALIGN.CENTER)
		get_box().set_vertical_pivot_align(get_box().VERTICAL_PIVOT_ALIGN.CENTER)
	
	else:
		get_box().set_horizental_pivot_align(get_box().HORIZENTAL_PIVOT_ALIGN.LEFT)
		get_box().set_vertical_pivot_align(get_box().VERTICAL_PIVOT_ALIGN.UP)
	
	get_sprite().centered = centered



func _on_Sprite_texture_changed():
	get_box().size = get_sprite().texture.get_size()

