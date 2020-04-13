extends Control


var active = false


onready var select = $select


func _ready():
	
	share.add_hook('navigate', self, 'set_navigate')
	
	select.rect_size.y = perhundred()




func position_perhundred():
	return get_local_mouse_position().y / perhundred()


func perhundred():
	return (rect_size.y - select.rect_size.y) /100.0


var mouse_capture = false

func _input(event):
	
	if event.is_action_pressed("view_click_mouse"):
		mouse_capture = true
		
	elif event.is_action_released("view_click_mouse"):
		mouse_capture = false

func _process(delta):
	
	if not active:
		return
	
	if mouse_capture:
		set_scroll(get_local_mouse_position().y)
		
		
		get_tree().set_input_as_handled()
		owner.notify(self)


func _on_scroll_mouse_entered():
	active = true

func _on_scroll_mouse_exited():
	active = false



func set_scroll(_height):
	select.rect_position.y = _height



func get_scroll() -> float:
	
	var scroll := 0.0
	
	if select.rect_position.y != 0: 
		scroll = select.rect_position.y / perhundred()
	
	return scroll


func notify(last):
	
	if last.name == 'Navigate':
		set_scroll(perhundred() * owner.get_scroll_by_camera())
	elif last.name == 'Camera2D':
		set_scroll(perhundred() * owner.get_scroll(self))

