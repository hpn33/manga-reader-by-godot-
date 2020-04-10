tool
extends Node2D

onready var camera = $Camera2D
onready var viewer = $VBox2D setget , get_viewer
func get_viewer():
	if viewer == null:
		viewer = get_child(0)
	
	return viewer



var limit_rect := Rect2() setget , get_limit_rect
func get_limit_rect() -> Rect2:
	return self.viewer.main_rect()





var image_list := []


func _ready():
	manager.connect("showing", self, 'show')


func show():
	image_list = manager.show_list()
	
	viewer.render(image_list)



func perhundred() -> float:
	return self.viewer.size.y / 100.0



func goto_index(index):
	
	var count = viewer.get_child_count()
	
	if not count > 0:
		print('no image set')
		return
	
	
	if index <= 0 or index > count:
		print('index [', index ,'] out of range [0 : ',count, ']')
		return
	
	print('index ', index, ' ', count)
	
	return
	
	position.y = viewer.child_height(index) + camera.off_height()
	
	camera.snap_to_limits()
	
