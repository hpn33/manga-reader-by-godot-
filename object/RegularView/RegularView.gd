extends Node2D

onready var camera = $'../Camera2D'

var active := false


func _ready() -> void:
	yield(owner, "ready")
	active = config.get_data('regular_view', false)
	
	
	pass


func _process(delta: float) -> void:
	update()

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed('regular'):
		active = !active
		config.set_data('regular_view', active)
		config.save()


func _draw() -> void:
	
	if not active:
		return
	
	var zoom = camera.zoom.x
	
	
	var step = 10
	var bold_step = step * 10
	var main_step = bold_step * 10
	
	var norm_c = Color('#30ffffff')
	var bold_c = Color('#50ffffff')
	var main_c = Color('#8fffffff')
	
	var power = (zoom * (zoom * 2))
	
	norm_c.a = norm_c.a / power
	bold_c.a = bold_c.a / power
	main_c.a = main_c.a / power
	
	
	norm_c.a = min(norm_c.a, 0.18)
	if norm_c.a < 0.05:
		norm_c.a = 0
	
	bold_c.a = min(bold_c.a, 0.31)
	if bold_c.a < 0.05:
		bold_c.a = 0
	
	main_c.a = min(main_c.a, 0.56)
	if main_c.a < 0.05:
		main_c.a = 0
	
	var norm_w = 0.01 / zoom
	var bold_w = 0.1 / zoom
	var main_w = 0.7 / zoom
	
	
	var vr = get_viewport_rect()
	var size = vr.size * zoom
	var pos = camera.position
	
	
	var xh = (vr.size.x/2) * zoom
	var xa = pos.x - xh
	var xb = pos.x + xh
	
	var yh = (vr.size.y/2) * zoom
	var ya = pos.y - yh
	var yb = pos.y + yh	
	
	if norm_c.a != 0:
		draw_x(xa, xb , pos, size, step, norm_c, norm_w)
		draw_y(ya, yb , pos, size, step, norm_c, norm_w)
	
	if bold_c.a != 0:
		draw_x(xa, xb , pos, size, bold_step, bold_c, bold_w)
		draw_y(ya, yb , pos, size, bold_step, bold_c, bold_w)
	
	if main_c.a != 0:
		draw_x(xa, xb , pos, size, main_step, main_c, main_w)
		draw_y(ya, yb , pos, size, main_step, main_c, main_w)


func draw_x(a, b, pos, size, step , color, width):
	
	for x in range(a, b):
		if x % step == 0:
			draw_line(Vector2(x, pos.y - size.y/2),  Vector2(x, pos.y + size.y/2), color, width)


func draw_y(a, b, pos, size, step , color, width):
	
	for y in range(a, b):
		if y % step == 0:
			draw_line(Vector2(pos.x - size.x/2, y),  Vector2(pos.x + size.x/2, y), color, width)
