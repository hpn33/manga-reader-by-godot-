extends Node


func _ready() -> void:
	config.init()
	# danger: remove setting
	config.rebuild()

	config.load()
	for key in data.configs.keys():
		data.configs[key] = config.get_data(key)

	print(data.configs)
	# save data
#	config.show_text()
	for key in data.configs.keys():
		print(key, config.get_data(key))

	data.configs.colors.append(['aa', 'aaa'])
	data.configs.colors.append(['bb', 'bbb'])

#	config.set_data(data.configs)
	for key in data.configs.keys():
		config.set_data(key, data.configs[key])
	config.save()

#	config.show_text()
	for key in data.configs.keys():
		print(key, config.get_data(key))
	
