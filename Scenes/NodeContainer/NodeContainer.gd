tool
extends Node2D

signal user_clicked
signal node_selected
signal no_more_moves_posssible

export(NodePath) var tree_root_path = null
export(bool) var debug_mode = true

onready var tree_root = get_node_or_null(tree_root_path)
onready var camera = get_node_or_null("Camera2D")

var selected_node : TreeNode = null

var visited_nodes = []

func _enter_tree():
	# register self class for global access
	TreeNode._reset_ids()
		

func _ready():
	GlobalAccess.node_container = self
	
	if Engine.editor_hint:
		return
	
	assert(tree_root != null, "TreeRoot not defined.")
	connect("user_clicked", self, "_on_node_selected")
	connect("no_more_moves_posssible", self, "no_more_connections")
	
	_confirm_selection(tree_root)


func _on_node_selected(node : TreeNode):
	
	if selected_node == node:
		return
	
	# perform checks to know if we can select this node:
	# ideally, this would be server side.
	if (node in selected_node.get_children() or node == selected_node.get_parent() \
		or node in selected_node.get_parent().get_children() or \
		(node in selected_node.bridge_nodes or selected_node in node.bridge_nodes)) and not (node in visited_nodes):
		
		print("In reach")
		_confirm_selection(node)
		
	else:
		print("Out of reach")


func find_connection_between(a, b) -> Line2D:
	
	if not a or not b:
		return null
	
	var conn  = a.find_connection_to(b)
	var conn2 = b.find_connection_to(a)
	
	return conn if conn else conn2
	

var pulsate_tween = null
func _confirm_selection(node):
		
	var l_conn = find_connection_between(selected_node, node)	
	if l_conn:
		l_conn.get_node("AnimationPlayer").play("activated")
		selected_node.element.get_node("AnimationPlayer").play("darken")
		
	
	node.element.get_node("AnimationPlayer").play("on_selected")
	selected_node = node
	visited_nodes.append(selected_node)
	print(node.name)
	emit_signal("node_selected", node)
	
	# pulsate
	if pulsate_tween:
		pulsate_tween.stop()
	pulsate_tween = create_tween()
	pulsate_tween.tween_property(selected_node.element, "scale", Vector2(1.1, 1.1), 1.2)
	pulsate_tween.tween_property(selected_node.element, "scale", Vector2(0.9, 0.9), 1.2)
	pulsate_tween.set_loops()
	pulsate_tween.set_ease(Tween.EASE_IN_OUT)
	pulsate_tween.play()
	
	var possible = _check_possible_moves()
	if not possible:
		emit_signal("no_more_moves_posssible")

func _check_possible_moves() -> bool:
	var possible = false
	
	# for every connection, check if there is an unvisited node
	
	for conn in selected_node.line_connections:
		
		var end = "a"
		if conn.a == selected_node:
			end = "b"
		
		possible = not (conn[end] in visited_nodes)
		
		if possible:
			break
	
	return possible


func no_more_connections():
	print("NO MORE CONNECTIONS POSSIBLE")


func get_visited_ids_array() -> Array:
	var res = []
	for node in visited_nodes:
		res.append(node.tree_id)
	return res

