extends Node

signal data_changed(_data)

var path := '' setget set_path


func set_path(value):
	if path == value:
		return
	path = value
	emit_signal("data_changed", self)


var page_count := 0 setget set_page_count


func set_page_count(value):
	page_count = value
	emit_signal("data_changed", self)


var colors := []





