extends LineEdit


func _on_Title_text_changed(new_text):
	owner.check_button_title()
