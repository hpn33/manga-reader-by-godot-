extends CanvasLayer

onready var file_dialog := $FileDialog
onready var vb = $"../vBox"

func _on_FileDialog_dir_selected(path: String) -> void:
	
	var regex = RegEx.new()
	var image_list:= []
	var dir := Directory.new()
	
#	print('path: ' + di)
	if dir.open(path) == OK:
		
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
#				print("Found directory: " + file_name)
#			else:
				
#				print(file_name)
				regex.compile('[*.](png|jpg)$')
				var result = regex.search(file_name)
				
				if result:
					image_list.append(file_name)
				
#				
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	vb.add_images(path, image_list)
	
	
#	print('=====last')
#	for i in image_list:
#		print(i)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"):
		file_dialog.popup_centered()
