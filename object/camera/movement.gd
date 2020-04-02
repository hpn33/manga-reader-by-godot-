extends Node

# TODO: 
# setting option for speed

const speed := 10


var target := Vector2()
var y_size : float


func _ready():
	
	y_size = get_tree().root.get_viewport().size.y
	
	owner.position = target


func _input(event):
	
	# long movement
	var _direction := int(event.is_action_pressed("page_down")) - int(event.is_action_pressed("page_up"))
	
	if _direction != 0:
		target.y += y_size * 0.85 * owner.zoom.y * _direction



var direction := Vector2()

func _process(delta):
	
	
	direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

	if direction.length_squared() > 0:
		target += direction.normalized() * speed * owner.zoom
		if owner.limit_rect: target = owner.snap_to_limits(target)
	
	
	# final
	owner.position = lerp(owner.position, target, 25 * delta)


