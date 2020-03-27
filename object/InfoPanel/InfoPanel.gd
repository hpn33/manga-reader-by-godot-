extends PopupPanel


onready var path_label := $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/Path

onready var file_check := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/FileCheck
onready var vbox_local_file := $VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/ScrollContainer/LocalFile
onready var count_label := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Count


onready var sort_check := $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/SortCheck
onready var vbox_sort_list := $VBoxContainer/HBoxContainer/VBoxContainer2/MarginContainer/ScrollContainer/SortList
onready var visible_label := $VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer/VisibleCount

"""

* auto save button

# buttons
- button for saving sort_list
- button (use) for acting change on image viewer
- option (single check_box) for choise one of list (files or sort_list)
for using on imageViewer


# sort list
- sorting by drag and drop
- option for change visiblity of files in sort list


# repire
- if file was change just detect what change as possible
and make option for repire that

"""


var button_group = ButtonGroup.new()


func _ready():
	
	share.add_hook('image_list', self, 'refresh')
	
	sort_check.group = button_group
	file_check.group = button_group
	
	for button in button_group.get_buttons():
		button.connect('pressed', self, '_button_pressed')




func refresh(list = []):
	
	# show_path_folder
	path_label.text = manager.path
	
	set_active_list_button()
	
	# file list
	vbox_local_file.refresh()
	count_label.text = str(manager.file_list().size())
	
	# sort list
	vbox_sort_list.refresh()
	show_count_sort()
	


func set_active_list_button():
	
	# set active list
	for button in button_group.get_buttons():
		if button.text == manager.active_list():
			button.pressed = true
			break


func show_count_sort():
	visible_label.refresh()


func _on_Save_pressed():
	manager.save('sort_list', vbox_sort_list.list)

func _on_Use_pressed():
	manager.show()

func _button_pressed():
	manager.set_active_list(button_group.get_pressed_button().text)




func _on_InfoPanel_about_to_show():
	refresh()


func _on_number_pressed():
	vbox_sort_list.sort_by_number()


