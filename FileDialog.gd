extends FileDialog



func _on_FileDialog_dir_selected(dir: String) -> void:
	owner.find_image_path(dir)
