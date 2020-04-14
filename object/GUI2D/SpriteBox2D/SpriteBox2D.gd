tool
extends Box2D
class_name SpriteBox


onready var sprite :Sprite= $Sprite setget , get_sprite
func get_sprite() -> Sprite:
	if sprite == null:
		sprite = get_child(0)
	
	return sprite



export(bool) var centered := true setget set_centered
func set_centered(_centered):
	centered = _centered
	
	if centered:
		set_horizental_pivot_align(HORIZENTAL_PIVOT_ALIGN.CENTER)
		set_vertical_pivot_align(VERTICAL_PIVOT_ALIGN.CENTER)
	
	else:
		set_horizental_pivot_align(HORIZENTAL_PIVOT_ALIGN.LEFT)
		set_vertical_pivot_align(VERTICAL_PIVOT_ALIGN.UP)
	
	get_sprite().centered = centered
	
	resize()


func set_texture(texture):
	get_sprite().texture = texture
	



func resize():
	set_size(get_sprite().texture.get_size())





func _on_Sprite_texture_changed():
	resize()
