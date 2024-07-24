tool
extends Node2D
class_name TreeNode

signal position_changed

# Since we cannot use own class name here, we create this type const.
const TYPE_TREE_NODE = 1
const _static = {
	"id": 0
}

export(PackedScene) var element_scene = null
export(bool) var relevant = true
export(Array, NodePath) var bridges = []
export(int) var tree_id setget _set_id, get_id

func _set_id(value):
	return

func get_id():
	return tree_id

var element = null
var line_connections = []

var bridge_nodes = []

var _dummy_element_instance = null


func _get_configuration_warning():
	var warning = ""
	warning += "No element scene defined\n" if not element_scene else ""
	
	return warning

static func _reset_ids():
	_static.id = 0


static func get_last_id() -> int:
	return _static.id

static func _get_new_id() -> int:
	var id = _static.id
	_static.id += 1
	return id


func _enter_tree():
	assert(element_scene != null, "No element scene given.")
	
	tree_id = _get_new_id()
	
	if Engine.editor_hint:
		_dummy_element_instance = element_scene.instance()		
		return
	
	for child in get_children():
		if child.get("TYPE_TREE_NODE"):
			continue
		child.queue_free()
	
	line_connections.clear()
	
	# Instances the element of this node
	element = element_scene.instance()
	element.z_as_relative = false
	element.z_index = Enums.ZIndex.Elements	
	add_child(element)
	
	z_as_relative = false
	z_index = Enums.ZIndex.TreeNodes
	
	element.connect("user_clicked", self, "_on_user_click")
	
	
func _on_user_click():
	GlobalAccess.node_container.emit_signal("user_clicked", self)

	
func _ready():
		
	for b in bridges:
		bridge_nodes.append(get_node_or_null(b))
		
	if Engine.editor_hint:		
		var line_scene_editor : PackedScene = preload("res://Scenes/NodeContainer/LineConnectionEditor.tscn")
		_build_connections(line_scene_editor)
		
		update()
		return
	
	
	# create a line connection to my parent child and incested nodes.
	var line_scene : PackedScene = preload("res://Scenes/NodeContainer/LineConnection.tscn")
	_build_connections(line_scene)
	
#	if NodesColors.initialized:
#		_get_outline_color()
#	else:
	NodesColors.connect("colors_received", self, "_get_outline_color")


func _get_outline_color():	
	element.get_node("outline").modulate = NodesColors.get_node_color(tree_id)


func _build_connections(line_scene):
	for child in get_children():
		if child.get("TYPE_TREE_NODE"):
			_create_connection(self, child, line_scene)
			
	for node in bridge_nodes:
		if not node:
			# node lost the ref? no longerexists?
			continue
			
		if node.get("TYPE_TREE_NODE"):
			print("connection bridge between ", self, " and ", node)
			_create_connection(self, node, line_scene)
			
	for sibling in get_parent().get_children():
		if sibling == self:
			continue
		if not sibling.get("TYPE_TREE_NODE"):
			continue
		
		_create_connection(self, sibling, line_scene)


func _create_connection(a : Node2D, b : Node2D, line_scene : PackedScene) -> void:
	
	var should_be_visible = not(a.check_nodes_connected(a, b) or b.check_nodes_connected(a, b))
	
	var line : Line2D  = null
	if should_be_visible:
		line = line_scene.instance()
		line.z_as_relative = false
		line.z_index = Enums.ZIndex.LineConnections
		add_child(line)
	
	var line_conn_obj = {
		"line": line,
		"a": a,
		"b": b,
		"is_visible": should_be_visible
	}
	
	_update_line_points(line_conn_obj)
	line_connections.append(line_conn_obj)
	

func _update_line_points(line_connection_obj):
	if not line_connection_obj.is_visible:
		return
		
	line_connection_obj.line.clear_points()
	line_connection_obj.line.add_point(line_connection_obj.a.global_position - line_connection_obj.line.global_position)
	line_connection_obj.line.add_point(line_connection_obj.b.global_position - line_connection_obj.line.global_position)


func check_nodes_connected(a, b) -> bool:
	for connection in line_connections:
		if (connection.a == a or connection.a == b) and (connection.b == a or connection.b == b):
			return true
	return false
	
	
func find_connection_to(a) -> Line2D:
	for connection in line_connections:		
		if (connection.a == a or connection.b == a):
			return connection.line
	return null


var _last_post = position
var ignore_adjust = false
func _process(delta):
	
	if Engine.editor_hint and not ignore_adjust:
		if position != _last_post:
			# is being dragged
			for child in get_children():
				if child.get("TYPE_TREE_NODE") and Input.is_key_pressed(KEY_ALT):
					child.position += _last_post - position
					child.ignore_adjust = true
					child.update()
					
	update()
			
	for connection in line_connections:
		_update_line_points(connection)
	
	
	ignore_adjust = false
	_last_post = position
	
func _draw():
	if Engine.editor_hint:
		
		var size_node = _dummy_element_instance.get_node_or_null("outline")
		if not size_node:
			return
		
		var color = Color.aquamarine
		if "Root" in name:
			color = Color.greenyellow
		color.a = 0.3
		draw_circle(Vector2.ZERO, (size_node.get_rect().size * size_node.scale).x / 2.0, color)
	
	if OS.is_debug_build():
		draw_string(preload("res://Fonts/kenney_kenney-fonts/Resources/KenneyPixel_debug.tres"), Vector2.ZERO, str(tree_id), Color.red)
	
