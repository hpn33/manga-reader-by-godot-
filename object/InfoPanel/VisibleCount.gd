extends Label


func refresh():
	
	var count := 0
	
	for item in manager.sort_list():
		if item.visiable:
			count += 1
	
	
	text = str(count)
