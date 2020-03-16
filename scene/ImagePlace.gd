extends ImageView


func _ready() -> void:
	share.add_hook('image_list', self, 'start')
