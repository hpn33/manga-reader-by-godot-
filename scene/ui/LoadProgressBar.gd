extends LoadProgressBar


onready var anim = $AnimationPlayer


func show():
	if anim.current_animation != 'show':
		anim.play("show")


func hide():
	if anim.current_animation != 'hide':
		anim.play("hide")

