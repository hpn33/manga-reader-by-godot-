extends Node


var thread = null


func load_image(path):
	
	thread = Thread.new()
	thread.start( self, "_thread_load", path)


func _thread_load(path):
	
	var image = Image.new()
	image.load(path)
	var image_texture = ImageTexture.new()
	
	image_texture.create_from_image(image)
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done", image_texture)


func _thread_done(image_texture):
	assert(image_texture)
	
	# Always wait for threads to finish, this is required on Windows
	thread.wait_to_finish()
	
	owner.loaded(image_texture)
	

