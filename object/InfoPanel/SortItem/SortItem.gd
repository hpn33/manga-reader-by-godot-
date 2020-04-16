extends HBoxContainer
class_name SortItem


onready var title = $Title
onready var check = $Check

var this := true
var id := 0


func init(_id, _title, visiable):
	
	id = _id
	
	title.text = _title
	check.pressed = visiable


func get_drag_data(position):

	var preview = Label.new()
	preview.text = title.text
	set_drag_preview(preview) # not necessary
	
	return get_index()


func can_drop_data(position, data):
	return typeof(data) == TYPE_INT


func drop_data(position, item): # end drag
	get_parent().move_item(item, get_index())


func _on_Check_pressed():
	get_parent().update_item(get_index(), check.pressed)


