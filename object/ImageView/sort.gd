extends State


func enter(msg: Dictionary = {}) -> void:
	
	get_parent().get_parent().sorting()
	change_state('idle')

