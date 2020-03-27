extends ConfigWraper
class_name ImagesSetting


const CONFIG_FILE := 'config.cfg'
const CONFIG_PATH := '.mrconfig'

var ioutil := IOUtil.new()

func _init():
	be()


func be(_path = path):
	
	path = _path + '/' + CONFIG_PATH + '/' + CONFIG_FILE
	
	default = {
		active_list = 'File',
		file_list = [],
		sort_list = []
	}
	
	shortget = default.keys()
	
	ioutil.be(_path)


func active():
	if path == '':
		return
	
	# if not exist(config folder) make it
	if not ioutil.dir_exists(CONFIG_PATH):
		ioutil.make_dir(CONFIG_PATH)
	
	
	return self.init()



