extends Node
class_name GMap


var keys := []
var values := []


func append(key: String, value):
	keys.append(key)
	values.append(value)


func get(key: String):
	
	var position = get_position(key)
	
	return values[position]


func clear():
	keys.clear()
	values.clear()


func remove(key: String):
	
	var position = get_position(key)
	
	remove_at(position)


func remove_at(position: int):
	keys.remove(position)
	values.remove(position)


func get_position(key: String) -> int:
	var position = keys.find(key)
	
	if position == -1:
		print("%s: key '%s' not exist." % [name, key])
		return position
	
	return position

