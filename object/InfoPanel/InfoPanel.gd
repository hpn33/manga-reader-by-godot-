extends PopupPanel


onready var vbox_local_file := $VBoxContainer/HBoxContainer/VBoxContainer/MarginContainer/ScrollContainer/LocalFile
onready var label_path := $VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/Path
onready var label_count := $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Count

func _ready():
	
	share.add_hook('local_files', self, 'refresh')





func refresh(files = manager.files()):
	
	
	show_local_files(files)
	show_count_files(files.size())
	show_path_folder()



func show_local_files(files):
	for child in vbox_local_file.get_children():
		vbox_local_file.remove_child(child)
	
	for title in files:
		var label = Label.new()
		label.text = title
		
		vbox_local_file.add_child(label)


func show_count_files(count):
	label_count.text = str(count)


func show_path_folder():
	label_path.text = manager.path
