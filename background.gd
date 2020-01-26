extends Sprite

var scalle := 20

func setting(camera):
	position = camera.position
	scale = scalle * camera.zoom
