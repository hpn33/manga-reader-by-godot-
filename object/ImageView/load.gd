extends State


var load_thread :Thread
#var unuse_thread:= []
#onready var progress = $"../../../UI/ProgressBar"


func enter(msg: Dictionary = {}) -> void:
	load_image()


func load_image():
	
#	if load_thread:
#		if load_thread.is_active():
#			unuse_thread.append(load_thread)
	
	load_thread = Thread.new()
	load_thread.start( self, "_thread_load_image", owner.image_list)


func _thread_load_image(paths):
	
	owner.image_textures.clear()
	
#	progress.call_deferred('set_visible', true)
#	progress.call_deferred('set_max', paths.size())
	
	for i in paths.size():
		var _path = paths[i]
		print(_path)
		
		var image = Image.new()
		image.load(_path)
		var res = ImageTexture.new()
		res.create_from_image(image)
		owner.image_textures.append(res)
#		progress.call_deferred('set_value', i)
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done")


func _thread_done():
	# Always wait for threads to finish, this is required on Windows
	load_thread.wait_to_finish()
#	progress.call_deferred('set_visible', false)
	
	_load_done()


func _load_done():
	change_state('add')



#func _process(delta) -> void:
#	var index := 0
#
#	while true:
#
#		if unuse_thread.size() == 0:
#			break
#
#		if not unuse_thread[index].is_active():
#			unuse_thread.remove(index)
#			index -= 1
#			print(str(index) + ':' + str(unuse_thread.size()))
#
#		if index >= unuse_thread.size()-1:
#			break
#		index += 1
#		print(str(index) + ':' + str(unuse_thread.size()))
#
