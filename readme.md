# Manga Reader for manga eater
Maked by Godot
> for showing squere image like any normal web manga reader


## Feture
- [x] setting
- [x] config file on images location
- [ ] pagination
- [x] Regular View
- [ ] file system
- [x] color panels
- [x] navigate






## Setting
* setting file
* Background Color panel
- [x] change background color



#### Global Setting file
make file on `user://` directory of godot by name `config.cfg`
for saving:
- [x] background colors
- [x] recent folder
- [x] some signal system for data changed

#### Image Folder Setting file
config file for images in folder location
for sorting image

#### Image Config file
store setting for opening image


## Regular view
`control + R` for toggle view.
* **beautiful background**
* costing fps


## File System
- [ ] choising image path
- [ ] set host of images file
- [ ] check before path exist
- [ ] bookmark path


## Color Panel
for set color for background
* store and edit colors
* undo

## Navigate
move easer between image's
- [x] goto image by number
- [x] goto image by scroll

#### Movement
- [x] full reset view `control + shift + R`
- [x] center of view `control + R`
- [ ] go to the first
- [ ] go to the end

- [x] movement with keyboard
* normal move `WASD` or `arrow keys`
* long move with `page down` and `page up`

- [x] movement with mouse
movement with `left click`
zoom with `scroll`


#### Scroll Bar
- [ ] show summery view of image's
- [ ] ?

#### Pagination
navigate to another image by number


## Logic System
* **SharePoint**: Observer System for control data
* **config wraper**: for use config file to save setting

### Share Point
use Obserever pattern to reacte when exact data changed
> similar to signal but for variable and when changed call function that set with variable


### Config wrapper
backlog: like model binding is can extend to a script and save setting
* ?save file should be a exact name?
* ?need a core?
- [ ] it work.

## TODO
- [ ] set fullwidth screen on current image
- [x] system for navigate to any image by number
- [ ] making short path to 100 char
- [ ] add vertical mode
- [x] scroll bar
- [ ] undo delete color for back color to ex position on the color list
- [x] improve movement
- [x] config file on image folder ( for sorting images and set custom setting )
- [ ] load on thread or courotine
- [x] refresh anything that need when opening new folder
- [ ] clean code for scrolling
- [ ] clean code on imagePlace and imageHolder

