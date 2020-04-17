extends VBoxContainer


onready var index_label = $"Current"
onready var count_label = $"All"


var index := -1
var count := 0


func reset():
	count = owner.get_image_count()
	count_label.text = str(count)
	
	index = -1 if count == 0 else 0
	
	refresh(false)


func _on_First_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = 0
	
	refresh()


func _on_Prev_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = clamp(index - 1, 0, count-1)
	
	refresh()


func _on_Next_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = clamp(index + 1, 0, count-1)
	
	refresh()


func _on_End_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = count-1
	
	refresh()



func refresh(can_go = true):
	index_label.text = str(clamp(index, -1, count - 1) + 1)
	
	if can_go:
		owner.notify(self)


func set_current_index(_index):
	
	if _index == -1:
		return
	
	index = _index
	
	refresh(false)



func notify(last):
	
	if last.name == name:
		return
	
	set_current_index(owner.get_fouce_index(self))
