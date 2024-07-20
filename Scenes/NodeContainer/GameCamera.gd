extends Camera2D


func _ready():
	GlobalAccess.node_container.connect("node_selected", self, "_on_node_selected")
	
	yield(GlobalAccess.node_container, "ready")
	smoothing_enabled = false
	_on_node_selected(GlobalAccess.node_container.selected_node)
	smoothing_enabled = true


func _on_node_selected(node : TreeNode):
	print(node.global_position)
	global_position = node.global_position
