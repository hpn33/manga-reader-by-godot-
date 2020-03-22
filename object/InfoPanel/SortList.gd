extends VBoxContainer


onready var sort_item = preload("res://object/InfoPanel/SortItem/SortItem.tscn")


var list := []


#func _ready():
#	share.add_hook('local_files', self, 'refresh')

#	refresh()

func refresh(_list = list):
	
	clear()
	
	list = _list
	
	
	
	var id := 0
	var title := ''
	var visiable := true
	
	for item in _list:
		var new = sort_item.instance()
		
		add_child(new)
		
		id = item.id
		visiable = item.visiable
		
		for file in manager.files():
			if id == file.id:
				title = file.title
		
		
		new.init(id, title, visiable)
	
	
	




func move_item(from, to):
	
	list.insert(to + 1, list[from])
	
	list.remove(from)
	
	manager.save('sort', list)
	
	refresh()


func update_item(index, visiable):
	
	list[index].visiable = visiable
	
	manager.save('sort', list)


func clear():
	for child in get_children():
		remove_child(child)

