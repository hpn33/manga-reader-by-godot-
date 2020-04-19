tool
extends Node2D

onready var camera = $Camera2D
onready var scroll_bar = $CanvasLayer/ScrollBar
onready var nav_bar = $CanvasLayer/NavBar


var image_list := []




func _ready():
	manager.connect("showing", self, 'show')
	
	reset()


func show():
	image_list = manager.show_list()
	
	viewer.render(image_list)



func reset():
	nav_bar.reset()
	camera.reset()
	scroll_bar.reset()

func clear():
	viewer.reset()
	reset()

onready var viewer = $Viewer



var limit_rect := Rect2() setget , get_limit_rect
func get_limit_rect() -> Rect2:
	return viewer.out_rect()


func get_fouce_index(target) -> int:
	return viewer.find_child_index(camera.position.y)


func get_scroll(target) -> float:
	
	var scroll := 0.0
	
	if target.name == 'Camera2D':
		scroll = scroll_bar.scroll
	
	elif target.name == 'ScrollBar':
		scroll = camera.scroll
	
	return scroll


func perhundred() -> float:
	return viewer.perhundred()


func get_index_position() -> float:
	return viewer.child_position(nav_bar.index)


func get_focus_image():
	if nav_bar.index == -1:
		return
	
	return viewer.get_child(nav_bar.index)


func get_last_image():
	if viewer.get_child_count() == 0:
		return
	
	return viewer.last()


func get_scroll_by_camera() -> float:
	return camera.get_scroll_by_height(get_index_position())


func get_image_count() -> int:
	return viewer.get_child_count()


func image_on_the_range():
	
	var height = camera.viewport(false).y
	var pos = camera.position.y
	
	return viewer.child_in_range(pos - height, pos + height)

func notify(last) -> void:
	
	if last.name == 'Camera2D':
		viewer.refresh()
	
	get_tree().call_group('navigate', 'notify', last)
