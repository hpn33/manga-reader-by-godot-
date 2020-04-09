tool
extends Node2D
class_name Box2D


export var can_debug := false

export(Vector2) var size := Vector2()

export(Vector2) var margin := Vector2()
export(Vector2) var padding := Vector2()

export(Vector2) var offset := Vector2()





func main_rect() -> Rect2:
	return Rect2(-offset, size)

func out_rect() -> Rect2:
	var rect = main_rect()
	
	rect.position -= margin/2
	rect.size += margin
	
	return rect

func in_rect() -> Rect2:
	var rect = main_rect()
	
	rect.position += padding/2
	rect.size -= padding
	
	return rect






func _process(delta: float) -> void:
	update()


func _draw() -> void:

	if not can_debug:
		return

	# pivot point
	draw_circle(Vector2.ZERO, 1.5, Color.plum)


	# main board
	draw_rect(main_rect(), Color.white, false, 1)

	# out board
	draw_rect(out_rect(), Color.white, false, 1)

	# in board
	draw_rect(in_rect(), Color.white, false, 1)
