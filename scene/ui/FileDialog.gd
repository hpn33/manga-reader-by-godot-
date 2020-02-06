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
	
	share.set_value('target_dir', dir)
	share.set_value('recents', paths)

