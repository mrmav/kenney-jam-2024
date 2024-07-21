extends Camera2D

export(Vector2) var zoom_min_max = Vector2(1, 3)
export(float) var zoom_amount = 0.1

func _ready():
	GlobalAccess.node_container.connect("node_selected", self, "_on_node_selected")
	
	yield(GlobalAccess.node_container, "ready")
	_on_node_selected(GlobalAccess.node_container.selected_node)

var tween = null
func _process(delta):
	
	if tween and tween.is_running():
		print("tweeen trunning ")
		return
	
	var new_zoom = zoom.x
	
	if Input.is_action_just_released("zoom_in"):
		new_zoom -= zoom_amount
		
	if Input.is_action_just_released("zoom_out"):
		new_zoom += zoom_amount
	
	if new_zoom != zoom.x:		
		var a = clamp(new_zoom, zoom_min_max.x, zoom_min_max.y)
		
		tween = get_tree().create_tween()
		tween.set_ease(Tween.EASE_OUT)
		tween.set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(self, "zoom", Vector2(a, a), 0.6)
		tween.play()
		print("playe twween ")
	
	
func _on_node_selected(node : TreeNode):
	print(node.global_position)
	global_position = node.global_position
