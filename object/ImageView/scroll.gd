extends Control


var active = false


onready var select = $select


func _ready():
	
	share.add_hook('scroll', self, 'set_scroll')
	
	select.rect_size.y = perhundred()


func init():
	pass




func position_perhundred():
	return get_local_mouse_position().y / perhundred()


func perhundred():
	return rect_size.y /100.0


func _process(delta):
	
	if not active:
		return
	
	if Input.is_action_pressed("view_click_mouse"):
		
		set_select_position(get_local_mouse_position().y)
		
		share.set_value('scroll', position_perhundred())


func _on_scroll_mouse_entered():
	active = true

func _on_scroll_mouse_exited():
	active = false


func set_scroll(scroll):
	set_select_position(perhundred() * scroll)


func set_select_position(_height):
	select.rect_position.y = _height
	





