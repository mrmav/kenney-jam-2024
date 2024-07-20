tool
extends Node2D

signal user_clicked
signal node_selected

export(NodePath) var tree_root_path = null

onready var tree_root = get_node_or_null(tree_root_path)
onready var camera = get_node_or_null("Camera2D")

var selected_node : TreeNode = null

func _enter_tree():
	# register self class for global access
	GlobalAccess.node_container = self
	

func _ready():
	
	assert(tree_root != null, "TreeRoot not defined.")
	connect("user_clicked", self, "_on_node_selected")
	
	selected_node = tree_root


func _on_node_selected(node : TreeNode):
	
	if selected_node == node:
		return
	
	# perform checks to know if we can select this node:
	# ideally, this would be server side.
	if node in selected_node.get_children() or node == selected_node.get_parent() \
		or node in selected_node.get_parent().get_children():
		selected_node = node
		print(node)
		print(node.name)
		emit_signal("node_selected", node)
		print("In reach")
	else:
		print("Out of reach")
