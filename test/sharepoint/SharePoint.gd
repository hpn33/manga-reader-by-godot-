extends Node


func _ready() -> void:
	share.add_value('a', false)
	print('a: ', share.get_value('a'))
	
	# check unexist key
	share.add_hook('ab', self, 'a_change')
	
	# add method for hooking
	share.add_hook('a', self, 'a_change')
	share.set_value('a', true)
	
	# add another method for hooking
	share.add_hook('a', self, 'a_change2')
	share.set_value('a', false)
	
	# remove methoc and check
	share.remove_hook('a', self, 'a_change2')
	share.set_value('a', true)

func a_change(value):
	print('a: ', value)

func a_change2(value):
	print('a2: ', value)
