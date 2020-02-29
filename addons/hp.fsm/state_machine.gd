extends Node
class_name StateMachine

"""
Hierarchical State machine for the player.
Initializes states and delegates engine callbacks (_physics_process, _unhandled_input) to the state.
"""

export var debug := false

export var initial_state: = NodePath()
onready var current_state : State= get_node(initial_state) setget set_state

onready var _state_name: String = current_state.name

var active = false setget set_active
onready var parent = get_parent()



func _init() -> void:
	add_to_group("state_machine")

func _ready() -> void:
	
	set_active(true)
	
	yield(owner, "ready")
	current_state.enter()



func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.unhandled_input(event)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)


func set_active(value: bool):
	active = value
	set_physics_process(value)
	set_process_input(value)
	


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	
	if not has_node(target_state_path):
		return

	var target_state: = get_node(target_state_path)
	assert(target_state.is_composite == false)
	
#	msg = {'pre': _state_name}
	if debug:
		print('%s:\t%s -> %s' % [parent.name, _state_name, target_state.name])
	
	if current_state:
		current_state.exit()
	
	self.current_state = target_state
	current_state.enter(msg)


func set_state(value: State) -> void:
	current_state = value
	_state_name = current_state.name
#	print('%s:\t= %s' % [parent.name, _state_name] )


func state_is(target_state_path: String) -> bool:
	return target_state_path == _state_name
