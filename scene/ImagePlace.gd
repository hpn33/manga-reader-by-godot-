extends ImageView


func _ready() -> void:
	share.add_hook('image_list', self, 'start')

func perhundred():
	return size.y / 100
