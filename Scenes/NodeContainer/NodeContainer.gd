tool
extends Node2D

signal node_selected(node, element)

onready var tree_root = get_node_or_null("TreeRoot")
onready var camera = get_node_or_null("Camera2D")

var selected_node : TreeNode = tree_root

func _ready():
	connect("node_selected", self, "_on_node_selected")


func _on_node_selected(node : TreeNode, element):
	camera.global_position = node.global_position
