tool
extends Node2D

enum Align { LEFT, CENTER, RIGHT }

export(Vector2) var size := Vector2.ONE * 100 setget set_size
export(Align) var align = Align.CENTER setget set_align

onready var box := $Box


#func _ready() -> void:
#	print('root')
	
	set_align(Align.CENTER)

func set_align(_align):
	align = _align
	
	if align == Align.CENTER:
		var center_pos = size /2.0
		var center_with_offset = center_pos - (box.size / 2.0)
		
		box.position = center_with_offset

func set_size(_size):
	size = _size
	update()

func _draw() -> void:
	var rect = Rect2(Vector2(), size)
	
	draw_rect(rect, Color.green, false)

