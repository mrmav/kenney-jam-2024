tool
extends Node2D

signal user_clicked

export var master_color : Color = Color.white setget set_master_color

func set_master_color(value):
	master_color = value
	
	if not Engine.editor_hint:
		return
	
	$Content/TextureRect/RectClipBG/ColorRect.color = master_color
	$Content/TextureRect/RectClipBG/PatternBG.self_modulate = master_color.darkened(0.1)
	

export var icon_path : NodePath
export var area2D_path: NodePath
export var description_path: NodePath
export var tool_tip_path : NodePath

var icon : TextureRect
var area2D: Area2D
var description: Label
var tool_tip : Control

var hover_scale: float = 1.3
var default_icon_scale: Vector2 = Vector2(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	$CPUParticles2D.color = master_color
	icon = get_node(icon_path)
	area2D = get_node(area2D_path)
	description = get_node(description_path)
	tool_tip = get_node(tool_tip_path)
	
	if Engine.editor_hint:
		return
	
	set_master_color(master_color)
	
	tool_tip.visible = false
	
	area2D.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	area2D.connect("mouse_exited", self, "_on_Area2D_mouse_exited")
	area2D.connect("input_event", self, "_on_area_input_event")
	
	
func _on_area_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("user_clicked")


func _process(_delta):
	if Engine.editor_hint:
		return
	
	tool_tip.rect_global_position = get_global_mouse_position() 
	tool_tip.rect_global_position.y - tool_tip.rect_min_size.y
	

func _on_Area2D_mouse_entered() -> void:
	# Increase the size of the sprite
	icon.rect_scale = default_icon_scale * hover_scale
	display_description()
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _on_Area2D_mouse_exited() -> void:
	# Return to the default size
	icon.rect_scale = default_icon_scale
	_reset_description()
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

var description_tween : SceneTreeTween = null
func display_description():
	description.percent_visible = 0
		
	description_tween = get_tree().create_tween()
	# Use the tween to animate the `percent_visible` property from 0 to 1
	description_tween.tween_property(
		description, 
		"percent_visible",
		1, 
		0.1*description.text.length()
	)
	description_tween.set_trans(Tween.TRANS_LINEAR)
	description_tween.set_ease(Tween.EASE_IN_OUT)
	
	tool_tip.visible = true
	description_tween.play()


func _reset_description():
	tool_tip.visible = false
	description_tween.kill()
	description.percent_visible = 0
