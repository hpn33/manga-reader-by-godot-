extends VBoxContainer


onready var index_label = $Current
onready var count_label = $All

onready var first_btn = $First
onready var ten_prv_btn = $TenPrv
onready var prv_btn = $Prv

onready var end_btn = $End
onready var ten_next_btn = $TenNext
onready var next_btn = $Next


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


func _on_TenPrv_pressed():
	if count == 0:
		index = -1
		return
	
	index = int(clamp(index - 10, 0, count-1))
	
	refresh()


func _on_Prev_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = int(clamp(index - 1, 0, count-1))
	
	refresh()


func _on_Next_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = int(clamp(index + 1, 0, count-1))
	
	refresh()


func _on_TenNext_pressed():
	if count == 0:
		index = -1
		return
	
	index = int(clamp(index + 10, 0, count-1))
	
	refresh()


func _on_End_pressed():
	
	if count == 0:
		index = -1
		return
	
	index = count-1
	
	refresh()


func refresh(can_go = true):
	index_label.text = str(clamp(index, -1, count - 1) + 1)
	
	check_buttons()
	
	if can_go:
		owner.notify(self)


func check_buttons():
	
	disable_buttons(index == -1)
	
	if index == -1:
		return
	
	first_btn.disabled = (index == 0)
	prv_btn.disabled = (index == 0)
	
	ten_prv_btn.disabled = not (index-10 >= 0)
	ten_next_btn.disabled = not (index+10 <= count-1)
	
	next_btn.disabled = (index == count-1)
	end_btn.disabled = (index == count-1)
	
	
	


func set_current_index(_index):
	
	if _index == -1:
		return
	
	index = _index
	
	refresh(false)


func disable_buttons(disable: bool) -> void:
	for child in get_children():
		if not child is Button:
			continue
		
		child.disabled = disable
		


func notify(last):
	
	if last.name == name:
		return
	
	set_current_index(owner.get_focus_index())

