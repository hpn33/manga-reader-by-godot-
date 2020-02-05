tool
extends ColorRect
class_name LoadProgressBar


onready var total_label = $VBoxContainer/total
onready var value_label = $VBoxContainer/value


export var total := 0.0 setget set_total
export var value := 0.0 setget set_value



func set_total(value):
	total = value
	if total_label:
		total_label.text = str(value)


func set_value(_value):
	value = _value
	if value_label:
		value_label.text = str(_value)




