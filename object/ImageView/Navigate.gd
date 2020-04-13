extends VBoxContainer


onready var index_label = $"Current"
onready var all_index_label = $"All"


var index := 0
var count := 0


func reset():
	index = 1
	count = owner.get_image_count()
	all_index_label.text = str(count)
	
	refresh(false)


func _on_First_pressed():
	
	if count == 0:
		index = 0
		return
	
	index = 1
	
	refresh()


func _on_Prev_pressed():
	
	if count == 0:
		index = 0
		return
	
	index = clamp(index - 1, 1, count)
	
	refresh()


func _on_Next_pressed():
	
	if count == 0:
		index = 0
		return
	
	index = clamp(index + 1, 1, count)
	
	refresh()


func _on_End_pressed():
	
	if count == 0:
		index = 0
		return
	
	index = count
	
	refresh()



func refresh(can_go = true):
	index_label.text = str(index)
	
	owner.index = index - 1
	
	if can_go:
		owner.notify(self)


func set_current_index(_index):
	
	if _index == -1:
		return
	
	index = _index + 1
	
	refresh(false)



func notify(last):
	
	if last.name == name:
		return
	
	set_current_index(owner.get_index())
