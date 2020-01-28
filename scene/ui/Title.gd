extends Button

onready var anim = $AnimationPlayer


func _ready() -> void:
	set_title('choise image path')


func set_title(title: String):
	text = title
	anim.play("show")


func _on_Title_pressed() -> void:
	owner.ui.pop_file_dialog()
