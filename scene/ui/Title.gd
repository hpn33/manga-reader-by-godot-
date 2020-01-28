extends Button

onready var anim = $AnimationPlayer
onready var tween = $Tween


func _ready() -> void:
	set_title('choise image path')


func set_title(title: String):
	text = title
#	show()
	anim.play("show")


func show():
	tween.interpolate_property(self, 'position:y', 20, 3, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.start()


func _on_Title_pressed() -> void:
	owner.ui.pop_file_dialog()
