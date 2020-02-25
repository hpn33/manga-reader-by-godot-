# Manga Reader for manga eater
maked by Godot
> for showing squere image like any normal web manga reader


## feture
- [x] movement
- [x] setting
- [ ] config file on images location
- [ ] pagination


### movement
- [x] movement with mouse ( need improve )
- [x] movement with keyboard ( need improve )

### setting
* setting file
* Background Color panel
- [x] change background color



#### setting file
make file on `user://` directory of godot by name `config.cfg`
for saving:
- [x] background colors
- [x] recent folder
- [x] some signal system for data changed

### config file
make config file for images in folder location
for sorting image

### pagination
navigate to another image by number


## Logic System
* SharePoint: Observer System for control data
* config wraper for use config file to save setting

#### Share Point
use Obserever pattern to reacte when exact data changed
> similar to signal but for variable and when changed call function that set with variable


## TODO
- [ ] improve label of image folder path animation ( change to tween )
- [ ] undo delete color for back color to ex position on the color list
- [x] undo for color panel
- [ ] fix recent address sort
- [x] delete color
- [ ] improve movement
- [x] make recent folder address
- [ ] config file on image folder ( for sorting images and set custom setting )
- [x] save image folder address on setting file
- [x] signal system on config system (  ) for when a data changed ( by name SharePoint )
- [x] fix image view for showing image
- [ ] fix background responsiblity