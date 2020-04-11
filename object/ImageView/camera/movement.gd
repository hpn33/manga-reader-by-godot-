extends Node

# TODO: 
# setting option for speed

const speed := 10


var target := Vector2()


func _ready():
	
	get_parent().position = target


func _input(event):
	
	# long movement
	var _direction := int(event.is_action_pressed("page_down")) - int(event.is_action_pressed("page_up"))
	
	if _direction != 0:
		target.y += get_parent().viewport_height() * 0.85 * get_parent().zoom.y * _direction
		target = get_parent().snap_to_limits_util(target)
		get_parent().moved()



var direction := Vector2()

func _process(delta):
	
	
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

	if direction.length_squared() > 0:
		target += direction.normalized() * speed * get_parent().zoom
		
#		if owner.limit_rect: 
		target = get_parent().snap_to_limits_util(target)
		
		get_parent().moved()
	
	
	# final
	get_parent().position = lerp(get_parent().position, target, 25 * delta)


func reset():
	get_parent().setting()

func reset_x():
	get_parent().setting(Vector2(0, target.y))


