# Manga Reader for manga eater
maked by Godot
> for showing squere image like any normal web manga reader

## feture
* movement
* setting
* config file on images location
* pagination


### Core System
* Observer System ( SharePoint ) for control data
* config wraper for use config file to save setting


### movement
- [x] movement with mouse ( need improve )
- [x] movement with keyboard ( need improve )

### setting
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

### setting
- [x] change background color


## TODO
- [ ] improve movement
- [x] make recent folder address
- [ ] config file on image folder ( for sorting images )
- [x] save image folder address on setting file
- [x] signal system on config system (  ) for when a data changed ( by name SharePoint )
- [ ] delete color
- [ ] undo for color panel