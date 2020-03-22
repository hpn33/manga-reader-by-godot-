extends PopupPanel


onready var path_label := $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/Path

onready var vbox_local_file := $VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/ScrollContainer/LocalFile
onready var count_label := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Count


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


func _ready():
	
	share.add_hook('local_files', self, 'refresh')





func refresh(files = manager.files()):
	
	show_path_folder()
	
	show_local_files(files)
	show_count_files(files.size())
	
	show_sort_list(manager.sort_list())
	show_count_sort()



func show_local_files(files):
	for child in vbox_local_file.get_children():
		vbox_local_file.remove_child(child)
	
	for file in files:
		var label = Label.new()
		label.text = file.title
		
		
		vbox_local_file.add_child(label)


func show_count_files(count):
	count_label.text = str(count)


func show_path_folder():
	path_label.text = manager.path


func show_sort_list(list):
	vbox_sort_list.refresh(list)


func show_count_sort():
	visible_label.text = str(visiable_count())


func visiable_count():
	var count := 0
	
	for item in manager.sort_list():
		if item.visiable:
			count += 1
	
	return count


func _on_Save_pressed():
	manager.save('sort', manager.sort_list())
