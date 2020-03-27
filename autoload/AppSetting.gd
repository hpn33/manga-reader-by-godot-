extends ConfigWraper
class_name AppSetting


func _init():
	default = {
		active_color = 'default',
		regular_view = true,
		colors = [
			['default', '1a1a1a'],
			['color-1', '115853']
		],
		recents = []
	}
	
	section_name = 'setting'
