extends Node2D
class_name ImageView


onready var fsm = $state

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"

export(int) var seperation = 10


var index := 0
var image_list := []
var image_textures := []


var size := Vector2()


func start(_image_list):
	image_list = _image_list
	
	fsm.transition_to('load')


func set_box(w, h):
	
	size = Vector2(w, h)
	var rect = Rect2(position, size)
	
	camera2d.limit_rect = rect
	camera2d.position.x = size.x/2



#func _process(delta: float) -> void:
#	update()
#
#
#func _draw() -> void:
#
#	var rect = Rect2(Vector2(), size)
#
#	draw_rect(rect, Color.white, false, 2)
#	pass

