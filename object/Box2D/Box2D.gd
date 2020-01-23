extends Node2D
class_name Box2D


enum {
	NOTIFICATION_SORT_CHILDREN,
	NOTIFICATION_THEME_CHANGED
}

signal minimum_size_changed()

#var rect = Rect2()
var size = Vector2.ZERO
var vertical :bool
var align



var _min_size_cache = {
	min_size = 0,
	will_stretch = false,
	final_size = 0
}


func _init(p_vertical: bool = true) -> void:
	
	vertical = p_vertical;
#	align = ALIGN_BEGIN;
	
	#set_ignore_mouse(true);
	#set_mouse_filter(MOUSE_FILTER_PASS);





func _resort():
	
	
	
	# First pass, determine minimum size AND amount of stretchable elements 
	
#	Size2i new_size = get_size();
	var new_size = size

	#int sep = get_constant("separation"); #,vertical?"VBoxContainer":"HBoxContainer");
	var sep := 0
	
	var first := true;
	var children_count := 0;
	var stretch_min := 0;
	var stretch_avail := 0;
	var stretch_ratio_total := 0.0;
	
	var nodes2d := []
	var min_size_caches := []
#	Map<Control *, _MinSizeCache> min_size_cache;
	
#	for (int i = 0; i < get_child_count(); i++) {
	for i in get_child_count():
#		Control *c = Object::cast_to<Control>(get_child(i));
		var node2d = get_child(i)
		
		if (!c || !c->is_visible_in_tree())
			continue;
		if not node == null:
			contin
		if (c->is_set_as_toplevel())
			continue;

		Size2i size = c->get_combined_minimum_size();
		_MinSizeCache msc;

		if (vertical) { /* VERTICAL */
			stretch_min += size.height;
			msc.min_size = size.height;
			msc.will_stretch = c->get_v_size_flags() & SIZE_EXPAND;

		} else { /* HORIZONTAL */
			stretch_min += size.width;
			msc.min_size = size.width;
			msc.will_stretch = c->get_h_size_flags() & SIZE_EXPAND;
		}

		if (msc.will_stretch) {
			stretch_avail += msc.min_size;
			stretch_ratio_total += c->get_stretch_ratio();
		}
		msc.final_size = msc.min_size;
		min_size_cache[c] = msc;
		children_count++;
	}

	if (children_count == 0)
		return;

	int stretch_max = (vertical ? new_size.height : new_size.width) - (children_count - 1) * sep;
	int stretch_diff = stretch_max - stretch_min;
	if (stretch_diff < 0) {
		//avoid negative stretch space
		stretch_diff = 0;
	}

	stretch_avail += stretch_diff; //available stretch space.
	/** Second, pass sucessively to discard elements that cant be stretched, this will run while stretchable
		elements exist */

	bool has_stretched = false;
	while (stretch_ratio_total > 0) { // first of all, dont even be here if no stretchable objects exist

		has_stretched = true;
		bool refit_successful = true; //assume refit-test will go well

		for (int i = 0; i < get_child_count(); i++) {

			Control *c = Object::cast_to<Control>(get_child(i));
			if (!c || !c->is_visible_in_tree())
				continue;
			if (c->is_set_as_toplevel())
				continue;

			ERR_FAIL_COND(!min_size_cache.has(c));
			_MinSizeCache &msc = min_size_cache[c];

			if (msc.will_stretch) { //wants to stretch
				//lets see if it can really stretch

				int final_pixel_size = stretch_avail * c->get_stretch_ratio() / stretch_ratio_total;
				if (final_pixel_size < msc.min_size) {
					//if available stretching area is too small for widget,
					//then remove it from stretching area
					msc.will_stretch = false;
					stretch_ratio_total -= c->get_stretch_ratio();
					refit_successful = false;
					stretch_avail -= msc.min_size;
					msc.final_size = msc.min_size;
					break;
				} else {
					msc.final_size = final_pixel_size;
				}
			}
		}

		if (refit_successful) //uf refit went well, break
			break;
	}

	/** Final pass, draw and stretch elements **/

	int ofs = 0;
	if (!has_stretched) {
		switch (align) {
			case ALIGN_BEGIN:
				break;
			case ALIGN_CENTER:
				ofs = stretch_diff / 2;
				break;
			case ALIGN_END:
				ofs = stretch_diff;
				break;
		}
	}

	first = true;
	int idx = 0;

	for (int i = 0; i < get_child_count(); i++) {

		Control *c = Object::cast_to<Control>(get_child(i));
		if (!c || !c->is_visible_in_tree())
			continue;
		if (c->is_set_as_toplevel())
			continue;

		_MinSizeCache &msc = min_size_cache[c];

		if (first)
			first = false;
		else
			ofs += sep;

		int from = ofs;
		int to = ofs + msc.final_size;

		if (msc.will_stretch && idx == children_count - 1) {
			//adjust so the last one always fits perfect
			//compensating for numerical imprecision

			to = vertical ? new_size.height : new_size.width;
		}

		int size = to - from;

		Rect2 rect;

		if (vertical) {

			rect = Rect2(0, from, new_size.width, size);
		} else {

			rect = Rect2(from, 0, size, new_size.height);
		}

		fit_child_in_rect(c, rect);

		ofs = to;
		idx++;
	}
}


func get_minimum_size():
	
#	Size2i minimum;
	var minimum := Vector2.ZERO
	
#	var sep :int= get_constant("separation"); //,vertical?"VBoxContainer":"HBoxContainer");
	
	var sep = 0
	
	var first := true;
	
	for i in get_child_count():
		var node2d :Node2D= get_child(i)
		
		if not node2d:
			continue
		if node2d.is_set_as_toplevel():
			continue
		if not node2d.visible:
			continue
		
		#
#		var size = node2d.
		
#		var size := rect.size
		
		if vertical:
			if size.x > minimum.x:
				minimum.x = size.x
			
			minimum.y += size.y + (0 if first else sep)
		
		else:
			if size.y > minimum.y:
				minimum.y = size.y
			
			
			minimum.x += size.x + (0 if first else sep)
		
		first = false
	
	return minimum


func _notification(what: int) -> void:
	
	if what == Box2D.NOTIFICATION_SORT_CHILDREN:
		_resort()
	elif what == Box2D.NOTIFICATION_THEME_CHANGED:
#		minimum_size_changed()
		emit_signal("minimum_size_changed")



# p_align: AlignMode
func set_alignment(p_align):
	align = p_align
	_resort()

func get_alignment() :
	return align;


func add_spacer(p_begin: bool) :
	
	var node2d = Node2D.new()
#	Control *c = memnew(Control);
#	c->set_mouse_filter(MOUSE_FILTER_PASS); //allow spacer to pass mouse events
	
#	if vertical:
#		c->set_v_size_flags(SIZE_EXPAND_FILL);
#	else:
#		c->set_h_size_flags(SIZE_EXPAND_FILL);

	add_child(node2d);
	if p_begin:
		move_child(node2d, 0);




func add_margin_child(p_label:String, p_node2d: Node2D, p_expand: bool)-> MarginContainer:
	
	var l = Label.new()
	l.text = p_label
	add_child(l)
	
	var mc = MarginContainer.new()
	mc.add_constant_override("margin_left", 0);
	mc.add_child(p_node2d);
	add_child(mc);
	
#	if p_expand:
#		mc->set_v_size_flags(SIZE_EXPAND_FILL);
	
	return mc;



