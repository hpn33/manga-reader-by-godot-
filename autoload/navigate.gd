extends Node

signal changed
signal refresh


var current = 0
var count = 0




func refresh(_count):
	current = 1
	count = _count
	
	emit_signal("refresh")



