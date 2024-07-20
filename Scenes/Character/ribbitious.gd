extends Control

export var button_path: NodePath
export var lerp_factor: float = 0.9

var button: Button

var start_offset = Vector2(0,100)
# Called when the node enters the scene tree for the first time.
func _ready():
	button = get_node(button_path) as Button
	
	button.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	button.connect("mouse_exited", self, "_on_Area2D_mouse_exited")
	
	rect_position = rect_position + start_offset
	
	pass # Replace with function body.


	
func _on_Area2D_mouse_entered() -> void:
	print("Hello ")
	var target_pos = rect_position - start_offset
	rect_position = target_pos

	# Increase the size of the sprite
	pass
	

	
func _on_Area2D_mouse_exited() -> void:
	print("Bye ")
	# Return to the default size
	var target_pos = rect_position + start_offset
	rect_position = target_pos
	pass
