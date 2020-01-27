extends Node

signal data_changed(_data)

var path := '' setget set_path

func set_path(value):
	path = value
	emit_signal("data_changed", self)







