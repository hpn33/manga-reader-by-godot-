extends Tree




func _ready():
	share.add_hook('local_files', self, 'refresh')
	
	refresh()

func refresh(local_files = []):
	clear()
	
	var root = create_item()
	root.set_text(0, 'sort')
	
	for names in local_files:
		var child = create_item(root)
		child.set_text(0, names)
