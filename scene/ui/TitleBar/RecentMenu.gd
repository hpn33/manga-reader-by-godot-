extends MenuButton

onready var anim = $AnimationPlayer


func _ready() -> void:
	get_popup().connect('id_pressed', self, '_id_pressed')
	
#	config.connect("init", self, '_set_recent_path')
	share.add_hook('recents', self, '_recent_changed')
	
	set_title('choise image path')


func set_title(title: String):
	text = title
	anim.play("show")


func _id_pressed(id: int):
	var item = get_popup().get_item_text(id)
#	data.path = item
	share.set_value('path', item)
	re_init()


#func _set_recent_path():
#	get_popup().clear()
#	for path in config.get_data('recents'):
#		if text != path:
#			get_popup().add_item(path)


func _recent_changed(recents: Array):
	get_popup().clear()
	for path in recents:
		if text != path:
			get_popup().add_item(path)


func re_init():
#	_set_recent_path()
	_recent_changed(share.get_value('recents'))

