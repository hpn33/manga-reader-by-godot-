extends Sprite


func fix_by_camera(camera):
	position = camera.position
	scale = get_viewport_rect().size * camera.zoom

