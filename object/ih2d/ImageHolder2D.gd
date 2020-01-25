extends Sprite

signal done

var thread = null

func loading(file_path: String):
	
#	print(Image.new().load(file_path))
#	print(ResourceLoader.load(file_path))
#	print(StreamTexture.new().load(file_path))
	
	load_image(file_path)
	

func _thread_load(path):
#	var ril = ResourceLoader.load_interactive(path)
	
#	assert(ril)
#	var total = ril.get_stage_count()
	
	# Call deferred to configure max load steps
#	progress.call_deferred("set_max", total)
	
#	var res = null
	
#	while true: #iterate until we have a resource
#
#		# Update progress bar, use call deferred, which routes to main thread
##		progress.call_deferred("set_value", ril.get_stage())
#
#		# Simulate a delay
##		OS.delay_msec(SIMULATED_DELAY_SEC * 1000.0)
#
#		# Poll (does a load step)
#		var err = ril.poll()
#
#		# if OK, then load another one. If EOF, it' s done. Otherwise there was an error.
#		if err == ERR_FILE_EOF:
#			# Loading done, fetch resource
#			res = ril.get_resource()
#			break
#		elif err != OK:
#			# Not OK, there was an error
#			print("There was an error loading")
#			break
	
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
	
	texture = resource
	set_center_offset()
	
	emit_signal("done")


func set_center_offset():
#	var center_pos = get_tree().root.get_viewport().size.x/2
	var center_pos = get_parent().size.x/2
	
#	offset.x = -int(texture.get_width())/2
#	position.x = center_pos

func load_image(path):
	
	thread = Thread.new()
	thread.start( self, "_thread_load", path)



func _draw() -> void:
#	var size = Vector2(texture.get_width(), texture.get_height())
	var rect = Rect2(Vector2(), texture.get_size())
	
	draw_rect(rect, Color.green, false)
	draw_circle(Vector2(), 5, Color.yellow)





