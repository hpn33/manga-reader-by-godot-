extends VBoxContainer
class_name ColorList


onready var color_holder = preload("res://object/ColorPicker/ColorHolder/ColorHolder.tscn")


func _ready() -> void:
	re_add()


func clear():
	for i in get_child_count():
		remove_child(get_child(0))


func add(color):
	var new :Button= color_holder.instance()
	
	add_child(new)
	
	new.set_(color)
	new.connect("pressed", self, '_holder_pressed', [color])
	new.connect("delete", self, '_delete_button', [color])


func add_by_array(colors: GMap):
	for color in colors.to_iterator():
		add(color)


func update_item(title, color_code):
	for i in get_child_count():
		var child = get_child(i)
		if title == child.title:
			child.set_color(color_code)
			break


func _holder_pressed(color):
	owner.active_color(color)


func _delete_button(color):
	owner.delete_color(color)


func re_add(colors :GMap= owner.colors):
	clear()
	add_by_array(colors)
