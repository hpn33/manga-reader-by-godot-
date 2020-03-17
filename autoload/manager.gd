extends Node
class_name Manager


var ioutil := IOUtil.new()
var setting :ImagesSetting


func open(_path):
	
	setting = ImagesSetting.new(_path)
	
	
	# if path exist set it
	if not ioutil.dir_exists(_path):
		print("An error occurred when trying to access the path.")
		return
	
	ioutil.be(_path)
	
	
	setting.active()
	
	
	# check change's
#	check_config()
	
	# use config's
#	read_config()
	
	
	
	# get images
	var image_list = ioutil.list_by_type('png|jpg')
	
	share.set_value('image_list', image_list)



