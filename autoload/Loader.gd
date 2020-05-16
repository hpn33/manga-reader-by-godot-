extends Node


var threads := []
var garbeg_list := []


func load(_path, _target, _method):
	
	var _thread = Thread.new()
	threads.append(_thread)
	
	_thread.start(self, "loading", {
		target = _target,
		method = _method,
		path   = _path,
		thread = _thread,
		garbeg = garbeg_list
		})


func loading(data: Dictionary):
	
	var image := Image.new()
	image.load(data.path)
	
	var image_texture := ImageTexture.new()
	image_texture.create_from_image(image)
	
	data.texture = image_texture
	
	# Send whathever we did (or not) get
	call_deferred("call_method", data)


func call_method(data: Dictionary):
	
	# Always wait for threads to finish, this is required on Windows
	for thread in threads:
		if thread.get_id() == data.thread.get_id():
			thread.wait_to_finish()
			
			break
	
	
	var f = funcref(data.target, data.method)
	
	if f.is_valid():
		f.call_func(data.texture)
	
	data.garbeg.append(data.thread)
	

func _process(delta):
	
	
	for garbeg in garbeg_list:
		
		threads.erase(garbeg)
		garbeg_list.erase(garbeg)
	
#	if threads.empty():
#		return
#
#	for thread in threads:
#		if not thread.is_active():
#			threads.remove(threads.find(thread))
	


