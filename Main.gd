extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	NodesColors.emit_signal("request_colors")
	GlobalAccess.connect("received_results", self, "_on_results")

func _on_results(result):
	GlobalAccess.run_nodes = GlobalAccess.node_container.get_visited_ids_array().duplicate()
	get_tree().change_scene("res://Scenes/SubmitMenu/submitMenu.tscn")
	pass
