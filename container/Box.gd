tool
extends Node2D


export(Vector2) var size := Vector2.ONE * 10 setget set_size
var offset := Vector2()


func set_size(_size):
	size = _size
	update()

func _draw() -> void:
	var rect = Rect2(Vector2(), size)
	draw_rect(rect, Color.white, false)
