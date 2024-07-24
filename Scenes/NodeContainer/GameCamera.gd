extends Camera2D

export(float) var zoomed_in_amount = 4
export(float) var zoomed_out_amount = 1
export(float) var drag_max_dist = 600

var zoomed_in = false
var anchor_position : Vector2 = Vector2.ZERO

onready var container = get_parent()

onready var input_catch = get_node_or_null("../CanvasLayer/CatchInput")

func _ready():
	container.connect("node_selected", self, "_on_node_selected")
	
	yield(container, "ready")
	_on_node_selected(container.selected_node)
	
	zoom = Vector2(zoomed_out_amount, zoomed_out_amount)
	input_catch.connect("zoom", self, "_on_zoom")
	input_catch.connect("drag", self, "_on_drag")


var tween = null
func _on_zoom():
	
	if tween and tween.is_running():
		return
	
	var new_zoom = zoomed_out_amount if zoomed_in else zoomed_in_amount

	tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "zoom", Vector2(new_zoom, new_zoom), 0.2)
	tween.play()
	
	zoomed_in = !zoomed_in


func _on_drag(dist : Vector2):
	
	var res_pos = global_position - dist
	
	if res_pos.distance_to(anchor_position) > drag_max_dist:
		return
	
	global_position = res_pos



func _on_node_selected(node : TreeNode):
	anchor_position = node.global_position
	global_position = anchor_position
