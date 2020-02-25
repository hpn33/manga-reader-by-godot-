extends Button

onready var list = $'../List'


func _on_Undo_pressed():
	var c = list.get_child(list.get_child_count()-1)
	
	c.modulate = Color.brown
	c.undo()

