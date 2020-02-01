extends MenuButton

onready var anim = $AnimationPlayer


func _ready() -> void:
	get_popup().connect('id_pressed', self, '_id_pressed')
	
	config.connect("init", self, '_set_recent_path')
	
	set_title('choise image path')


func set_title(title: String):
	text = title
	anim.play("show")


func _id_pressed(id: int):
	var item = get_popup().get_item_text(id)
	data.path = item
	re_init()


func _set_recent_path():
	get_popup().clear()
	for path in config.get_data('recents'):
		if text != path:
			get_popup().add_item(path)

func re_init():
	_set_recent_path()
