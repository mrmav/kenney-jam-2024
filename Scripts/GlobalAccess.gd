extends Node

signal received_results

var node_container : Node2D = null setget _set_node_container, get_node_container

var run_nodes = null

func _set_node_container(value):
	if not node_container:
		node_container = value

func get_node_container() -> Node2D:
	return node_container
	
func reset_state():
	node_container = null
