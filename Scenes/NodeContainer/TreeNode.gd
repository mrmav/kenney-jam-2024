tool
extends Node2D
class_name TreeNode

# Since we cannot use own class name here, we create this type const.
const TYPE_TREE_NODE = 1

export(PackedScene) var element_scene = null

var element = null
var line_connections = []

func _enter_tree():
	assert(element_scene != null, "No element scene given.")
	
	if Engine.editor_hint:		
		return
	
	# Instances the element of this node
	element = element_scene.instance()
	element.z_as_relative = false
	element.z_index = Enums.ZIndex.Elements
	add_child(element)
		
	element.connect("user_clicked", self, "_on_user_click")


func _on_user_click():
	GlobalAccess.node_container.emit_signal("user_clicked", self)

	
func _ready():
	
	if Engine.editor_hint:
		return
	
	# create a line connection to my parent child and incested nodes.
	var line_scene : PackedScene = preload("res://Scenes/NodeContainer/LineConnection.tscn")
	
	for child in get_children():
		if child.get("TYPE_TREE_NODE"):
			_create_connection(self, child, line_scene)
			
	for sibling in get_parent().get_children():
		if sibling == self:
			continue
		if not sibling.get("TYPE_TREE_NODE"):
			continue
#		if sibling.get_child_count() > 0:
#			continue
		
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
	
