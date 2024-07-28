extends Node

signal game_ready

# Called when the node enters the scene tree for the first time.
func _ready():
	NodesColors.connect("colors_received", self, "emit_signal", ["game_ready"])
	NodesColors.emit_signal("request_colors")
	GlobalAccess.connect("received_results", self, "_on_results")

func _on_results(result):
	ScoreManager.set_player_score(float(result.result))
	GlobalAccess.run_nodes = GlobalAccess.node_container.get_visited_ids_array().duplicate()
	get_tree().change_scene("res://Scenes/SubmitMenu/submitMenu.tscn")
	pass
