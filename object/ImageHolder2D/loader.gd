extends Node


var thread = null


func load_image(path):
	print(owner.name)
	thread = Thread.new()
	thread.start( self, "_thread_load", path)


func _thread_load(path):
	
	var image = Image.new()
	image.load(path)
	var res = ImageTexture.new()
	
	res.create_from_image(image)
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows
	thread.wait_to_finish()
	
	var prev_size = owner.size.y
	
	owner.texture = resource
	
	var diff = owner.size.y - prev_size
	
	owner.adapter.fix_pos_to_last(owner.get_position_in_parent(), diff)
	
	owner.set_label_pos()
	

