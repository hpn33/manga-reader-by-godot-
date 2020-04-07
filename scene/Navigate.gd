extends VBoxContainer


#onready var image_place = $"../../ImagePlace"
onready var camera = $"../../Camera2D"

onready var index_label = $"Current"
onready var all_index_label = $"All"


var index = 0
var count = 0


func _ready():
	share.add_hook('image_list', self, 'image_list_changed')


func image_list_changed(list: Array):
	index = 1
	count = list.size()
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
	camera.goto_index(index)
