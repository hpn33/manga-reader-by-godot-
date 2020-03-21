extends Tree


var list := GMap.new()

func _ready():
#	share.add_hook('local_files', self, 'refresh')
	
#	refresh()
	pass

func refresh(local_files = list):
	
	clear()
	
	if not local_files is GMap:
		list.clear()
		
		for i in local_files.size():
			list.append(str(i), local_files[i])
	
	
	var root = create_item()
	root.set_text(0, 'sort')
	
	for item in list.to_iterator():
		var child = create_item(root)
		child.set_text(0, item[0])
		child.set_text(1, item[1])
		
	



func get_drag_data(position): # begin drag

	var preview = Label.new()
	preview.text = get_selected().get_text(1)
	set_drag_preview(preview) # not necessary

	return get_selected() # TreeItem


func can_drop_data(position, data):
	return data is TreeItem # you shall not pass!


func drop_data(position, item): # end drag
	var to_item = get_item_at_position(position)
	var shift = get_drop_section_at_position(position)
	# shift == 0 if dropping on item, -1, +1 if in between
	
	moved(item, to_item, shift)



func moved(item, to_item, shift):
	
	
	var from_id :String= item.get_text(0)
	var from_title :String= item.get_text(1)
	
	var item_pos = list.find(from_id)
	
	
	var to_id = to_item.get_text(0)
	var to_title = to_item.get_text(1)
	
	var to_item_pos = list.find(to_id)
	
	
	list.insert(to_item_pos + 1, from_id, from_title)
	
	var offset = 1 if item_pos > to_item_pos else 0
	list.remove_at(item_pos + offset)
	
	refresh()



