tool
extends Node2D
class_name Box2D


export var can_debug := false


export(Vector2) var size := Vector2() setget set_size
func set_size(_size):
	size = _size
	
	repivot()



export(Vector2) var margin := Vector2() setget set_margin
func set_margin(_margin: Vector2):
	margin = _margin
	
	repivot()



export(Vector2) var padding := Vector2()



export(Vector2) var offset := Vector2() setget set_offset
func set_offset(_offset):
	offset = _offset
	
	for child in get_children():
		child.position = offset


export(Vector2) var pivot := Vector2()




enum VERTICAL_PIVOT_ALIGN { UP, CENTER, DOWN }
export(VERTICAL_PIVOT_ALIGN) var vertical_pivot_align := VERTICAL_PIVOT_ALIGN.UP setget set_vertical_pivot_align
func set_vertical_pivot_align(_vertical_pivot_align):
	vertical_pivot_align = _vertical_pivot_align
	
	set_vertical_pivot()


func set_vertical_pivot():
	
	if vertical_pivot_align == VERTICAL_PIVOT_ALIGN.UP:
		pivot.y = 0
	
	elif vertical_pivot_align == VERTICAL_PIVOT_ALIGN.CENTER:
		pivot.y = -main_rect().size.y / 2
	
	elif vertical_pivot_align == VERTICAL_PIVOT_ALIGN.DOWN:
		pivot.y = -main_rect().size.y



enum HORIZENTAL_PIVOT_ALIGN { LEFT, CENTER, RIGHT }
export(HORIZENTAL_PIVOT_ALIGN) var horizental_pivot_align := HORIZENTAL_PIVOT_ALIGN.LEFT setget set_horizental_pivot_align
func set_horizental_pivot_align(_horizental_pivot_align):
	horizental_pivot_align = _horizental_pivot_align
	
	set_horizental_pivot()


func set_horizental_pivot():
	
	if horizental_pivot_align == HORIZENTAL_PIVOT_ALIGN.LEFT:
		pivot.x = 0
	
	elif horizental_pivot_align == HORIZENTAL_PIVOT_ALIGN.CENTER:
		pivot.x = -main_rect().size.x / 2
	
	elif horizental_pivot_align == HORIZENTAL_PIVOT_ALIGN.RIGHT:
		pivot.x = -main_rect().size.x



# reset horizental & vertical pivot
func repivot():
	set_horizental_pivot()
	set_vertical_pivot()




func main_rect() -> Rect2:
	return Rect2(pivot+offset, size)

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



func width() -> float:
	return out_rect().size.x


func height() -> float:
	return out_rect().size.y


 




func _process(delta: float) -> void:
	update()


func _draw() -> void:

	if not can_debug:
		return

	# pivot point
	draw_circle(Vector2.ZERO, 5, Color.plum)


	# out board
	draw_rect(out_rect(), Color.red, false, 1)

	# in board
	draw_rect(in_rect(), Color.orange, false, 1)
	
	# main board
	draw_rect(main_rect(), Color.green, false, 1)
