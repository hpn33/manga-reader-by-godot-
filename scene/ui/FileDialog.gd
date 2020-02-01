extends FileDialog


func _on_FileDialog_dir_selected(dir: String) -> void:
	var paths :Array= config.get_data('recents')
	
	var index = paths.find(dir)
	
	if index == -1:
		paths.append(dir)
	else:
		var v = paths[index]
		paths.remove(index)
		paths.append(v)
	
	config.set_data('recents', paths)
	config.save()
	
	
	data.path = dir
	
	owner.ui.title_bar.recent_menu.re_init()

