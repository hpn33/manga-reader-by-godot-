extends ConfigWraper
class_name ImagesSetting


const CONFIG_FILE := 'config.cfg'
const CONFIG_PATH := '.mr'

var ioutil := IOUtil.new()

func _init(_path):
	
	path = _path + '/' + CONFIG_PATH + '/' + CONFIG_FILE
	
	default = {
		names = [],
		sort = []
	}
	
	
	ioutil.be(_path)


func active():
	# if not exist(config folder) make it
	if not ioutil.dir_exists(CONFIG_PATH):
		ioutil.make_dir(CONFIG_PATH)
	
	
	self.init()


func get_name_list():
	var sort = get_data('sort')
	
	if sort.size() != 0:
		return sort
	
	return get_data('names')

