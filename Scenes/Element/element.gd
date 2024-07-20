extends Node2D

export var outline_path: NodePath
export var sphere_path: NodePath
export var light_path: NodePath
export var noise01_path: NodePath
export var icon_path: NodePath
export var noise02_path: NodePath
export var area2D_path: NodePath
export var description_path: NodePath
export var description_tween_path: NodePath

var outline: Sprite
var sphere: Sprite
var light: Sprite
var noise01: Sprite
var icon: Sprite
var noise02: Sprite
var area2D: Area2D
var description: Label
var description_tween: Tween

var hover_scale: float = 1.3
var default_icon_scale: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	outline = get_node(outline_path) as Sprite
	sphere = get_node(sphere_path) as Sprite
	light = get_node(light_path) as Sprite
	noise01 = get_node(noise01_path) as Sprite
	icon = get_node(icon_path) as Sprite
	noise02 = get_node(noise02_path) as Sprite
	area2D = get_node(area2D_path) as Area2D
	description = get_node(description_path) as Label
	description_tween = get_node(description_tween_path) as Tween
	
	description.visible = false
	
	area2D.connect("mouse_entered", self, "_on_Area2D_mouse_entered")
	area2D.connect("mouse_exited", self, "_on_Area2D_mouse_exited")
	
	default_icon_scale = icon.scale
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rotation_speed = 2
	light.rotation += rotation_speed * delta
	noise01.rotation += rotation_speed *-.2* delta
	noise02.rotation += rotation_speed *.2 * delta
	
	description.set_global_position(outline.global_position)
	pass
	
	
func _on_Area2D_mouse_entered() -> void:
	# Increase the size of the sprite
	icon.scale = default_icon_scale * hover_scale
	noise02.visible = false
	displayDescription()
	pass
		
func _on_Area2D_mouse_exited() -> void:
	# Return to the default size
	icon.scale = default_icon_scale
	noise02.visible = true
	description.visible = false
	pass

func displayDescription():
	description.percent_visible = 0	
	var duration = 1.0 
	
	# Use the tween to animate the `percent_visible` property from 0 to 1
	description_tween.interpolate_property(
		description, 
		"percent_visible", 
		0, 
		1, 
		duration, 
		Tween.TRANS_LINEAR, 
		Tween.EASE_IN_OUT
	)
	
	description.visible = true
	description_tween.start()
	pass 

