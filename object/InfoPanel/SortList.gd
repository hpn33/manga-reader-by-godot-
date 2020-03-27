extends VBoxContainer


onready var sort_item = preload("res://object/InfoPanel/SortItem/SortItem.tscn")


var list := []


#func _ready():
#	share.add_hook('local_files', self, 'refresh')

#	refresh()


func refresh():
	
	clear()
	
	list = manager.sort_list()
	var files = manager.file_list().duplicate()
	
	for item in list:
		var new = sort_item.instance()
		
		add_child(new)
		
		for index in files.size():
			if item.id == files[index].id:
				new.init(files[index].id, files[index].title, item.visiable)
				files.remove(index)
				break
		
	
	
	




func move_item(from, to):
	
	
	list.insert(to + 1, list[from])
	
	var off = 0
	if from > to:
		off = 1
	
	list.remove(from + off)
	
	manager.save('sort_list', list)
	
	refresh()


func update_item(index, visiable):
	
	list[index].visiable = visiable
	
	manager.save('sort_list', list)
	
	owner.show_count_sort()


func sort_by_number():
	
	var li := []
	
	list = manager.sort_list()
	var files = manager.file_list().duplicate()
	
	for item in list:
		
		for index in files.size():
			if item.id == files[index].id:
				
				var it := {
					id = files[index].id,
					title = files[index].title,
					visiable = item.visiable
				}
				
				li.append(it)
				files.remove(index)
				break
	
	
	list = bubble_sort(li)
	manager.save('sort_list', list)
	
	refresh()


func bubble_sort(array):
	
	var index = len(array) - 1
	while index >= 0:

		for j in range(index):
#			print(array[j].title)
#			print(array[j+1].title)
			if int(array[j].title) > int(array[j+1].title):
				var temp = array[j]
				array[j] = array[j+1]
				array[j+1] = temp

		index -= 1
	return array


func clear():
	for child in get_children():
		remove_child(child)

