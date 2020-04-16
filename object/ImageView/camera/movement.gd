extends Node

# TODO: 
# setting option for speed

const speed := 10


var target := Vector2()


func _ready():
	
	owner.position = target


func _unhandled_input(event):
	
	# long movement
	var _direction := int(event.is_action("page_down")) - int(event.is_action("page_up"))
	
	if _direction != 0:
		target.y += owner.viewport().y * 0.85  * _direction
		target = owner.snap_to_limits_util(target)
		owner.moved()



var direction := Vector2()

func _process(delta):
	
	
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

	if direction.length_squared() > 0:
		target += direction.normalized() * speed * owner.zoom
		
#		if owner.limit_rect: 
		target = owner.snap_to_limits_util(target)
		
		owner.moved()
	
	
	# final
	owner.position = lerp(owner.position, target, 25 * delta)


func reset():
	owner.reset()
	

func reset_x():
	target = Vector2(0, target.y)
	owner.position = target


