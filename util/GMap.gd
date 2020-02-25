extends Node
class_name GMap


#################################################

#  variabel
#  ---------

#################################################


var keys := []
var values := []


#################################################

#  geting data
#  ---------

#  any kind of getting data

#################################################


func append(key: String, value):
	keys.append(key)
	values.append(value)


func get(key: String):
	
	var position = get_position(key)
	
	return values[position]


func at(position: int):
	return values[position]


#################################################

#  iterating
#  ---------

#   ability to work with array

#################################################


func to_iterator() -> Array:
	var iterat := []
	
	for i in keys.size():
		iterat.append([keys[i], values[i]])
	
	return iterat


func from_iterator(array: Array) -> void:
	
	clear()
	
	for item in array:
		keys.append(item[0])
		values.append(item[1])


#################################################

#  clean
#  ---------

#   function for different kind of removing

#################################################


func clear():
	keys.clear()
	values.clear()


func remove(key: String):
	
	var position = get_position(key)
	
	remove_at(position)


func remove_at(position: int):
	keys.remove(position)
	values.remove(position)


#################################################

#  util
#  ---------

#   helpfuly method

#################################################


func get_position(key: String) -> int:
	var position = keys.find(key)
	
	if position == -1:
		print("%s: key '%s' not exist." % [name, key])
		return position
	
	return position


func size() -> int:
	return keys.size()


