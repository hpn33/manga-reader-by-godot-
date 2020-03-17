extends ConfigWraper
class_name AppSetting


func _init():
	default = {
		active_color = 'default',
		regular_view = false,
		colors = [
			['default', '1a1a1a'],
			['color-1', '115853']
		],
		recents = []
	}
	
	root_section = 'setting'
