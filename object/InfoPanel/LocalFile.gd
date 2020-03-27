extends VBoxContainer



func refresh():
	
	# clear children
	for child in get_children():
		remove_child(child)
	
	
	for file in manager.file_list():
		var label = Label.new()
		label.text = file.title
		
		add_child(label)
	

