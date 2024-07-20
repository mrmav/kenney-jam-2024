extends Control

export var button_path: NodePath
export var clouds_path: NodePath
var button: Button
var cloud: Control

var start_offset = Vector2(0,100)
# Called when the node enters the scene tree for the first time.
func _ready():
	button = get_node(button_path) as Button
	cloud = get_node(clouds_path) as Control
	
	button.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	button.connect("mouse_exited", self, "_on_Area2D_mouse_exited")
	
	rect_position = rect_position + start_offset
	pass # Replace with function body.


	
func _on_Area2D_mouse_entered() -> void:
	print("Hello ")
	rect_position = rect_position - start_offset
	cloud.visible = false
	pass

func _on_Area2D_mouse_exited() -> void:
	print("Bye ")
	# Return to the default size
	rect_position = rect_position + start_offset
	cloud.visible = true
	pass
