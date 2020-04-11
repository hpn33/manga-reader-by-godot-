tool
extends Node2D

onready var camera = $Camera2D
onready var viewer = $Viewer setget , get_viewer
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
	
	self.viewer.render(image_list)



onready var scroll = $CanvasLayer/scroll
onready var navigate = $CanvasLayer/Navigate


func refresh():
#	scroll.init()
	
	navigate.init()

func perhundred() -> float:
	return self.viewer.perhundred()



func goto_index(index):
	
	var count = viewer.get_child_count()
	
	if not count > 0:
		print('no image set')
		return
	
	if index <= 0 or index > count:
		print('index [', index ,'] out of range [0 : ',count, ']')
		return
	
	print('index ', index, ' ', count)
	
	camera.goto(self.viewer.child_position(index))
	
