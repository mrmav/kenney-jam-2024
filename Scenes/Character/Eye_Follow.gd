extends Control

# Declare member variables for the eyes' parts
export var base_eye_path: NodePath
export var pupil_path: NodePath
export var glow_path: NodePath
export var eye_radius: float = 20
export var lerp_factor: float = 0.1

var base_eye: TextureRect
var pupil: TextureRect
var glow: TextureRect

func _ready():
	
	base_eye = get_node(base_eye_path) as TextureRect
	pupil = get_node(pupil_path) as TextureRect
	glow = get_node(glow_path) as TextureRect
	
	# Optionally, you can set the origin of the eye parts
	base_eye.set_pivot_offset(base_eye.rect_size / 2)
	pupil.set_pivot_offset(pupil.rect_size / 2)
	glow.set_pivot_offset(glow.rect_size / 2)

func _process(delta):
		# Get the position of the mouse relative to the eye
	var mouse_pos = get_global_mouse_position()
	
	# Calculate the direction from the base eye to the mouse position
	var direction = (mouse_pos - base_eye.rect_global_position).normalized()
	
	# Calculate the target position for the pupil
	var target_position = base_eye.rect_global_position + direction * eye_radius
	
	# Smoothly interpolate the pupil's position towards the target position
	pupil.rect_global_position = pupil.rect_global_position.linear_interpolate(target_position, lerp_factor)
	glow.rect_global_position = glow.rect_global_position.linear_interpolate(target_position, lerp_factor)
