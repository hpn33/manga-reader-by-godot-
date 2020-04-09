extends Control


var active = false


onready var select = $select


func _ready():
	
	navigate.connect("changed", self, 'navigate_changed')
	
	
	share.add_hook('scroll', self, 'set_scroll')
	
	select.rect_size.y = perhundred()


func navigate_changed():
	pass


func position_perhundred():
	return get_local_mouse_position().y / perhundred()


func perhundred():
	return rect_size.y /100.0


func _process(delta):
	
	if not active:
		return
	
	if Input.is_action_pressed("view_click_mouse"):
		
		select.rect_position.y = get_local_mouse_position().y
		
		share.set_value('scroll', position_perhundred())


func _on_scroll_mouse_entered():
	active = true

func _on_scroll_mouse_exited():
	active = false


func set_scroll(scroll):
	select.rect_position.y = perhundred() * scroll
