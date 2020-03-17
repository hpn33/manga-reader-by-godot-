extends MenuButton

onready var tween = $Tween


func _ready() -> void:
	get_popup().connect('id_pressed', self, '_id_pressed')
	
	share.add_hook('recents', self, '_recent_changed')
	
	set_title('choise image path')


func set_title(title: String):
	text = title
	show()


func _id_pressed(id: int):
	var path = get_popup().get_item_text(id)
	
	manager.open(path)
	
	_recent_changed(share.get_value('recents')) 


func _recent_changed(recents: Array):
	get_popup().clear()
	for path in recents:
		if text != path:
			get_popup().add_item(path)


func show():
	tween.interpolate_property(self,
	 'rect_position:y',
	 20, 3,
	 0.3,
	 Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	tween.interpolate_property(self,
	 'modulate',
	 Color('#00ffffff'), Color('#ffffff'),
	 0.3,
	 Tween.TRANS_QUAD, Tween.EASE_IN)
	
	tween.start()

