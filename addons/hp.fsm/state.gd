extends Node
class_name State

"""
State interface for the Player scene.
Stores a reference to the Player and to the state machine.
As we're using Hierarchical State Machines, a state can be a node branch.
The lowest leaf tries to handle callbacks, and if it can't, it delegates the work to its parent.
"""



var is_composite: = get_child_count() != 0
var _state_machine: Node = null
onready var parent = get_parent()

func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node

func change_state(target_state_path: String, msg: Dictionary = {}) -> void:
	_state_machine.transition_to(target_state_path, msg)




func _ready() -> void:
	_state_machine = _get_state_machine(self)




func enter(msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func process(delta) -> void:
	pass

func physics_process(delta: float) -> void:
	pass

func unhandled_input(event: InputEvent) -> void:
	pass












