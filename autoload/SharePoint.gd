extends Node
class_name SharePoint


var keys := []
var values := []

var hook_keys := []
var hooks := []


func add_value(key: String, value = ''):
	keys.append(key)
	values.append(value)


func set_value(key: String, value, hooking := true):
	var index = keys.find(key)
	values[index] = value
	
	if hooking:
		call_hooks(key, value)


func get_value(key: String):
	
	if keys.find(key) == -1:
		print('key not exist')
		return
	
	var value = values[keys.find(key)]
	
	
	return value


func remove_value(key: String):
	
	var index = keys.find(key)
	if index == -1:
		print('key not match')
		return
	
	keys.remove(index)
	values.remove(index)
	
	remove_hook_by_key(key)


func add_hook(key: String, target, method: String):
	# check key exist
	if keys.find(key) == -1:
		print('key not exist: add key by add_value')
		return
	
	# not exist: can add
	if hook_keys.find(key) != -1:
		var match_hook = match_by_key(key)
		
		for index in match_hook:
			if hooks[index][0] == target and hooks[index][1] == method:
				print('this hook exist')
				return
		
	
	hook_keys.append(key)
	hooks.append([target, method])


func remove_hook(key: String, target, method: String):
	var match_hooks := match_by_key(key)
	
	for index in match_hooks:
		var hook = hooks[index]
		
		if hook[0] is target:
			# target object not match
			continue
		
		if hook[1] != method:
			# method name not match
			continue
		
		hook_keys.remove(index)
		hooks.remove(index)


func remove_hook_by_key(key: String):
	var match_hooks = match_by_key(key)
	
	for index in match_hooks:
		hook_keys.remove(index)
		hooks.remove(index)


func call_hooks(key: String, value):
	var match_hooks = match_by_key(key)
	
	for index in match_hooks:
		var hook = hooks[index]
		funcref(hook[0], hook[1]).call_func(value)


# util
func match_by_key(key: String) -> Array:
	
	# find index of keys
	var matchs := []
	for i in hook_keys.size():
		if hook_keys[i] == key:
			matchs.append(i)
	
	return matchs

