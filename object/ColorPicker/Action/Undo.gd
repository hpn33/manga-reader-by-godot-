extends Button

onready var list = $'../List'


func _on_Undo_pressed():
	list.get_child(list.get_child_count()-1).undo()

