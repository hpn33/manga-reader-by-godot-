extends Control



onready var select = $select

var active := false


func _ready():
	
	select.rect_size.y = perhundred()




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


func reset():
	set_scroll(0)








func perhundred():
	return (rect_size.y - select.rect_size.y) /100.0








var scroll := 0.0


func set_scroll(_height):
	select.rect_position.y = clamp(_height, 0, rect_size.y-select.rect_size.y)
	
	if select.rect_position.y == 0:
		scroll = 0.0
	
	elif select.rect_position.y != 0:
		scroll = select.rect_position.y / perhundred()


func notify(last):
	
	if last.name == 'NavBar':
		set_scroll(perhundred() * owner.get_scroll_by_camera())
	elif last.name == 'Camera2D':
		set_scroll(perhundred() * owner.get_scroll(self))

