extends VBoxContainer


#onready var image_place = $"../../ImagePlace"
#onready var camera = $"../../Camera2D"

onready var index_label = $"Current"
onready var all_index_label = $"All"


var index := 0
var count := 0


func _ready():
	share.add_hook('current_index', self, 'set_current_index')
	
#	navigate.connect("changed", self, 'navigate_changed')
#	navigate.connect("refresh", self, 'navigate_refreshed')
	
#	share.add_hook('image_list', self, 'image_list_changed')
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
	
	if count == 0:
		return
	
	index = 1
	
	refresh()


func _on_Prev_pressed():
	
	if count == 0:
		return
	
	index = clamp(index - 1, 1, count)
	
	refresh()


func _on_Next_pressed():
	
	if count == 0:
		return
	
	index = clamp(index + 1, 1, count)
	
	refresh()


func _on_End_pressed():
	
	if count == 0:
		return
	
	index = count
	
	refresh()



func refresh(can_go:= true):
	index_label.text = str(index)
	
#	owner.point_change(self)
	
	if can_go:
		owner.goto_index(index)


func set_current_index(_index):
	
	if _index == 0:
		return
	
	index = _index + 1
	
	refresh(false)


