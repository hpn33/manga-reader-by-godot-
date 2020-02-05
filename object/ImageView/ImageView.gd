extends Node2D
class_name ImageView


onready var fsm = $state

export(PackedScene) var image_holder = preload("res://object/ImageHolder2D/ImageHolder2D.tscn")

onready var camera2d = $"../Camera2D"

export(int) var seperation = 10 #setget set_sperat


var index := 0
var image_list := []
var image_textures := []


var size := Vector2()
var margin := Vector2(20, 10)


func start(_image_list):
	image_list = _image_list
	
	fsm.transition_to('load')


func set_box(w, h):
	
	size.x = max(w, size.x)
	size.y += h
	
	var rect = Rect2(position, size)
	
	share.set_value('camera_limit', rect)
#	camera2d.limit_rect = rect
#	camera2d.position.x = size.x/2


#func set_sperat(value: int) -> void:
#	seperation = value
#	if fsm and not fsm.state_is('sort'):
#		fsm.transition_to('sort')



func _process(delta: float) -> void:
	update()


func _draw() -> void:

	var rect = Rect2(Vector2(), size)

	draw_rect(rect, Color.white, false, 10)

