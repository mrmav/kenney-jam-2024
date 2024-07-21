extends Control

export var hover_button_path: NodePath
export var submitText_path: NodePath
export var clouds_path: NodePath

var hover_button: Button
var submit_text: Control
var cloud: Control

var start_offset = Vector2(0,100)
var start_offset_submit = Vector2(0,-150)
# Called when the node enters the scene tree for the first time.
func _ready():
	hover_button = get_node(hover_button_path) as Button
	submit_text = get_node(submitText_path) as Control
	cloud = get_node(clouds_path) as Control
	
	hover_button.connect("mouse_entered", self, "_on_HoverButton_mouse_entered")
	hover_button.connect("mouse_exited", self, "_on_HoverButton_mouse_exited")
	hover_button.connect("pressed", self, "_on_Button_pressed")
	
	rect_position = rect_position + start_offset
	submit_text.rect_position = submit_text.rect_position + start_offset_submit
	pass # Replace with function body.

	
func _on_HoverButton_mouse_entered() -> void:
	print("Hello ")
	submit_text.rect_position = submit_text.rect_position - start_offset_submit
	rect_position = rect_position - start_offset
	cloud.visible = false
	pass

func _on_HoverButton_mouse_exited() -> void:
	print("Bye ")
	submit_text.rect_position = submit_text.rect_position + start_offset_submit
	rect_position = rect_position + start_offset
	cloud.visible = true
	pass
	
func _on_Button_pressed() -> void:
	print("Submit? ")
	pass
	
