extends Sprite

var scalle := Vector2(1100, 800)

func setting(camera):
	position = camera.position
	scale = scalle * camera.zoom
