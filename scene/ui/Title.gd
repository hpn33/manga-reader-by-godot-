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


func _set_recent_path():
	for path in config.get_data('recents'):
		get_popup().add_item(path)
	
