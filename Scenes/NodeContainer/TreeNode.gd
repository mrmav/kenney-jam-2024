tool
extends Node2D
class_name TreeNode

# Since we cannot use own class name here, we create this type const.
const TYPE_TREE_NODE = 1

export(PackedScene) var element_scene = null
export(Array, NodePath) var incested_nodes = []

var line_connections = []

func _enter_tree():
	assert(element_scene != null, "No element scene given.")
	
	if Engine.editor_hint:
		return
	
	# Instances the element of this node
	var el = element_scene.instance()
	el.z_as_relative = false
	el.z_index = Enums.ZIndex.Elements
	add_child(el)
	
	connect("tree_entered", el, "set_owner", [owner])
	
func _ready():
	
	if Engine.editor_hint:
		return
	
	# create a line connection to my parent child and incested nodes.
	var line_scene : PackedScene = preload("res://Scenes/NodeContainer/LineConnection.tscn")
	
	for child in get_children():
		if child.get("TYPE_TREE_NODE"):
			_create_connection(self, child, line_scene)
			
	for sibling in incested_nodes:
		if sibling.get("TYPE_TREE_NODE"):
			_create_connection(self, sibling, line_scene)


func _create_connection(a : Node2D, b : Node2D, line_scene : PackedScene) -> void:
	
	var line : Line2D = line_scene.instance()
	line.z_as_relative = false
	line.z_index = Enums.ZIndex.LineConnections
	add_child(line)
	
	line.clear_points()
	line.add_point(a.global_position - line.global_position)
	line.add_point(b.global_position - line.global_position)
	
	line_connections.append(line_connections)
	
