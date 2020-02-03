extends State


var load_thread :Thread
onready var progress = $"../../../UI/ProgressBar"


func enter(msg: Dictionary = {}) -> void:
	load_image()


func load_image():
	load_thread = Thread.new()
	load_thread.start( self, "_thread_load_image", owner.image_list)


func _thread_load_image(paths):
	progress.call_deferred('set_visible', true)
	progress.call_deferred('set_max', paths.size())
	for i in paths.size():
		var _path = paths[i]
		print(_path)
		
		var image = Image.new()
		image.load(_path)
		var res = ImageTexture.new()
		res.create_from_image(image)
		owner.image_textures.append(res)
		progress.call_deferred('set_value', i)
	
	# Send whathever we did (or not) get
	call_deferred("_thread_done")


func _thread_done():
	# Always wait for threads to finish, this is required on Windows
	load_thread.wait_to_finish()
	progress.call_deferred('set_visible', false)
	
	_load_done()


func _load_done():
	change_state('add')
