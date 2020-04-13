tool
extends Node2D

onready var viewer = $Viewer setget , get_viewer

onready var Camera2D = $Camera2D
onready var scroll_bar = $CanvasLayer/scroll_bar
onready var Navigate = $CanvasLayer/Navigate



func get_viewer():
	if viewer == null:
		viewer = get_child(0)
	
	return viewer



var limit_rect := Rect2() setget , get_limit_rect
func get_limit_rect() -> Rect2:
	return self.viewer.out_rect()





var image_list := []


func _ready():
	manager.connect("showing", self, 'show')
	


func show():
	image_list = manager.show_list()
	
	self.viewer.render(image_list)



func reset():
	Navigate.reset()




func perhundred() -> float:
	return self.viewer.perhundred()



func goto_index(_index):
	
	var count = viewer.get_child_count()
	
	if not count > 0:
		print('no image set')
		return
	
	if _index <= 0 or _index > count:
		print('index [', _index ,'] out of range [0 : ',count, ']')
		return
	
	print('index ', _index, ' ', count)
	
	Camera2D.goto(self.viewer.child_position(_index))





var index := 0
func get_index() -> int:
	return viewer.find_child_index(get_camera_position())


var camera_position := 0.0 setget , get_camera_position
func get_camera_position() -> float:
	return Camera2D.position.y

func get_index_position() -> float:
	return viewer.child_position(index)


func get_scroll_by_camera():
	return Camera2D.get_scroll_by_position(get_index_position())

var scroll := 0.0
func get_scroll(target) -> float:
	
	if target.name == 'Camera2D':
		return scroll_bar.get_scroll()
	
	elif target.name == 'scroll_bar':
		return Camera2D.get_scroll()
	
	return 0.0

func get_image_count() -> int:
	return viewer.get_child_count()




func notify(last):
	get_tree().call_group('navigate', 'notify', last)
