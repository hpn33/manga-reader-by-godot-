extends State


func enter(msg: Dictionary = {}) -> void:
	_add_image()


func _add_image():
	 
	_remove_children()
	
	if not _has_image():
		return
	
	_add()
	
	change_state('sort')
#	change_state('idle')


func _remove_children():
	# clear
	for child in owner.get_children():
		
		if 'state' != child.name:
			owner.remove_child(child)


func _has_image():
	return owner.image_list.size() != 0


func _add():
	var seperat = true
	
	var index := 0
	var size :float= owner.image_textures.size()
	
#	while true:
#		pass
	
#	for texture in owner.image_textures:
	for i in size:
		var tex = owner.image_textures[i]
		var new :Sprite= owner.image_holder.instance()
	
		owner.add_child(new)
		new.texture = tex
		
		# todo: seperat
		if i >= size -1:
			seperat = false
		
		_sort(new, seperat)
		
		print(i)
		if i >= size -1:
			break
#		new.position = owner.size.x / 2.0
	y_pos = 0


var y_pos := 0.0
var seperation := 0

func _sort(image: Sprite, seperat: bool):
	
	var size = image.texture.get_size()
	
	seperation = owner.seperation if seperat else 0
	
	
	owner.set_box(size.x, size.y + seperation)
	
	image.position.x = owner.size.x / 2
	image.position.y = y_pos
	
	y_pos += size.y + seperation
