extends Node



const speed := 10



func _input(event):
	
	# long movement
	var direction := int(event.is_action_pressed("page_down")) - int(event.is_action_pressed("page_up"))
	
	if direction != 0:
		owner.position.y += get_tree().root.get_viewport().size.y * 0.85 * owner.zoom.y * direction



func _process(delta):
	
	
	var y := int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	var x := int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	
	
	owner.position.y += speed * owner.zoom.y * y
	owner.position.x += speed * owner.zoom.x * x
	
