extends NinePatchRect

onready var description = $ElementName

func _ready():
	GlobalAccess.connect("show_element_description", self, "display_description")
	GlobalAccess.connect("hide_element_description", self, "hide_description")
	hide_description()
	
	
func _process(_delta):
	if Engine.editor_hint:
		return
	
	rect_global_position = get_global_mouse_position() 
	rect_global_position.y - rect_min_size.y
	
func _resize():
	rect_size = description.get_font("font").get_string_size(description.text + "       ")


var description_tween : SceneTreeTween = null
func display_description(text):
	$ElementName.text = text
	_resize()
	
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
	
	visible = true
	description_tween.play()


func hide_description():
	visible = false
	if description_tween:
		description_tween.kill()
	description.percent_visible = 0
