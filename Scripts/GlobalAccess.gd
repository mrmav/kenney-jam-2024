extends Node

signal received_results

const GameColors = {
	"nigredo" : "#22252d",
	"albedo" : "#c0d3ef",
	"citrinitas" : "#dfb602",
	"rubedo" : "#ad3b5c"
}

var node_container : Node2D = null setget _set_node_container, get_node_container

var run_nodes = null

func _set_node_container(value):
	if not node_container:
		node_container = value

func get_node_container() -> Node2D:
	return node_container
	
func reset_state():
	node_container = null

func _on_run_submit_reply(body : PoolByteArray):
	prepare_new_run()
	
func prepare_new_run():
	reset_state()
	ScoreManager.reset_state()
	get_tree().change_scene("res://Main.tscn")
