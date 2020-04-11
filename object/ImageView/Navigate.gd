extends VBoxContainer


#onready var image_place = $"../../ImagePlace"
#onready var camera = $"../../Camera2D"

onready var index_label = $"Current"
onready var all_index_label = $"All"


var index := 0
var count := 0


func _ready():
	pass
#	navigate.connect("changed", self, 'navigate_changed')
#	navigate.connect("refresh", self, 'navigate_refreshed')
	
#	share.add_hook('image_list', self, 'image_list_changed')


#func navigate_refreshed():
#	index = 1
#	count = navigate.count
#
#	index_label.text = str(index)
#	all_index_label.text = str(count)
#
#
#func navigate_changed():
#	pass


#func image_list_changed(list: Array):
#	index = 1
#	count = list.size()
#	all_index_label.text = str(count)
#
#	refresh()

func init():
	index = 1
	count = owner.viewer.get_child_count()
	all_index_label.text = str(count)
	
	refresh()


func _on_First_pressed():
	index = 1
	
	refresh()


func _on_Prev_pressed():
	index = clamp(index - 1, 1, count)
	
	refresh()


func _on_Next_pressed():
	index = clamp(index + 1, 1, count)
	
	refresh()


func _on_End_pressed():
	index = count
	
	refresh()



func refresh():
	index_label.text = str(index)
	owner.goto_index(index)


func _on_LineEdit_text_changed(new_text):
	var i = int(new_text)
	
	if i > 0 and i <= count:
		index = i
	
	refresh()
