extends CanvasLayer

#var file_dialog := FileDialog.new()
onready var file_dialog := $FileDialog
#onready var vb = $VBoxContainer2/ScrollContainer/VBoxContainer
onready var vb = $"../vBox"


#var image_list :Array= []

func _init() -> void:
#	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
#	file_dialog.mode = FileDialog.MODE_OPEN_DIR
#	file_dialog.resizable = true
#	file_dialog.connect("dir_selected", self, '_on_FileDialog_dir_selected')
#
#	add_child(file_dialog)
	pass

#func _process(delta):
#	var viewport = get_tree().root.get_viewport()
#	var m = viewport.get_mouse_position()
#	var z = m.x/viewport.size.x
#
	


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
	


func _on_Button_pressed() -> void:
	file_dialog.popup_centered()
	
	

var zoom = 0.4

func _on_zin_pressed() -> void:
	zoom += .2
	set_image_scale()


func _on_zout_pressed() -> void:
	zoom -= .2
	set_image_scale()

func set_image_scale():
	vb.rect_scale = Vector2.ONE * zoom
