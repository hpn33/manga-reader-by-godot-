extends MarginContainer
class_name ColorList


onready var color_holder = preload("res://object/ColorPicker/ColorHolder/ColorHolder.tscn")

onready var list := $vBox


func _ready() -> void:
	
	clear()
	
	add_by_array(owner.colors)


func clear():
	for i in list.get_child_count():
		list.remove_child(list.get_child(0))


func add(color):
	var new :Button= color_holder.instance()
	
	list.add_child(new)
	
	new.set_(color)
	new.connect("pressed", self, '_holder_pressed', [new, color])


func add_by_array(colors: Array):
	for color in colors:
		add(color)


func up_item(title, color_code):
	for i in list.get_child_count():
		var child = list.get_child(i)
		if title == child.title:
			child.set_color(color_code)
			break


func _holder_pressed(holder, color):
	owner.set_color(color)

