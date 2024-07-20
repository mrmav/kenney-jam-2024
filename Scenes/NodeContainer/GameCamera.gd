extends Camera2D


func _ready():
	GlobalAccess.node_container.connect("node_selected", self, "_on_node_selected")


func _on_node_selected(node : TreeNode):
	print(node.global_position)
	global_position = node.global_position
