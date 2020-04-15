extends VBoxContainer


onready var index_label = $"Current"
onready var all_index_label = $"All"


export var index := 0 setget set_index
func set_index(_index):
	index = _index
	
	owner.index = index

var count := 0


func reset():
	self.index = 0
	count = owner.get_image_count()
	all_index_label.text = str(count)
	
	refresh(false)


func _on_First_pressed():
	
	if count == 0:
		self.index = 0
		return
	
	self.index = 0
	
	refresh()


func _on_Prev_pressed():
	
	if count == 0:
		self.index = 0
		return
	
	self.index = clamp(index - 1, 0, count-1)
	
	refresh()


func _on_Next_pressed():
	
	if count == 0:
		self.index = 0
		return
	
	self.index = clamp(index + 1, 0, count-1)
	
	refresh()


func _on_End_pressed():
	
	if count == 0:
		self.index = 0
		return
	
	self.index = count-1
	
	refresh()



func refresh(can_go = true):
	index_label.text = str(index + 1)
	
	if can_go:
		owner.notify(self)


func set_current_index(_index):
	
	if _index == -1:
		return
	
	self.index = _index
	
	refresh(false)



func notify(last):
	
	if last.name == name:
		return
	
	set_current_index(owner.get_index())
