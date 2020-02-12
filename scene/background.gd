extends Sprite


func _ready() -> void:
	share.add_hook('background_color', self, '_background_color_changed')


func fix_by_camera(camera):
	position = camera.position
	scale = get_viewport_rect().size * camera.zoom


func _background_color_changed(color_code):
	if color_code:
		modulate = Color('#' + color_code)
