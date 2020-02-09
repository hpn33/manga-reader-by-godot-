extends State


func enter(msg: Dictionary = {}) -> void:
	
	owner.sorting()
	change_state('idle')

