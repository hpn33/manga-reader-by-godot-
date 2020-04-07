extends Control

onready var holder = $MarginContainer/VBoxContainer

var info := {
	keys = [],
	values = []
}

func _ready() -> void:
#	data.connect("data_changed", self, '_data_changed')
	check_visiblity()


func add_info(key, text: String):
	var label = Label.new()
	label.rect_min_size.x = 210
	label.autowrap = true
	label.text = key + ': ' + text
	
	info.keys.append(key)
	info.values.append(label)
	
	holder.add_child(label)
	
	check_visiblity()


func clear(key):
	
	var index = info.keys.find(key)
	var target_node = info.values[index]
	
	holder.remove_child(target_node)
	
	info.keys.remove(index)
	info.values.remove(index)
	
	check_visiblity()


func clear_all():
	
	for label in info.values:
		holder.remove_child(label)
	
	info.keys.clear()
	info.values.clear()
	
	check_visiblity()


func check_visiblity():
	
	if visible:
		if info.keys.size() == 0:
			visible = false
	else:
		if info.keys.size() > 0:
			visible = true


#func _data_changed(_data):
#	clear_all()
#	add_info('path', data.path)
#	add_info('pages', str(data.page_count))

